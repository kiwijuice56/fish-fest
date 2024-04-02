class_name MoluscFish
extends Fish
 
@export var max_speed: float = 150.0
@export var cohesion: float = 1.0
@export var alignment: float = 1.0
@export var separation: float = 1.0
@export var despawn_range: float = 1600

var fish_sighted: Array[Fish]
var targets: Array[Fish]

func _ready() -> void:
	super._ready()
	
	%VisionArea.body_entered.connect(_on_fish_entered)
	%VisionArea.body_exited.connect(_on_fish_exited)
	%KillArea.body_entered.connect(_on_kill_entered)
	
	velocity = Vector2(randf() - 0.5, randf() - 0.5).normalized() * 64

func _physics_process(delta: float) -> void:
	var close: Vector2 = Vector2()
	var avg_velocity: Vector2 = Vector2()
	var avg_position: Vector2 = Vector2()
	if len(fish_sighted) > 0:
		for fish in fish_sighted:
			close += global_position - fish.global_position
			avg_velocity += fish.velocity
			avg_position += fish.global_position
		avg_velocity /= len(fish_sighted)
		avg_position /= len(fish_sighted)
		velocity += close * separation * delta
		velocity += avg_velocity * alignment * delta
		velocity += (avg_position - global_position) * cohesion * delta
	if len(targets) > 0:
		avg_position = Vector2()
		for fish in targets:
			avg_position += fish.global_position
		avg_position /= len(targets)
		velocity += (avg_position - global_position) * 1.8 * delta
		max_speed = lerp(max_speed, 200.0, delta * 2)
	else:
		max_speed = lerp(max_speed, 64.0, delta * 2)
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	rotation = lerp_angle(rotation, Vector2(1,0).angle_to(velocity.normalized()), delta * 4)
	%AnimationPlayer.speed_scale = velocity.length() / max_speed * 3.0
	
	move_and_slide()
	if is_on_wall():
		velocity =  Vector2(randf() - 0.5, randf() - 0.5).normalized() * max_speed
	
	if (Ref.player.global_position - global_position).length() > despawn_range:
		queue_free()

func _item_found(area: Area2D) -> void:
	if not area is Algae:
		return
	area.collect(self)

func _on_fish_entered(body: PhysicsBody2D) -> void:
	if not body == self and (body is PlayerFish or body is BoidFish):
		targets.append(body)
	elif not body == self and body is MoluscFish:
		fish_sighted.append(body)

func _on_fish_exited(body: PhysicsBody2D) -> void:
	if (body is PlayerFish or body is BoidFish):
		targets.remove_at(targets.find(body))
	elif not body == self and body is MoluscFish:
		fish_sighted.remove_at(fish_sighted.find(body))

func _on_kill_entered(body: PhysicsBody2D) -> void:
	if (body is BoidFish or body is PlayerFish) and not %AnimationPlayer2.is_playing():
		%AnimationPlayer2.play("kill")
		if body is BoidFish:
			body.queue_free()
		else:
			Ref.main.gameover.call_deferred()
