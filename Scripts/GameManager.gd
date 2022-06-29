extends Node

#onready var player = get_node("Player")
signal pause_game(is_paused)

enum GameState {
	PLAYING,
	PAUSED,
	END
}

var game_state = GameState.PLAYING

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if game_state != GameState.END:
		if Input.is_action_just_pressed("ui_cancel"):
			if game_state == GameState.PAUSED:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				game_state = GameState.PLAYING
				get_tree().paused = false
			elif game_state == GameState.PLAYING:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				game_state = GameState.PAUSED
				get_tree().paused = true
