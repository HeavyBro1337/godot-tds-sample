extends Node2D

class_name RotatableAnimation

@export var frameCount : int :
	get:
		if len(angleFrames) == 0:
			return 0
		return len(angleFrames[0])
		
@export var animationPath : String

@export var angleFrames : Array[Array] = []

func get_rotated_frame(angle : float, frame) -> Texture2D:
	while angle < 0:
		angle += 360
		
	var snap : float = 360 / len(angleFrames)
	angle = round(angle / snap) * snap # snapping angle
	angle = int(angle) % 360
	var rots = len(angleFrames) - 1
	var index : int = rots - round(angle / 360 * rots)
	return angleFrames[index][frame]

func _ready():
	var directories = []
	var dir = DirAccess.open(animationPath)
	
	if dir != null:
		directories = dir.get_directories()
	for d in directories:
		var files = []
		var framesDir = DirAccess.open(animationPath + "/" + d)
		
		if framesDir != null:
			angleFrames.append([])
			files = framesDir.get_files()
			print(files)
			for f in files:
				if ".import" in f:
					continue
				var path = animationPath + d + "/" + f
				print(path)
				var spr = load(path)
				angleFrames[-1].append(spr)
	print(len(angleFrames))
