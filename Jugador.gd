extends Sprite

export (float) var speed:float 

func _process(delta):

	# 	Mueve el jugador de acuerdo a la tecla presionada (Input).
	var direction:int = int(Input.is_action_pressed("derecha")) - int(Input.is_action_pressed("izquierda"))
	position.x += direction * speed * delta
	
	####
	
	#var derecha = Input.is_action_just_pressed("derecha")
	#var izquierda = Input.is_action_just_pressed("izquierda")
	
	#position.x += 20 * delta
	
	#if derecha:
	#	position.x += speed * delta
		
	#elif izquierda:
	#	position.x += speed * delta
