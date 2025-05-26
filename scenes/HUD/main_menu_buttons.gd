extends VBoxContainer

@onready var play_button: Button = $Play
@onready var options_button: Button = $Options
@onready var exit_button: Button = $Exit
@onready var credits_button: Button = $Créditos


func _process(delta: float) -> void:
	play_button.text = tr("PLAY_GAME_BUTTON")
	options_button.text = tr("OPTION_GAME_BUTTON")
	exit_button.text = tr("QUIT_GAME_BUTTON")
	credits_button.text = tr("CREDITS_BUTTON")
	
