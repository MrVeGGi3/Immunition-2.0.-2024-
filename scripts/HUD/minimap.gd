extends Control


@onready var color_rect = $ColorRect/SubViewportContainer/SubViewport/ColorRect
@export var target : NodePath
@export var camera_distance := 40.0 
@onready var player := get_node(target)
@onready var camera = $ColorRect/SubViewportContainer/SubViewport/Camera3D
@export var level : NodePath
@onready var world := get_node(level)
#@onready var screen_size = DisplayServer.window_get_size()
#var enemy_colorect = preload("res://scenes/icons/EnemyMinimapColorect.tscn")
#@onready var diff_size = Vector2(screen_size.x - color_rect.size.x, screen_size.y - color_rect.size.y)

func _process(_delta : float) -> void:
	if target:
		camera.size = camera_distance
		camera.position = Vector3(player.position.x, camera_distance, player.position.z)
	
	#var enemies_green = get_tree().get_nodes_in_group("green")
	#var enemies_blue = get_tree().get_nodes_in_group("blue")
	#var enemies_red = get_tree().get_nodes_in_group("red")
	

	
	#for g in enemies_green:
		#var g_colorect = enemy_colorect.instantiate()
		#var enemy_position = Vector2(g.global_position.x, g.global_position.y)
		#var real_position = enemy_position + diff_size
		#g_colorect.position = real_position
		#g_colorect.color = Color.SEA_GREEN
		#get_parent().add_child(g_colorect)

			
	#for b in enemies_blue:
		#var b_colorect = enemy_colorect.instantiate()
		#var enemy_position = Vector2(b.global_position.x, b.global_position.y)
		#var real_position = enemy_position + diff_size
		#b_colorect.position = real_position
		#b_colorect.color = Color.SKY_BLUE
		#get_parent().add_child(b_colorect)
	
		
	#for r in enemies_red:
		#var r_colorect = enemy_colorect.instantiate()
		#var enemy_position = Vector2(r.global_position.x, r.global_position.y)
		#var real_position = enemy_position + diff_size
		#r_colorect.position = real_position
		#r_colorect.color = Color.DARK_RED
		#get_parent().add_child(r_colorect)
		
	
	
