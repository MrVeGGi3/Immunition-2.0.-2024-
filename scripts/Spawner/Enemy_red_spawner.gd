extends Node3D

@export var maximum_enemies = 5
@export var height_spawn_position = 3.0
@export var time_to_spawn = 5.0
# Called when the node enters the scene tree for the first time.
@onready var create_enemy_r_timer: Timer = $CreateEnemyRTimer
@onready var enemy_red = preload("res://scenes/Characters/enemy_r.tscn")

func spawnEnemyRed():
	var instance = enemy_red.instantiate()
	get_parent().add_child(instance)
	if instance.is_inside_tree():
		instance.global_transform.origin = global_transform.origin + Vector3(0, height_spawn_position,0) 
		Global.red_pathogen_spawned += 1
		create_enemy_r_timer.start()
		print("Patógeno Vermelho Spawnado")
	else:
		print("Patógeno Vermelho não foi Spawnado da Maneira Adequada")
		spawnEnemyRed()
		
func _on_timer_timeout():
	spawnEnemyRed()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_enemy_r_timer.wait_time = time_to_spawn

func start_timer():
	create_enemy_r_timer.start()
		
func stop_spawn():
	create_enemy_r_timer.stop()
