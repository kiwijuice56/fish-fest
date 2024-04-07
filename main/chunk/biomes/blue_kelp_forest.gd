class_name BlueKelpForest
extends Chunk

@export var muncher_scene: PackedScene
@export var muncher_scene2: PackedScene

func initialize() -> void:
	super.initialize()
	generate_algae(16, 48)
	generate_scene_separate(muncher_scene, 12, 32)
	generate_scene_separate(muncher_scene2, 4, 8)
