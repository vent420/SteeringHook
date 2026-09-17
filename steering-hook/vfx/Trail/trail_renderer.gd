extends Node2D

const Max_Trail_Count: int = 40

func _ready() -> void:
	$TrailTimer.timeout.connect(update_trail)
	$TrailTimer.start()

func update_trail():
	if $Line2D.points.size() == Max_Trail_Count:
		$Line2D.remove_point(0)
	$Line2D.add_point(global_position)
	print("golbal pos : ", global_position)
