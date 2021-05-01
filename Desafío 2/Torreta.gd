extends Sprite

onready var armTorreta = $ArmTorreta #Obtengo el nodo Arm Torreta(hijo)

var global_position_player:Vector2
#export (PackedScene) var projectile_scene:PackedScene

#var speed = 200 #Pixeles No se mueve la torreta.

func initialize(projectile_container, global_position): 
	armTorreta.container = projectile_container
	global_position_player = global_position 

func _physics_process(delta):
	
	#Apuntar a un objetivo
	#armTorreta.global_position 
	
	var position_player = global_position_player
	armTorreta.fire_torreta(position_player)
	
	#if Input.is_action_just_pressed("fire_torreta"): # Acción que se acaba de presionar. 
		#var new_projectile = projectile_scene.instance() # Crea una instancia del proyectil de la Torreta
		#add_child(new_projectile) Se añade al árbol. 
