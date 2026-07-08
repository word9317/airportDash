extends Node 

const LOSE_SCREEN = preload("res://scenes/lost.tscn")

func lose_game():
	print("Game Over!")
	var lose_screen_instance = LOSE_SCREEN.instantiate()
	get_tree().current_scene.add_child(lose_screen_instance)
