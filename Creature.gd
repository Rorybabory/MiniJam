extends RigidBody2D

var textures = [
	load("res://creatures/creature1.png"),
	load("res://creatures/creature2.png"),
	load("res://creatures/creature3.png"),
	load("res://creatures/creature4.png"),
	load("res://creatures/creature5.png"),
	load("res://creatures/creature6.png")
]


enum STATE {IDLE, FLEE, ROAM, INIT}

var state = STATE.IDLE

var player

var hopcount = 0
var moving = false

var initDir = Vector2(0,0)
var initCount = 0
var initTarget = 0
var hopspeed = 0
var target_velocity = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	hopcount = randf()
	
	resetInitDir()
	
	$Sprite2D.scale.y = 0
	
	$Sprite2D.set_texture(textures[randi_range(0, 5)])
	
	player = get_node("/root/World/Player")
	pass # Replace with function body.


func resetInitDir():
	initTarget = randf_range(2, 4)
	initDir.x = randf_range(-4, 4)
	initDir.y = randf_range(-4, 4)
	initDir = initDir.normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ($Sprite2D.scale.y < $Sprite2D.scale.x):
		$Sprite2D.scale.y+=delta*0.25
	else:
		$Sprite2D.scale.y = $Sprite2D.scale.x
	var vec = global_position - player.global_position
	var dir = vec.normalized()
	
	var len = vec.length()
	
	match(state):
		STATE.IDLE:
			moving = false
			target_velocity.x *= pow(0.001, delta);
			target_velocity.y *= pow(0.001, delta);
		STATE.FLEE:
			moving = true
			target_velocity = dir * 115
			hopspeed = 1.0
		STATE.ROAM:
			moving = true
			hopspeed = 0.4
		STATE.INIT:
			initCount += delta
			if (initCount > initTarget):
				resetInitDir()
				initCount = 0
			target_velocity = initDir * 70
			moving = true
			hopspeed = 0.2
	
	if (len < 150):
		state = STATE.FLEE
	elif (len < 300):
		state = STATE.ROAM
	elif (state != STATE.INIT):
		state = STATE.INIT
			
	linear_velocity.x = lerp(linear_velocity.y, target_velocity.x, delta*4.0)
	linear_velocity.y = lerp(linear_velocity.y, target_velocity.y, delta*4.0)
	
	$Sprite2D.flip_h = linear_velocity.x < 0
	
	if (not moving):
		return
	hopcount+=delta;
	var hoppos = sin(hopcount*25.0*hopspeed)
	if (hoppos < -0.5):
		hoppos = -0.5;
	hoppos+=0.5
	$Sprite2D.position.y = -hoppos * 7 * hopspeed
