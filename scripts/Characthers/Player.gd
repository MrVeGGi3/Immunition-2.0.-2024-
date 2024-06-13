extends CharacterBody3D
#Arma 1
@onready var ray_cast_3d = $RayCast3D #raycast da pistola linfócito
@onready var shoot_sound = $ShootPlayer #som da pistola linfócito
@onready var ammo_linf = $"PlayerHUD/UI_AMMO/Linfócito/Ammo_Linf" #texto da munição da arma linfócito
#Arma 2
@onready var macrofage_ray_3d = $MacrofageRay3D #raycast do macrófago
@onready var macrofage_shoot = $MacrofageShoot #som do macrofagoweapon
@onready var ammo_macr = $"PlayerHUD/UI_AMMO/Macrofágo/Ammo_Macr"
#Arma 3
@onready var flame_thrower_shoot = $FlameThrowerShoot #raycast do neutrófilo
@onready var neutrofile_sound = $NeutrofileSound#som do flamethrower
@onready var ammo_neu = $"PlayerHUD/UI_AMMO/Neutrófilo/Ammo_Neu"



#Animação e Camera
@onready var animated_sprite_2d = $PlayerHUD/GunShoot/AnimatedSprite2D # animated sprite das armas
@onready var camera_3d = $Camera3D #camera de visão do player
@onready var particles = $FlameThrowerShoot/GPUParticles3D #efeito de particulas
@onready var enable_particle = $FlameThrowerShoot/EnableParticle #Timer para evitar desvio visual das partículas

#Animação das barras de armas
@onready var linfocit_bar = $"PlayerHUD/UI_AMMO/Linfócito/LinfocitBar"
@onready var macrofage_bar = $"PlayerHUD/UI_AMMO/Macrofágo/MacrofageBar"
@onready var neutrofile_bar = $"PlayerHUD/UI_AMMO/Neutrófilo/NeutrofileBar"

#UI
@onready var deathscreen = $PlayerHUD/DeathScreen #tela de quando o player morre
@onready var progress_bar = $PlayerHUD/PlayerLifeBar/ProgressBar # barra de progresso de vida do player
@onready var pause_menu = $PlayerHUD/pause_menu #menu de pausa
@onready var player_life_bar = $PlayerHUD/PlayerLifeBar #UI que mostra os stats do player
@onready var damage_taken = $PlayerHUD/PlayerLifeBar/DamageTaken #Animação que mostra quando o jogador perde vida
@onready var gun_shoot = $PlayerHUD/GunShoot
@onready var wheel_switch_weapons = $PlayerHUD/WheelSwitchWeapons
@onready var ui_ammo = $PlayerHUD/UI_AMMO
@onready var memory_system = $PlayerHUD/MemorySystem
@onready var whell_memory = $"PlayerHUD/Whell&memory"


#Músicas(BGM
@onready var death_sound = $DeathSound # música da morte do player

#Tutorial


#Ajuste de Mecânica
@onready var marker_3d = $Marker3D
@onready var hit_marker_explosion = $HitMarkerExplosion

#Constantes
const vida_maxima = 10.0
const INCREASE_SPEED = 10
var JUMP_FORCE = 8.0
const GRAVITY = Vector3(0, -9.8, 0)
const CONTROL_BULLET_EMISSION = Global.CONTROL_BULLET_EMISSION

#Booleanas
var can_shoot = Global.c_shoot
var can_shoot_mf = Global.c_shoot_mf
var can_shoot_nf = Global.c_shoot_nf
var dead = false
var m1 = Global.m1_active
var m2 = Global.m2_active
var m3 = Global.m3_active


#Variáveis do Player
var vida
@export var l_ammo = 30 #munição linfócito
@export var m_ammo = 25 #munição macrófago
@export var n_ammo = 100 #munição neutrófilo
@export var max_speed : float = 24.0
@export var SPEED = 12.0
@export var aceleration = 0.5

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED #altera o modo de captura do mouse para usar como FPS
	#Animações
	animated_sprite_2d.animation_finished.connect(shoot_anim_done) #conecta a outra animação
	damage_taken.animation_finished.connect(return_normalUI) #conecta á outra animação
	#Esconder e mostrar UI
	deathscreen.hide()
	pause_menu.hide()
	player_life_bar.show()
	#Física
	set_physics_process(true)
	$CollisionShape3D.disabled = false
	#Músicas
	death_sound.stop()#ao resetar, para a música de morte
	#Variáveis
	vida = vida_maxima #vida igual a vida máxima quando resetar
	l_ammo = 20 #munição linfócito
	m_ammo = 20 #munição macrófago
	n_ammo = 15 #munição neutrófilo
	

	
