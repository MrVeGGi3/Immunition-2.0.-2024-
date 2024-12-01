extends CharacterBody3D
#Variáveis
@export_category("Atributos")
@export var move_speed = 5.0 
@export var attack_range = 2.0
@export var enemy_health = 15
@export var minimum_distance = 10

@export_category("Recarregar Armas")
@export var l_ammo : int = 2
@export var m_ammo : int = 1
@export var n_ammo : float = 5

@export_category("Dano ao Player")
@export var damage = 2

@export_category("Propriedades")
var can_colide = true
var dead = false
var is_pipe_attacked = false
var is_force_applied = false
var can_follow_player = true

@export_category("Força Aplicada do Rigidbody")
var force_x = 0.0
var force_y = 0.0
var force_z = 100.0
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
@onready var symbol = $IconControl
@onready var rc: RayCast3D = $RayCast3D

#Variáveis de Armazenamento
var nearest_pipe
var pipe_shortest_distance
var current_position
var player_position 

func _ready() -> void:
	pass
	
func _physics_process(delta):
	if dead:
		return
	current_position = global_transform.origin
	var next_position = nav.get_next_path_position()
	var new_velocity = (next_position - current_position).normalized()
	velocity = velocity.move_toward(new_velocity, move_speed)
	move_and_slide()
	
	
	if player == null:
		return
	player_position = player.marker_3d.global_transform.origin
	rc.look_at(player_position)
	
	if rc.is_colliding() and can_follow_player:
		var collider = rc.get_collider()
		if collider == player:
			nav.target_position = player_position
	
	var dist_to_player = global_transform.origin.distance_to(player_position)
	if  dist_to_player <= minimum_distance and !is_pipe_attacked:
		can_follow_player = true
		attempt_to_kill_player()
		
	var pipes = get_tree().get_nodes_in_group("pipe")
	if pipes.is_empty():
		return
	nearest_pipe = null
	pipe_shortest_distance = INF
	
	for pipe in pipes:
		if pipe.visible == true:
			var pipe_position = pipe.global_transform.origin
			var distance_to_pipe = current_position.distance_to(pipe_position)
			if distance_to_pipe <  pipe_shortest_distance:
				pipe_shortest_distance = distance_to_pipe
				nearest_pipe = pipe
		if nearest_pipe != null and pipe_shortest_distance <= minimum_distance and pipe_shortest_distance < dist_to_player and !pipe.get_destroyed():
			nav.target_position = nearest_pipe.global_transform.origin
			can_follow_player = false
		else:
			can_follow_player = true
			attempt_to_kill_player()
	
	if is_force_applied:
		if velocity.z != 0:
			velocity.z = lerp(velocity.z, 0, 0.1 * delta)
		else:
			is_force_applied = false		
	
		

func attempt_to_kill_player():
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
		print("O número de Patógenos derrotados é:", Global.pathogen_killed)
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

func attack_pipe(pipe):
	monster_bite.play()
	is_pipe_attacked = true
	pipe.damage(damage)
		
func _backward_force():
	print("Estou sendo empurrado pela explosão")
	var opposite_direction_z = -transform.basis.z.normalized()
	velocity = Vector3(force_x, force_y, force_z) * opposite_direction_z
	is_force_applied = true

func _time_ended():
	queue_free()
