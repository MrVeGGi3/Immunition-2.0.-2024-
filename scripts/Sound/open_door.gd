extends MeshInstance3D

@onready var opening_door = $OpeningDoor2

func ready():
	position.y = 0.487
	
func open_door():
	opening_door.play()

func set_final_position():
	queue_free()
