extends CharacterBody3D

@onready var animated_sprite_3d = $AnimatedSprite3D
@export var move_speed = 5.0
@export var attack_range = 2.0
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
var dead = false
@onready var timer = $Timer
var can_colide = true
@onready var monster_bite = $MonsterBite

func _physics_process(_delta):
	if dead:
		return
	if player == null:
		return
	var dir = player.global_transform.origin - global_transform.origin
	dir = dir.normalized()
	velocity = dir * move_speed
	move_and_slide()
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

func kill_red():
	dead = true
	$DeathSound.play()
	animated_sprite_3d.play("death")
	$CollisionShape3D.disabled = true
	collision_layer = 0

func _on_timer_timeout():
	can_colide = true
