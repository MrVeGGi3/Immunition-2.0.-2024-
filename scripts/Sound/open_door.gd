extends MeshInstance3D

@onready var opening_door = $"../DevGrey35/OpeningDoor"

func ready():
	position.y = 0.486
	
func open_door():
	opening_door.play()

func set_final_position():
	queue_free()
