extends CharacterBody3D

#Variáveis
@export var move_speed = 5.0
@export var attack_range = 2.0
var enemy_health = 15
#Booleanas
var dead = false
var can_colide = true
#Instâncias
@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var timer = $Timer
@onready var monster_bite = $MonsterBite
@onready var progress_bar = $SubViewport/ProgressBar
@onready var label = $SubViewport/ProgressBar/Label
@onready var animated_sprite_3d = $AnimatedSprite3D
@onready var sub_viewport = $SubViewport

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
	enemy_health -= 5
	if enemy_health <= 0:
		dead = true
		progress_bar.visible = false
		$DeathSound.play()
		animated_sprite_3d.play("death")
		$CollisionShape3D.disabled = true
		collision_layer = 0

func _on_timer_timeout():
	can_colide = true
	
func heal_green():
	enemy_health += 2

func _process(_delta):
	progress_bar.value = enemy_health
	label.set_text(str(enemy_health))
	if enemy_health > 15:
		progress_bar.max_value = enemy_health
		

