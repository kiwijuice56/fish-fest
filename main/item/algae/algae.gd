class_name Algae
extends Item

func _ready() -> void:
	%Sprite2D.modulate = Color.from_hsv(randf(), 0.8, 0.5)
