extends Area

export(float) var rotation_speed = 1.0

onready var mesh = get_node("MeshInstance")

func _process(delta):
	if GameManager.game_state == GameManager.GameState.PAUSED:
		return

	mesh.rotation.y += rotation_speed * delta


#func _on_Coin_area_entered(area):
#	PlayerData.coins_value_change(1)
#	print(PlayerData.coins_get())
#	queue_free()


func _on_Coin_body_entered(body):
	if body.editor_description == "Player":
		PlayerData.coins_value_change(1)
		queue_free()
