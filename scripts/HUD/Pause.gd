extends Control
@onready var main_bgm = $MainBGM
@onready var shoot = $Shoot
var menu = "res://scenes/HUD/menu.tscn"
@onready var wheel_switch_weapons = $"../WheelSwitchWeapons"
const MINIMAP = preload("res://scenes/HUD/minimap.tscn")
@onready var is_paused = Global.is_paused

func _ready():
	visible = false
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true
		wheel_switch_weapons.hide()
		main_bgm.play()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	if Input.is_action_just_pressed("ui_cancel") and is_paused:
		_on_voltar_ao_jogo_pressed()
	
func _on_voltar_ao_jogo_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	main_bgm.stop()
	visible = false
	get_tree().paused = false
	
func _on_backto_main_menu_pressed():
	get_tree().change_scene_to_file(menu)
	
func _on_test_sfx_pressed():
	shoot.play()
	
func set_global_pause(variavel : bool):
	Global.is_paused = variavel
	
