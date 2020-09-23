extends Area2D

var player
var hasMG
var hasGrenade
var isReverse = false
var hasGloves

export var poType = []
signal reverseLevel
onready var LabelI = preload("res://src/prefabs/Label.tscn")
onready var SpriteI = preload("res://src/prefabs/Sprite.tscn")
onready var wFI = preload("res://src/prefabs/UI/whiteFlash.tscn")
onready var enemyI = preload("res://src/prefabs/enemy.tscn")

func _ready() -> void:
	connect("reverseLevel", get_parent().get_node("startPoint"), "levelReverse")
	poType.clear()
	for N in get_parent().get_children():
		if N.is_in_group("add") && N.is_in_group("turret"):
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
	if !isReverse:
		var wF = wFI.instance()
		player.get_node("CanvasLayer/Control").add_child(wF)
		isReverse = true
		Global.isReverse = true
		yield(get_tree().create_timer(0.8), "timeout")
		player.get_node("CanvasLayer/Control/ColorRect").show()
		emit_signal("reverseLevel")
		
		for P in poType:
			if P == "machineGun":
				hasMG = true
				displayNEffect("Turrets Activated!", "res://assets/sprites/UI/poTurret1n.png",1)
			elif P == "speed2x":
				get_parent().get_node("player").speed = get_parent().get_node("player").speed / 3
				displayNEffect("Lost Speed!", "res://assets/sprites/UI/poSpeed1n.png",1)
			elif P == "grenadeHand":
				hasGrenade = true
				displayNEffect("GLs Activated!", "res://assets/sprites/UI/poGrenade1n.png",0.7)
			elif P == "boxingGloves":
				hasGloves = true
				displayNEffect("More Enemies!", "res://assets/sprites/UI/poBoxing1n.png",0.7)
		
		for N in get_parent().get_children():
			if N.is_in_group("delete"):
				N.clear()
			elif N.is_in_group("add"):
				if N.is_in_group("turret") && hasMG:
					N.shouldShoot = true
					print(N.get_name())
				if N.is_in_group("GL") && hasGrenade:
					N.shouldShoot = true
					print(N.get_name())
				if N.is_in_group("melee") && hasGloves:
					var enemy = enemyI.instance()
					enemy.set_position(N.get_position())
					N.get_parent().add_child(enemy)
				if N.is_in_group("world"):
					N.show()
					N.set_collision_layer_bit(3,4)
			else:
				pass
		

func displayNEffect(text, Texturea, scale):
	var Labela = LabelI.instance()
	Labela.set_position(Vector2(player.prevLabel + 32, 32))
	player.prevLabel += 120
	Labela.get_node("Label").set_text(text)
	Labela.get_node("Sprite").set_texture(load(Texturea))
	Labela.get_node("Sprite").set_scale(Vector2(scale,scale))
	player.get_node("CanvasLayer/Control/Control").add_child(Labela)
