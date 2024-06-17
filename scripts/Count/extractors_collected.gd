extends Control

@onready var extractor_collected_label = %ExtractorCollected
@onready var player = get_tree().get_nodes_in_group("player")
@onready var extractor_collected = $ExtractorCollected

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	extractor_collected_label.text = str(Global.extractors_collected)
	if player[0].dead:
		visible = false
