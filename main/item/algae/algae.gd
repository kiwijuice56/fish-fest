class_name Algae
extends Item

@export var color: GradientTexture1D

func _ready() -> void:
	modulate = color.gradient.sample(randf())

func collect(collector: Fish) -> void:
	if collected:
		return
	collected = true
	if collector is BoidFish:
		Stats.energy += 1
	if collector is PlayerFish:
		Stats.energy += 3
	$AnimationPlayer.play("eat")
	await $AnimationPlayer.animation_finished
	queue_free()
