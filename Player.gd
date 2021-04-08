extends Node2D
onready var sprite = $Sprite
export var player = 0;
onready var tween = $Tween

var sprites = [preload("res://assets/pieceYellow_border01.png"), preload("res://assets/pieceRed_border01.png"), preload("res://assets/piecePurple_border01.png"),preload("res://assets/pieceBlack_border01.png")]

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
	for n in spaces:
		movespace()
		yield(tween, "tween_completed")
		GameState.update_space_label(space_num)
	emit_signal("movedone")

func movespace():
	match space_num:
		0: direction = Vector2.RIGHT
		14: direction = Vector2.DOWN
		20: direction = Vector2.LEFT
		33: direction = Vector2.UP
		37: direction = Vector2.RIGHT
		48: direction = Vector2.DOWN
		50: direction = Vector2.LEFT
	space_num = (space_num + 1)
	tween.interpolate_property(self, "position", position,
		position + direction * tilesize, 1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
