extends CanvasLayer

func _ready():
	pass

func _on_StartGame_pressed():
	get_tree().change_scene("res://stages/StageSelection.tscn")