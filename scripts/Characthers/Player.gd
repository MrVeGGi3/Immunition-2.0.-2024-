extends CharacterBody3D
#Arma 1
@onready var ray_cast_3d = $RayCast3D #raycast da pistola linfócito
@onready var shoot_sound = $ShootPlayer #som da pistola linfócito
@onready var ammo_linf = $PlayerHUD/UI_AMMO/Ammo_Linf #texto da munição da arma linfócito
#Arma 2
@onready var macrofage_ray_3d = $MacrofageRay3D #raycast do macrófago
@onready var macrofage_shoot = $MacrofageShoot #som do macrofagoweapon
@onready var ammo_macr = $PlayerHUD/UI_AMMO/Ammo_Macr #texto da munição da arma macrófago
#Arma 3
@onready var flame_thrower_shoot = $FlameThrowerShoot #raycast do neutrófilo
@onready var neutrofile_sound = $NeutrofileSound#som do flamethrower
@onready var ammo_neu = $PlayerHUD/UI_AMMO/Ammo_Neu #texto da munição da arma neutrófilo


#Animação e Camera
@onready var animated_sprite_2d = $PlayerHUD/GunShoot/AnimatedSprite2D # animated sprite das armas
@onready var camera_3d = $Camera3D #camera de visão do player
#UI
@onready var deathscreen = $PlayerHUD/DeathScreen #tela de quando o player morre
@onready var progress_bar = $PlayerHUD/PlayerLifeBar/ProgressBar # barra de progresso de vida do player
@onready var pause_menu = $PlayerHUD/pause_menu #menu de pausa
@onready var phase_finished = $PlayerHUD/PhaseFinished #UI de quando termina a fase
@onready var player_life_bar = $PlayerHUD/PlayerLifeBar #UI que mostra os stats do player
@onready var damage_taken = $PlayerHUD/PlayerLifeBar/DamageTaken #Animação que mostra quando o jogador perde vida
@onready var gun_shoot = $PlayerHUD/GunShoot

#Músicas(BGM)
@onready var death_sound = $DeathSound # música da morte do player
@onready var main_bgm = $MainBGM # trilha sonora principal
#Tutorial
@onready var tutorial_walk = $PlayerHUD/TutorialGuide/TutorialWalk #animação de tutorial
@onready var tutorial_guide = $PlayerHUD/TutorialGuide  #UI que mostra a animação de tutorial
@onready var win_platform : MeshInstance3D = get_tree().get_first_node_in_group("finishphase") #Instância da Plataforma para detectar colisão
@onready var tutorial_ui = $PlayerHUD/Tutorial_UI #nó que contém a caixa de diálogo do tutorial
@onready var speech_tutorial = $PlayerHUD/Tutorial_UI/SpeechTutorial #Lugar aonde vai atualizar os textos

#Constantes
const vida_maxima = 10.0
const MOUSE_SENS = 0.5
const SPEED = 10.0
const INCREASE_SPEED = 20
var JUMP_FORCE = 5.0
const GRAVITY = Vector3(0, -9.8, 0)
#Booleanas
var can_shoot = true
var can_shoot_mf = false
var can_shoot_nf = false
var dead = false
#Variáveis do Player
var vida
var l_ammo = 20 #munição linfócito
var m_ammo = 20 #munição macrófago
var n_ammo = 50 #munição neutrófilo

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE #altera o modo de captura do mouse para usar como FPS
	#Animações
	animated_sprite_2d.animation_finished.connect(shoot_anim_done) #conecta a outra animação
	damage_taken.animation_finished.connect(return_normalUI) #conecta á outra animação
	#Esconder e mostrar UI
	deathscreen.hide()
	phase_finished.hide()
	pause_menu.hide()
	tutorial_guide.show()
	player_life_bar.show()
	#Física
	set_physics_process(true)
	get_tree().paused = true
	$CollisionShape3D.disabled = false
	#Músicas
	death_sound.stop()#ao resetar, para a música de morte
	$MainBGM.play() #executa o BGM principal 
	tutorial_walk.play("walk")
	#Variáveis
	vida = vida_maxima #vida igual a vida máxima quando resetar
	l_ammo = 20 #munição linfócito
	m_ammo = 20 #munição macrófago
	n_ammo = 50 #munição neutrófilo
	can_shoot_mf = false
	can_shoot_nf = false
	

	
func _input(event):
	if dead:
		return
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENS
		rotation_degrees.x -= event.relative.y * MOUSE_SENS
	if rotation_degrees.x > 90:
		rotation_degrees.x = 90
	if rotation_degrees.x < -90:
		rotation_degrees.x = -90

