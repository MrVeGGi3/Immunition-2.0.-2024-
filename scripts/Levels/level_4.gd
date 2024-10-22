extends Node3D

@onready var diareia = get_tree().get_first_node_in_group("diareia")

@onready var m1: Marker3D = $Markers_3D/Marker3D1
@onready var m2: Marker3D = $Markers_3D/Marker3D2
@onready var m3: Marker3D = $Markers_3D/Marker3D3
@onready var m4: Marker3D = $Markers_3D/Marker3D4
@onready var m5: Marker3D = $Markers_3D/Marker3D5
@onready var m6: Marker3D = $Markers_3D/Marker3D6

@onready var reach_point_1: Area3D = $Markers_3D/Marker3D1/ReachPoint1
@onready var reach_point_2: Area3D = $Markers_3D/Marker3D2/ReachPoint2
@onready var reach_point_3: Area3D = $Markers_3D/Marker3D3/ReachPoint3
@onready var reach_point_4: Area3D = $Markers_3D/Marker3D4/ReachPoint4
@onready var reach_point_5: Area3D = $Markers_3D/Marker3D5/ReachPoint5
@onready var reach_point_6: Area3D = $Markers_3D/Marker3D6/ReachPoint6

var index = 0
var waypoint = []
var areas = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	waypoint = [m1.global_transform.origin, m2.global_transform.origin, m3.global_transform.origin, m4.global_transform.origin, m5.global_transform.origin, m6.global_transform.origin]
	areas = [reach_point_1, reach_point_2, reach_point_3, reach_point_4, reach_point_5, reach_point_6]
		

func _physics_process(delta: float) -> void:
	diareia.nav.target_position = waypoint[index]
	var actual_area = areas[index]
	var bodies = actual_area.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("diareia"):
			index += 1
			if index == 7:
				index = 0
			print("O index atual é:", index)
			 
