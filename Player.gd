extends Node2D
onready var sprite = $Sprite
export var player = 0;
onready var tween = $Tween

var sprites = [preload("res://assets/PNG/Pieces (Black)/pieceBlack_border00.png"), preload("res://assets/PNG/Pieces (Green)/pieceGreen_border00.png"), preload("res://assets/PNG/Pieces (Red)/pieceRed_border00.png"),preload("res://assets/PNG/Pieces (Purple)/piecePurple_border00.png")]

signal movedone


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = sprites[player]
	position.x = 32
	position.y = 64
