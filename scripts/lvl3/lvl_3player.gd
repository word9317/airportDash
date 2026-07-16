extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
@onready var sprite = $AnimatedSprite2D
@onready var collisionshape = $CollisionShape2D
var dead = false
var is_level_ending: bool = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle left/right movement.
	var direction = Input.get_axis("move_right", "move_left")
	if direction:
		velocity.x = direction * SPEED
		
		# Flipping logic based on direction
		if direction > 0:
			sprite.flip_h = false  # Facing right (default)
		elif direction < 0:
			sprite.flip_h = true   # Facing left (flipped)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle animations
	if not is_on_floor():
		if sprite.animation != "jump":
			sprite.play("jump")
	else:
		if sprite.animation != "run":
			sprite.play("run")
			
	move_and_slide()

	# Check collisions
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		# Safety check: make sure the collider actually exists
		if collider == null:
			continue
			
		if collider.is_in_group("person"):
			print("ded")
			die()
			return # Stop checking other collisions this frame
			
		if collider.is_in_group("end"):
			print("lvlEnd")
			is_level_ending = true # INSTANTLY flags that the level is over
			get_tree().paused = true

			await get_tree().create_timer(2.5).timeout
			print("end")
			return

	# Only check for crushing/pushing if the level isn't already won
	if test_move(global_transform, Vector2.ZERO):
		if test_move(global_transform, Vector2(1, 0)):
			print("ded via push")
			die()

func die():
	if dead: return
	dead = true
	sprite.play("dead")
	get_tree().paused = true
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/lost.tscn")
