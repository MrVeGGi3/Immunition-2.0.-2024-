extends Node
@onready var description: Label = $"../Description"

func _process(delta: float) -> void:
	description.text = tr("PHASE_1_CONDITION_2")
