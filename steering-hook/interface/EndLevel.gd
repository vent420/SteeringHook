extends Node

@export var score: int = 0
@export var hasWon = false	
@export var scoreLabel: Label = null
@export var TimerLabel: Label= null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func getscore(Score: int):
	score = Score

func _on_play_b_pressed() -> void:
	pass # Replace with function body.


func _on_quit_b_pressed() -> void:
	pass # Replace with function body.
