class_name JellyFish
extends Fish

@export var tentacle_scene: PackedScene
@export var max_speed: float = 150.0
@export var despawn_range: float = 1600

func _ready() -> void:
	super._ready()
	velocity = Vector2(randf() - 0.5, randf() - 0.5).normalized() * max_speed
	
	var tentacle_count: int = randi_range(4, 8)
	for i in range(tentacle_count):
		var new_tentacle: Tentacle = tentacle_scene.instantiate()
		new_tentacle.rotation = i * 2 * PI / (tentacle_count)
		new_tentacle.hostile = false
		%Tentacles.add_child(new_tentacle)
	scale *= randf_range(.6, .8)

func _physics_process(delta: float) -> void:
	var avg_vel: Vector2
	for tentacle in %Tentacles.get_children():
		avg_vel += tentacle.joints.get_child(0).linear_velocity
	if avg_vel.length() >= 1.0:
		velocity = (avg_vel / %Tentacles.get_child_count()).normalized() * max_speed
	
	move_and_slide()
	if is_on_wall():
		velocity =  Vector2(randf() - 0.5, randf() - 0.5).normalized() * max_speed
	
	if (Ref.player.global_position - global_position).length() > despawn_range:
		queue_free()

