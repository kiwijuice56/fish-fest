class_name Main
extends Node

func gameover() -> void:
	$GameOver.gameover()

func _ready() -> void:
	Ref.refresh()
	get_tree().paused = false
