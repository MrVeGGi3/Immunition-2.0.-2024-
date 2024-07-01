class_name InfluenzaSpawner
extends Node3D

var influenza = preload("res://scenes/Characters/Influenza.tscn")
var influenza_created = Global.influenza_in_scene
# Called when the node enters the scene tree for the first time.
var can_create_influ = false
var no_max_influ = false
@export var max_influenza = 6
@onready var create_cell_instance = $CreateCellInstance

func spawnInflu():
	if can_create_influ and no_max_influ:
		var instance = influenza.instantiate()
		get_parent().add_child(instance)
		if instance.is_inside_tree():
			instance.global_position = global_position + Vector3(0,1,0).normalized() 
			influenza_created += 1
			create_cell_instance.start()
			print("Influenza Spawnado")
		else:
			print("Influenza não foi colocado de maneira correta")
	
func _on_timer_timeout():
	spawnInflu()
	
func _process(_delta):
	var influenza_in_phase = get_tree().get_nodes_in_group("influenza")
	if influenza_in_phase.size() < max_influenza:
		no_max_influ = true
