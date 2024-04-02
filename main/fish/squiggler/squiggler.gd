class_name Squiggler
extends Fish

@export var tentacle_scene: PackedScene
@export var tentacle_count: int = 8
@export var despawn_distance: float = 1800

var target: Fish

func _ready() -> void:
	tentacle_count = randi_range(5, 12)
	for i in range(tentacle_count):
		var new_tentacle: Tentacle = tentacle_scene.instantiate()
		new_tentacle.rotation = i * 2 * PI / (tentacle_count)
		%Tentacles.add_child(new_tentacle)
	%VisionArea.body_entered.connect(_on_something_seen)
	%VisionArea.body_exited.connect(_on_something_unseen)

func _physics_process(delta: float) -> void:
	var avg_vel: Vector2
	for tentacle in %Tentacles.get_children():
		avg_vel += tentacle.joints.get_child(0).linear_velocity
	if avg_vel.length() <= 1.0 and not is_instance_valid(target):
		return
	velocity = (avg_vel / %Tentacles.get_child_count()).normalized() * 32
	if is_instance_valid(target):
		velocity += (target.global_position - global_position).normalized() * 160
	move_and_slide()
	
	if (Ref.player.global_position - global_position).length() > despawn_distance:
		queue_free()

func _on_something_seen(body: PhysicsBody2D):
	if body is BoidFish or body is PlayerFish:
		target = body

func _on_something_unseen(body: PhysicsBody2D):
	if body == target:
		target = null
