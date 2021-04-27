extends Node

onready var player = $Player
onready var torreta1 = $Torreta
#onready var torreta2 = $Torreta
#onready var torreta3 = $Torreta


func _ready():
	player.initialize(self) 
	torreta1.initialize(self, player.global_position) #Paso la dirección del Player.
	#torreta2.initialize(self, player.global_position) #Paso la dirección del Player.
	#torreta3.initialize(self, player.global_position) #Paso la dirección del Player.
