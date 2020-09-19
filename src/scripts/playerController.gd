extends KinematicBody2D

var _velocity = Vector2()
var _collider
var health

export var friction = 0.1
export var speed = 500
export var cutOff = 10
export var maxHealth = 100

func _ready() -> void:
	health = maxHealth

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if health < 1:
		print("oof")
	print(health)
	if Input.is_action_just_pressed("dash"):
		_velocity = Vector2(1, 0).rotated(get_rotation()) * speed
	elif _velocity < Vector2(cutOff,cutOff) && _velocity > Vector2(-cutOff,-cutOff):
		_velocity = Vector2(0,0)
	else:
		_velocity = lerp(_velocity, Vector2(0,0), friction)
	move_and_slide(_velocity)
	
