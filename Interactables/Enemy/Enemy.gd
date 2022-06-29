extends KinematicBody

export(int) var health = 35
export(float) var knockback_speed = 10

enum EnemyState {
	HIT,
	MOVING,
	IDLE
}

var enemy_state = EnemyState.IDLE

onready var timer = get_node("Timer")
onready var knockback_tween = get_node("KnockbackTween")

var is_invulnerable = false

var velocity = Vector3()

func _on_body_entered(body):
	if body.name == "InteractableCollider":
		is_invulnerable = true
		health -= 1
		#print("Health: " + str(health))
		timer.start()
		if health <= 0:
			queue_free()
		velocity.y = 5
		enemy_state = EnemyState.HIT
		var player_pos = body.get_global_transform().origin
		player_pos.y = 0
		look_at(player_pos, Vector3(0,1,0))

func _physics_process(delta):
	rotation_degrees.x = 0
	rotation_degrees.z = 0
	
	if GameManager.game_state == GameManager.GameState.PAUSED:
		return
	
	if !is_on_floor():
		velocity.y += get_gravity()
	
	match enemy_state:
		EnemyState.HIT:
			knockback(delta)

func get_gravity() -> float:
	return -.98

func knockback(delta):
	var direction = global_transform.basis.z.normalized()
	velocity.x = direction.x * knockback_speed
	
	velocity.z = direction.z * knockback_speed
	move_and_slide(velocity, Vector3.UP)
	
func _on_Timer_timeout():
	enemy_state = EnemyState.IDLE


func _on_InvulnTimer_timeout():
	is_invulnerable = false

func is_enemy():
	pass
