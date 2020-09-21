extends KinematicBody2D

var _velocity = Vector2()
var _collider
var health
var _canMove = true
var prevLabel = 10

export var friction = 0.1
export var speed = 500
export var cutOff = 10
export var maxHealth = 100

onready var goScreen = get_node("CanvasLayer/Control/GameOver")

func _ready() -> void:
	health = maxHealth

func _process(delta: float) -> void:
	if health < 1:
		goScreen.set_visible(true)
		_canMove = false
	if Input.is_action_just_pressed("dash"):
		_velocity = Vector2(1, 0).rotated(get_rotation()) * speed
	elif _velocity < Vector2(cutOff,cutOff) && _velocity > Vector2(-cutOff,-cutOff):
		_velocity = Vector2(0,0)
	else:
		_velocity = lerp(_velocity, Vector2(0,0), friction)
	if _canMove:
		move_and_slide(_velocity)
		look_at(get_global_mouse_position())
	
