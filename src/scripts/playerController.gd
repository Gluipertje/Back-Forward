extends KinematicBody2D

var _velocity = Vector2()
var _collider
var health
var _canMove = true
var prevLabel = 10
var doMove = true
var sizex

export var friction = 0.1
export var speed = 500
export var cutOff = 10
export var maxHealth = 100

onready var goScreen = get_node("CanvasLayer/Control/GameOver")
onready var healthBar = get_node("CanvasLayer/Control/ColorRect3/ColorRect4")
onready var sfx2I = preload("res://src/oth/sfx/whoosh1sfx.tscn")

func _ready() -> void:
	health = maxHealth
	sizex = healthBar.rect_size.x
	Global.isWon = false

func _process(delta: float) -> void:
	if health < 1 && !Global.isWon:
		goScreen.set_visible(true)
		_canMove = false
		Global.isDead = true
	if Input.is_action_just_pressed("dash") && doMove:
		_velocity = Vector2(1, 0).rotated(get_rotation()) * speed
		var sfx2 = sfx2I.instance()
		sfx2.set_position(get_position())
		sfx2.set_pitch_scale(1.3)
		sfx2.set_volume_db(-5)
		get_tree().get_root().add_child(sfx2)
	elif _velocity < Vector2(cutOff,cutOff) && _velocity > Vector2(-cutOff,-cutOff) && doMove:
		_velocity = Vector2(0,0)
	else:
		_velocity = lerp(_velocity, Vector2(0,0), friction)
	if _canMove && doMove:
		move_and_slide(_velocity)
		look_at(get_global_mouse_position())
	get_node("CanvasLayer/Control/ColorRect2/Label").set_text("Score: " + str(Global.score))
	healthBar.set_size(Vector2(sizex * health / maxHealth, 28))
	
