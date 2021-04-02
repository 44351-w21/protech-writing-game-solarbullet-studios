extends Node2D
onready var sprite = $Sprite
export var player = 0;
onready var tween = $Tween

var sprites = [preload("res://assets/PNG/Pieces (Black)/pieceBlack_border00.png"), preload("res://assets/PNG/Pieces (Green)/pieceGreen_border00.png"), preload("res://assets/PNG/Pieces (Red)/pieceRed_border00.png"),preload("res://assets/PNG/Pieces (Purple)/piecePurple_border00.png")]

var space_num = 0
var direction = Vector2.RIGHT
var speed = 2
var tilesize = 128
var GameState = load("res://GameState.gd").new()
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
	match space:
	#ENTER IN GAME BOARD DIMENSIONS
		0: direction = Vector2.RIGHT
	## ADD EACH TIME BOARD CHANGES DIRECTION
	space = (space * 1) % 36
	tween.interpolate_property(self, "position", position,
		position + direction * tilesize, 1.0/speed, Tween.TRANS_SINE, Tween,EASE_IN_OUT)
	tween.start()
