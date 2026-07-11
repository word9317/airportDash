extends PathFollow2D

# The speed of movement in pixels per second
@export var speed: float = 50.0

# Set to true if you want it to move, false to pause it
@export var is_moving: bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_moving:
		# Progress moves the node along the path in pixels
		progress += speed * (delta*5) 
		if progress_ratio >= 1.0:
			is_moving = false
			
	pass
