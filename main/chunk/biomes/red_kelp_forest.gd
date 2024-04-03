class_name RedKelpForest
extends Chunk

@export var muncher_scene: PackedScene

func initialize() -> void:
	super.initialize()
	generate_algae(8, 25)
	generate_scene(kelp_scene, 4, 16)
	generate_scene_separate(muncher_scene, 1, 3)
