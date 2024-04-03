class_name BlueKelpForest
extends Chunk

@export var muncher_scene: PackedScene

func initialize() -> void:
	super.initialize()
	generate_algae(16, 48)
	generate_scene_separate(muncher_scene, 12, 32)
