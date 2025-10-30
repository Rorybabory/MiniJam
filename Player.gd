extends RigidBody2D

const speed = 200;
const rotate_speed = 10;
var velocity = Vector2(0,0);
var hopping = false;

var hopcount = 0.0;

var catcher

var catcher_dir = 1.0

var target_rotvel = 0.0
var rotvel = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	catcher = get_node("Catcher")
	pass # Replace with function body.

func hop_update(delta):
	hopcount+=delta;
	var hoppos = sin(hopcount*25.0)
	if (hoppos < -0.5):
		hoppos = -0.5;
	hoppos+=0.5
	$Sprite.position.y = -hoppos * 0.02 * (absf(velocity.x)+absf(velocity.y))
	
func update_catcher(delta):
	target_rotvel = Input.get_axis("rot_left", "rot_right");
	
	if (absf(target_rotvel) > 0.1):
		if (target_rotvel > 0):
			catcher.get_node("Sprite").flip_v = true
		else:
			catcher.get_node("Sprite").flip_v = false
	
	rotvel = lerp(rotvel, target_rotvel, delta*5.0)
	#catcher.angular_velocity = rotvel
	catcher.rotate(rotvel * delta * 10.0)
	catcher.global_position = global_position
	pass

func movement(delta):
	if (Input.is_action_pressed("left")):
		velocity.x = -speed;
	elif (Input.is_action_pressed("right")):
		velocity.x = speed;
	else:
		velocity.x *= pow(0.001, delta);
	if (Input.is_action_pressed("up")):
		velocity.y = -speed;
	elif (Input.is_action_pressed("down")):
		velocity.y = speed;
	else:
		velocity.y *= pow(0.001, delta);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement(delta)
	hop_update(delta)
	update_catcher(delta)
	linear_velocity = velocity;
	pass

