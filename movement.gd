extends CharacterBody2D

class_name Player
@export var animator : RotatableAnimator
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
	var dir : Vector2 = ($PlayerSync.mouse_position - position).normalized()
	animator.angle = vec_to_deg(dir)

func _mine() -> bool:
	return player == multiplayer.get_unique_id()


func _ready():
	if not _mine():
		camera.queue_free()
	set_physics_process(multiplayer.is_server())

func handle_input(delta : float):
	position += $PlayerSync.direction.normalized() * speed * delta
	# $PlayerInput.position = position

func _physics_process(delta):
	handle_input(delta)
	move_and_slide()
	
func _process(delta):
	get_degrees_to_mouse()
	if not _mine():
		var dir : Vector2 = ($PlayerSync.mouse_position - position).normalized()
		animator.angle = vec_to_deg(dir)

static func vec_to_deg(direction : Vector2) -> float:
	return rad_to_deg(atan2(direction.y, direction.x))
	
@rpc
func shoot_projectile():
	var bullet = preload("res://Bullet.tscn").instantiate()
	var dir : Vector2 = ($PlayerSync.mouse_position - position).normalized()
	var angle : float = vec_to_deg(dir)
	bullet.rotation_degrees = angle
	bullet.name = "bullet %d" % player
	bullet.position = position
	get_parent().add_child(bullet, true)
	
	
	
