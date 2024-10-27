extends Node3D

@export var maximum_enemies = 5
@export var height_spawn_position = 3.0
@export var time_to_spawn = 5.0
# Called when the node enters the scene tree for the first time.
@onready var create_enemy_g_timer: Timer = $CreateEnemyGTimer
@onready var enemy_green = preload("res://scenes/Characters/enemy_g.tscn")

func spawnEnemyGreen():
	var instance = enemy_green.instantiate()
	get_parent().add_child(instance)
	if instance.is_inside_tree():
		instance.global_transform.origin = global_transform.origin + Vector3(0, height_spawn_position,0) 
		Global.green_pathogen_spawned += 1
		create_enemy_g_timer.start()
		print("Patógeno Verde Spawnado")
	else:
		print("Patógeno Verde não foi Spawnado da Maneira Adequada")
		
func _on_timer_timeout():
	spawnEnemyGreen()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_enemy_g_timer.wait_time = time_to_spawn
	create_enemy_g_timer.start()
