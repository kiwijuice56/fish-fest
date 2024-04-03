class_name Main
extends Node

func player_death() -> void:
	var replaced: bool = false
	for boid in get_tree().get_nodes_in_group("children"):
		if is_instance_valid(boid):
			Ref.player.global_position = boid.global_position
			Ref.player.velocity = boid.velocity
			boid.queue_free()
			replaced = true
			break
	if not replaced:
		$GameOver.gameover()

func _ready() -> void:
	Stats.reset()
	Ref.refresh()
	if not Stats.first_game:
		get_tree().paused = false
