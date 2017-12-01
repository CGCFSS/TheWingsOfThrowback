extends "res://scripts/enemy_base.gd"

var corner = 0

func _ready():
	speed = 5
	score = 200
	
	set_fixed_process(true)
	add_to_group('destroy')
	add_to_group('enemy')
	
	main = get_parent()
	if(active):
		set_level_params()
	pass

func _fixed_process(delta):
	if(active):
		if(corner):
			move(Vector2(-(speed + delta), (2 + delta)))
		else:
			move(Vector2(-(speed + delta), -(2 + delta)))
		if(get_global_pos().x < 0):
			queue_free()
	pass