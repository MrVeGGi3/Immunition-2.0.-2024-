extends ProgressBar
@onready var progress_bar = $"."

var group_colours = {
	"blue" : Color(hex_to_rgba("0662b5")),
	"red"  : Color(hex_to_rgba("b9002f")),
	"green": Color(hex_to_rgba("247523"))
}
# Called when the node enters the scene tree for the first time.
func _ready():
	var groups = get_groups()
	for group in groups:
		progress_bar.set_tint(group_colours[group])
		break
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hex_to_rgba(hex):
	var red = hex >> 24 & 0xFF
	var green = hex >> 16 & 0xFF
	var blue = hex >> 8 & 0xFF
	var alpha = hex & 0xFF
	return Color(red / 255.0, green / 255.0, blue / 255.0, alpha / 255.0)
