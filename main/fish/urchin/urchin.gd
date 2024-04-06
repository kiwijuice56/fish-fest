class_name Urchin
extends Fish

@export var max_speed: float = 32
@export var spike: PackedScene
@export var tendrils: int = 8
@export var despawn_range: float = 1400

func _ready() -> void:
	super._ready()
	randomize()
	velocity = Vector2(randf() - 0.5, randf() - 0.5).normalized() * max_speed
	
	for j in range(2):
		var tentacle_count: int = randi_range(7, 16)
		var offset: float = randf() + 0.1
		for i in range(tentacle_count):
			var new_tentacle: Node2D = spike.instantiate()
			new_tentacle.rotation = randf_range(0, 0.01) + offset + i * 2 * PI / (tentacle_count)
			new_tentacle.get_child(0).scale *= randf_range(0.6, 0.8)
			add_child(new_tentacle)
	$AnimationPlayer.speed_scale = (-1 if randf() < 0.5 else 1) * (randf() * 0.01 + 0.01)
	scale *= randf_range(1.4, 2.1)

func _physics_process(delta: float) -> void:
	move_and_slide()
	if (Ref.player.global_position - global_position).length() > despawn_range:
		queue_free()
