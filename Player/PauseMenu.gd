extends Panel



func _on_ResumeButton_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	GameManager.game_state = GameManager.GameState.PLAYING
	print(get_tree().paused)
	hide()


func _on_MenuButton_pressed():
	get_tree().change_scene("res://Scenes/TitleScene.tscn")


func _on_OptionsButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://HexMap/MapGenerator.tscn")


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_RespawnButton_pressed():
	get_tree().paused = false
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GameManager.game_state = GameManager.GameState.PLAYING
	var pos = get_node("../../SpawnPosition").transform.origin
	get_node("../../Player").transform.origin = pos
