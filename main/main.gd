class_name Main
extends Node

func gameover() -> void:
	$GameOver.gameover()

func _ready() -> void:
	Stats.reset()
	Ref.refresh()
	get_tree().paused = false
