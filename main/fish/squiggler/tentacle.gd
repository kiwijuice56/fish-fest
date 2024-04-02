class_name Tentacle
extends Node2D

@export var controller: NodePath
@onready var joints: Node2D = $Joints
@onready var line: Line2D = $Line2D

func _ready() -> void:
	$PinJoint2D.node_a = "../../../"

func _physics_process(delta: float) -> void:
	for i in range(joints.get_child_count()):
		line.points[i + 1] = joints.get_child(i).position
