extends Timer

var main
var started = true
func _ready():
	main = get_parent()
	
	pass


func _on_timer_timeout():
	if main.gameRuning:
		stop()
		var enemyNum = randi()%(main.level+1)
		
		if(main.level == 1):
			if(main.distance > 5):
				get_enemy_4()
			get_enemy_2()
		elif(main.level == 2):
			if(enemyNum == 0):
				get_enemy_1()
			elif(enemyNum == 1):
				get_enemy_2()
			get_enemy_4()
				
		elif(main.level == 3):
			if(enemyNum == 0):
				get_enemy_1()
			elif(enemyNum == 1):
				get_enemy_2()
			elif(enemyNum == 2):
				get_enemy_3()
		elif(main.level == 4):
			get_enemy_1()
			get_enemy_4()
			if(enemyNum == 1):
				get_enemy_2()
			elif(enemyNum == 2):
				get_enemy_3()
		
		if(main.level == 1):
			set_wait_time(1)
		elif(main.level == 2):
			set_wait_time(0.7)
		elif(main.level == 3):
			set_wait_time(0.3)
		elif(main.level == 4):
			set_wait_time(0.5)
		start()
	pass

func get_enemy_1():
	var count = randi()%5+1

	var yRands = []
	var yRand  = 0
	var enemyScene  = preload("res://scenes/enemy1.tscn")
	var vpos
	
	for i in range(count):
		var enemy = enemyScene.instance()

		yRand = randi()%13
		while(yRands.has(yRand)):
			yRand = randi()%13
		
		yRands.push_back(yRand)
		vpos  = Vector2(1250, 10 + (60 * yRand))
		enemy.get_node("sprite").set_flip_h(true)
		enemy.set_pos(vpos)
		
		if(main.level == 1):
			enemy.speed = 20
		elif(main.level == 2):
			enemy.speed = 15
		elif(main.level == 3):
			enemy.speed = 12
		elif(main.level == 4):
			enemy.speed = 8
		enemy.active = true
		enemy.type   = 2
		enemy.show()
		main.add_child(enemy)
	
	pass
	
func get_enemy_2():
	var count = randi()%5+1
	
	var yRands = []
	var yRand  = 0
	var enemyScene  = preload("res://scenes/enemy2.tscn")
	var vpos
	var enemy 
	
	for i in range(count):
		yRand = randi()%13
		while(yRands.has(yRand)):
			yRand = randi()%13
		
		yRands.push_back(yRand)
		vpos  = Vector2(1250, 10 + (60 * yRand))
		enemy = enemyScene.instance()
		
		if(main.level == 1):
			enemy.speed = 25
		elif(main.level == 2):
			enemy.speed = 20
		elif(main.level == 3):
			enemy.speed = 15
		elif(main.level == 4):
			enemy.speed = 10
		enemy.score = 200
		enemy.type   = 3
		enemy.set_pos(vpos)
		enemy.active = true
		enemy.show()
		main.add_child(enemy)
	
	pass
	
func get_enemy_3():
	var enemy = preload("res://scenes/enemy3.tscn").instance()
	enemy.corner = randi()%2
	
	if(enemy.corner):
		enemy.set_pos(Vector2(1250, 0))
	else:
		enemy.set_pos(Vector2(1250, 720))
	
	if(main.level == 1):
		enemy.speed = 10
	elif(main.level == 2):
		enemy.speed = 10
	elif(main.level == 3):
		enemy.speed = 8
	elif(main.level == 4):
		enemy.speed = 7
	enemy.active = true
	enemy.type   = 4
	enemy.show()
	main.add_child(enemy)
	
	pass
	
func get_enemy_4():
	var count 
	if(main.level < 4):
		count = randi()%3+1
	else:
		count = randi()%3
	var yRands = []
	var yRand  = 0
	var enemyScene  = preload("res://scenes/enemy1.tscn")
	var vpos
	
	for i in range(count):
		var enemy = enemyScene.instance()

		yRand = randi()%13
		while(yRands.has(yRand)):
			yRand = randi()%13
		
		yRands.push_back(yRand)
		vpos  = Vector2(-3, 10 + (60 * yRand))
		enemy.direction = 1
		
		
		enemy.type   = 5
		if(main.level == 1):
			enemy.type   = 2
			enemy.speed = 12
		elif(main.level == 2):
			enemy.speed = 10
		elif(main.level == 3):
			enemy.speed = 8
		elif(main.level == 4):
			enemy.speed = 7
			
		enemy.get_node("sprite").set_flip_h(false)
		enemy.set_pos(vpos)
		enemy.active = true
		enemy.show()
		main.add_child(enemy)
	
	pass