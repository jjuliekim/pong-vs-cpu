extends StaticBody2D

var win_height : int  # records height of game window
var p_height : int  # records height of paddle

# Called when the node enters the scene tree for the first time.
# initialize variables
func _ready():
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y  # ColorRect is child node of Player node


# Called every frame. 'delta' is the elapsed time since the previous frame.
# handle player input
func _process(delta):
	# using delta = game moves at same speed
	# paddle movement
	if Input.is_action_pressed("ui_up"):
		position.y -= get_parent().PADDLE_SPEED * delta  # get parent = go to parent node and look for variables
	elif Input.is_action_pressed("ui_down"):
		position.y += get_parent().PADDLE_SPEED * delta
	
	# limit paddle movement to window using the 'clamp' function
	# clamp the y position of the paddle between the two y positions
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
