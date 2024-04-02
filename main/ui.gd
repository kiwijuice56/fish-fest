class_name UI
extends CanvasLayer

func _ready() -> void:
	Stats.energy_changed.connect(_on_energy_changed)

func _on_energy_changed() -> void:
	%EnergyLabel.text = "energy: " + str(Stats.energy)

func gameover() -> void:
	%GameOver.visible = true
	await get_tree().create_timer(2.0).timeout
	var tween: Tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(%GameOver/RichTextLabel, "modulate:a", 1.0, 4.0)
