extends Node

signal coins_changed(new_value)
signal health_changed(value)

signal game_over()
signal game_win()

signal increase_total_coins(value)

var coins = 0 setget coins_value_change, coins_get

var health = 5
var max_health = 5

var total_coins = 0

enum PlayerSate {
	IDLE,
	JUMPING,
	FALLING,
	MOVING
}

var player_state = PlayerSate.IDLE

func _ready():
	connect("increase_total_coins", self, "increase_total_coins")

func increase_total_coins(value):
	total_coins += value

func change_health_value(value):
	health -= value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("game_over")
	

func coins_value_change(change_value):
	coins += change_value
	if coins < 0:
		coins = 0
		
	emit_signal("coins_changed", coins)
	
	if coins >= total_coins and total_coins > 0:
		emit_signal("game_win")
		return


func coins_get():
	return coins
