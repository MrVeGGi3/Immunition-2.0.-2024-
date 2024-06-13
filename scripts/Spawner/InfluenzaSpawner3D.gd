class_name InfluenzaSpawner
extends Node3D

var influenza = preload("res://scenes/Characters/Influenza.tscn")
var influenza_created = Global.influenza_in_scene
@export var maximum_influenza = 2
# Called when the node enters the scene tree for the first time.
var can_create_influ = false
@onready var create_cell_instance = $CreateCellInstance

func spawnInflu():
	if influenza_created > maximum_influenza:
		return
	var instance = influenza.instantiate()
	instance.global_position = global_position + Vector3(0,1,0).normalized() 
	get_parent().add_child(instance)
	influenza_created += 1
	create_cell_instance.start()
	print("Influenza Spawnado")
	
func _on_timer_timeout():
	spawnInflu()
	
func _process(_delta):
	pass
