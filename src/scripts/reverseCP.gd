extends Area2D

var player
var hasMG
var isReverse = false

export var poType = []
signal reverseLevel
onready var LabelI = preload("res://src/prefabs/Label.tscn")
onready var SpriteI = preload("res://src/prefabs/Sprite.tscn")

func _ready() -> void:
	connect("reverseLevel", get_parent().get_node("startPoint"), "levelReverse")
	for N in get_parent().get_children():
		if N.is_in_group("add") && N.is_in_group("turret"):
			N.show()
			N.shouldShoot = false
		else:
			pass

func _on_reverseCP_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player = body
		$Sprite.set_visible(false)
		$Sprite2.set_visible(true)
		if !isReverse:
			reverseLevel()

func reverseLevel():
	player.get_node("CanvasLayer/Control/ColorRect").show()
	isReverse = true
	emit_signal("reverseLevel")
	
	for P in poType:
		if P == "machineGun":
			hasMG = true
			displayNEffect("Turrets Activated!", "res://assets/sprites/UI/poTurret1n.png")
		elif P == "speed2x":
			displayNEffect("Lost Speed!", "res://assets/sprites/UI/poSpeed1n.png")
	
	for N in get_parent().get_children():
		if N.is_in_group("delete"):
			N.clear()
		elif N.is_in_group("add"):
			N.show()
			if N.is_in_group("turret") && hasMG:
				N.shouldShoot = true
		else:
			pass

func displayNEffect(text, Texturea):
	var Labela = LabelI.instance()
	Labela.set_position(Vector2(player.prevLabel + 32, 48))
	player.prevLabel += 120
	Labela.get_node("Label").set_text(text)
	Labela.get_node("Sprite").set_texture(load(Texturea))
	player.get_node("CanvasLayer/Control/Control").add_child(Labela)
