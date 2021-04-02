extends Node

var currentPlayer
var currentPlayerLabel
var game = null

func _ready():
	var root = get_tree().get_root()
	game = root.get_child(root.get_child_count()-1)

func update_space_label(space_num):
	game.update_space_label(space_num)
