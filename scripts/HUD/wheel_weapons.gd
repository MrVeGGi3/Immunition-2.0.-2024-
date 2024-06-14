extends Control


@onready var green_button = $Wheel/Green/GreenButton
@onready var blue_button = $Wheel/Blue/BlueButton
@onready var red_button = $Wheel/Red/RedButton
@export var player : CharacterBody3D = null
@onready var ms = $"../MemorySystem"

var weapon_selected = null

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	weapon_selected = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var can_shoot = Global.c_shoot
	var can_shoot_mf = Global.c_shoot_mf
	var can_shoot_nf = Global.c_shoot_nf
	
	if can_shoot:
		green_button.play("selected")
	elif can_shoot_mf:
		blue_button.play("selected")
	elif can_shoot_nf:
		red_button.play("selected")
	
	if Input.is_action_just_pressed("weapon_wheel") and !weapon_selected and !ms.visible:
		visible = true
		get_tree().paused = true
		weapon_selected = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
		
	elif Input.is_action_just_pressed("weapon_wheel") and weapon_selected and !ms.visible:
		visible = false
		get_tree().paused = false
		weapon_selected = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	

#Botão da Arma Verde
func _on_green_mouse_entered():
	green_button.play("hover")
	
func _on_green_mouse_exited():
	green_button.play("normal")


#Botão da Arma Azul
func _on_blue_mouse_entered():
	blue_button.play("hover")
	
func _on_blue_mouse_exited():
	blue_button.play("normal")

#Botão da Arma Vermelha
func _on_red_mouse_entered():
	red_button.play("hover")
func _on_red_mouse_exited():
	red_button.play("normal")

#Botões Pressionados
func _on_green_pressed():
	player.change_linfocit()
	green_button.play("selected")
	disable_animations(blue_button, red_button)
	_disable_wheel()
	
func _on_blue_pressed():
	player.change_macrofage()
	blue_button.play("selected")
	disable_animations(green_button, red_button)
	_disable_wheel()
	
func _on_red_pressed():
	player.change_neutrofile()
	red_button.play("selected")
	disable_animations(green_button, blue_button)
	visible = false
	_disable_wheel()
	
func disable_animations(botao1, botao2):
	botao1.play("normal")
	botao2.play("normal")

func set_global_bool(variavel, variavel2, variavel3):
	Global.c_shoot = variavel
	Global.c_shoot_mf = variavel2
	Global.c_shoot_nf = variavel3
	
func _disable_wheel():
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
