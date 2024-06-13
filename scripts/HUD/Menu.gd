extends Control
@onready var world_scene = "res://scenes/Levels/world.tscn"
@onready var option_scene = "res://scenes/HUD/options_menu.tscn"
@onready var level_selection = "res://scenes/HUD/level_selection.tscn"
@onready var credits = "res://scenes/Credits.tscn"
@onready var main_bgm = $MainBGM

func _ready():
	main_bgm.play()
	
func _on_play_pressed():
	get_tree().change_scene_to_file(world_scene)

func _on_options_pressed():
	get_tree().change_scene_to_file(option_scene)

func _on_exit_pressed():
	get_tree().quit()
  
func _on_créditos_pressed():
	get_tree().change_scene_to_file(credits)
