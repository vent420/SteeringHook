extends Sprite2D

@export var spr_arr: Array[Texture2D]

func _ready() -> void:
	pass
	# xxx.connect(ChangeRoadColor)

func ChangeRoadColor(level: int):
	texture = spr_arr[level]
