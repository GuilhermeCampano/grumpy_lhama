extends Node2D

# PLAYGROUND BE CAREFUL
export (PackedScene) var Spit

var spit_impulse = 0;
const impulse_per_tick = 4;

func _physics_process(delta):
	get_input(delta)

func get_input(delta):
	if Input.is_action_pressed("spit"):
		update_spit_impulse()
	if Input.is_action_just_released("spit"):
		add_spit()
		reset_spit_impulse()

func add_spit():
	if $HUD.spit_counter_current <= 0:
		return
	var offset = Vector2(0, 0)
	var spit = Spit.instance()
	var spit_position = Vector2(170, 490)
	var mouse_pos = get_global_mouse_position()
	mouse_pos.x = clamp(mouse_pos.x, spit_position.x, 1000)
	mouse_pos.y = clamp(mouse_pos.y, 0, spit_position.y)
	var vector = mouse_pos - spit_position
	var magnitude = vector.normalized() * spit_impulse
	spit.set_position(spit_position)
	spit.apply_impulse(offset, magnitude)
	add_child(spit)
	$HUD.spit_consume()

func update_spit_impulse():
	spit_impulse += impulse_per_tick;
	spit_impulse = min(spit_impulse, 400)
	$Lhama.move_head(spit_impulse)

func reset_spit_impulse():
	spit_impulse = 0
	$Lhama.reset_head()