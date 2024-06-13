extends Control

@onready var influenza_defeated = %InfluenzaDefeated
@onready var total_influenza = %TotalInfluenza
@export var influenza_to_destroy = 3 

# Called when the node enters the scene tree for the first time.
func _ready():
	total_influenza.text = str(influenza_to_destroy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	influenza_defeated.text = str(Global.influenza_destroyed)
	
