extends Node2D

class_name NetworkManager

var peer = ENetMultiplayerPeer.new()


func _enter_tree():
	print("ready. Network manager...")

func host():
	await peer.create_server(5000)
	multiplayer.multiplayer_peer = peer
	print("Hosted")
	
func join(ip : String):
	peer.create_client(ip, 5000)
	multiplayer.multiplayer_peer = peer
func change_level(scene: PackedScene):
	# Remove old level if any.
	var level = $Level
	for c in level.get_children():
		level.remove_child(c)
		c.queue_free()
	# Add new level.
	level.add_child(scene.instantiate())
