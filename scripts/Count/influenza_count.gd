extends Control

@onready var timer = $Control2/Control/Timer
var can_count = false
@onready var count: Timer = $Control2/Count


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var minutes = 0
	timer.text = str("%02d:%02d" %[minutes, floori(count.time_left)])

func _start_count():
	count.start()
	print("Timer Iniciado")
