class_name RockyBiome
extends Chunk

@export var muncher_scene: PackedScene
@export var rock_scene: PackedScene

func initialize() -> void:
	super.initialize()
	generate_algae(8, 32)
	generate_scene(rock_scene, 8, 22)
	generate_scene(kelp_scene, 2, 4)
	generate_scene_separate(muncher_scene, 1, 3)
