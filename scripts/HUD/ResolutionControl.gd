extends Control
@onready var option_button = %ResolutionButton


const RESOLUTION_DICTIONARY : Dictionary = {
		"1152 x 648" : Vector2i(1152,648),
		"800 x 600"  : Vector2i(800,600),
		"1280 x 720" : Vector2i(1280, 720),
		"1920 x 1080" : Vector2i(1920,1080)

}


# Called when the node enters the scene tree for the first time.
func _ready():
	option_button.item_selected.connect(on_resolution_selected)
	add_resolutions_items()
	
func add_resolutions_items() -> void:
	for resolution_size_text in RESOLUTION_DICTIONARY:
		option_button.add_item(resolution_size_text)

func on_resolution_selected(index : int) -> void:
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

	
