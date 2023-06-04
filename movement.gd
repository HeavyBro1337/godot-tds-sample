extends Node2D

var speed = 30.0

func _physics_process(delta):
	var direction : Vector2 = Vector2(0, 0)
	
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	
	position += direction.normalized() * speed * delta


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
