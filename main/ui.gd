class_name UI
extends CanvasLayer

func _ready() -> void:
	Stats.energy_changed.connect(_on_energy_changed)
	Stats.fish_changed.connect(_on_fish_changed)
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

func _on_fish_changed() -> void:
	pass

func set_shader_value(value: float):
	%Boggle.material.set_shader_parameter("fV", min(1.0, value))

func _on_energy_changed() -> void:
	var old_eggs: int = int(%EnergyLabel.text)
	var new_eggs: int = int(Stats.energy / 50)
	if new_eggs > old_eggs:
		$AudioStreamPlayer.playing = true
	%EnergyLabel.text = str(new_eggs)
	var new_fv: float = (Stats.energy % 50) / 50.0
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_BOUNCE)
	tween.tween_method(set_shader_value, %Boggle.material.get_shader_parameter("fV"), new_fv, 0.2)

func gameover() -> void:
	%GameOver.visible = true
	await get_tree().create_timer(2.0).timeout
	var tween: Tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(%GameOver/RichTextLabel, "modulate:a", 1.0, 4.0)
