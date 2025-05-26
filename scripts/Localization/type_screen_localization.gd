extends Node

@onready var type_screen_label: Label = $"../HBoxContainer/TypeScreenLabel"

func _process(delta: float) -> void:
	type_screen_label.text = tr("SCREEN_TYPE")
