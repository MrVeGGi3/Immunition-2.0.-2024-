extends Control

@onready var timer = $Control2/Control/Timer
var can_count = false
@export var time_to_count = 30.0
@onready var count = $Control2/Count

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(floori(count.time_left))
	var minutes = 0
	timer.text = "%02d:%02d" %[minutes, floori(count.time_left)]


