extends CharacterBody2D

class_name Player

@export var speed : float = 30
@export var visuals : Sprite2D
@export var camera : Camera2D
@export var player := 0 :
	set(id):
		player = id
		$PlayerSync.set_multiplayer_authority(player)
		
		

@export var rotations : Array[Texture2D]

func get_degrees_to_mouse():
	if not _mine():
		return
	$PlayerSync.mouse_position = get_node("/root/Scene").get_local_mouse_position()
	var dir : Vector2 = (position - $PlayerSync.mouse_position).normalized()
	set_sprite(rad_to_deg(atan2(dir.y, -dir.x)))

func _mine() -> bool:
	return player == multiplayer.get_unique_id()


func _ready():
	if not _mine():
		camera.queue_free()
	set_physics_process(multiplayer.is_server())
	
func set_sprite(angle : float):
	while angle < 0:
		angle += 360
	var snap : float = 360 / len(rotations)
	angle = round(angle / snap) * snap # snapping angle
	angle = int(angle) % 360
	
	var index : int = round(angle / 360 * (len(rotations) - 1))
	visuals.texture = rotations[index]

func handle_input(delta : float):
	position += $PlayerSync.direction.normalized() * speed * delta
	# $PlayerInput.position = position

func _physics_process(delta):
	handle_input(delta)
	move_and_slide()
	
func _process(delta):
	get_degrees_to_mouse()
	if not _mine():
		var dir : Vector2 = (position - $PlayerSync.mouse_position).normalized()
		set_sprite(rad_to_deg(atan2(dir.y, -dir.x)))
