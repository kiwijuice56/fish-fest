extends Node

signal energy_changed
signal fish_changed


var first_game: bool = true
var energy: int:
	set(val):
		energy = val
		energy_changed.emit()
var fish: int:
	set(val):
		fish = val
		fish_changed.emit()

func reset() -> void:
	energy = 50
	fish = 1
