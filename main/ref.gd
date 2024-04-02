extends Node

@onready var player: PlayerFish = get_tree().get_root().get_node("Main/PlayerFish")
@onready var main: Main = get_tree().get_root().get_node("Main")

func refresh() -> void:
	player =  get_tree().get_root().get_node("Main/PlayerFish")
	main = get_tree().get_root().get_node("Main")