func _process(_delta):
	if dead:
		return
	progress_bar.value = vida	
	if Input.is_action_just_pressed("restart"):
		restart()
		
	if Input.is_action_just_pressed("change_macrofage"):
		neutrofile_sound.stop()
		animated_sprite_2d.play("idle_macrofage")
		animated_sprite_2d.animation_finished.disconnect(shoot_neutrofile_anim_done)
		animated_sprite_2d.animation_finished.disconnect(shoot_anim_done)
		animated_sprite_2d.animation_finished.connect(shoot_macrofage_anim_done)
		if l_ammo > 0:
			can_shoot_mf = true
			can_shoot = false
			can_shoot_nf = false

	if Input.is_action_just_pressed("change_linfocit"):
		neutrofile_sound.stop()
		animated_sprite_2d.play("idle")
		animated_sprite_2d.animation_finished.disconnect(shoot_neutrofile_anim_done)
		animated_sprite_2d.animation_finished.disconnect(shoot_macrofage_anim_done)
		animated_sprite_2d.animation_finished.connect(shoot_anim_done)
		if m_ammo > 0:
			can_shoot = true
			can_shoot_mf = false
			can_shoot_nf = false
	
	if Input.is_action_just_pressed("change_neutrofile"):
		neutrofile_sound.stop()
		animated_sprite_2d.play("idle_neutro")
		animated_sprite_2d.animation_finished.disconnect(shoot_anim_done)
		animated_sprite_2d.animation_finished.disconnect(shoot_macrofage_anim_done)
		animated_sprite_2d.animation_finished.connect(shoot_neutrofile_anim_done)
		if n_ammo > 0:
			can_shoot = false
			can_shoot_mf = false
			can_shoot_nf = true
	
	if Input.is_action_just_pressed("shoot"):
		if can_shoot:
			shoot()
			l_ammo -= 1
			if l_ammo == 0:
				can_shoot = false
		elif can_shoot_mf:
			shoot_by_macrofage()
			m_ammo -=1
			if m_ammo == 0:
				can_shoot_mf = false
		if can_shoot_nf:
			shoot_by_neutrofile()
			n_ammo -= 4 
			if n_ammo < 0:
				n_ammo = 0
			if n_ammo == 0:
				can_shoot_nf = false
				
			
				
				
				
	#labels para informação de munição
	ammo_linf.text = str(l_ammo)
	ammo_macr.text = str(m_ammo)
	ammo_neu.text = str(n_ammo)
		
func _physics_process(delta):
	
	velocity += GRAVITY * delta  #aplicação de gravidade
	if dead: #se morto, para o elemento de física
		return
	var input_dir = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards") #definir os movimentos de cada vetor 
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_FORCE
			if Input.is_action_pressed("run"):
				velocity += direction * INCREASE_SPEED
			else:
				velocity += direction * SPEED

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if Input.is_action_just_pressed("run"):
			velocity.x += direction.x * INCREASE_SPEED
			velocity.z += direction.z * INCREASE_SPEED
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if position.y < -30: #Se o jogador estiver muito fundo caindo, ele morre
		kill()
	
	move_and_slide()
	_on_check_coliision_FinishLevel() #Função que verifica o fim do level

func restart():
	get_tree().reload_current_scene()

func shoot():
	if !can_shoot:
		return
	can_shoot = false
	animated_sprite_2d.play("shoot")
	shoot_sound.play()
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("kill_green"):
		ray_cast_3d.get_collider().kill_green()
		
func shoot_by_macrofage():
	if !can_shoot_mf:
		return
	can_shoot_mf = false
	animated_sprite_2d.play("shoot_macrofage")
	macrofage_shoot.play()
	if macrofage_ray_3d.is_colliding() and macrofage_ray_3d.get_collider().has_method("kill_blue"):
		macrofage_ray_3d.get_collider().kill_blue()

func shoot_by_neutrofile():
	can_shoot_nf = true
	if flame_thrower_shoot.is_colliding() and flame_thrower_shoot.get_collider().has_method("kill_red"):
		flame_thrower_shoot.get_collider().kill_red()
	animated_sprite_2d.play("shoot_neutro")
	neutrofile_sound.play()

func return_normalUI():
	damage_taken.play("idle")


func damage():
	vida -= 2
	damage_taken.play("damage_received")
	if vida == 0:
		kill()
	
		
func kill():
		dead = true
		can_shoot = false
		can_shoot_mf = false
		$CollisionShape3D.disabled = true
		$MainBGM.stop()
		gun_shoot.hide()
		disable_UI()
		death_sound.play()
		deathscreen.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func disable_UI():
	player_life_bar.hide()
	tutorial_guide.hide()
	main_bgm.stop()
		

func _on_exit_game_pressed():
	get_tree().quit()
	
func _on_check_coliision_FinishLevel():
	var eye_line = Vector3.UP * 0.5
	var query = PhysicsRayQueryParameters3D.create(global_transform.origin + eye_line, win_platform.global_transform.origin + eye_line, 1)
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	if result.is_empty():
		can_shoot = false
		can_shoot_mf = false
		disable_UI()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
		phase_finished.show()
		
		
func shoot_macrofage_anim_done():
	animated_sprite_2d.play("idle_macrofage")
	can_shoot_mf = true

func shoot_anim_done():
	animated_sprite_2d.play("idle")
	can_shoot = true
	
func shoot_neutrofile_anim_done():
	animated_sprite_2d.play("idle_neutro")
	can_shoot_nf = true
		

func _on_jump_tutorial_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	tutorial_ui.hide()
