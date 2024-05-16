extends CharacterBody3D
#Variveis
@export var move_speed = 7.0
@export var attack_range = 2.0
var enemy_health = 15
var minimum_distance = 10
#Booleanas
var dead = false
var can_colide = true
#Instancias
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var animated_sprite_3d = $AnimatedSprite3D
@onready var timer = $Timer
@onready var monster_bite = $MonsterBite
@onready var progress_bar = $SubViewport/ProgressBar
@onready var label = $SubViewport/ProgressBar/Label
@onready var sub_viewport = $SubViewport
#Variáveis Globais
@onready var CONTROL_BULLET_EMISSION = Global.CONTROL_BULLET_EMISSION

func _physics_process(_delta):
	if dead:
		return
	if player == null:
		return
	var dir = player.global_transform.origin - global_transform.origin
	dir = dir.normalized()
	velocity = dir * move_speed
	move_and_slide()
	var dist_to_player = global_transform.origin.distance_to(player.global_transform.origin)
	if dist_to_player <= minimum_distance:
		attempt_to_kill_player()

func attempt_to_kill_player():
	var dist_to_player = global_transform.origin.distance_to(player.global_transform.origin)
	if dist_to_player > attack_range:
		return
	var eye_line = Vector3.UP * 1.0
	var query = PhysicsRayQueryParameters3D.create(global_transform.origin + eye_line, player.global_transform.origin + eye_line, 1)
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	if result.is_empty() and can_colide and player.vida > 0:
		monster_bite.play()
		player.damage()
		can_colide = false
		timer.start()

func kill_green_lf():
	enemy_health -= 5
	move_speed -= 2
	if move_speed < 2:
		move_speed = 2
	if enemy_health < 0:
		enemy_health = 0
	if enemy_health == 0:
		killed()

func kill_green_mf():
	enemy_health -= 7
	if enemy_health < 0:
		enemy_health = 0
	if enemy_health == 0:
		killed()

func kill_green_nf():
	enemy_health -= CONTROL_BULLET_EMISSION * 2
	if enemy_health < 0:
		enemy_health = 0
	if enemy_health == 0:
		killed()
	
func heal_green_lf():
	enemy_health -= 2
	move_speed -= 1
	if move_speed < 2:
		move_speed = 2
	if enemy_health < 0:
		enemy_health = 0
	if enemy_health == 0:
		killed()

func heal_green_mf():
	enemy_health -= 3
	if enemy_health < 0:
		enemy_health = 0
	if enemy_health == 0:
		killed()
		
func heal_green_nf():
	enemy_health -= CONTROL_BULLET_EMISSION * 0.5
	if enemy_health < 0:
		enemy_health = 0
	if enemy_health == 0:
		killed()

func _on_timer_timeout():
	can_colide = true

func _process(_delta):
	progress_bar.value = enemy_health
	label.set_text(str(int(enemy_health)))
	if enemy_health > 15:
		progress_bar.max_value = enemy_health

func killed():
	if enemy_health <= 0:
		dead = true
		$DeathSound.play()
		progress_bar.visible = false
		animated_sprite_3d.play("death")
		$CollisionShape3D.disabled = true
		collision_layer = 0
		

