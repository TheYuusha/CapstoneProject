extends RayCast

onready var shadow = get_node("Shadow") 

func _process(delta):
	if is_colliding():
		shadow.global_transform.origin = get_collision_point()
