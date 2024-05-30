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
#Variável de comparação
var nearest_cell = null
#Variável de Controle
var is_moving = true
var is_shooting = false
var shoot_by_player = false
#Instâncias
@onready var mesh_instance_influenza = $MeshInstance3Ds
var projectile = preload("res://scenes/testing/influenza_projectile.tscn")
#Referência de Localização
@onready var marker_3d = $Marker3D
#Timers
@onready var blink_cooldown = $BlinkCooldown
@onready var go_to_object = $GoToObject
@onready var shoot_time = $ShootTime


# Called when the node enters the scene tree for the first time.
func _ready():
	var pos_x = randf_range(0,4)
	var pos_y = randf_range(2,4)
	var pos_z = randf_range(0,4)
	keep_distance = Vector3(pos_x, pos_y, pos_z)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_shooting:
		shoot_player()
	if is_moving:
		var cells = get_tree().get_nodes_in_group("cell")
		nearest_cell = null
		var shortest_distance = INF
		var current_position = global_transform.origin
		# Encontre a célula mais próxima
		for c in cells:
			var cell_distance = (c.global_transform.origin - current_position).length()
			if cell_distance < shortest_distance:
				shortest_distance = cell_distance
				nearest_cell = c

		if nearest_cell:
			var nearest_cell_position = nearest_cell.global_transform.origin
			var direction = (nearest_cell_position - current_position).normalized()
			var movement = direction * speed * delta
			
			# Verifique se está perto o suficiente para chegar na célula
			if current_position.distance_to(nearest_cell_position) <= movement.length():
				global_transform.origin = nearest_cell_position
				is_moving = false  
				go_to_object.start()
			else:
				global_transform.origin += movement
				
				
		var player = get_tree().get_nodes_in_group("player")
		var player_position = player[0].marker_3d.global_transform.origin + keep_distance
		var player_distance = (player_position - global_transform.origin).normalized()
		if global_transform.origin.distance_to(player_position) <= shortest_distance:
			var movement = player_distance * speed * delta
			if global_transform.origin.distance_to(player_position) <= movement.length() and !is_shooting:
				global_transform.origin = Vector3(player_position.x, player_position.y + 1, player_position.z)
				go_to_object.start()
			else:
				global_transform.origin += movement
				
		if shoot_by_player:
			var movement = player_distance * speed * delta
			if global_transform.origin.distance_to(player_position) <= movement.length() and !is_shooting:
				global_transform.origin = Vector3(player_position.x, player_position.y + 1, player_position.z)
				go_to_object.start()
			else:
				global_transform.origin += movement
		
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
	if life <= 0:
		Global.influenza_destroyed += 1 
		print("Eu destruí:", Global.influenza_destroyed)
		queue_free()
	
func hit_by_nf(damage):
	life -= damage * CONTROL_BULLET_EMISSION
	if life <= 0:
		Global.influenza_destroyed += 1
		print("Eu destruí:", Global.influenza_destroyed)
		queue_free()

