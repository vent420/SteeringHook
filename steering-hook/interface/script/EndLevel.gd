extends Node

@export var score: int = 0
@export var hasWon = false	
@export var scoreLabel: Label = null
@export var TimerLabel: Label= null
@export var textLabel: Label= null
@export var retryLabel: Label= null
@export var Checkpoint = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scoreLabel.text = str(score)
	TimerLabel.text = str(0)
	
	if(hasWon):
		textLabel.text = str("You Won!")
	else:
		textLabel.text = str("You Lost!!!")
		
	if(Checkpoint):
		retryLabel.text = "Continue ?"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func getscore(Score: int):
	score = Score

func _on_retry_pressed() -> void:
	if(Checkpoint):
		queue_free()
	else:
		get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://interface/main.tscn")
	pass # Replace with function body.
