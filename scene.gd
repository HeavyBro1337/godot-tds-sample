extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if not multiplayer.is_server():
		return

	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(del_player)

	# Spawn already connected players
	for id in multiplayer.get_peers():
		add_player(id)

	# Spawn the local player unless this is a dedicated server export.
	if not OS.has_feature("dedicated_server"):
		add_player(1)
		
func add_player(id : int):
	print("id: %d" % id)
	var p : Player = preload("res://player.tscn").instantiate()
	p.player = id
	p.name = str(id)
	$Players.add_child(p, true)

func del_player(id : int):
	if not $Players.has_node(str(id)):
		return
	$Players.get_node(str(id)).queue_free()
