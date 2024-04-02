class_name World
extends Node

@export var chunk_scene: PackedScene
var chunk_storage: Dictionary
var player_chunk: Vector2 = Vector2(0, 0)

func _ready() -> void:
	update_chunks()

func _process(delta: float) -> void:
	var new_player_chunk: Vector2 = (Ref.player.global_position / Chunk.SIZE).floor()
	if new_player_chunk != player_chunk:
		player_chunk = new_player_chunk
		update_chunks()

func update_chunks() -> void:
	for child in get_children():
		remove_child(child)
	for i in range(-1, 2):
		for j in range(-1, 2):
			var offset: Vector2 = Vector2(i, j)
			var chunk_pos: Vector2 = player_chunk + offset
			if not chunk_pos in chunk_storage:
				chunk_storage[chunk_pos] = generate_chunk(chunk_pos)
			else:
				add_child(chunk_storage[chunk_pos])

func generate_chunk(chunk_pos: Vector2) -> Chunk:
	var new_chunk: Chunk = chunk_scene.instantiate()
	add_child(new_chunk)
	new_chunk.global_position = Chunk.SIZE * chunk_pos
	return new_chunk
