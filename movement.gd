extends CharacterBody2D


@export var speed : float = 30
@export var visuals : Sprite2D

@export var rotations : Array[Texture]

func rotate_to_mouse():
	var mouse_pos : Vector2 = get_global_mouse_position()
	var dir : Vector2 = (position - mouse_pos)
	visuals.rotation_degrees = rad_to_deg(atan2(dir.y, dir.x))

func set_sprite(angle : float):
	

func handle_input(delta : float):
	var direction : Vector2 = Vector2(0, 0)
	
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	
	position += direction.normalized() * speed * delta

func _physics_process(delta):
	handle_input(delta)
	rotate_to_mouse()
	move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
