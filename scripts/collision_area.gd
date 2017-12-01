extends Area2D

func _ready():
	pass

func _on_area_area_enter( area ):
	var body = area.get_parent()
	if body.is_in_group("bullets"):
		body.queue_free()
		get_parent().get_parent().addScore(get_parent().score)
		get_parent().explosion()
	pass