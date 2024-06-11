extends Control

@onready var player = get_tree().get_first_node_in_group("player")
var phase_change = preload("res://scenes/HUD/level_selection.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _on_go_to_menu_pressed():
	get_tree().change_scene_to_file(phase_change)


