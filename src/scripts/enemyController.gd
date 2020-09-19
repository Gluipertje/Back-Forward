extends KinematicBody2D

var _collider
var _canAttack = true
var _velocity
var _playerDis

onready var player = get_parent().get_node("player")
var timer = Timer.new()

export var speed = 200
export var attackDamage = 10

func _ready() -> void:
	timer.set_wait_time(1.0)
	timer.connect("timeout", self, "timeout")
	add_child(timer)

func _process(delta: float) -> void:
	_playerDis = get_position().distance_to(player.get_position())
	Engine.set_time_scale(1)
	if _playerDis < 250:	
		Engine.set_time_scale((_playerDis/250))
	if _playerDis <= 80 && _canAttack:
		player.health -= attackDamage
		_canAttack = false
		timer.start()
	_velocity = to_local(player.get_position()).normalized() * speed
	if _playerDis > 80:
		move_and_slide(_velocity)
	$Sprite.look_at(player.get_position())

func timeout():
	_canAttack = true
