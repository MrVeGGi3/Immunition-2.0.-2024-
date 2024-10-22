extends Control
@onready var world_scene = "res://scenes/Levels/world.tscn"
@onready var menu = "res://scenes/HUD/menu.tscn"
@onready var shoot_sound = $Shoot
@onready var main_bgm = $MainBGM
@onready var button_selected: AudioStreamPlayer = $ButtonSelected

func _ready():
	main_bgm.play()
	
func _on_voltar_pressed():
	play_button_pressed()
	get_tree().change_scene_to_file(menu)
	
func _on_play_pressed():
	play_button_pressed()
	get_tree().change_scene_to_file(world_scene)
	
func _on_playsound_pressed():
	play_button_pressed()
	shoot_sound.play()

func play_button_pressed():
	button_selected.play()