func _input(event):
	var MOUSE_SENS = Global.mouse_sens
	if dead:
		return
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENS
		rotation_degrees.x -= event.relative.y * MOUSE_SENS
	if rotation_degrees.x > 90:
		rotation_degrees.x = 90
	if rotation_degrees.x < -90:
		rotation_degrees.x = -90
		
	

func _process(delta):
	var MOUSE_SENS = Global.mouse_sens
	
	if dead:
		return
	progress_bar.value = vida
	MOUSE_SENS = Global.mouse_sens
	can_shoot = Global.c_shoot
	can_shoot_mf = Global.c_shoot_mf
	can_shoot_nf = Global.c_shoot_nf
	m1 = Global.m1_active
	m2 = Global.m2_active
	m3 = Global.m3_active
	
	var right_stick_x = Input.get_action_strength("camera_xbox_right") - Input.get_action_strength("camera_xbox_left")
	var right_stick_y = Input.get_action_strength("camera_xbox_up") - Input.get_action_strength("camera_xbox_down")
	
	rotation_degrees.y -= right_stick_x * MOUSE_SENS * 3
	rotation_degrees.x -= right_stick_y * MOUSE_SENS * 3
	
	if rotation_degrees.x > 90:
		rotation_degrees.x = 90
	if rotation_degrees.x < -90:
		rotation_degrees.x = -90

	if Input.is_action_just_pressed("restart"):
		restart()
		
	if Input.is_action_just_pressed("change_macrofage"):
		change_macrofage()

	elif Input.is_action_just_pressed("change_linfocit"):
		change_linfocit()
	
	elif Input.is_action_just_pressed("change_neutrofile"):
		change_neutrofile()
	
	if Input.is_action_just_pressed("shoot"):
		if can_shoot:
			shoot()
			if l_ammo < 0:
				l_ammo = 0
			if not l_ammo < 0:
				l_ammo -=1
			if l_ammo == 0:
				can_shoot = false
				set_global_transition_bool_cs(can_shoot)
				
		elif can_shoot_mf:
			shoot_by_macrofage()
			if m_ammo < 0:
				m_ammo = 0
			if not m_ammo < 0:
				m_ammo -=1
			if m_ammo == 0:
				can_shoot_mf = false
				set_global_transition_bool_csm(can_shoot_mf)
				
	if Input.is_action_pressed("shoot") and can_shoot_nf:
		shoot_by_neutrofile()
		if n_ammo < 0:
			n_ammo = 0
		if n_ammo > 0:
			n_ammo -= 3 * delta * CONTROL_BULLET_EMISSION
	else:
		particles.emitting = false
				
			
				
				
				
	#labels para informação de munição
	ammo_linf.text = str(l_ammo)
	ammo_macr.text = str(m_ammo)
	ammo_neu.text = str(int(n_ammo))
		
func _physics_process(delta):
	
	velocity += GRAVITY * delta  #aplicação de gravidade
	if dead: #se morto, para o elemento de física
		return
	var input_dir = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards") #definir os movimentos de cada vetor 
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_FORCE
	
	if position.y < -40:  # Se o jogador estiver muito fundo caindo, ele morre
		kill()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if particles.emitting:
			particles.emitting = false
			enable_particle.start()
		if Input.is_action_pressed("run"):
				velocity.x = direction.x * lerp(SPEED, SPEED * 2, 0.6)
				velocity.z = direction.z * lerp(SPEED, SPEED *2, 0.6) # Aumentar a velocidade ao correr	
		else: 
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
	

func restart():
	get_tree().reload_current_scene()

func shoot():
	if !can_shoot:
		return
	can_shoot = false
	set_global_transition_bool_cs(can_shoot)
	animated_sprite_2d.play("shoot")
	shoot_sound.play()
	#Inimigo Verde
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("kill_green_lf") and m1:
		ray_cast_3d.get_collider().kill_green_lf()
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("heal_green_lf") and m2:
		ray_cast_3d.get_collider().heal_green_lf()
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("heal_green_lf") and m3:
		ray_cast_3d.get_collider().heal_green_lf()
#	#Inimigo Azul
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("kill_blue_lf") and m2:
		ray_cast_3d.get_collider().kill_blue_lf()
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("heal_blue_lf") and m3:
		ray_cast_3d.get_collider().heal_blue_lf()
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("heal_blue_lf") and m1:
		ray_cast_3d.get_collider().heal_blue_lf()
	#Inimigo Vermelho
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("kill_red_lf") and m3:
		ray_cast_3d.get_collider().kill_red_lf()
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("heal_red_lf") and m2:
		ray_cast_3d.get_collider().heal_red_lf()
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("heal_red_lf") and m1:
		ray_cast_3d.get_collider().heal_red_lf()
		
	#Célula Infectada
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("hit"):
		ray_cast_3d.get_collider().hit(5,3)
	
	#Influenza
	if ray_cast_3d.is_colliding() and ray_cast_3d.get_collider().has_method("hit_by_lf"):
		ray_cast_3d.get_collider().hit_by_lf(1,1)
	
		
		
