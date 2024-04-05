class_name Kelp
extends StaticBody2D

@export var color: GradientTexture1D

func initialize() -> void:
	rotation = randf() * 2 * PI
	scale *= 1.6 * randf() + 0.8
	z_index = 1 + int(scale.x)
	modulate = color.gradient.sample(randf())
	if has_node("AnimationPlayer"):
		$AnimationPlayer.speed_scale = (-1 if randf() < 0.5 else 1) * randf() / 256.0
