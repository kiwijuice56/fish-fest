class_name RedKelpForest
extends Chunk

@export var muncher_scene: PackedScene
@export var muncher_scene2: PackedScene

func initialize() -> void:
	super.initialize()
	generate_algae(8, 25)
	generate_scene(kelp_scene, 4, 12)
	generate_scene_separate(muncher_scene, 0, 3)
	if muncher_scene2 != null:
		generate_scene_separate(muncher_scene2, 0, 8)
