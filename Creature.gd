extends RigidBody2D


enum state {IDLE, FLEE}

var player

var hopcount = 0
var moving = false

var target_velocity = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	hopcount = randf()
	player = get_node("/root/World/Player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var vec = global_position - player.global_position
	var dir = vec.normalized()
	
	var len = vec.length()
	
	if (len < 150):
		moving = true
		target_velocity = dir * delta * 10000
	elif (len > 300):
		moving = false
		target_velocity.x *= pow(0.001, delta);
		target_velocity.y *= pow(0.001, delta);
	pass
	
	linear_velocity.x = lerp(linear_velocity.y, target_velocity.x, delta*2.0)
	linear_velocity.y = lerp(linear_velocity.y, target_velocity.y, delta*2.0)
	
	if (not moving):
		return
	hopcount+=delta;
	var hoppos = sin(hopcount*25.0)
	if (hoppos < -0.5):
		hoppos = -0.5;
	hoppos+=0.5
	$Sprite2D.position.y = -hoppos * 7
