extends CharacterBody3D

@export_category("Atributos")
@export var speed = 5
@export var life = 10
@export var original_color = Color(237,147,145,255)
@export var red_color = Color(255,0,0,255)
@export_category("Controle de Distância")
@export var distance_to_shoot = Vector3(5,5,5).normalized()
@export var keep_distance = Vector3()
@onready var CONTROL_BULLET_EMISSION = Global.CONTROL_BULLET_EMISSION
@export_category("Colisão com o Chão")
@export var floor_distance = 4
@export var floor_smoothness = 0.5
#Variável de comparação
var nearest_cell = null
#Variável de Controle
var is_moving = true
var is_shooting = false
var shoot_by_player = false
#Instâncias
var projectile = preload("res://scenes/testing/influenza_projectile.tscn")
#Referência de Localização
@onready var marker_3d = $Marker3D
#Timers
@onready var blink_cooldown = $BlinkCooldown
@onready var go_to_object = $GoToObject
@onready var shoot_time = $ShootTime
@onready var nav = $NavigationAgent3D

# Called when the node enters the scene tree for the first time.
func _ready():
	var pos_x = randf_range(0,4)
	var pos_y = randf_range(2,4)
	var pos_z = randf_range(0,4)
	keep_distance = Vector3(pos_x, pos_y, pos_z)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player = get_tree().get_nodes_in_group("player")
	var player_position = player[0].marker_3d.global_transform.origin + keep_distance
	var current_position = global_transform.origin
	var next_location = nav.get_next_path_position()
	var new_velocity = (next_location - current_position).normalized() * speed
	velocity = velocity.move_toward(new_velocity, .25)
	move_and_slide()
		
	if !is_shooting:
		shoot_player()
	if is_moving:
		var cells = get_tree().get_nodes_in_group("cell")
		nearest_cell = null
		var shortest_distance = INF
		
		# Encontre a célula mais próxima
		for c in cells:
			var cell_distance = (c.global_transform.origin - current_position).length()
			if cell_distance < shortest_distance:
				shortest_distance = cell_distance
				nearest_cell = c

		if nearest_cell:
			var nearest_cell_position = nearest_cell.global_transform.origin
			nav.target_position = nearest_cell_position
		else:
			nav.target_position = player_position
				
		
		if current_position.distance_to(player_position) <= shortest_distance and !is_shooting:
				nav.target_position = player_position
				
		if shoot_by_player:
			nav.target_position = player_position
			
		
		
func _on_go_to_object_timeout():
	is_moving = true

func shoot_player():
	var new_projectile = projectile.instantiate()
	new_projectile.global_transform.origin = marker_3d.global_transform.origin
	get_parent().add_child(new_projectile)
	is_shooting = true
	shoot_time.start()

func _on_shoot_time_timeout():
	is_shooting = false
	
func hit_by_lf(damage, speed_down):
	life -= damage
	speed -= speed_down
	shoot_by_player = true
	if life <= 0:
		Global.influenza_destroyed += 1 
		print("Eu destruí:", Global.influenza_destroyed)
		queue_free()

func hit_by_mf(damage):
	life -= damage
	shoot_by_player = true
	if life <= 0:
		Global.influenza_destroyed += 1 
		print("Eu destruí:", Global.influenza_destroyed)
		queue_free()
	
func hit_by_nf(damage):
	life -= damage * CONTROL_BULLET_EMISSION
	shoot_by_player = true
	if life <= 0:
		Global.influenza_destroyed += 1
		print("Eu destruí:", Global.influenza_destroyed)
		queue_free()

	