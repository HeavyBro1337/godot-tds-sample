extends CharacterBody2D

@export var speed : float


func _physics_process(delta):
	var dir = Vector2.RIGHT.rotated(rotation) * delta * speed
	position += dir
	var collision = move_and_collide(dir)
	if collision != null:
		process_collision(collision)
	
func process_collision(collision : KinematicCollision2D):
	var body : Node2D = collision.get_collider()
	body.queue_free()
	
