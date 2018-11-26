extends Node2D

export (PackedScene) var Spit
export (PackedScene) var Enemy

var isGameOver = false
var spit_impulse = 0;
const impulse_per_tick = 4;

func _ready():
	pass

func _physics_process(delta):
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
		return false
	var offset = Vector2(0, 0);
	var spit = Spit.instance()
	var mouse_pos = get_global_mouse_position()
	var impuse_horizontal = spit_impulse
	var impuse_vertical = max(mouse_pos.y - 600, -200)
	var final_impulse = Vector2(impuse_horizontal, impuse_vertical)
	print(mouse_pos, impuse_vertical)
	spit.set_position(Vector2(170, 490))
	spit.apply_impulse(offset, final_impulse)
	add_child(spit)
	$HUD.spit_consume()

func _on_Wave_timeout():
	add_enemy()
	next_wave()

func add_enemy():
	var spawn_position = Vector2(1200, 525);
	var enemy = Enemy.instance()
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
	spit_impulse += impulse_per_tick;
	spit_impulse = min(spit_impulse, 400)
	$Lhama.move_head(spit_impulse)

func reset_spit_impulse():
	spit_impulse = 0
	$Lhama.reset_head()
	
func handle_game_over():
	if isGameOver:
		return false
	$Lhama.queue_free()
	$HUD.show_game_over()
	isGameOver = true