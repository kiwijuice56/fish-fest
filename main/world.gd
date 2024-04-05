class_name World
extends Node

@export var chunk_scenes: Array[PackedScene]
@export var chunk_prop: Array[float]
@export var squiggler_scene: PackedScene

var chunk_storage: Dictionary
var player_chunk: Vector2 = Vector2(0, 0)
var noise: FastNoiseLite
var current_squiggler: Squiggler

func _ready() -> void:
	randomize()
	noise = FastNoiseLite.new()
	noise.offset = Vector3(randf(), randf(), randf()) * 1024
	noise.frequency = 0.2
	update_chunks()

func _process(delta: float) -> void:
	var new_player_chunk: Vector2 = (Ref.player.global_position / Chunk.SIZE).floor()
	if new_player_chunk != player_chunk:
		player_chunk = new_player_chunk
		update_chunks.call_deferred()

func update_chunks() -> void:
	var tween: Tween = get_tree().create_tween()
	var last: Dictionary = {}
	for child in get_children():
		last[child] = true
	
	var remain: Dictionary = {}
	for i in range(-1, 2):
		for j in range(-1, 2):
			var offset: Vector2 = Vector2(i, j)
			var chunk_pos: Vector2 = player_chunk + offset
			if not chunk_pos in chunk_storage:
				chunk_storage[chunk_pos] = generate_chunk(chunk_pos)
			elif not chunk_storage[chunk_pos] in last:
				add_child(chunk_storage[chunk_pos])
			remain[chunk_storage[chunk_pos]] = true
	for child in get_children():
		if not child in remain:
			remove_child(child)
	tween.tween_property(%Background, "color", chunk_storage[player_chunk].bg_color, 1.0)

func generate_chunk(chunk_pos: Vector2) -> Chunk:
	var noise_coord: Vector2 = chunk_pos
	var val: float = (noise.get_noise_2d(noise_coord.x, noise_coord.y) + 1.0) / 2.0
	var i: int = 0
	while i < len(chunk_prop) and val > chunk_prop[i]:
		i += 1
	if chunk_pos.length() <= 2:
		i = 0
	
	var new_chunk: Chunk = chunk_scenes[i].instantiate()
	new_chunk.global_position = Chunk.SIZE * chunk_pos
	add_child.call_deferred(new_chunk)
	new_chunk.initialize.call_deferred()
	
	var no_squiggler: bool = chunk_pos.length() <= 4.0
	
	if not no_squiggler and randf() < new_chunk.squiggler_chance and not is_instance_valid(current_squiggler):
		current_squiggler = squiggler_scene.instantiate()
		get_parent().add_child.call_deferred(current_squiggler)
		current_squiggler.global_position = chunk_pos * Chunk.SIZE + Chunk.SIZE * 0.5
	return new_chunk
