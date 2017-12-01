extends Area2D

func _ready():
	pass


func _on_area_area_enter( area ):
	var body = area.get_parent()
	if body.is_in_group("ammo"):
		body.queue_free()
		
		get_parent().get_ammo()
	if body.is_in_group("destroy"):
		body.plane_colision()
		
		get_parent().destroy()
	pass 