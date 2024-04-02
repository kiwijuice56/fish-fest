class_name Chunk
extends Node2D

@export var algae_scene: PackedScene

var id_color: Color

const SIZE: Vector2 = Vector2(800, 600)

func _ready() -> void:
	pass

func initialize() -> void:
	%IDSprite.modulate = Color.from_hsv(randf(), 1.0, 1.0)

func generate_algae(min: int, max: int):
	var count: int = randi() % (max - min) + min
	for i in range(count):
		var new_algae: Algae = algae_scene.instantiate()
		add_child(new_algae)
		new_algae.position = Vector2(randi() % int(Chunk.SIZE.x), randi() % int(Chunk.SIZE.y))
