extends Node2D

onready var p1 = $Player
onready var p2 = $Player2
onready var p3 = $Player3
onready var p4 = $Player4

onready var player_label = $HUD/HBox/Label
onready var space_label = $HUD/HBox/SpaceLabel
onready var diceButton= $HUD/HBox/DiceButton
onready var endButton = $HUD/HBox/EndButton

var next_player = ['', 'Player2', 'Player3', 'Player4', 'Player']
var activePlayerIndex = 1

var dice = 0

func _ready():
	randomize()
	GameState.currentPlayer = p1
	GameState.currentPlayerLabel = "Player 1"
	$HUD/TurnScreen/BoxLayout/Label.visible = false
	update_label()

func _on_DiceButton_pressed():
	dice = randi() % 6
	diceButton.disabled = true
	$HUD/Dice.frame = dice
	$HUD/Dice/DiceNoise.play()
	GameState.currentPlayer.move(dice + 1)
	yield(GameState.currentPlayer, "movedone")
	diceButton.visible = false
	endButton.visible = true

func update_label():
	player_label.text = GameState.currentPlayerLabel

func update_space_label(space):
	space_label.text=str(space)

func _on_EndButton_pressed():
	#Bring up HUD TurnSwitch screen
	$HUD/TurnScreen/BoxLayout/Label.visible = true
	$HUD/TurnScreen/BoxLayout/Label/SwitchTurnButton.visible = true


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
	update_space_label(GameState.currentPlayer.space_num)
	update_label()
	
	endButton.visible = false
	diceButton.visible = true
	diceButton.disabled = false
	$HUD/TurnScreen/BoxLayout/Label/SwitchTurnButton.visible = false
	$HUD/TurnScreen/BoxLayout/Label.visible = false
