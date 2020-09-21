extends RigidBody2D

onready var explosionI = preload("res://src/prefabs/powerUps/explosion1.tscn")

func _ready() -> void:
	yield(get_tree().create_timer(1), "timeout")
	boom()

func boom():
	var explosion = explosionI.instance()
	explosion.set_position(get_global_position())
	get_tree().get_root().add_child(explosion)
	queue_free()
