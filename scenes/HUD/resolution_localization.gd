extends Node
@onready var resolution_label: Label = $"../HBoxContainer/ResolutionLabel"



func _process(delta: float) -> void:
	resolution_label.text = tr("SCREEN_RESOLUTION")
