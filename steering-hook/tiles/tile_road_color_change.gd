extends Sprite2D

@export var defaultPath: String

func _ready() -> void:
	if defaultPath.is_empty(): defaultPath = texture.resource_path.left(-4)
	# xxx.connect(ChangeRoadColor)
	ChangeRoadColor("m")

func ChangeRoadColor(col: String):
	var path_to_new_file: String = defaultPath + "_" + col + ".png"
	if ResourceLoader.exists(path_to_new_file):
		texture = load(path_to_new_file)
	else:
		print(path_to_new_file)
