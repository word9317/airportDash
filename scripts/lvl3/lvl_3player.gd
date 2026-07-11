extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
@onready var sprite = $AnimatedSprite2D
@onready var collisionshape = $CollisionShape2D
var dead = false

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

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("person"):
			print("ded")
			die()
		if test_move(global_transform, Vector2.ZERO):
			# Get the overlapping bodies to see if it's our buggy obstacle
			# We look slightly to the right where the obstacle comes from
			if test_move(global_transform, Vector2(1, 0)):
				print("ded via push")
				die()

func die():
	if dead: return
	dead = true
	sprite.play("dead")
	get_tree().paused = true
