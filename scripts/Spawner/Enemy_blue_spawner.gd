extends Node3D

@export var maximum_enemies = 5
@export var height_spawn_position = 3.0
@export var time_to_spawn = 5.0
# Called when the node enters the scene tree for the first time.
@onready var create_enemy_b_timer: Timer = $CreateEnemyBTimer
@onready var enemy_blue = preload("res://scenes/Characters/enemy_b.tscn")

func spawnEnemyBlue():
	var instance = enemy_blue.instantiate()
	get_parent().add_child(instance)
	if instance.is_inside_tree():
		instance.global_transform.origin = global_transform.origin + Vector3(0, height_spawn_position, 0) 
		Global.blue_pathogen_spawned += 1
		create_enemy_b_timer.start()
		print("Patógeno Azul Spawnado")
	else:
		print("Patógeno Azul não foi Spawnado da Maneira Adequada")
		spawnEnemyBlue()
	
func _on_timer_timeout():
	spawnEnemyBlue()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_enemy_b_timer.wait_time = time_to_spawn
	create_enemy_b_timer.start()
