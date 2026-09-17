extends Sprite2D

@export var defaultPath: String

func _ready() -> void:
	if defaultPath.is_empty(): defaultPath = texture.resource_path.left(-4)
	# xxx.connect(ChangeRoadColor)
	ChangeRoadColor("r")

func ChangeRoadColor(col: String):
	texture = load(defaultPath + "_" + col + ".png")
