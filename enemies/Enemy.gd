extends KinematicBody2D
export var speed = 100;
signal dead
signal hit_player

func _physics_process(delta):
	walk(speed * delta);

func walk (dS): 
	var distance = Vector2(-dS, 0);
	var collision = move_and_collide(distance);
	collision && handle_collision(collision)

func handle_collision(collision):
	var collider = collision.get_collider()
	if collider.is_in_group("spit"):
		handle_collision_spit()
	elif collider.is_in_group("player"):
		handle_collision_player()

func handle_collision_spit():
	speed = -100;
	$Sprite.scale = Vector2(0.9, 0.9)
	$Sprite.rotate(30)
	$Timer.start()

func handle_collision_player():
	emit_signal("hit_player")
	#$Timer.start()
	
func _on_Timer_timeout():
	$Timer.stop()
	emit_signal("dead")
	queue_free()
