extends Node2D
onready var sprite = $Sprite
export var player = 0
onready var tween = $Tween

var coin

var can_move = true

var sprites = [preload("res://assets/pieceYellow_border00.png"), preload("res://assets/pieceRed_border01.png"), preload("res://assets/piecePurple_border01.png"),preload("res://assets/pieceBlack_border01.png")]

var space_num = 0
var direction = Vector2.RIGHT
var speed = 2
var tilesize = 64
signal movedone


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = sprites[player]
	position.x = 32
	position.y = 64
	
func move(spaces):
	get_node("..").enableCoin()
	for n in spaces:
		if GameState.currentPlayer.can_move == true:
			movespace()
			yield(tween, "tween_completed")
			GameState.update_space_label(n)
	emit_signal("movedone")
	
	
func movespace():
	match space_num:
		0: direction = Vector2.RIGHT
		7: 
			can_move = false
			get_node("..").disableDiceBtn()
			get_node("..").flipButton.visible = true
		14: direction = Vector2.DOWN
		15:
			can_move = false
			get_node("..").disableDiceBtn()
			get_node("..").flipButton.visible = true
		20: direction = Vector2.LEFT
		29:
			can_move = false
			get_node("..").disableDiceBtn()
			get_node("..").flipButton.visible = true
		33: direction = Vector2.UP
		37: direction = Vector2.RIGHT
		42:
			can_move = false
			get_node("..").disableDiceBtn()
			get_node("..").flipButton.visible = true
		48: direction = Vector2.DOWN
		50: direction = Vector2.LEFT
		51:
			can_move = false
			get_node("..").disableDiceBtn()
	space_num = (space_num + 1)
	tween.interpolate_property(self, "position", position,
		position + direction * tilesize, 1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()




func _on_CoinFlipBtn_pressed():
	coin = randi() % 2
	if coin == 0:
		GameState.currentPlayer.can_move = true
		GameState.currentPlayer.move(1)
		get_node("..").disableCoin()
		get_node("..").invisibleDice()
		get_node("..").visibleEnd()
	if coin == 1:
		get_node("..").disableCoin()
		get_node("..").invisibleDice()
		get_node("..").visibleEnd()
	emit_signal("movedone")
func getNum():
	return space_num
