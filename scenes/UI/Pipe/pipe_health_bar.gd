extends Control

@onready var pipes = get_tree().get_nodes_in_group("pipe")
#Porcentagens
@onready var pipe_percentage_1: Label = $Labels/PipePercentage1
@onready var pipe_percentage_2: Label = $Labels/PipePercentage2
@onready var pipe_percentage_3: Label = $Labels/PipePercentage3
@onready var pipe_percentage_4: Label = $Labels/PipePercentage4
@onready var pipes_percentages = [pipe_percentage_1, pipe_percentage_2, pipe_percentage_3, pipe_percentage_4]
#HealthBars
@onready var pipe_life_bar_1: TextureProgressBar = $HealthBars/PipeLifeBar1
@onready var pipe_life_bar_2: TextureProgressBar = $HealthBars/PipeLifeBar2
@onready var pipe_life_bar_3: TextureProgressBar = $HealthBars/PipeLifeBar3
@onready var pipe_life_bar_4: TextureProgressBar = $HealthBars/PipeLifeBar4
@onready var pipes_life_bar = [pipe_life_bar_1, pipe_life_bar_2, pipe_life_bar_3, pipe_life_bar_4]
#AnimatedSprites3D
@onready var pipe_animation_1: AnimatedSprite2D = $PipeAnimation/PipeAnimation1
@onready var pipe_animation_2: AnimatedSprite2D = $PipeAnimation/PipeAnimation2
@onready var pipe_animation_3: AnimatedSprite2D = $PipeAnimation/PipeAnimation3
@onready var pipe_animation_4: AnimatedSprite2D = $PipeAnimation/PipeAnimation4
@onready var pipes_animations = [pipe_animation_1, pipe_animation_2, pipe_animation_3, pipe_animation_4]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(pipes.size()):
		pipes_life_bar[i].max_value = pipes[i].max_life
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(pipes.size()):
		pipes_life_bar[i].value = pipes[i].get_pipe_life()
		pipes_percentages[i].text = str(pipes[i].get_pipe_life())
		if pipes[i].get_destroyed():
			pipes_animations[i].play("broken")
		elif pipes[i].get_attacked():
			pipes_animations[i].play("attacked")
		else:
			pipes_animations[i].play("default")
	
