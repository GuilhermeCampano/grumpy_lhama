extends Node2D

export (PackedScene) var Spit
export (PackedScene) var Enemy

var isGameOver = false
var spit_impulse = 0;
const IMPULSE_PER_TICK = 4;

func _ready():
	pass

func _physics_process(delta):
	if isGameOver:
		return
	get_input(delta)

func get_input(delta):
	if Input.is_action_just_pressed("secret_key"):
		handle_game_over()
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

func _on_Wave_timeout():
	add_enemy()
	next_wave()

func add_enemy():
	var spawn_position = Vector2(1200, 525);
	var enemy = Enemy.instance()
	var random_speed = randi()%100+100
	enemy.speed = random_speed
	enemy.set_position(spawn_position)
	enemy.connect("dead", self, "on_enemy_hit")
	enemy.connect("hit_player", self, "on_player_hit")
	add_child(enemy)

func on_enemy_hit():
	pass

func on_player_hit():
	print("player has been hit")
	handle_game_over()

func next_wave():
	var random_time = randi()%5+1
	$Wave.set_wait_time(random_time)
	$Wave.start()

func update_spit_impulse():
	spit_impulse += IMPULSE_PER_TICK;
	spit_impulse = min(spit_impulse, 400)
	$Lhama.move_head(spit_impulse)

func reset_spit_impulse():
	spit_impulse = 0
	$Lhama.reset_head()
	
func handle_game_over():
	if isGameOver:
		return
	$Lhama.queue_free()
	$HUD.show_game_over()
	isGameOver = true