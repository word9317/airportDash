extends Node2D
#Tuff label
@export var timeLabel: RichTextLabel

# time that flight leaves
var leave1: int = 11
var leave2: int = 35
@export var leavingTime: RichTextLabel

#Time variables
@export var time1: String = "00"
@export var time2: String = "00"

var colonOn: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeLabel.text = time1 + ":" + time2
	
	# 1. Convert current times from Strings to Integers
	var current_hour: int = int(time1)
	var current_min: int = int(time2)
	
	# 2. Calculate the raw difference
	var diff_hours: int = leave1 - current_hour
	var diff_mins: int = leave2 - current_min
	
	# 3. If minutes are negative, borrow 1 hour (60 minutes)
	if diff_mins < 0:
		diff_mins += 60
		diff_hours -= 1
		
	# 4. (Optional Safety) If the calculated time is negative, the flight already left!
	if diff_hours < 0:
		leavingTime.text = "You missed your flight!"
	else:
		# 5. Display the clean, positive numbers
		leavingTime.text = "Flight leaves in " + str(diff_hours) + " hours and " + str(diff_mins) + " minutes..."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func timerChange() -> void:
	colonOn = !colonOn
	if colonOn:
		timeLabel.text = time1 + ":" + time2
	else:
		timeLabel.text = time1 + " " + time2
	pass # Replace with function body.
