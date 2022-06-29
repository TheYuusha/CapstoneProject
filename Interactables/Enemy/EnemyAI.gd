extends Spatial

onready var enemy = get_node("../")

var path = []
var path_node = 0

var speed = 8

onready var nav = get_node("../../")

var target

func _physics_process(delta):
	var velocity = Vector3.ZERO
	
	if target != null:
		enemy.look_at(target.get_global_transform().origin, Vector3.UP)
		velocity = -global_transform.basis.z.normalized() * speed
	
	if !enemy.is_on_floor():
		velocity.y += -9.8
	enemy.move_and_slide(velocity, Vector3.UP)

#func _physics_process(delta):
#	if path_node < path.size():
#		var direction = (path[path_node] - enemy.global_transform.origin)
#		if direction.length() < 1:
#			path_node += 1
#		else:
#			enemy.move_and_slide(direction.normalized() * speed, Vector3.UP)
#
#func move_to(target_pos):
#	path = nav.get_simple_path(enemy.global_transform.origin, target_pos)
#	path_node = 0

func _on_Timer_timeout():
	if target != null:
		pass
		#move_to(get_node(target).global_transform.origin + Vector3(0, .5, 0))
		#move_to(target.global_transform.origin + Vector3(0, .5, 0))


func _on_VisionArea_body_entered(body):
	if body.editor_description == "Player":
		target = body
