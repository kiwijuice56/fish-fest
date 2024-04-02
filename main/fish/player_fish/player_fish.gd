class_name PlayerFish
extends Fish

@export var boid_scene: PackedScene
@export var max_speed: float = 128.0
@export var max_radius: float = 128.0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept", false):
		for i in range(16):
			spawn_boid()

func _physics_process(delta: float) -> void:
	var dir: Vector2 = get_global_mouse_position() - global_position
	var speed: float = min(max_radius, dir.length()) / max_radius * max_speed
	dir = dir.normalized()
	
	velocity = dir * speed
	
	%Sprite2D.rotation = Vector2(1, 0).angle_to(dir)
	%AnimationPlayer.speed_scale = speed / max_speed * 3.0
	
	move_and_slide()

func spawn_boid() -> void:
	var new_boid: BoidFish = boid_scene.instantiate()
	get_parent().add_child(new_boid)
	get_parent().move_child(new_boid, 0)
	new_boid.global_position = global_position
	new_boid.commander = self
