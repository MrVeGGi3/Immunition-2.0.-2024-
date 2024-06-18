extends CharacterBody3D

@export_category("Atributos")
@export var speed = 5
@export var life = 5
@export var damage = 2
@export var hit_color = Color(255,0,0,255) #Vermelho

@export_category("Variáveis de Spawn")
@export var spawn_collision : int = 2
@export var spawn_destroyed : int = 1

#Variável de Controle
var is_hitting = false
@onready var marker_3d = $Marker3D

#Timers
@onready var collision_timer = $CollisionTimer
@onready var blink_cooldown = $BlinkCooldown

#Instâncias
@onready var influenza = preload("res://scenes/Characters/Influenza.tscn")
@onready var explosion = preload("res://scenes/effect/explosion.tscn")
@onready var nav = $NavigationAgent3D
@onready var infectedl_cell_animation = $InfectedlCellAnimation

var virus_type : String = "null"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player = get_tree().get_nodes_in_group("player")
	var player_position = player[0].hit_marker_explosion.global_transform.origin
	nav.target_position = player_position
	var current_location = global_transform.origin
	var next_location = nav.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	velocity = velocity.move_toward(new_velocity, .25)
	move_and_slide()
		
	if current_location.distance_to(player_position) <= 1 and !is_hitting:
		var new_explosion = explosion.instantiate()
		get_parent().add_child(new_explosion)
		if new_explosion.is_inside_tree():
			new_explosion.global_transform.origin = marker_3d.global_transform.origin
			is_hitting = true
		else:
			print("Instância da Explosão não colocada de maneira correta")
			
	if is_hitting:
		queue_free()
		spawn_influenza(spawn_collision, virus_type)
		print("Fui spawnado após entrar em colisão com o player")
			
func spawn_influenza(spawn, virus):
	for i in range(spawn):
		if virus_type == "influenza":
			var new_influenza = influenza.instantiate()
			get_parent().add_child(new_influenza)
			if new_influenza.is_inside_tree():
				new_influenza.global_transform.origin = global_transform.origin
			else:
				print("Instância de Influenza não colocada de maneira correta")

func hit(damage_by_player, speed_down):
	damage_effect()
	life -= damage_by_player
	speed -= speed_down
	print("Célula Infectada - Recebi dano")
	if life <= 0:
		Global.infected_cells_destroyed += 1
		kill()
	
func kill():
	queue_free()
	spawn_influenza(spawn_destroyed, virus_type)
	print("Fui spawnado após ser destruído")
	
func get_virus_type(virus):
	virus_type = virus
	print("O tipo de vírus é:", virus_type)

func damage_effect():
	infectedl_cell_animation.modulate = Color.WHITE
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(infectedl_cell_animation,"modulate", Color.RED, 0.3)
