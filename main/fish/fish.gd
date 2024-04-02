class_name Fish
extends CharacterBody2D

func _ready() -> void:
	%CollectionArea.area_entered.connect(_item_found)

func _item_found(area: Area2D) -> void:
	if area is Item:
		area.collect(self)
