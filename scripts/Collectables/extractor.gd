extends Node3D

@onready var extractor_area_3d = $Extractor_Area3D
@onready var extractor_collected = $ExtractorCollected

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var bodies = extractor_area_3d.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"):
			catch_extractor()
			

func catch_extractor():
	extractor_collected.play()
	Global.extractors_collected += 1
	print("Extratores Coletados:", Global.extractors_collected)
	queue_free()
