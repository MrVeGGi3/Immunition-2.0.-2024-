class_name InfectedCell
extends CharacterBody3D

@export_category("Atributos")
@export var speed = 5
@export var life = 5
@export var damage = 2
@export_category("Variáveis de Spawn")
@export var spawn_collision : int = 2
@export var spawn_destroyed : int = 1
#Variável de Controle
var is_hitting = false
@onready var collision_timer = $CollisionTimer
@onready var influenza = preload("res://scenes/testing/Influenza.tscn")
#Raycasts
@onready var explosion = preload("res://scenes/testing/explosion.tscn")
@onready var marker_3d = $Marker3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
		var player = get_tree().get_nodes_in_group("player")
		var player_position = player[0].hit_marker_explosion.global_transform.origin
		var player_distance = (player_position - global_transform.origin).normalized()
		var movement = player_distance * speed * delta
		if global_transform.origin.distance_to(player_position) <= movement.length():
			global_transform.origin = player_position
		else:
			global_transform.origin += movement
		
		if global_transform.origin.distance_to(player_position) <= 1 and !is_hitting:
			var new_explosion = explosion.instantiate()
			new_explosion.global_transform.origin = marker_3d.global_transform.origin
			get_parent().add_child(new_explosion)
			is_hitting = true
			
		if is_hitting:
			queue_free()
			spawn_influenza(spawn_collision)
			print("Fui spawnado após entrar em colisão com o player")
				
func spawn_influenza(spawn):
	for i in range(spawn):
		var new_influenza = influenza.instantiate()
		new_influenza.global_transform.origin = global_transform.origin
		get_parent().add_child(new_influenza)

func hit(damage_by_player, speed_down):
	life -= damage_by_player
	speed -= speed_down
	print("Célula Infectada - Recebi dano")
	if life <= 0:
		Global.infected_cells_destroyed += 1
		kill()
	
func kill():
	queue_free()
	spawn_influenza(spawn_destroyed)
	print("Fui spawnado após ser destruído")
	
