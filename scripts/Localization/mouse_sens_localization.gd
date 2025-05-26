extends Node
@onready var mouse_sens_label: Label = $"../MouseSensLabel"

func _process(delta: float) -> void:
	mouse_sens_label.text = tr("MOUSE_SENSIBILITY")
