extends MultiplayerSynchronizer

@export var mouse_position : Vector2
@export var direction : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	var is_mine = get_multiplayer_authority() == multiplayer.get_unique_id()
	set_process(is_mine)
	set_process_input(is_mine)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = Input.get_vector("left", "right", "up", "down")
@rpc("any_peer")
func shoot_projectile():
	get_parent().shoot_projectile()
	
func _input(event):
	if event.is_action_pressed("fire"):
			rpc("shoot_projectile")
			shoot_projectile()
	
