extends Control
@onready var world_scene = "res://scenes/Levels/world.tscn"
@onready var phase_selection = "res://scenes/HUD/level_selection.tscn"
@onready var shoot_sound = $Shoot
@onready var main_bgm = $MainBGM
func _ready():
	main_bgm.play()
	
func _on_voltar_pressed():
	get_tree().change_scene_to_file(phase_selection)
	
func _on_play_pressed():
	get_tree().change_scene_to_file(world_scene)
	
func _on_playsound_pressed():
	shoot_sound.play()
