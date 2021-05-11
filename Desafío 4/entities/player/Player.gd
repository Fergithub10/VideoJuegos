extends KinematicBody2D

onready var cannon = $Cannon

const FLOOR_NORMAL := Vector2.UP  # Igual a Vector2(0, -1)
const SNAP_DIRECTION := Vector2.UP
const SNAP_LENGHT := 32.0
const SLOPE_THRESHOLD := deg2rad(46)

onready var player_animation = $PlayerAnimation
onready var body = $Body # Cargo el Body para invertir el posicionamiento del personaje. (flip) 

export (float) var ACCELERATION:float = 60.0
export (float) var H_SPEED_LIMIT:float = 600.0
export (int) var jump_speed = 500
export (float) var FRICTION_WEIGHT:float = 0.1
export (int) var gravity = 10

var projectile_container

var velocity:Vector2 = Vector2.ZERO
var snap_vector:Vector2 = SNAP_DIRECTION * SNAP_LENGHT

func initialize(projectile_container):
	self.projectile_container = projectile_container
	cannon.projectile_container = projectile_container	
	# Inicializo la animación del personaje en Idle.  
	player_animation.play()	
	_play_animation("idle")


func get_input():
	# Cannon fire
	if Input.is_action_just_pressed("fire_cannon"):
		if projectile_container == null:
			projectile_container = get_parent()
			cannon.projectile_container = projectile_container
		cannon.fire()

	# Jump Action
	var jump = Input.is_action_just_pressed('jump')
	if jump and is_on_floor():
		velocity.y -= jump_speed
		#player_animation.stop()
		#_play_animation("jump")

	#Visualización horizontal.
	var h_movement_direction:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if h_movement_direction != 0:
		velocity.x = clamp(velocity.x + (h_movement_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
		# Verifico la dirección del personaje.
		if (velocity.x > 0):
			body.flip_h = false # La dirección del personaje es hacia adelante. 
		else:
			body.flip_h = true # La dirección del personaje es hacia atrás. 
		_play_animation('walk')		
	else:
		velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
		player_animation.play("idle") # Deja la visualización del personaje en Idle (inactivo)

	var mouse_position:Vector2 = get_global_mouse_position()
	cannon.look_at(mouse_position)


func _physics_process(delta):
	
	#Obtengo el valor de la tecla presionada.
	get_input()
	
	# Apply velocity
	var snap:Vector2
	
	velocity.y += gravity

	velocity = move_and_slide_with_snap(velocity, snap_vector, FLOOR_NORMAL, true, 4, SLOPE_THRESHOLD) # Usando move_and_slide_with_snap y con threshold de slope

func _play_animation(animation:String):
	if player_animation.has_animation(animation):
		player_animation.play(animation)

func notify_hit():
	print("I'm player and imma die")
	player_animation.stop()
	player_animation.play("dead")
	#call_deferred("_remove")

func _remove():
	set_physics_process(false)
	hide()
	collision_layer = 0


