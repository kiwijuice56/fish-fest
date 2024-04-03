class_name Tentacle
extends Node2D

@export var hostile: bool = true
@export var cooldown_time: float = 12.0
@export var controller: NodePath
@onready var joints: Node2D = $Joints
@onready var line: Line2D = $Line2D

var prey: Fish
var lunging: bool = false

func _ready() -> void:
	$PinJoint2D.node_a = "../../../"
	if hostile:
		%Killer.body_entered.connect(_on_prey_entered)
		%Seen.body_entered.connect(_on_prey_seen)
		%Seen.body_exited.connect(_on_prey_left)
		%Timer.timeout.connect(_on_lunge)
	
	%AnimationPlayer.speed_scale = 1.0 / cooldown_time

func _physics_process(delta: float) -> void:
	for i in range(joints.get_child_count()):
		line.points[i + 1] = joints.get_child(i).position

func _on_prey_entered(body: PhysicsBody2D):
	var tip: RigidBody2D = joints.get_child(-1) 
	if (body is BoidFish or body is PlayerFish) and not %AnimationPlayer.is_playing() and tip.linear_velocity.length() >= 512:
		%AnimationPlayer.play("kill")
		
		if body is BoidFish:
			Stats.fish -= 1
			body.queue_free()
		else:
			Stats.fish -= 1
			Ref.main.gameover.call_deferred()

func _on_prey_seen(body: PhysicsBody2D):
	if body is PlayerFish or body is BoidFish:
		prey = body

func _on_prey_left(body: PhysicsBody2D):
	if body is PlayerFish or body is BoidFish:
		prey = null

func _on_lunge() -> void:
	if is_instance_valid(prey) and not %AnimationPlayer.is_playing():
		var tip: RigidBody2D = joints.get_child(-1) 
		tip.apply_impulse(96 * (prey.global_position - tip.global_position))
