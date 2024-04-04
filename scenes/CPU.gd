extends StaticBody2D

var ball_pos : Vector2  # AI needs to know the position of the ball
var dist : int  # vertical distance of paddle and ball
var move_by : int  # how much the paddle should move
var win_height : int
var p_height : int

# Called when the node enters the scene tree for the first time.
func _ready():
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# move paddle towards ball
	ball_pos = $"../Ball".position  # can drag node to the code to get the 'reference'
	dist = position.y - ball_pos.y
	
	if abs(dist) > get_parent().PADDLE_SPEED * delta:
		move_by = get_parent().PADDLE_SPEED * delta * (dist / abs(dist))  # to determine if move +/-
	else:  # fixes jittery paddle and overshooting
		move_by = dist
		
	position.y -= move_by
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
