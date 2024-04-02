class_name PlayerFish
extends Fish

@export var egg_scene: PackedScene
@export var max_speed: float = 128.0
@export var max_radius: float = 128.0

var locked: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_right", false) and Stats.energy >= 50:
		Stats.energy -= 50
		spawn_egg()
	if event.is_action_pressed("ui_cancel"):
		locked = not locked

func _physics_process(delta: float) -> void:
	var dir: Vector2 = get_global_mouse_position() - global_position
	var speed: float = min(max_radius, dir.length()) / max_radius * max_speed
	dir = dir.normalized()
	
	velocity = dir * speed
	
	%Sprite2D.rotation = Vector2(1, 0).angle_to(dir)
	%AnimationPlayer.speed_scale = speed / max_speed * 3.0
	%WindPlayer.volume_db = -80 + speed / max_speed * 48
	
	if not locked:
		move_and_slide()

func _item_found(area: Area2D) -> void:
	if not area is Algae:
		return
	area.collect(self)

func spawn_egg() -> void:
	%PlopPlayer.playing = true
	var new_egg: Egg = egg_scene.instantiate()
	get_parent().add_child(new_egg)
	get_parent().move_child(new_egg, 0)
	new_egg.global_position = global_position
