extends Node

func _ready() -> void:
	ChangeBuildingColor("r")

func ChangeBuildingColor(col: String):
	for child in get_children():
		var defaultPath: String =  child.texture.resource_path.left(-6)
		var path_to_new_file: String = defaultPath + "_" + col + ".png"
		if ResourceLoader.exists(path_to_new_file):
			child.texture = load(path_to_new_file)
		else:
			push_warning("No sprite with path " + path_to_new_file + " exists.")
