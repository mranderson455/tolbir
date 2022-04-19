extends KinematicBody2D

onready var _cursor = $Cursor
onready var _top = $Top
onready var _bot = $Bottom

export (int) var speed = 100

var bullet = preload("res://BasicBullet.tscn")

var mousePos = Vector2()
var velocity = Vector2()

var isAttacking = false
var isRunning = false
var leftPunch = false
var currentWeapon = "none"
var currentBullet

func _process(delta):
	mousePos = get_global_mouse_position();
	_top.look_at(mousePos);
	_cursor.global_position = mousePos
	
	if (velocity.x != 0 || velocity.y != 0):
		if isRunning:
			_bot.get_child(1).play("run")
			if !isAttacking:
				_top.get_child(1).play("run_" + str(currentWeapon))
		else:
			_bot.get_child(1).play("walk")
			if !isAttacking:
				_top.get_child(1).play("walk_" + str(currentWeapon))
	else:
		_bot.get_child(1).play("idle")
		if !isAttacking:
			_top.get_child(1).play("idle_" + str(currentWeapon))
	
	
	
	if !isAttacking && Input.is_action_pressed("attack"):
		if currentWeapon == "none":
			if leftPunch:
				_top.get_child(1).play("attack_none1")
			else:
				_top.get_child(1).play("attack_none2")
			leftPunch = !leftPunch
		elif currentWeapon == "pistol":
			_top.get_child(1).play("attack_pistol")
			currentBullet = bullet.instance()
			
			currentBullet.rotation = _top.rotation
			currentBullet.position += Vector2(20, 0).rotated(currentBullet.rotation)
			add_child(currentBullet)
		elif currentWeapon == "ak":
			_top.get_child(1).play("attack_ak")
			currentBullet = bullet.instance()
			
			currentBullet.rotation = _top.rotation
			currentBullet.position = _top.position + Vector2(20, 3).rotated(currentBullet.rotation)
			add_child(currentBullet)
		isAttacking = true
	pass


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 50
		_bot.rotation_degrees = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 50
		_bot.rotation_degrees = 180
	if Input.is_action_pressed("ui_down"):
		velocity.y += 50
		_bot.rotation_degrees = 270
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 50
		_bot.rotation_degrees = 90
		
	if Input.is_action_pressed("run"):
		isRunning = true
	else:
		isRunning = false
		
	if Input.is_key_pressed(KEY_1):
		currentWeapon = "pistol"
	elif Input.is_key_pressed(KEY_2):
		currentWeapon = "ak"
	elif Input.is_key_pressed(KEY_3):
		currentWeapon = "none"

func _physics_process(delta):
	get_input()
	
	if isRunning:
		velocity = move_and_slide(velocity * 1.8)
	else:
		velocity = move_and_slide(velocity)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack_none1" || anim_name == "attack_none2" || anim_name == "attack_pistol" || anim_name == "attack_ak":
		isAttacking = false
	
	pass
