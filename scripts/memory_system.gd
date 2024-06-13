extends Control

var m1 = Global.m1_active
var m2 = Global.m2_active
var m3 = Global.m3_active

@onready var m1_selected = $"Memorias/Memoria 1/M1_Selected"
@onready var m2_selected = $"Memorias/Memoria 2/M2_Selected"
@onready var m3_selected = $"Memorias/Memoria 3/M3_Selected"
@onready var pause_menu = $"../pause_menu"
@onready var wsw = $"../WheelSwitchWeapons"


@export var player:CharacterBody3D = null

var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("call_memory_system") and !wsw.visible:
		get_tree().paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	elif Input.is_action_just_pressed("call_memory_system"):
		_disable_visibility()
		get_tree().paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
	if Input.is_action_just_pressed("roll_up"):
		if count == 0:
			count = 2
			activate_memory(count)
			print(count)
		else:
			count -= 1
			activate_memory(count)
			print(count)
	if Input.is_action_just_pressed("roll_down"):
		if count == 2:
			count = 0
			activate_memory(count)
			print(count)
		else:
			count += 1
			activate_memory(count)
			print(count)


func _on_memoria_1_pressed():
	m1 = true
	m2 = false
	m3 = false
	m1_selected.visible = true
	set_global_memory_variables(m1, m2, m3)
	change_button_animation_state(m2_selected, m3_selected)
	_disable_visibility()

func _on_memoria_2_pressed():
	m1 = false
	m2 = true
	m3 = false
	m2_selected.visible = true
	set_global_memory_variables(m1, m2, m3)
	change_button_animation_state(m1_selected, m3_selected)
	_disable_visibility()
	
func _on_memoria_3_pressed():
	m1 = false
	m2 = false
	m3 = true
	m3_selected.visible = true
	set_global_memory_variables(m1, m2, m3)
	change_button_animation_state(m1_selected, m2_selected)
	_disable_visibility()
	
func set_global_memory_variables(variavel, variavel2, variavel3):
	Global.m1_active = variavel
	Global.m2_active = variavel2
	Global.m3_active = variavel3

func activate_memory(number):
	if number == 0:
		_on_memoria_1_pressed()
	elif number == 1:
		_on_memoria_2_pressed()
	elif number == 2:
		_on_memoria_3_pressed()

func change_button_animation_state(b1, b2):
	b1.visible = false
	b2.visible = false
	
func _disable_visibility():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
