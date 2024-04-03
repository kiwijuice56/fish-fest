class_name Debris
extends Sprite2D

@export var color: GradientTexture1D
var velocity: Vector2
var bodies: Array[PhysicsBody2D]

func _ready() -> void:
	modulate = color.gradient.sample(randf())
	modulate.a = 0.4
	velocity = Vector2(randf(), randf()).normalized() * randf() * 16
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)

func _physics_process(delta: float) -> void:
	var vel: Vector2 = Vector2()
	for body in bodies:
		if "velocity" in body:
			vel += body.velocity
	position += velocity * delta
	if len(bodies) > 0:
		velocity = lerp(velocity, vel, delta)

func _on_body_entered(body: PhysicsBody2D) -> void:
	bodies.append(body)

func _on_body_exited(body: PhysicsBody2D) -> void:
	bodies.remove_at(bodies.find(body))
