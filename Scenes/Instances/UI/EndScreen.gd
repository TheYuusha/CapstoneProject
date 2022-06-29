extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerData.connect("game_over", self, "GameOver")
	PlayerData.connect("game_win", self, "GameWin")

func GameOver():
	get_tree().paused = true
	GameManager.game_state = GameManager.GameState.END
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_node("EndText").text = "Game Over"
	

func GameWin():
	get_tree().paused = true
	GameManager.game_state = GameManager.GameState.END
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_node("EndText").text = "You Win"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
