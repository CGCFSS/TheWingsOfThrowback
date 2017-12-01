extends KinematicBody2D

var main
var maxSpeed = 600
var kinRotate = 0
var acc = 40
var kinSpeed = Vector2(0,0)
var padX
var padY
var fire = false
var upper = false
var lower = false
var overTimer = 10
var ammo = 10
var lerpSpeed = .5

func _ready():
	set_fixed_process(true)
	add_to_group('player')
	main = get_parent()
	main.get_node('ammo').set_text(str(ammo))
	pass
	
func _fixed_process(delta):
	if main.gameRuning:
		
		var posX = get_pos().x
		var posY = get_pos().y
		if(posX < 0 || posX > 1280 || posY < 0 || posY > 720):
			main.get_node('arrow').show()
			main.get_node('overTimer').show()
			main.get_node('overTimer').set_text(str(round(overTimer)))
			overTimer = overTimer - delta
			if(overTimer <= 0):
				main.stopGame()
				queue_free()
		else:
			overTimer = 10
			main.get_node('arrow').hide()
			main.get_node('overTimer').hide()
		shooting()
		moving(delta)

	pass

func shooting():
	if Input.is_action_pressed("ui_select") and !fire and ammo > 0:
		var bulletCharge = 1000
		if(main.level == 2):
			bulletCharge = 500
		ammo = ammo - 1
		main.get_node('ammo').set_text('Ammo: '+ str(ammo))
		if main.level > 2:
			main.get_node('sample').play('shot')
		else:
			main.get_node('sample').play('rocket')
		var bullet = preload("res://scenes/bullet.tscn").instance()
		bullet.active = true
		get_parent().add_child(bullet)
		bullet.set_pos(get_pos()+Vector2(30, -12))
		bullet.set_rot(get_rot())
		var bulletSpeed = Vector2(cos(kinRotate*(PI/180)), -sin(kinRotate*(PI/180))) 
		bullet.kinSpeed = bulletSpeed * bulletCharge
	fire = Input.is_action_pressed("ui_select")
	pass
	
func moving(delta):
	if(Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_down") || Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left")):
		if Input.is_action_pressed("ui_up"):
			if(kinRotate < 60):
				kinRotate = kinRotate + 1
				rotate(kinRotate)
			if(kinSpeed.y > -maxSpeed):
				kinSpeed = kinSpeed + Vector2(0, -acc)
		if Input.is_action_pressed("ui_down"):
			if(kinRotate > -60):
				kinRotate = kinRotate - 1
				rotate(kinRotate)
			if(kinSpeed.y < maxSpeed):
				kinSpeed = kinSpeed + Vector2(0, acc)
		if Input.is_action_pressed("ui_left"):
			if(kinSpeed.x > -maxSpeed):
				kinSpeed = kinSpeed + Vector2(-acc, 0)
		if Input.is_action_pressed("ui_right"):
			if(kinSpeed.x < maxSpeed):
				kinSpeed = kinSpeed + Vector2(acc, 0)
	else:
		kinSpeed.x = lerp(kinSpeed.x, 0, lerpSpeed)
		kinSpeed.y = lerp(kinSpeed.y, 0, lerpSpeed)
		kinRotate  = lerp(kinRotate, 0, lerpSpeed)

	set_rot(kinRotate * delta)
	move(kinSpeed * delta)
	pass
	
func get_ammo():
	
	if main.level < 3:
		ammo = ammo + 10
	else:
		ammo = ammo + 50
	main.get_node('ammo').set_text('Ammo: '+str(ammo))
		
	pass
	
func destroy():
	
	main.stopGame()
	get_node("sprite").hide()
	get_node("explosion").show()
	get_node("animation").stop_all()
	get_node("animation").play("explosion")
	get_node("area/collision").queue_free()
	get_node("animation").connect("finished", self, "queue_free")
		
	pass

func blink(speed = .01):
	var fade_speed = float(speed)
		
	var sprite = get_node('sprite')
	var timer  = get_node('timer')
	
	var opacity = sprite.get_opacity()
	for i in range(3):
		while sprite.get_opacity() > 0.5:
			opacity = opacity-0.01
			sprite.set_opacity(opacity)
			timer.set_wait_time(fade_speed)
			timer.start()
			yield(timer, "timeout")
		while sprite.get_opacity() < 1:
			opacity = opacity+0.01
			sprite.set_opacity(opacity)
			timer.set_wait_time(fade_speed)
			timer.start()
			yield(timer, "timeout")
			
		
	pass
