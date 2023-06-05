extends MultiplayerSynchronizer

@export var mouse_position : Vector2
@export var direction : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = Input.get_vector("left", "right", "up", "down")
