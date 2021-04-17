extends Node2D
onready var sprite = $Sprite
export var player = 0
onready var tween = $Tween

var coin
var tide
var positive


export var can_move = true
export var can_move2 = true

var sprites = [preload("res://assets/pieceYellow_border00.png"), preload("res://assets/pieceRed_border01.png"), preload("res://assets/piecePurple_border01.png"),preload("res://assets/pieceBlack_border01.png")]

var space_num = 0
var direction = Vector2.RIGHT
var speed = 2
var tilesize = 64
signal movedone


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.texture = sprites[player]
	position.x = 32
	position.y = 64
	
func move(spaces):
	get_node("..").enableCoin()
	for n in spaces:
		if GameState.currentPlayer.can_move == true and GameState.currentPlayer.can_move2 == true:
			movespace()
			yield(tween, "tween_completed")
			GameState.update_space_label(n)
	emit_signal("movedone")
	
	
func movespace():
	match space_num:
		0: direction = Vector2.RIGHT
		7: 
			can_move = false
			get_node("..").disableDiceBtn()
			get_node("..").flipButton.visible = true
		11:
			can_move2 = false
			get_node("..").disableDiceBtn()
			get_node("..").visibleTide()
			
		14: direction = Vector2.DOWN
		15:
			can_move = false
			get_node("..").disableDiceBtn()
			get_node("..").flipButton.visible = true
		19: 
			can_move2 = false
			get_node("..").disableDiceBtn()
			get_node("..").visibleTide()
		20:direction = Vector2.LEFT
		29:
			can_move = false
			get_node("..").disableDiceBtn()
			get_node("..").flipButton.visible = true
		33: direction = Vector2.UP
		34:
			can_move2 = false
			get_node("..").disableDiceBtn()
			get_node("..").visibleTide()
		37: direction = Vector2.RIGHT
		42:
			can_move = false
			get_node("..").disableDiceBtn()
			get_node("..").flipButton.visible = true
		48: direction = Vector2.DOWN
		50: direction = Vector2.LEFT
		51:
			can_move = false
			get_node("..").disableDiceBtn()
			get_node("..").invisibleEnd()
		57:
			get_tree().change_scene("res://win-screen.tscn")
		
	space_num = (space_num + 1)
	tween.interpolate_property(self, "position", position,
		position + direction * tilesize, 1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()






func getNum():
	return space_num


func _on_CoinFlipBtn_pressed():
	coin = randi() % 2
	if coin == 0:
		GameState.currentPlayer.can_move = true
		GameState.currentPlayer.move(1)
		get_node("..").disableCoin()
		get_node("..").invisibleDice()
		get_node("..").visibleEnd()
	if coin == 1:
		get_node("..").disableCoin()
		get_node("..").invisibleDice()
		get_node("..").visibleEnd()
	emit_signal("movedone")



func _on_TideBtn_pressed():
	tide = randi() % 2
	get_node("..").invisibleTide()
	get_node("..").invisibleDice()
	get_node("..").visibleEnd()
	if tide == 0:
		positive = randi() % 3
		get_node("..").HighTide.visible = true
		get_node("..").HighLabel.text = "Move Forward " + str(positive +1)
		get_node("..").HighLabel.visible = true
		timer()
		GameState.currentPlayer.can_move2 = true
		GameState.currentPlayer.move(positive + 1)
	elif tide == 1:
		GameState.currentPlayer.can_move2 = true
		if(space_num == 12):
			timer()
			get_node("..").LowTide.visible = true
			get_node("..").LowLabel.text = str("Move back 1")
			get_node("..").LowLabel.visible = true
			direction = Vector2.LEFT
			GameState.currentPlayer.move(1)
			direction = Vector2.RIGHT
			space_num = (space_num - 2)
		elif(space_num == 20):
			timer()
			get_node("..").LowTide.visible = true
			get_node("..").LowLabel.text = str("Move back 1")
			get_node("..").LowLabel.visible = true
			direction = Vector2.UP
			GameState.currentPlayer.move(1)
			direction = Vector2.LEFT
			space_num = (space_num - 2)
		elif(space_num == 35):
			timer()
			get_node("..").LowTide.visible = true
			get_node("..").LowLabel.text = str("Move back 1")
			get_node("..").LowLabel.visible = true
			direction = Vector2.DOWN
			GameState.currentPlayer.move(1)
			direction = Vector2.UP
			space_num = (space_num - 2)
		else:
			timer()
			get_node("..").LowTide.visible = true
			get_node("..").LowLabel.text = str("Do Not Move")
			get_node("..").LowLabel.visible = true
	emit_signal("movedone")
	
func timer():
	var t = Timer.new()
	t.set_wait_time(4)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
