extends Node2D

# incredible variables
var progress: float = 0.0
var outOfTime: bool = false

# fetch some items in the scene
@onready var pathFollower = $Background/Case/Path2D/PathFollow2D
@onready var timer = $Background/Case/Timer
@export var PercentLabel: RichTextLabel

var won: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !outOfTime:
		# progress deterioration, use deltatime so framerate doesnt really affect
		progress -= 15.0 * delta
	
		# hi(progress)
		if Input.is_action_just_pressed("SpaceBar"):
			progress += 4.0 # movement
			print("hi")
		
		# keep progress between 0 and 100
		progress = clamp(progress, 0.0, 100.0)
	
		# move the zipper
		pathFollower.progress_ratio = progress / 100.0
		#Text
		PercentLabel.text = str(snapped(progress, 0.1)) + "% \n" + str(snapped(timer.time_left, 0.1)) 

		# made it to the end yet?
		if progress >= 100.0:
			print("You won!")
			timer.stop()
			timer.wait_time = 2.0
			timer.start()
			won = true
			set_process(false) #stops the process
	


func timerTimeOut() -> void:
	if !won:
		print("Out of time")
		outOfTime = true
		GameManager.lose_game()
	else:
		print("next")
		get_tree().change_scene_to_file("res://scenes/lvl2.tscn")
