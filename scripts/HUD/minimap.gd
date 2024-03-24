extends Control


@onready var color_rect = $ColorRect/SubViewportContainer/ColorRect
@export var target : NodePath
@export var camera_distance := 40.0 
@onready var player := get_node(target)
@onready var camera = $ColorRect/SubViewportContainer/SubViewport/Camera3D
	
func _process(delta : float) -> void:
	if target:
		camera.size = camera_distance
		camera.position = Vector3(player.position.x, camera_distance, player.position.z)
	
