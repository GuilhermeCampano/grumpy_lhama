extends Container

const PLAYGROUND = "res://stages/playground/Playground.tscn"
const STAGE_1 = "res://stages/stage_1/Main.tscn"

func _ready():
	pass

func _on_Stage1_pressed():
	get_tree().change_scene(STAGE_1)

func _on_Training_pressed():
	get_tree().change_scene(PLAYGROUND)
