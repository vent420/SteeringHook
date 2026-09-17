extends Node2D

@export var target: Node2D

func _process(delta: float) -> void:
	LocateFinishLine()

func LocateFinishLine():
	look_at(target.position)
