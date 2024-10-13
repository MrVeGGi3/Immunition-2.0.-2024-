extends Control

var seconds
var minutes
var elapsed_time
@onready var timer: Label = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	seconds = 0
	minutes = 0
	elapsed_time = 0 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	if elapsed_time >= 1.0:
		seconds += 1.0
		elapsed_time = 0.0
		if seconds >= 60:
			minutes += 1
			seconds = 0
	timer.text = "%02d:%02d" %[minutes, floori(seconds)]
