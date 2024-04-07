class_name Parallax
extends ParallaxBackground

@export var kelp_scene: PackedScene
@export var rock_scene: PackedScene

func _ready() -> void:
	var noise: FastNoiseLite = FastNoiseLite.new()
	
	for i in range(32):
		var pos: Vector2 = Vector2(randf(), randf()) * 1600 + Vector2(200, 200)
		if noise.get_noise_2dv(pos) > 0.5:
			continue
		
		var new_kelp: Kelp = kelp_scene.instantiate()
		%ParallaxLayer.add_child(new_kelp)
		new_kelp.initialize()
		new_kelp.scale *= 0.5
		new_kelp.position = pos
