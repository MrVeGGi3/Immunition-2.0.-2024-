extends Node3D

@onready var area_3d: Area3D = $Area3D
@onready var destruction_timer: Timer = $DestructionTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	destruction_timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_destruction_timer_timeout() -> void:
	queue_free()
