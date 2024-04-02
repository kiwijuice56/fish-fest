extends Node

signal energy_changed

var energy: int:
	set(val):
		energy = val
		energy_changed.emit()
