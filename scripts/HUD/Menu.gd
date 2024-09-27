extends Control
@onready var world_scene = "res://scenes/Levels/world.tscn"
@onready var option_scene = "res://scenes/HUD/options_menu.tscn"
@onready var level_selection = "res://scenes/HUD/level_selection.tscn"
@onready var credits = "res://scenes/Credits.tscn"
@onready var main_bgm = $MainBGM
@onready var button_selected: AudioStreamPlayer = $ButtonSelected


func _ready():
	main_bgm.play()
	
	if !main_bgm.playing:
		main_bgm.play()
	
func _on_play_pressed():
	play_music_button()
	get_tree().change_scene_to_file(world_scene)

func _on_options_pressed():
	play_music_button()
	get_tree().change_scene_to_file(option_scene)

func _on_exit_pressed():
	play_music_button()
	get_tree().quit()
  
func _on_créditos_pressed():
	button_selected.play()
	get_tree().change_scene_to_file(credits)

func play_music_button():
	button_selected.play()
	
