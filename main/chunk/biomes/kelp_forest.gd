class_name KelpForest
extends Chunk

func initialize() -> void:
	super.initialize()
	generate_algae(4, 16)
	generate_scene(kelp_scene, 4, 24)
