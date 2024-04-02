class_name Egg
extends Item

@export var boid_scene: PackedScene
@export var hatch_time: float = 12.0

func _ready() -> void:
	grow()

func grow() -> void:
	%AnimationPlayer.speed_scale = 1.0 / hatch_time
	%AnimationPlayer.play("grow")
	await %AnimationPlayer.animation_finished
	spawn_boid()
	queue_free()

func spawn_boid() -> void:
	var new_boid: BoidFish = boid_scene.instantiate()
	get_parent().add_child(new_boid)
	get_parent().move_child(new_boid, 0)
	new_boid.global_position = global_position
	new_boid.commander = Ref.player
