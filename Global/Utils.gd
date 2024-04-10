extends Node

const SAVE_PATH = "res://savegame.bin"

func _physics_process(delta):
	quitGame()

func quitGame():
	if Input.is_action_just_pressed("Quit_Game"):
		get_tree().quit()

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"Gold": Game.Gold,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)

func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				if current_line["playerHP"] > 0:
					Game.playerHP = current_line["playerHP"]
					Game.Gold = current_line["Gold"]
				else:
					Game.playerHP = Game.maxHP
					Game.Gold = 0
					

