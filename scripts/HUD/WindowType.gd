extends Control
@onready var option_button = %OptionButton as OptionButton

var WINDOW_MODE_ARRAY: Array[String] = [
		tr("WINDOWED_MODE"),
		tr("FULLSCREEN_MODE"),
		tr("NO_EDGE_MODE"),
		tr("FULLSCREEN_NO_EDGE")
]


func update_window_language():
	WINDOW_MODE_ARRAY = [
		tr("WINDOWED_MODE"),
		tr("FULLSCREEN_MODE"),
		tr("NO_EDGE_MODE"),
		tr("FULLSCREEN_NO_EDGE")
	]
	print(WINDOW_MODE_ARRAY)
	add_window_mode_items()


# Called when the node enters the scene tree for the first time.
func _ready():
	add_window_mode_items()
	option_button.item_selected.connect(on_window_mode_selected)
	
	
func on_window_mode_selected(index : int) -> void:
	match index:
		0: 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)	
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)	
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)	
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)	
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			
func add_window_mode_items() -> void:
	option_button.clear()
	for window_mode in WINDOW_MODE_ARRAY:
		option_button.add_item(window_mode)
	
