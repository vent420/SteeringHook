extends Node





func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print("booster collided with player")
	self.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	pass # Replace with function body.
