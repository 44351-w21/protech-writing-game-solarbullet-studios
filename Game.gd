extends Node2D

var dice = 0

func _ready():
	randomize()

func _on_DiceButton_pressed():
	dice = randi() % 6
	$Dice.frame = dice
	$DiceNoise.play()
