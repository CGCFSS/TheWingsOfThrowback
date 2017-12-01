extends KinematicBody2D

var active = false
var speedX = 10
var speedY = -10
var kinSpeed = Vector2(0,0)

func _ready():
	set_fixed_process(true)
	add_to_group('bullets')
	pass

func _fixed_process(delta):
	if(active):
		show()
		move(kinSpeed * delta)
		if(get_global_pos().x > 1250):
			queue_free()
		if is_colliding():
			queue_free()
	pass