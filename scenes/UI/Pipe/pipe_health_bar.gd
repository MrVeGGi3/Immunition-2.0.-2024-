extends Control

@onready var pipes = get_tree().get_nodes_in_group("pipe")
@onready var pipe_percentage: Label = $Labels/PipePercentage1
@onready var pipe_life_bar: TextureProgressBar = $HealthBars/PipeLifeBar1
@onready var pipe_animation: AnimatedSprite2D = $PipeAnimation/PipeAnimation1
@onready var pipe_number: Label = $"PipeAnimation/PipeAnimation1/Counter 1/Number 1"

@onready var index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pipe_number.text = str(index + 1)
	pipe_percentage.text = str(pipes[index].get_pipe_life())
	pipe_life_bar.value = pipes[index].get_pipe_life()
	if pipes[index].get_destroyed():
		pipe_animation.play("broken")
	elif pipes[index].get_attacked():
		pipe_animation.play("attacked")
	elif pipes[index].get_restored():
		pipe_animation.play("confirm")
	else:
		pipe_animation.play("default")

func _next_index():
	index += 1
