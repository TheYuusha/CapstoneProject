extends Spatial

export(float) var look_sensitivity = 15.0
export(float) var min_look_angle = 20.0
export(float) var max_look_angle = -75.0

export(float) var max_distance = 10.0
export(float) var min_distance = 3.0

export(float) var scroll_speed = .5

var mouse_delta = Vector2()

var target = null

onready var player = get_parent()
onready var camera = $Camera
onready var camera_collider = get_node("CameraCollider")
#onready var move_rot = get_parent().get_node("Model")

#if camera_collider.is_colliding():
#		camera.global_transform.origin = camera_collider.get_collision_point()
#	else:
#		camera.translation = camera_collider.cast_to


func _init():
	pass
	#GameManager.camera = self

func input(event):
	if event is InputEventMouseMotion:
		mouse_delta = event.relative
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			camera.translation.x -= scroll_speed
		if event.button_index == BUTTON_WHEEL_DOWN:
			camera.translation.x += scroll_speed
		camera.translation.x = clamp(camera.translation.x, min_distance, max_distance)


func process(delta):
	if camera_collider.is_colliding():
		camera.global_transform.origin = camera_collider.get_collision_point() - camera.global_transform.basis.z.normalized() * 2.5
	else:
		camera.translation = camera_collider.cast_to
	
	var rot = Vector3(mouse_delta.y, mouse_delta.x, 0) * look_sensitivity * delta

	rotation_degrees.z -= rot.x
	rotation_degrees.z = clamp(rotation_degrees.z, min_look_angle, max_look_angle)

	#player.
	player.rotation_degrees.y -= rot.y
	#move_rot.rotation_degrees.y -= rot.y
	#get_parent().get_node("Art").rotation_degrees.y -= rot.y

	#player.get_child(2).

	mouse_delta = Vector2()
