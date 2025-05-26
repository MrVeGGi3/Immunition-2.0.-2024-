extends Node
@onready var testar_sfx: Button = $"../TestarSFX"
@onready var voltar_button: Button = $"../Voltar"
@onready var jogar_button: Button = $"../Jogar"
@onready var options_title_label: Label = $"../../Options"


func _process(delta: float) -> void:
	testar_sfx.text = tr("TEST_SFX_BUTTON")
	voltar_button.text = tr("BACK_BUTTON")
	jogar_button.text = tr("PLAY_GAME_BUTTON")
	options_title_label.text = tr("OPTION_GAME_BUTTON")
