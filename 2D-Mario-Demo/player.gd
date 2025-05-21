extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var SPEED: float = 100.0
@export var JUMP_VELOCITY: float = -300.0

@export_group("Camera sync")
@export var camera_sync: Camera2D
@export var should_camera_sync: bool = true
@export_group("")



func _physics_process(delta: float) -> void:
	
	var camera_left_bound = camera_sync.global_position.x - camera_sync.get_viewport_rect().size.x / 2 / camera_sync.zoom.x
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		

	if global_position.x < camera_left_bound + 8:
		global_position.x = camera_left_bound + 8 
		velocity.x = max(0, velocity.x) 

	# Handle jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("jump")  # Play jump animation

	# Get movement direction
	var direction := Input.get_axis("move_left", "move_right")

	# Animation Handling
	if not is_on_floor():
		$AnimatedSprite2D.play("jump")  # Ensure jump plays when in air
	elif direction > 0:
		$AnimatedSprite2D.play("run_right")  # Play right movement animation
	elif direction < 0:
		$AnimatedSprite2D.play("run_left")  # Play left movement animation
	else:
		$AnimatedSprite2D.play("idle")  # Play idle animation when not moving

	# Move player
	velocity.x = direction * SPEED if direction else move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func _process(delta):
	if global_position.x > camera_sync.global_position.x && should_camera_sync:
		camera_sync.global_position.x = global_position.x
