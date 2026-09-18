extends Node

var audio_player_node: Resource = preload("res://audio/audio_player.tscn")
var music_player: AudioStreamPlayer2D
var engine_loop_player: AudioStreamPlayer2D
var drift_loop_player: AudioStreamPlayer2D
var is_drifting: bool = false
var drift_volume_tween: Tween

@export var max_drift_volume: float = 1.2
@export var drift_volume_attack: float = 0.7
@export var drift_volume_release: float = 0.5
@export var engine_vol_mult: float = 0.9


@export var music_fade_in: float = 4
@export var g_music_volume: float = 0.9
@export var g_sounds_volume: float = 1.0

func _ready() -> void:
	
	return
	play_oneshot("car_engine_startup")
	start_level()

func change_drifting(to: bool, pan: float = 0.5):
	if not drift_loop_player: return
	if is_drifting == to: return
	is_drifting = to
	drift_loop_player.panning_strength = pan
	if drift_volume_tween: drift_volume_tween.stop()
	if is_drifting:
		var t = (max_drift_volume - drift_loop_player.volume_linear) * drift_volume_attack
		drift_volume_tween = get_tree().create_tween()
		drift_volume_tween.tween_property(drift_loop_player,"volume_linear",max_drift_volume,t)
	else:
		var t = (drift_loop_player.volume_linear) * drift_volume_release
		drift_volume_tween = get_tree().create_tween()
		drift_volume_tween.tween_property(drift_loop_player,"volume_linear",0,t)

func _process(_delta: float) -> void:
	if music_player:
		if not music_player.playing:
			music_player.play()
	if engine_loop_player:
		if not engine_loop_player.playing:
			engine_loop_player.play()
	if drift_loop_player:
		if not drift_loop_player.playing:
			drift_loop_player.play()

func start_level():
	music_player = audio_player_node.instantiate()
	add_child(music_player)
	music()
	
	engine_loop_player = audio_player_node.instantiate()
	add_child(engine_loop_player)
	engine_loop_player.stream = load("res://audio/sxf_loop_car_engine_main_v01.ogg")
	engine_change(0,1)
	
	drift_loop_player = audio_player_node.instantiate()
	add_child(drift_loop_player)
	drift_loop_player.volume_linear = 0
	drift_loop_player.stream = load("res://audio/sfx_loop_car_turn_drift_v01.ogg")

func engine_change(speed: float, max_speed: float):
	if not engine_loop_player: return
	if max_speed <= 0: max_speed = 1
	engine_loop_player.volume_linear = (speed/max_speed)/1.5*engine_vol_mult
	engine_loop_player.pitch_scale = 1 + (speed/max_speed)/2

func engine_loop_end(fade_time: float = 0.2):
	if not engine_loop_player: return
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(engine_loop_player,"volume_linear",0,fade_time)
	await tween.finished
	engine_loop_player.queue_free()

func music_end(fade_time: float = 0.2):
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(music_player,"volume_linear",0,fade_time)
	await tween.finished
	music_player.queue_free()

func change_music_volume(to: float):
	music_player.volume_linear = to
	g_music_volume = to

func music():
	music_player.stream = load("res://audio/mus_music_default_v01.ogg")
	var tween: Tween = get_tree().create_tween()
	music_player.volume_linear = 0
	tween.tween_property(music_player,"volume_linear",g_music_volume,music_fade_in)

## id = sound effect name (file name without "sfx_" and "_v01.ogg")
func play_oneshot(id: String, loudness: float = 1.0, pitch = 1.0, full_path: bool = false):
	var audio_player_node_isntance: AudioStreamPlayer2D = audio_player_node.instantiate()
	add_child(audio_player_node_isntance)
	
	var path : String
	if not full_path:
		path = str("audio/sfx_",id,"_v01.ogg")
	else:
		path = id
	
	audio_player_node_isntance.stream = load(path)
	audio_player_node_isntance.volume_linear = loudness*g_sounds_volume
	audio_player_node_isntance.pitch_scale = pitch
	audio_player_node_isntance.play()
	await audio_player_node_isntance.finished
	audio_player_node_isntance.queue_free()
