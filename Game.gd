extends Node2D

onready var p1 = $Player
onready var p2 = $Player2
onready var p3 = $Player3
onready var p4 = $Player4
onready var win = $HUD/WinBackground
onready var HighTide = $HUD/HighCard
onready var LowTide = $HUD/LowCard
onready var HighLabel = $HUD/HighCard/HighLabel
onready var LowLabel = $HUD/LowCard/LowLabel
onready var player_label = $HUD/Hbox/PlayerLabel
onready var space_label = $HUD/Hbox/SpaceLabel
onready var diceButton= $HUD/Hbox/DiceButton
onready var endButton = $HUD/Hbox/EndButton
onready var flipButton = $HUD/CoinFlipBtn
onready var turnScreen = $HUD/TurnScreen
onready var switchLabel = $HUD/TurnScreen/Label
onready var switchButton = $HUD/TurnScreen/Label/SwitchTurnButton

var next_player = ['', 'Player2', 'Player3', 'Player4', 'Player']
var activePlayerIndex = 1
var dice = 0

func _ready():
	randomize()
	GameState.currentPlayer = p1
	GameState.currentPlayerLabel = "Player 1"
	flipButton.visible = false
	switchLabel.visible = false
	invisibleTide()
	update_label()
	HighTide.visible = false
	LowTide.visible = false
	turnScreen.visible = false
	# $BlackmoorSong.play()
	

func _on_DiceButton_pressed():
	dice = randi() % 6
	diceButton.disabled = true
	$HUD/Hbox/Dice.frame = dice
	$HUD/Hbox/DiceNoise.play()
	$DiceTimer.start()

func update_label():
	player_label.text = GameState.currentPlayerLabel

func update_space_label(space):
	space_label.text="Space: " + str(space)

func _on_EndButton_pressed():
	#Bring up HUD TurnSwitch screen
	LowLabel.visible = false
	HighLabel.visible = false
	HighTide.visible = false
	LowTide.visible = false
	switchLabel.visible = true
	switchButton.visible = true
	turnScreen.visible = true


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
	enableCoin()
	switchButton.visible = false
	switchLabel.visible = false
	turnScreen.visible = false
	if GameState.currentPlayer.can_move == true:
		flipButton.visible = false
		visibleDice()
		invisibleEnd()
	elif GameState.currentPlayer.can_move == false:
		flipButton.visible = true
		invisibleDice()
		invisibleEnd()
		
	
func disableDiceBtn():
	diceButton.disabled = true
func enableDiceBtn():
	diceButton.disabled = false
func enableEnd():
	endButton.disabled = false
func disableEnd():
	endButton.disabled = true
func enableCoin():
	$HUD/CoinFlipBtn.disabled = false
func disableCoin():
	$HUD/CoinFlipBtn.disabled = true
func visibleDice():
	diceButton.visible = true
func invisibleDice():
	diceButton.visible = false
func visibleEnd():
	endButton.visible = true
func invisibleEnd():
	endButton.visible = false
func invisibleTide():
	$HUD/TideBtn.visible = false
func visibleTide():
	$HUD/TideBtn.visible = true


func _on_DiceTimer_timeout():
	GameState.currentPlayer.move(dice + 1)
	yield(GameState.currentPlayer, "movedone")
	diceButton.visible = false
	endButton.visible = true
