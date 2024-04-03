class_name UI
extends CanvasLayer

var egg_big_scene: PackedScene = preload("res://main/ui/egg_big.tscn")
var egg_small_scene: PackedScene = preload("res://main/ui/egg_small.tscn")

func _ready() -> void:
	Stats.energy_changed.connect(_on_energy_changed)
	Stats.eggs_changed.connect(_on_eggs_changed)
	
	# play tutorial stuff
	if Stats.first_game:
		get_tree().paused = true
		%Title/Label.visible = true
		%Title.visible = true
		await get_tree().create_timer(4.0).timeout
		$AnimationPlayer.play("title")
		get_tree().paused = false
		await $AnimationPlayer.animation_finished
		Stats.first_game = false
		await get_tree().create_timer(1.0).timeout
		$AnimationPlayer.play("tutorial")
	else:
		$AnimationPlayer.play("yeout")

func _on_eggs_changed(old: int, new: int) -> void:
	if new > old:
		$AudioStreamPlayer.playing = true
		add_egg()
	elif new < old:
		remove_egg()

func add_egg() -> void:
	var new_egg_big: Sprite2D = egg_big_scene.instantiate()
	add_child(new_egg_big)
	move_child(new_egg_big, 0)
	new_egg_big.position = Vector2(80, 105)
	
	var small_egg_position: Vector2 = Vector2(((Stats.eggs - 1) % 3) * 23, int((Stats.eggs - 1) / 3) * 23 + 63)
	var tween: Tween = get_tree().create_tween().set_parallel(true).set_ease(Tween.EASE_IN)
	tween.tween_property(new_egg_big, "global_position", $EggContainer.global_position + small_egg_position, 0.3)
	tween.tween_property(new_egg_big, "scale", Vector2(0.075, 0.075), 0.3)
	
	await tween.finished
	var new_egg_small: Sprite2D = egg_small_scene.instantiate()
	$EggContainer.add_child(new_egg_small)
	new_egg_small.position = small_egg_position
	
	new_egg_big.queue_free()

func remove_egg() -> void:
	$EggContainer.get_child(-1).queue_free()

func set_shader_value(value: float):
	%Boggle.material.set_shader_parameter("fV", min(1.0, value))

func _on_energy_changed() -> void:
	%EnergyLabel.text = str(int(Stats.energy / 50.0 * 100)) + "%"
	var new_fv: float = Stats.energy / 50.0
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE)
	tween.tween_method(set_shader_value, %Boggle.material.get_shader_parameter("fV"), new_fv, 0.2)

func gameover() -> void:
	%GameOver.visible = true
	await get_tree().create_timer(2.0).timeout
	var tween: Tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(%GameOver/RichTextLabel, "modulate:a", 1.0, 4.0)
