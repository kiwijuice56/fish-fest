class_name Clam
extends Fish

@export var despawn_range: float = 1400
var target: Fish
var open: bool = false

func _ready() -> void:
	%VisionArea.body_entered.connect(_on_something_seen)
	%VisionArea.body_exited.connect(_on_something_unseen)
	rotation = randf() * 2 * PI

func _physics_process(delta: float) -> void:
	if (Ref.player.global_position - global_position).length() > despawn_range:
		queue_free()
	
	%AnimationPlayer.speed_scale = lerp(%AnimationPlayer.speed_scale, 2.0, delta)
	if not target:
		return
	var dir: Vector2 = (target.global_position - global_position).normalized()
	rotation = lerp_angle(rotation, Vector2(1,0).angle_to(dir), delta * 0.35)
	%AnimationPlayer.speed_scale = lerp(%AnimationPlayer.speed_scale, 6.0, delta)

func _on_something_seen(body: PhysicsBody2D):
	if open:
		return
	if body is BoidFish or body is PlayerFish:
		target = body
		open = true
		#%AnimationPlayer.play("open")

func _on_something_unseen(body: PhysicsBody2D):
	if not open:
		return
	if body == target:
		target = null
		open = false
		#%AnimationPlayer.play("close")
