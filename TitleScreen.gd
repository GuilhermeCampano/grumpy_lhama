extends CanvasLayer

const PLAYGROUND_SCENE = "res://stages/playground/Playground.tscn"
const STAGE_1 = "res://stages/stage_1/Main.tscn"

func _on_StartGame_pressed():
	get_tree().change_scene(STAGE_1)
