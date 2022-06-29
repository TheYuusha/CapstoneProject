extends StaticBody

export(NodePath) var textbox
export(NodePath) var text_label

export(String) var text_to_display = ""

func interact():
	get_tree().paused = !get_tree().paused
	get_node(textbox).visible = get_tree().paused
	get_node(text_label).text = text_to_display
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE || get_node(textbox).visible == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
