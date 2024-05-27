extends Node

var mouse_sens = 0.5
var c_shoot = true
var c_shoot_mf = false
var c_shoot_nf = false
var m1_active = true
var m2_active = false
var m3_active = false
const CONTROL_BULLET_EMISSION = 2
var is_paused = false

#placar e pontuação
var contamined_cells : int = 0
var cells_in_scene : int = 0
var influenza_destroyed : int = 0
var infected_cells_destroyed : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
