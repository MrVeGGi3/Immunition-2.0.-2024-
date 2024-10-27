extends Node3D

@onready var timer_destruction: Timer = $TimerDestruction
@onready var area_3d: Area3D = $Area3D

@export_category("Throwing Variables")
@export var force_z = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_destruction.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var bodies = area_3d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemy"):
			print("Explosão SSM: Acertei um Inimigo")
			body._backward_force()


func _on_timer_destruction_timeout() -> void:
	queue_free()
