extends HBoxContainer

onready var value_label = get_node("Value")

func _init():
	PlayerData.connect("health_changed", self, "change_value")

func change_value(var value: int):
	value_label.text = "%02d" % value
