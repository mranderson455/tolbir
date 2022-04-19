extends Node2D

var scene = preload("res://plr.tscn")

func _ready():
	pass # Replace with function body.

func spawnProjectile(size, age, speed):
	add_child(scene.instance())

var t = 0
func _process(delta):
	t += 1
	
	if (int(t) % 10 == 0):
		spawnProjectile(1,1,1)
	pass
