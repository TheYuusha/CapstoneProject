extends Spatial

export(float) var MOVE_SPEED = 12

export(float) var current_speed = 8
export(float) var max_speed = 16
export(float) var acceleration = 5
export(float) var deceleration = 5

export(float) var jump_height = 5
export(float) var jump_time_to_peak = 2.0
export(float) var jump_time_to_descent = 1.0


onready var jump_velocity: float = (2.0 * jump_height) / jump_time_to_peak
onready var jump_gravity: float = (-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
onready var fall_gravity: float = (-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)

onready var ground_pound_collider = get_node("../GroundPoundArea/GroundPoundShape")

var velocity = Vector3()

var is_jumping = false

onready var player = get_node("../")

func physics_process(delta):
	movement(delta)

func movement(delta):
	var direction = Vector3.ZERO
	
	var x_input = Vector3.ZERO
	var y_input = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"):
		x_input = global_transform.basis.x
		if current_speed < max_speed:
			current_speed += acceleration * delta
		elif current_speed > max_speed:
			current_speed -= acceleration * delta
	else:
		current_speed = 8
	if Input.is_action_pressed("move_back"):
		x_input = -global_transform.basis.x
	
	if Input.is_action_pressed("strafe_left"):
		y_input = -global_transform.basis.z
	elif Input.is_action_pressed("strafe_right"):
		y_input = global_transform.basis.z
	
	direction = x_input + y_input
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
	velocity.x = direction.x * current_speed
	
	
	
	velocity.z = direction.z * MOVE_SPEED
	player.move_and_slide(velocity, Vector3.UP)
	
#	if !player.is_on_floor() and Input.is_action_pressed("jump"):
#			velocity.y += get_gravity() * delta

	if !player.is_on_floor() and !Input.is_action_pressed("jump"):
		if velocity.y > 0:
			velocity.y = 0
	velocity.y += get_gravity() * delta
		
	
	if Input.is_action_just_pressed("jump"):
		if player.is_on_floor():
			jump()
	
	return velocity

func get_gravity() -> float:
	return jump_gravity if velocity.y > 0.0 else fall_gravity

func jump():
	is_jumping = true
	velocity.y = jump_velocity

func _on_GroundPoundArea_body_entered(body):
	print("Hit")
	if body.editor_description == "Enemy":
		jump()
