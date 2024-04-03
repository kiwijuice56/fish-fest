extends Node2D

var flip: bool = false

func _ready() -> void:
	%Timer2.timeout.connect(flail)

func flail() -> void:
	flip = not flip

func _physics_process(delta: float) -> void:
	$Tentacle/Joints/Joint1.apply_torque((-1 if flip else 1) * 4000)
	#$Tentacle/Joints/Joint2.apply_torque((1 if flip else -1) * 2024)
	#$Tentacle/Joints/Joint4.apply_torque((1 if flip else -1) * 1600)
	#$Tentacle/Joints/Joint3.apply_torque((1 if not flip else -1) * 1000)
	#$Tentacle/Joints/Joint5.apply_torque((1 if flip else -1) * 800)
	#$Tentacle/Joints/Joint6.apply_torque((1 if not flip else -1) * 500)
