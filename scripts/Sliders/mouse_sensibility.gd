extends HSlider

@onready var mouse_slider = $"."
@export var camera : Camera3D = null
var mouse_sensibility = null
# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_slider.value = Global.mouse_sens
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_changed(value: float) -> void:
	mouse_sensibility = value
	Global.mouse_sens = mouse_sensibility
