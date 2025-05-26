extends Node

@onready var next_phase: Button = $"../Panel/NextPhase"
@onready var obrigado: Label = $"../Panel/Obrigado"
@onready var parabéns: Label = $"../Panel/Parabéns"


func _process(delta: float) -> void:
	parabéns.text = tr("CONGRATULATIONS")
	obrigado.text = tr("TUTORIAL_ENDED")
	next_phase.text = tr("NEXT_LEVEL_BUTTON")
