class_name KelpForest
extends Chunk

func initialize() -> void:
	super.initialize()
	generate_algae(4, 16)
	generate_kelp(4, 32)
