extends AnimationTree

@onready var animation_tree: AnimationTree = $"."
@onready var animação: AnimationPlayer = $"../AnimaçãoArmas"
@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards").normalized()
	if input_dir == Vector2.ZERO:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/walk"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/walk"] = true
	
	animation_tree["parameters/Idle/blend_position"] = input_dir
	animation_tree["parameters/Walk/blend_position"] = input_dir
	
