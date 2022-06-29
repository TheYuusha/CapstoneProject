extends HBoxContainer

onready var arrow = get_node("Arrow")

func mouse_over():
	arrow.show()

func mouse_exit():
	arrow.hide()
