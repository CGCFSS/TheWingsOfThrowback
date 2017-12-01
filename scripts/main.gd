extends Node2D

var gameRuning = false
var fail = false
var distance = 0.0
var score = 0
var level = 3
var plane

func _ready():
	set_fixed_process(true)
	get_node("timer").start()
	get_node("cloudsTimer").start()
	get_node("ammoTimer").start()
	
	plane = get_node('plane')

	pass
	
func _fixed_process(delta):
	if(gameRuning):
		
		distance = distance + 0.01
		check_level()
		get_node('distance').set_text(str(round(distance)) + ' km')
		
	if Input.is_action_pressed("ui_select"):
		if(fail):
			get_tree().reload_current_scene()
		elif(!gameRuning):
			gameRuning = true
			get_node('start').hide()
			get_node('title').hide()
			get_node('help').hide()
			get_node('distance').show()
			get_node('score').show()
			get_node('ammo').show()
			get_node('player').play()
	pass

func stopGame():
	get_node('player').stop()
	gameRuning = false
	fail = true
	get_node('arrow').hide()
	get_node('overTimer').hide()
	get_node('title').set_text('The End')
	get_node('title').show()
	get_node('start').set_text('Press Space to Reload!')
	get_node('start').show()
	
	pass
	
func addScore(newScore):
	score = score + newScore
	get_node('score').set_text('Score: '+ str(score))
	
	pass

func check_level():
	#change fonts!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	if distance >= 10 and distance < 25:
		if(level != 2):
			level = 2
			plane.get_node('sprite').set_texture(load('res://assets/planes/plane2_1.png'))
			plane.lerpSpeed = .1
			plane.maxSpeed = 500
			plane.get_node('sprite').set_vframes(1)
			plane.acc = 30
			plane.ammo = 15
			plane.blink()
		
	elif distance >= 25 and distance < 55:
		if(level != 3):
			level = 3
			plane.get_node('sprite').set_texture(load('res://assets/planes/plane3_1.png'))
			plane.get_node('sprite').set_vframes(6)
			plane.get_node('animation').play('fly6')
			plane.lerpSpeed = .03
			plane.maxSpeed = 400
			plane.acc = 20
			plane.ammo = 50
			plane.blink()
	elif distance >= 55 and distance < 100:
		if(level != 4):
			level = 4
			plane.get_node('sprite').set_texture(load('res://assets/planes/plane1.png'))
			plane.get_node('sprite').set_vframes(8)
			plane.get_node('animation').play('fly')
			plane.lerpSpeed = .03
			plane.maxSpeed  = 350
			plane.acc = 15
			plane.ammo = 50
			plane.blink()
	pass