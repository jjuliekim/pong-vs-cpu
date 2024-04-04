extends CharacterBody2D

var win_size : Vector2
const START_SPEED : int = 500
const ACCEL : int = 50
var speed : int  # current speed
var dir : Vector2  # direction
const MAX_Y_VECTOR : float = 0.6

# Called when the node enters the scene tree for the first time
func _ready():
	win_size = get_viewport_rect().size
	
# not actually 'new', just reposition and new direction
func new_ball():
	position.x = win_size.x / 2
	position.y = randi_range(200, win_size.y - 200)
	speed = START_SPEED
	dir = random_direction()

# Called every frame. 'delta' is the elapsed time since the previous frame
func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)  # built in function
	var collider
	if collision:
		collider = collision.get_collider()  # collision object
		# if ball hits paddle
		if collider == $"../Player" or collider == $"../CPU":
			speed += ACCEL
			dir = new_direction(collider)
			# dir.bounce(collision.get_normal())  # bounce function is built in, but this is just directly bouncing off straight
		# if ball hits wall
		else:
			dir = dir.bounce(collision.get_normal())
	
func random_direction():
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()  # can go either left or right
	new_dir.y = randf_range(-1, 1)  # more flexibility
	return new_dir.normalized()

# new direction calculation (angle of ball hitting paddle)
func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir := Vector2()  
	
	# flip the horizontal direction
	if dir.x > 0:  # moving to the right
		new_dir.x = -1
	else:  # moving to the left
		new_dir.x = 1
	# y direction
	new_dir.y = (dist / (collider.p_height / 2)) * MAX_Y_VECTOR  # distance from center
	return new_dir.normalized()
	
	
