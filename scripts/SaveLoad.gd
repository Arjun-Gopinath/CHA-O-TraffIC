extends Node

var location = "user://save.data"
var load_score

var password = "odiyan"
#var password = "odiyan"
func _save_score(sec):
	var data = {
		"seconds" : sec
	}
	var file = File.new()
	if file.file_exists(location):
		file.open_encrypted_with_pass(location, File.READ,password)
		var opened = parse_json(file.get_as_text())
		file.open_encrypted_with_pass(location, File.WRITE,password)
		sec = check_score(sec,opened["seconds"])
		data["seconds"] = sec
		file.store_line(to_json(data))
		file.close()
	else:
		file.open_encrypted_with_pass(location,File.WRITE,password)
		data["seconds"] = 0
		file.store_line(to_json(data))
		file.close()


func _create_file(sec):
	var file = File.new()
	if(file.open_encrypted_with_pass(location, File.WRITE,password) != 0):
		print("Error storing..permission not granted")
	else:
		var data = {
			"seconds" : sec
		}
		file.store_line(to_json(data))
		file.close()


func load_game_score():
	var file = File.new()
	var seconds = 0
	if file.file_exists(location):
		print("save file exsists in ",OS.get_user_data_dir())
		file.open_encrypted_with_pass(location, File.READ,password)
		var data = parse_json(file.get_as_text())
#		print(data["seconds"],data["mseconds"])
		seconds = data["seconds"]
		file.close()
	else:
		file.close()
		print("creating new save file in ",OS.get_user_data_dir())
		_create_file(seconds)
	return seconds


func check_score(current_score,saved_score):
	if(current_score > saved_score):
		return current_score
	return saved_score
