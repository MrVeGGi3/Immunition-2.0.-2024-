extends Control
@onready var main_bgm = $MainBGM
@onready var shoot = $Shoot
var menu = "res://scenes/HUD/menu.tscn"

func _ready():
	visible = false
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = true
		main_bgm.play()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		visible = true
	
func _on_voltar_ao_jogo_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	main_bgm.stop()
	visible = false
	get_tree().paused = false
	
func _on_backto_main_menu_pressed():
	get_tree().change_scene_to_file(menu)
	
func _on_test_sfx_pressed():
	shoot.play()
