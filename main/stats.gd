extends Node

signal energy_changed
signal fish_changed
signal eggs_changed(old, new)

var first_game: bool = true
var energy: int:
	set(val):
		energy = val
		if energy >= 40:
			energy -= 40
			self.eggs += 1
		energy_changed.emit()
var fish: int:
	set(val):
		fish = val
		fish_changed.emit()
var eggs: int:
	set(val):
		var old: int = eggs
		eggs = val
		eggs_changed.emit(old, eggs)

func reset() -> void:
	energy = 0
	fish = 1
	eggs = 0
