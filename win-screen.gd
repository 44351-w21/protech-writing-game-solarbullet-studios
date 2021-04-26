extends Node2D

onready var winLabel = $ColorRect/Label

func _ready():
	var curPlayer = GameState.currentPlayer
	winLabel.text =  "You win! Congratulations!"
	$Music.play()



func _on_mainMenu_pressed():
	get_tree().change_scene("res://title-screen.tscn")


func _on_Restart_pressed():
	get_tree().change_scene("res://Game.tscn")
