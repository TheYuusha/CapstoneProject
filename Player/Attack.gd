extends Spatial

export(float) var attack_duration = 1.0

onready var model = get_node("../Model")
onready var tween = get_node("../Tween")
onready var attack_collider = get_node("../InteractableCollider/CollisionShape")
onready var attack_timer = get_node("../AttackTimer")
var is_attacking = false

func physics_process(delta):
	
	if Input.is_action_just_pressed("attack") and is_attacking == false:
		attack()

func attack():
	is_attacking = true
	attack_timer.wait_time = attack_duration
	attack_timer.start()
	rotate_model()

func rotate_model():
	tween.interpolate_property(model, "rotation_degrees", model.rotation_degrees, 
					model.rotation_degrees + Vector3(0, 720, 0), attack_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	attack_collider.disabled = false

func _on_Tween_tween_completed(object, key):
	attack_collider.disabled = true

func _on_AttackTimer_timeout():
	is_attacking = false
