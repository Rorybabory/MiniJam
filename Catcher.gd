extends Area2D

@export var text: RichTextLabel

var lastrot = 0
var rot_velocity = 0
var num_caught = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_body_entered(body):
	if (body.is_in_group("Catchable") and absf(rot_velocity) > 4):
		body.queue_free()
		print("CAUGHT")
		num_caught += 1
		text.text = " Caught: " + str(num_caught)
		if (not $swoosh.playing):
			$swoosh.play();
	
	#if body.is_in_group("collectible"):
	#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = get_overlapping_bodies ( )
	
	rot_velocity = (lastrot-global_rotation)/delta;
	#print("angular velocity: " + str(rot_velocity))
	lastrot = global_rotation
	pass
