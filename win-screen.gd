extends Node2D

onready var winLabel = $ColorRect/Label

func _ready():
	var curPlayer = GameState.currentPlayer
	winLabel.text = str(curPlayer) + " wins! Congratulations!"
