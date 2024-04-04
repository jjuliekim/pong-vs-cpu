extends Sprite2D

var score := [0, 0]  # score stored in array, [0] = player, [1] = cpu
const PADDLE_SPEED : int = 500

# happens every time BallTimer ticks 1 sec (the set wait time)
func _on_ball_timer_timeout():
	$Ball.new_ball()  # can access/call function from different node

# CPU scored
func _on_score_left_body_entered(body):
	score[1] += 1
	$Hud/CPUScore.text = str(score[1])
	$BallTimer.start()
# Player scored
func _on_score_right_body_entered(body):
	score[0] += 1
	$Hud/PlayerScore.text = str(score[0])
	$BallTimer.start()
