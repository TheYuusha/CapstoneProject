extends Area

export(float) var boost = 16

func _on_AccelerationPad_area_entered(area):
	area.get_parent().current_speed = area.get_parent().max_speed + boost
