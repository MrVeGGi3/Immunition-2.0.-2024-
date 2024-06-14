extends CharacterBody3D

var dead = false
var can_colide = true
@onready var player = get_tree().get_first_node_in_group("player")
@onready var timer = $Timer
@onready var monster_bite = $MonsterBite
@onready var progress_bar = $SubViewport/ProgressBar
@onready var label = $SubViewport/ProgressBar/Label
@onready var animated_sprite_3d = $AnimatedSprite3D
@onready var sub_viewport = $SubViewport
@onready var nav = $NavigationAgent3D
@onready var CONTROL_BULLET_EMISSION = Global.CONTROL_BULLET_EMISSION
@onready var catch_player = $CatchPlayer
@onready var symbol = $Control/Sprite3D2




@export_category("Atributos")
@export var move_speed = 5.0
@export var enemy_health = 15.0
@export var attack_range = 2.0
@export var minimum_distance = 15

@export_category("Recarregar Armas")
@export var l_ammo : int = 2
@export var m_ammo : int = 2
@export var n_ammo : float = 4

@export_category("Dano ao Player")
@export var damage = 2

func _ready():
	nav.target_position = player.global_transform.origin

func _physics_process(_delta):
	if dead:
		return
	if player == null:
		return
		
	var current_position = global_transform.origin
	var next_position = nav.get_next_path_position()
	var player_position = player.global_transform.origin
	var dist_to_player = current_position.distance_to(player_position)

	if dist_to_player <= minimum_distance:
		nav.target_position = player_position
		attempt_to_kill_player()
		
	var new_velocity = (next_position - current_position).normalized() * move_speed
	velocity = velocity.move_toward(new_velocity, 0.25)
	move_and_slide()

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

func kill_red_nf():
	damage_effect()
	enemy_health -= 2 * CONTROL_BULLET_EMISSION
	if enemy_health <= 0:
		killed()

func heal_red_nf():
	damage_effect()
	enemy_health -= CONTROL_BULLET_EMISSION * 0.2
	if enemy_health < 0:
		enemy_health = 0
	if enemy_health == 0:
		killed()

func kill_red_lf():
	damage_effect()
	enemy_health -= 2
	move_speed -= 2
	if move_speed < 2:
		move_speed = 2
	if enemy_health < 0:
		enemy_health = 0
	if enemy_health == 0:
		killed()

func heal_red_lf():
	damage_effect()
	enemy_health -= 1
	move_speed -= 1
	if move_speed < 2:
		move_speed = 2
	if enemy_health <= 0:
		killed()

func heal_red_mf():
	damage_effect()
	enemy_health -= 3
	if enemy_health <= 0:
		killed()

func kill_red_mf():
	damage_effect()
	enemy_health -= 7
	if enemy_health <= 0:
		killed()	

func killed():
	dead = true
	symbol.visible = false
	progress_bar.visible = false
	$DeathSound.play()
	animated_sprite_3d.play("death")
	$CollisionShape3D.disabled = true
	collision_layer = 0
	player.get_more_ammo(l_ammo, m_ammo, n_ammo)


func _on_timer_timeout():
	can_colide = true

func heal_green():
	enemy_health += 2

func _process(delta):
	if dead:
		return
	progress_bar.value = enemy_health
	label.set_text(str(int(enemy_health)))
	if enemy_health > 15:
		progress_bar.max_value = enemy_health

func damage_effect():
	animated_sprite_3d.modulate = Color.RED
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(animated_sprite_3d, "modulate", Color.WHITE, 0.3)

