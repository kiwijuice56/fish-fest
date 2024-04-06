class_name Slug
extends Fish

@export var max_speed: float = 32
@export var despawn_range: float = 1400

func _ready() -> void:
	super._ready()
	randomize()
	velocity = Vector2(randf() - 0.5, randf() - 0.5).normalized() * max_speed
	rotation = Vector2(1, 0).angle_to(velocity.normalized())
	scale *= .3 + randf_range(.8, 1.2)
	%AnimationPlayer2.speed_scale *= randf_range(.8, 1.1)

func _physics_process(delta: float) -> void:
	move_and_slide()
	if (Ref.player.global_position - global_position).length() > despawn_range:
		queue_free()
