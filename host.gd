extends Button

@export var host : bool = false

func _pressed():
	var network : NetworkManager = get_node("/root/Scene")
	if host:
		network.host()
	else:
		network.join()
	hide()
	if multiplayer.is_server():
		print("Spawning level...")
		network.change_level.call_deferred(load("res://NetworkedScene.tscn"))
