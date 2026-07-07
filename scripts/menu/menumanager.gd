extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func QuitPressed() -> void:
	print("Hi")
	get_tree().quit()
	pass # Replace with function body.


func SettingsPressed() -> void:
	pass # Replace with function body.


func StartPressed() -> void:
	print("next scene thingy")
	# get_tree().change_scene_to_file("res://level_scene.tscn")
	pass # Replace with function body.
