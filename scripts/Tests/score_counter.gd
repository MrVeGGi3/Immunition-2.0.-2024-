extends Control

@export var max_score = 1000
@export var AnimSpeed = 10.0

var actual_score = 0 

@onready var counter: Label = $Counter
@onready var counter_animator: AnimationPlayer = $CounterAnimator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	counter.text = actual_score

func count_animation():
	if actual_score < max_score:
		actual_score += 100
	elif max_score - actual_score < 100:
		actual_score += 10
