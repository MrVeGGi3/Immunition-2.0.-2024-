extends RigidBody3D

@export_category("Forces Applied")
@export var force_x  = 0.0
@export var force_y = 0.0
@export var force_z = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_backwards_force()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _backwards_force():
	var backward = - transform.basis.z.normalized()
	apply_central_impulse(backward * Vector3(force_x, force_y, force_z))
