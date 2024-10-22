extends Node3D

@onready var diareia = get_tree().get_first_node_in_group("diareia")
@onready var m1 : Marker3D = $Marker3D
@onready var m2 : Marker3D = $Marker3D2
@onready var reach_area_1: Area3D = $Marker3D/ReachArea1
@onready var reach_area_2: Area3D = $Marker3D2/ReachArea2

var waypoints = []
var reach_areas = []
var index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	waypoints = [m1.global_transform.origin, m2.global_transform.origin]
	reach_areas = [reach_area_1, reach_area_2]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	diareia.nav.target_position = waypoints[index]
	var actual_area = reach_areas[index]
	var bodies = actual_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("diareia"):
			index += 1
			
	
