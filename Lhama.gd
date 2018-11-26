extends KinematicBody2D

var original_head_position_x;

func _ready():
	original_head_position_x = $Head.position.x

# HEAD
func move_head(impulse):
	$Head.position.x = -impulse/10

func reset_head():
	$Head.position.x = original_head_position_x
