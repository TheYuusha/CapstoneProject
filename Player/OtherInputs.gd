extends Spatial

onready var pause_menu = get_node("../../PlayerUI/PauseMenu")
onready var interact_cast = get_node("../../InteractCast") 

func _process(delta):
	if GameManager.game_state != GameManager.GameState.END:
		if Input.is_action_just_pressed("interact"):
			print("Pressed E")
			interact_cast.force_raycast_update()
			if interact_cast.is_colliding():
				interact_cast.get_collider().interact()
		if Input.is_action_just_pressed("ui_cancel"):
			if pause_menu != null:
				PauseGame(!pause_menu.visible)

func PauseGame(var pause: bool):
	pause_menu.visible = pause
