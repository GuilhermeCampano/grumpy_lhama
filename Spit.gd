extends RigidBody2D

func _ready():
	# set_physics_process(true)
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free();

func _on_Spit_body_entered(body):
	queue_free()
