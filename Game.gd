extends Node2D

onready var p1 = $Player
onready var p2 = $Player2
onready var p3 = $Player3
onready var p4 = $Player4

onready var player_label = $HUD/Hbox/PlayerLabel
onready var space_label = $HUD/Hbox/SpaceLabel
onready var diceButton= $HUD/Hbox/DiceButton
onready var endButton = $HUD/Hbox/EndButton
onready var flipButton = $HUD/CoinBox/CoinFlipBtn
onready var switchLabel = $HUD/TurnScreen/BoxLayout/Label
onready var switchButton = $HUD/TurnScreen/BoxLayout/Label/SwitchTurnButton
onready var winLabel = $HUD/WinScreen

var next_player = ['', 'Player2', 'Player3', 'Player4', 'Player']
var activePlayerIndex = 1
var dice = 0

func _ready():
	randomize()
	GameState.currentPlayer = p1
	GameState.currentPlayerLabel = "Player 1"
	switchLabel.visible = false
	winLabel.visible = false
	flipButton.visible = false
	update_label()

func _on_DiceButton_pressed():
	dice = randi() % 6
	diceButton.disabled = true
	$HUD/Hbox/Dice.frame = dice
	$HUD/Hbox/DiceNoise.play()
	GameState.currentPlayer.move(dice + 1)
	yield(GameState.currentPlayer, "movedone")
	diceButton.visible = false
	endButton.visible = true

func update_label():
	player_label.text = GameState.currentPlayerLabel

func update_space_label(space):
	space_label.text="Space: " + str(space)

func _on_EndButton_pressed():
	#Bring up HUD TurnSwitch screen
	switchLabel.visible = true
	switchButton.visible = true


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
	
func disableDiceBtn():
	diceButton.disabled = true
func enableDiceBtn():
	diceButton.disabled = false
func enableEnd():
	endButton.disabled = false
func disableEnd():
	endButton.disabled = true
func enableCoin():
	$HUD/CoinBox/CoinFlipBtn.disabled = false
func disableCoin():
	$HUD/CoinBox/CoinFlipBtn.disabled = true
func visibleDice():
	diceButton.visible = true
func invisibleDice():
	diceButton.visible = false
func visibleEnd():
	endButton.visible = true
func invisibleEnd():
	endButton.visible = false
