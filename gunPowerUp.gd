extends Node


var firing : bool = false
var countDown : float = 1

func _ready():
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		firing = true

func _physics_process(delta: float) -> void:
	if firing:
		countDown -= delta
	if countDown <= 0:
		fireLaser()

func fireLaser():
	return

