extends Control

func _ready():
	get_tree().paused = false

func _on_StartButton_pressed():
	get_tree().change_scene("res://HexMap/MapGenerator.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()
