extends Control

@onready var extractor_collected_label = %ExtractorCollected
@onready var player = get_tree().get_nodes_in_group("player")
@onready var description: Label = $Control2/Description

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	extractor_collected_label.text = str(Global.extractors_collected)
	if player[0].dead:
		visible = false
	
	description.text = tr("PHASE_1_CONDITION")
