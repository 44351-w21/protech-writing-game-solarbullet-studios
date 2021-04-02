extends Node2D

onready var p1 = $Player
onready var p2 = $Player2
onready var p3 = $Player3
onready var p4 = $Player4

onready var player_label = $HUD/PlayerLabel
onready var space_label = $HUD/SpaceLabel
onready var diceButton= $DiceButton
onready var endButton = $HUD/EndButton

var next_player = ['', 'Player2', 'Player3', 'Player4', 'Player']
var activePlayerIndex = 1

var dice = 0
var GameState = load("res://GameState.gd").new()

func _ready():
	randomize()

func _on_DiceButton_pressed():
	dice = randi() % 6
	$Dice.frame = dice
	$DiceNoise.play()
#	yield(GameState.currentPlayer, "movedone")
#	diceButton.visible = false
#	endButton.visible = true

func update_label():
	player_label.text = GameState.currentPlayerLabel

func update_space_label(space):
	space_label.text=str(space)

func _on_EndButton_pressed():
	$HUD/TurnSwitch/Label.text = next_player[activePlayerIndex] + "'s Turn"
	#Bring up HUD TurnSwitch screen
	$HUD/TurnSwitch.visible = true


func _on_SwitchTurnButton_pressed():
	GameState.currentPlayerLabel = next_player[activePlayerIndex]
	match activePlayerIndex:
		1:
			GameState.currentPlayer = p2
			activePlayerIndex = 2
		2:
			GameState.currentPlayer = p3
			activePlayerIndex = 3
		3:
			GameState.currentPlayer = p4
			activePlayerIndex = 4
		4: 
			GameState.currentPlayer = p1
			activePlayerIndex = 1
	update_space_label(GameState.currentPlayer.space)
	update_label()
