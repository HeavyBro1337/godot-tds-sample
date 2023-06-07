extends Sprite2D

class_name RotatableAnimator

@export var animation : Resource
var angle : float = 0
@export var fps : float = 30
var time : float = 0
@export var currentFrame : int = 0
func _process(delta):
	time += delta
	if time >= 1 / fps:
		currentFrame += 1
		currentFrame %= $CurrentAnimation.frameCount
		time -= time
	texture = $CurrentAnimation.get_rotated_frame(angle, currentFrame)
	
func _ready():
	var a = load(animation.resource_path).instantiate()
	a.name = "CurrentAnimation"
	add_child(a)
