extends Area

export(float) var bounce_power = 30

func _on_BouncePad_area_entered(area):
	area.get_parent().velocity.y = bounce_power
