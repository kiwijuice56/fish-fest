class_name KelpForest
extends Chunk

@export var muncher_scene: PackedScene

func initialize() -> void:
	super.initialize()
	generate_algae(4, 16)
	generate_scene(kelp_scene, 4, 22)
	generate_scene_separate(muncher_scene, 0, 2)
