extends KinematicBody

onready var player_movement = get_node("PlayerMovement")
onready var attack = get_node("Attack")
onready var other_inputs = get_node("OtherInputs")
onready var camera_origin = get_node("CameraOrigin")

func _init():
	GameManager.game_state = GameManager.GameState.PAUSED

func _ready():
	yield(get_tree().create_timer(1.0), "timeout")
	GameManager.game_state = GameManager.GameState.PLAYING

func _input(event):
	camera_origin.input(event)

func _process(delta):
	if GameManager.game_state != GameManager.GameState.PAUSED:
		camera_origin.process(delta)

func _physics_process(delta):
	if GameManager.game_state != GameManager.GameState.PAUSED:
		player_movement.physics_process(delta)
		attack.physics_process(delta)



func _on_HitArea_body_entered(body):
	if body.has_method("is_enemy"):
		PlayerData.change_health_value(1)
