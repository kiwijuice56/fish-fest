class_name Squiggler
extends Fish

func _physics_process(delta: float) -> void:
	var avg_vel: Vector2
	for tentacle in %Tentacles.get_children():
		avg_vel += tentacle.joints.get_child(0).linear_velocity
	if avg_vel.length() <= 1.0:
		return
	velocity = (avg_vel / %Tentacles.get_child_count()).normalized() * 32
	move_and_slide()
