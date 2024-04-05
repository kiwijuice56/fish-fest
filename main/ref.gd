extends Node

@onready var player: PlayerFish = get_tree().get_root().get_node("Main/PlayerFish")
@onready var main: Main = get_tree().get_root().get_node("Main")

var algae_pool: Array[Algae]
var algae_idx: int = 0
var noise: FastNoiseLite

func refresh() -> void:
	player =  get_tree().get_root().get_node("Main/PlayerFish")
	main = get_tree().get_root().get_node("Main")
	noise = FastNoiseLite.new()

func make_algae() -> void:
	for i in range(512):
		var algae: Algae = preload("res://main/item/algae/algae.tscn").instantiate()
		algae_pool[i] = algae

