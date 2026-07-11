extends CharacterBody2D


@export var speed := -250

func _physics_process(delta: float) -> void:
	position.x += speed*delta
	if position.x < 100:
		queue_free()