func shoot_by_macrofage():
	if !can_shoot_mf:
		return
	can_shoot_mf = false
	set_global_transition_bool_csm(can_shoot_mf)
	animated_sprite_2d.play("shoot_macrofage")
	macrofage_shoot.play()
	#Inimigo Azul
	if macrofage_ray_3d.is_colliding() and macrofage_ray_3d.get_collider().has_method("kill_blue_mf") and m2:
		macrofage_ray_3d.get_collider().kill_blue_mf()
	if macrofage_ray_3d.is_colliding() and macrofage_ray_3d.get_collider().has_method("heal_blue_mf") and m1:
		macrofage_ray_3d.get_collider().heal_blue_mf()
	if macrofage_ray_3d.is_colliding() and macrofage_ray_3d.get_collider().has_method("heal_blue_mf") and m3:
		macrofage_ray_3d.get_collider().heal_blue_mf()
	#Inimigo Verde
	if macrofage_ray_3d.is_colliding() and macrofage_ray_3d.get_collider().has_method("kill_green_mf") and m1:
		macrofage_ray_3d.get_collider().kill_green_mf()
	if macrofage_ray_3d.is_colliding() and macrofage_ray_3d.get_collider().has_method("heal_green_mf") and m2:
		macrofage_ray_3d.get_collider().heal_green_mf()
	if macrofage_ray_3d.is_colliding() and macrofage_ray_3d.get_collider().has_method("heal_green_mf") and m3:
		macrofage_ray_3d.get_collider().heal_green_mf()
	#Inimigo Vermelho
	if macrofage_ray_3d.is_colliding() and macrofage_ray_3d.get_collider().has_method("kill_red_mf") and m3:
		macrofage_ray_3d.get_collider().kill_red_mf()
	if macrofage_ray_3d.is_colliding() and macrofage_ray_3d.get_collider().has_method("heal_red_mf") and m2:
		macrofage_ray_3d.get_collider().heal_red_mf()
	if macrofage_ray_3d.is_colliding() and macrofage_ray_3d.get_collider().has_method("heal_red_mf") and m1:
		macrofage_ray_3d.get_collider().heal_red_mf()
	
	#Influenza
	if macrofage_ray_3d.is_colliding() and macrofage_ray_3d.get_collider().has_method("hit_by_mf"):
		macrofage_ray_3d.get_collider().hit_by_mf(7)
		
func shoot_by_neutrofile():
	if !can_shoot_nf:
		return
	particles.emitting = true
	animated_sprite_2d.play("shoot_neutro")
	neutrofile_sound.play()
	if flame_thrower_shoot.is_colliding() and flame_thrower_shoot.get_collider().has_method("kill_red_nf") and m3:
		flame_thrower_shoot.get_collider().kill_red_nf()
	if flame_thrower_shoot.is_colliding() and flame_thrower_shoot.get_collider().has_method("heal_red_nf") and m1:
		flame_thrower_shoot.get_collider().heal_red_nf()
	if flame_thrower_shoot.is_colliding() and flame_thrower_shoot.get_collider().has_method("heal_red_nf") and m2:
		flame_thrower_shoot.get_collider().heal_red_nf()

	if flame_thrower_shoot.is_colliding() and flame_thrower_shoot.get_collider().has_method("kill_green_nf") and m1:
		flame_thrower_shoot.get_collider().kill_green_nf()
	if flame_thrower_shoot.is_colliding() and flame_thrower_shoot.get_collider().has_method("heal_green_nf") and m2:
		flame_thrower_shoot.get_collider().heal_green_nf()
	if flame_thrower_shoot.is_colliding() and flame_thrower_shoot.get_collider().has_method("heal_green_nf") and m3:
		flame_thrower_shoot.get_collider().kill_green_nf()

	if flame_thrower_shoot.is_colliding() and flame_thrower_shoot.get_collider().has_method("kill_blue_nf") and m2:
		flame_thrower_shoot.get_collider().kill_blue_nf()
	if flame_thrower_shoot.is_colliding() and flame_thrower_shoot.get_collider().has_method("heal_blue_nf") and m1:
		flame_thrower_shoot.get_collider().heal_blue_nf()
	if flame_thrower_shoot.is_colliding() and flame_thrower_shoot.get_collider().has_method("heal_blue_nf") and m3:
		flame_thrower_shoot.get_collider().heal_blue_nf()
		
	#Influenza
	if flame_thrower_shoot.is_colliding() and flame_thrower_shoot.get_collider().has_method("hit_by_nf"):
		flame_thrower_shoot.get_collider().hit_by_nf(3)

