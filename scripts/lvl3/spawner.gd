extends Node2D

@onready var spawn_timer = $spawnTimer
@onready var spawn_point = $Marker2D

var ended: bool = false
var obstacleScene = [
	preload("res://scenes/pretendTheyAreCalledlvl2/lvl3OBSTACLE.tscn"),
	preload("res://scenes/pretendTheyAreCalledlvl2/lvl3OBSTACLE2.tscn"),
	preload("res://scenes/pretendTheyAreCalledlvl2/lvl3OBSTACLE3.tscn")
]

func _ready() -> void:
	randomize()
	# REMOVED the () so we pass the function as a reference, not call it immediately.
	# Also, we only need to connect this ONCE in _ready.
	spawn_timer.timeout.connect(spawnObstacle) 
	startSpawnTimer()

func spawnObstacle():
	if !ended:
		var randomObstacle = obstacleScene.pick_random()
		var obstacle = randomObstacle.instantiate()
		obstacle.position = spawn_point.position
		add_child(obstacle) # Don't forget to actually add it to the scene tree!
	
	# Randomize the timer again for the NEXT spawn
	startSpawnTimer() 
	
func startSpawnTimer():
	spawn_timer.wait_time = randf_range(2.0, 4.5)
	spawn_timer.start()


func gameEnd() -> void:
	ended = true
	await get_tree().create_timer(2.5).timeout 
	var end = preload("res://scenes/pretendTheyAreCalledlvl2/lvl2End.tscn").instantiate()
	end.position = spawn_point.position
	add_child(end)
