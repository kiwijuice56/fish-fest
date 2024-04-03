class_name BoidFish
extends Fish

@export var color_range: GradientTexture1D
@export var max_speed: float = 280.0
@export var cohesion: float = 1.0
@export var separation: float = 1.0
@export var alignment: float = 1.0
@export var player_follow: float = 2.0
@export var player_alignment: float = 2.0
@export var despawn_distance: float = 2000

@export var commander: PlayerFish
var fish_sighted: Array[BoidFish]
var dead: bool = false

func _ready() -> void:
	super._ready()
	
	%VisionArea.body_entered.connect(_on_fish_entered)
	%VisionArea.body_exited.connect(_on_fish_exited)
	
	velocity = Vector2(randf() - 0.5, randf() - 0.5).normalized() * 32
	modulate = color_range.gradient.sample(randf())

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
	
	if commander:
		if (commander.global_position - global_position).length() > despawn_distance:
			queue_free()
			return
		
		var player_mult: float = 1.0
		if Input.is_action_pressed("mouse_left"):
			player_mult = 12.0
		velocity += (commander.global_position - global_position) * player_follow * player_mult * delta
		velocity += commander.velocity * player_alignment * player_mult * delta
	
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	
	%Sprite2D.rotation = Vector2(1,0).angle_to(velocity.normalized())
	%AnimationPlayer.speed_scale = velocity.length() / max_speed * 3.0
	
	move_and_slide()

func _item_found(area: Area2D) -> void:
	if not area is Algae:
		return
	area.collect(self)

func _on_fish_entered(body: PhysicsBody2D) -> void:
	if not body is BoidFish:
		return
	fish_sighted.append(body)

func _on_fish_exited(body: PhysicsBody2D) -> void:
	if not body is BoidFish:
		return
	fish_sighted.remove_at(fish_sighted.find(body))
