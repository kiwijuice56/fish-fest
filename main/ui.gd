class_name UI
extends CanvasLayer

func _ready() -> void:
	Stats.energy_changed.connect(_on_energy_changed)

func _on_energy_changed() -> void:
	%EnergyLabel.text = "energy: " + str(Stats.energy)
