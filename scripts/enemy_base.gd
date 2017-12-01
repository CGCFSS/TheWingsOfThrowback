extends KinematicBody2D

var active = false
var speed = 7
var type  = 1
var score = 100
var main
var velosity = Vector2(0, 0)
var direction = -1

func _ready():
	set_fixed_process(true)
	add_to_group('destroy')
	add_to_group('enemy')
	main = get_parent()
	if(active):
		set_level_params()
	pass

func _fixed_process(delta):
	if(active):
		velosity.x = (speed + delta) * direction
		move(velosity)
		if(get_global_pos().x < 0 || get_global_pos().x > 1270):
			queue_free()
	pass
	
func plane_colision():
	explosion()
	pass

func explosion():
	
	get_node("sprite").hide()
	get_node("explosion").show()
	get_node("animation").stop_all()
	get_node("animation").play("explosion")
	get_node("area/collision").queue_free()
	get_node("animation").connect("finished", self, "queue_free")
	
	pass
	
func set_level_params():
	#change fonts!!!
	if main.level == 1:
		get_node('sprite').set_vframes(1)
		get_node('animation').stop()
	elif main.level == 2:
		get_node('sprite').set_vframes(1)
		get_node('animation').stop()
	elif main.level == 3:
		get_node('sprite').set_vframes(6)
		get_node('animation').play('fly6')
	elif main.level == 4:
		get_node('sprite').set_vframes(8)
		
		if(type == 4):
			type = 6
			get_node('sprite').set_vframes(6)
		if(type == 2):
			get_node('sprite').set_vframes(6)
			get_node('animation').play('fly6')
		elif(type == 3):
			get_node('animation').play('fly')
		elif(type == 5):
			get_node('sprite').set_vframes(6)
			get_node('animation').play('fly6')
		elif(type == 6):
			get_node('animation').play('fly6')
	var texture = load('res://assets/planes/plane'+ str(main.level) +'_'+ str(type) +'.png')
	get_node('sprite').set_texture(texture)
	
	pass