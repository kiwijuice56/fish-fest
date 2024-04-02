class_name Chunk
extends Node2D

const SIZE: Vector2 = Vector2(800, 600)

func _ready() -> void:
	%IDSprite.modulate = Color.from_hsv(randf(), 1.0, 1.0)
