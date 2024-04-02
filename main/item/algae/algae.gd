class_name Algae
extends Item

func _ready() -> void:
	modulate = Color.from_hsv(randf(), 0.8, 0.5)

func collect(collector: Fish) -> void:
	if collected:
		return
	collected = true
	Stats.energy += 1
	$AnimationPlayer.play("eat")
	await $AnimationPlayer.animation_finished
	queue_free()