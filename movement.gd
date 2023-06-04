extends CharacterBody2D


@export var speed : float = 30
@export var visuals : Sprite2D

@export var rotations : Array[Texture2D]

func get_degrees_to_mouse():
	var mouse_pos : Vector2 = get_global_mouse_position()
	var dir : Vector2 = (position - mouse_pos)
	set_sprite(rad_to_deg(atan2(dir.y, -dir.x)))

func set_sprite(angle : float):
	print("Before %d" % angle)
	while angle < 0:
		angle += 360
		
	var snap : float = 360 / len(rotations)
	angle = round(angle / snap) * snap # snapping angle
	
	var index : int = round(angle / 360 * (len(rotations) - 1))
	visuals.texture = rotations[index]
	
	print(angle)

func handle_input(delta : float):
	var direction : Vector2 = Vector2(0, 0)
	
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	
	position += direction.normalized() * speed * delta

func _physics_process(delta):
	handle_input(delta)
	get_degrees_to_mouse()
	move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
