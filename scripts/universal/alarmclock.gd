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
	timeLabel.text = time1 + " " + time2
	print(leave1-int(time1))
	print(leave2-int(time2))
	leavingTime.text = "Flight leaves in " + str(leave1) + " hours and " + str(leave2) + " minutes..."
	pass # Replace with function body.


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
