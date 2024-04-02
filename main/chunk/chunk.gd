class_name Chunk
extends Node2D

@export var bg_color: Color
@export var algae_scene: PackedScene
@export var kelp_scene: PackedScene
@export var squiggler_chance: float = 0.0

var id_color: Color
var noise: FastNoiseLite

const SIZE: Vector2 = Vector2(800, 600)

func _ready() -> void:
	pass

func initialize() -> void:
	%IDSprite.modulate = Color.from_hsv(randf(), 1.0, 1.0)
	noise = FastNoiseLite.new()

func generate_algae(min: int, max: int):
	var count: int = randi() % (max - min) + min
	for i in range(count):
		var new_algae: Algae = algae_scene.instantiate()
		add_child(new_algae)
		new_algae.position = Vector2(randi() % int(Chunk.SIZE.x), randi() % int(Chunk.SIZE.y))

func generate_kelp(min: int, max: int) -> void:
	var count: int = randi() % (max - min) + min
	for i in range(count):
		var coord: Vector2 = Vector2(randf(), randf())
		if noise.get_noise_2d(coord.x, coord.y) > 0.5:
			return
		var new_kelp: Kelp = kelp_scene.instantiate()
		add_child(new_kelp)
		new_kelp.initialize()
		new_kelp.position = coord * Chunk.SIZE
