extends Control

var timer_out = false
@onready var timer = $Control2/Control/Timer
var can_count = false
@export var time_to_count = 30.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !timer_out and can_count:
		time_to_count -= delta
		var time_elapsed_in_seconds = floori(time_to_count)
		var seconds = time_elapsed_in_seconds % 60
		var minutes = 0
		timer.text = "%02d:%02d" %[minutes, seconds]
		if seconds <= 0:
			timer_out = true
			visible = false
	
