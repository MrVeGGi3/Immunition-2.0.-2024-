extends HSlider

@onready var mouse_slider = $"."
var mouse_sensibility = null
# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_slider.value = Global.mouse_sens
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_value_changed(value):
	mouse_sensibility = value
	Global.mouse_sens = mouse_sensibility
	print("A sensibilidade do mouse é:", mouse_sensibility)
