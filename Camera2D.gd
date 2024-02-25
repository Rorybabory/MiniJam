extends Camera2D


var player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/World/Player")
	pass # Replace with function body.

func _physics_process(delta):
	position.x = lerp(position.x, player.position.x, delta * 7)
	position.y = lerp(position.y, player.position.y, delta * 7)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
