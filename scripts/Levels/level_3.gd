extends Node3D

@onready var pipes = get_tree().get_nodes_in_group("pipe")
@onready var pipe_health_bar: Control = $PipeHealthBar
@onready var timer_counter: Control = $TimerCounter

var index = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(1, pipes.size()):
		pipes[i].visible = false
	disable_visiblity()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pipes[index].get_actioned():
		enable_visiblity()


func _on_count_timeout() -> void:
	disable_visiblity()
	pipes[index].time_end()
	index += 1
	
	
func disable_visiblity():
	pipe_health_bar.visible = false
	timer_counter.visible = false
	
func enable_visiblity():
	pipe_health_bar.visible = true
	timer_counter.visible = true
	
