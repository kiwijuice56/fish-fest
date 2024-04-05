class_name Chunk
extends Node2D

@export var bg_color: Color
@export var algae_scene: PackedScene
@export var kelp_scene: PackedScene
@export var debris_scene: PackedScene
@export var squiggler_chance: float = 0.0

var id_color: Color
var noise: FastNoiseLite

const SIZE: Vector2 = Vector2(900, 900)

func _ready() -> void:
	pass

func initialize() -> void:
	%IDSprite.modulate = Color.from_hsv(randf(), 1.0, 1.0)
	noise = Ref.noise.duplicate()
	noise.offset = Vector3(randf(), randf(), randf()) * 1024
	generate_scene(debris_scene, 6, 12)

func generate_algae(min: int, max: int):
	var count: int = randi() % (max - min) + min
	for i in range(count):
		var new_algae: Algae = algae_scene.instantiate()
		add_child.call_deferred(new_algae)
		new_algae.position = Vector2(randi() % int(Chunk.SIZE.x), randi() % int(Chunk.SIZE.y))

func generate_scene(scene: PackedScene, min: int, max: int) -> void:
	var count: int = randi() % (max - min) + min
	for i in range(count):
		var coord: Vector2 = Vector2(randf(), randf())
		if noise.get_noise_2d(coord.x, coord.y) > 0.5:
			continue
		var new_something = scene.instantiate()
		add_child.call_deferred(new_something)
		if "initialize" in new_something:
			new_something.initialize.call_deferred()
		new_something.position = coord * Chunk.SIZE

func generate_scene_separate(scene: PackedScene, min: int, max: int) -> void:
	var count: int = randi() % (max - min) + min
	for i in range(count):
		var coord: Vector2 = Vector2(randf(), randf())
		var new_something = scene.instantiate()
		get_tree().get_root().add_child.call_deferred(new_something)
		if "initialize" in new_something:
			new_something.call_deferred.initialize()
		new_something.global_position = global_position + coord * Chunk.SIZE
