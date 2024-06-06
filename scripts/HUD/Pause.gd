extends Control

@onready var shoot = $Shoot
var menu = "res://scenes/HUD/menu.tscn"
@onready var wheel_switch_weapons = $"../WheelSwitchWeapons"
@onready var pause_menu = $"."
@onready var memory_system = $"../MemorySystem"


func _ready():
	visible = false
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and !visible:
		visible = true
		get_tree().paused = true
		wheel_switch_weapons.hide()
		memory_system.hide()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	elif Input.is_action_pressed("ui_cancel") and visible:
		_on_voltar_ao_jogo_pressed()
	
func _on_voltar_ao_jogo_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	visible = false
	get_tree().paused = false
	
func _on_backto_main_menu_pressed():
	get_tree().change_scene_to_file(menu)
	
func _on_test_sfx_pressed():
	shoot.play()
	
