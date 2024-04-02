class_name Algae
extends Item

func _ready() -> void:
	%Sprite2D.modulate = Color.from_hsv(randf(), 0.2, 0.5)