func return_normalUI():
	damage_taken.play("idle")


func _damage(damage):
	vida -= damage
	damage_taken.play("damage_received")
	if vida <= 0:
		kill()
	
		
func kill():
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		dead = true
		can_shoot = false
		can_shoot_mf = false
		can_shoot_nf = false
		set_global_animation_bool(can_shoot, can_shoot_mf, can_shoot_nf)
		$CollisionShape3D.disabled = true
		disable_UI()
		death_sound.play()
		deathscreen.show()
		particles.emitting = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func disable_UI():
	whell_memory.hide()
	gun_shoot.hide()
	player_life_bar.hide()
	wheel_switch_weapons.visible = false
	ui_ammo.hide()	
	memory_system.visible = false

func restore_UI():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	whell_memory.show()
	gun_shoot.show()
	player_life_bar.show()
	wheel_switch_weapons.visible = false
	ui_ammo.show()	
	memory_system.visible = true
	

func _on_exit_game_pressed():
	get_tree().quit()
		
func shoot_macrofage_anim_done():
	particles.emitting = false
	animated_sprite_2d.play("idle_macrofage")
	can_shoot_mf = true
	can_shoot = false
	can_shoot_nf = false
	set_global_animation_bool(can_shoot, can_shoot_mf, can_shoot_nf)
	
func shoot_anim_done():
	animated_sprite_2d.play("idle")
	can_shoot = true
	can_shoot_mf = false
	can_shoot_nf = false
	set_global_animation_bool(can_shoot, can_shoot_mf, can_shoot_nf)
	
func shoot_neutrofile_anim_done():
	can_shoot_nf = true
	can_shoot_mf = false
	can_shoot = false
	set_global_animation_bool(can_shoot, can_shoot_mf, can_shoot_nf)

	
func _on_jump_tutorial_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	
func set_global_animation_bool(variavel, variavel2, variavel3):
	Global.c_shoot = variavel
	Global.c_shoot_mf = variavel2
	Global.c_shoot_nf = variavel3
		
func set_global_transition_bool_cs(variavel):
		Global.c_shoot = variavel
func set_global_transition_bool_csm(variavel):
		Global.c_shoot_mf = variavel
func set_global_transition_bool_csn(variavel):
		Global.c_shoot_nf = variavel
		
func change_linfocit():
	animated_sprite_2d.play("idle")
	animated_sprite_2d.animation_finished.disconnect(shoot_macrofage_anim_done)
	animated_sprite_2d.animation_finished.disconnect(shoot_neutrofile_anim_done)
	animated_sprite_2d.animation_finished.connect(shoot_anim_done)
	if m_ammo > 0:
		can_shoot = true
		can_shoot_mf = false
		can_shoot_nf = false
		set_global_animation_bool(can_shoot, can_shoot_mf, can_shoot_nf)
	else:
		can_shoot = false
		set_global_transition_bool_cs(can_shoot)
	
func change_macrofage():
	neutrofile_sound.stop()
	animated_sprite_2d.play("idle_macrofage")
	animated_sprite_2d.animation_finished.disconnect(shoot_anim_done)
	animated_sprite_2d.animation_finished.disconnect(shoot_neutrofile_anim_done)
	animated_sprite_2d.animation_finished.connect(shoot_macrofage_anim_done)
	if l_ammo > 0:
		can_shoot_mf = true
		can_shoot = false
		can_shoot_nf = false
		set_global_animation_bool(can_shoot, can_shoot_mf, can_shoot_nf)
	else:
		can_shoot_mf = false
		set_global_transition_bool_csm(can_shoot_mf)
		
func change_neutrofile():
	neutrofile_sound.stop()
	animated_sprite_2d.play("shoot_neutro")
	animated_sprite_2d.animation_finished.disconnect(shoot_anim_done)
	animated_sprite_2d.animation_finished.disconnect(shoot_macrofage_anim_done)
	animated_sprite_2d.animation_finished.connect(shoot_neutrofile_anim_done)
	if n_ammo > 0:
		can_shoot = false
		can_shoot_mf = false
		can_shoot_nf = true
		set_global_animation_bool(can_shoot, can_shoot_mf, can_shoot_nf)
	else:
		can_shoot_nf = false
		set_global_transition_bool_csn(can_shoot_nf)

func get_more_ammo(lammo, mammo, nammo):
	l_ammo += lammo
	m_ammo += mammo
	n_ammo += nammo
	linfocit_bar.play("recharge")
	macrofage_bar.play("recharge")
	neutrofile_bar.play("recharge")
	
func _on_enable_particle_timeout():
	particles.emitting = true
