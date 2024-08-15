extends CharacterBody3D
#Variáveis
@export_category("Atributos")
@export var move_speed = 5.0 
@export var attack_range = 2.0
@export var enemy_health = 15
@export var minimum_distance = 15

@export_category("Recarregar Armas")
@export var l_ammo : int = 2
@export var m_ammo : int = 1
@export var n_ammo : float = 5

@export_category("Dano ao Player")
@export var damage = 2

#Booleanas
var can_colide = true
var dead = false
#Instâncias
@onready var timer = $Timer
@onready var monster_bite = $MonsterBite
@onready var animated_sprite_3d = $AnimatedSprite3D
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var progress_bar = $SubViewport/ProgressBar
@onready var label = $SubViewport/ProgressBar/Label
@onready var sub_viewport = $SubViewport
@onready var CONTROL_BULLET_EMISSION = Global.CONTROL_BULLET_EMISSION
@onready var nav = $NavigationAgent3D
@onready var symbol = $Sprite3D2


func _physics_process(_delta):
	var player_position = player.global_transform.origin
	var current_position = global_transform.origin
	var next_position = nav.get_next_path_position()
	var new_velocity = (next_position - current_position).normalized()
	velocity = velocity.move_toward(new_velocity, .25 * move_speed)
	move_and_slide()
	
	if dead:
		return
	if player == null:
		return
		
	var dist_to_player = global_transform.origin.distance_to(player_position)
	if  dist_to_player <= minimum_distance:
		nav.target_position = player_position
		attempt_to_kill_player()

func attempt_to_kill_player():
	var player_position = player.global_transform.origin
	var dist_to_player = global_transform.origin.distance_to(player_position)
	if dist_to_player > attack_range:
		return
	var eye_line = Vector3.UP * 1.0
	var query = PhysicsRayQueryParameters3D.create(global_transform.origin + eye_line, player.global_transform.origin + eye_line, 1)
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	if result.is_empty() and can_colide and player.vida > 0:
		monster_bite.play()
		player._damage(damage)
		can_colide = false
		timer.start()

func kill_blue_mf():
	damage_effect()
	enemy_health -= 15
	if enemy_health < 0:
		enemy_health = 0
	if enemy_health == 0:
		killed()
		
func kill_blue_lf():
	damage_effect()
	enemy_health -= 5
	move_speed -= 2
	if move_speed < 2:
		move_speed = 2
	if enemy_health < 0:
		enemy_health = 0
	if enemy_health == 0:
		killed()

func kill_blue_nf():
	damage_effect()
	enemy_health -= 0.3 * CONTROL_BULLET_EMISSION
	if enemy_health <= 0:
		killed()


func heal_blue_lf():
	damage_effect()
	enemy_health -= 2
	move_speed -= 1
	if move_speed < 2:
		move_speed = 2
	if enemy_health < 0:
		enemy_health = 0
	if enemy_health == 0:
		killed()

func heal_blue_mf():
	damage_effect()
	enemy_health -= 7.5
	if enemy_health < 0:
		enemy_health = 0
	if enemy_health == 0:
		killed()

func heal_blue_nf():
	damage_effect()
	enemy_health -= 0.05 * CONTROL_BULLET_EMISSION
	if enemy_health <= 0:
		killed()

	
func killed():
	if enemy_health <= 0:
		dead = true
		Global.pathogen_killed += 1
		$DeathSound.play()
		progress_bar.visible = false
		animated_sprite_3d.play("death")
		symbol.visible = false
		$CollisionShape3D.disabled = true
		collision_layer = 0
		player.get_more_ammo(l_ammo, m_ammo, n_ammo)
		
	
func _on_timer_timeout():
	can_colide = true

func _process(_delta):
	progress_bar.value = enemy_health
	label.set_text(str(int(enemy_health)))
	if enemy_health > 15:
		progress_bar.max_value = enemy_health
		
func damage_effect():
	animated_sprite_3d.modulate = Color.RED
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(animated_sprite_3d,"modulate", Color.WHITE, 0.3)
	
