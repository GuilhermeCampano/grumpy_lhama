extends CanvasLayer

func _ready():
	hide_game_over()

# SPIT Control
export var spit_counter_max = 3
export var spit_counter_current = 3
func spit_consume():
	spit_counter_current = max(spit_counter_current - 1, 0)
	$SpitRecover.start()
	update_spit_meter()

func _on_SpitRecover_timeout():
	if spit_counter_current < spit_counter_max:
		$SpitRecover.start()
		spit_counter_current += 1
		update_spit_meter()
	else:
		$SpitRecover.stop()

func update_spit_meter():
	$HBoxContainer/SpitCounter.set_text(str(spit_counter_current, "/", spit_counter_max))

func show_game_over():
	$CenterContainer/GameOverWrapper.show()

func hide_game_over():
	$CenterContainer/GameOverWrapper.hide()

func _on_TryAgain_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")
