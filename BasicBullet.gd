extends KinematicBody2D

var travelSpeed = 900

var velocity = Vector2()

func _process(delta):
	velocity = Vector2(travelSpeed, 0).rotated(rotation)
	pass

func _physics_process(delta):
	velocity = move_and_slide(velocity)
	pass
