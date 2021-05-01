extends Sprite

onready var fire_torr_position = $FireTorrPosition

var projectile_scene:PackedScene = load("res://entities/player/TorretaProjectile.tscn")

var container:Node

func fire_torreta(position_player):
	var new_projectile = projectile_scene.instance()
	container.add_child(new_projectile)
	new_projectile.initialize((position_player - global_position).normalized(), fire_torr_position.global_position)
