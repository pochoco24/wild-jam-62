extends Sprite2D

@onready var player = %Player
@onready var starting_time = $game_timer.wait_time

func _ready():
	$game_timer.start()

func _physics_process(delta):
#	print_debug(int($game_timer.time_left))
	#Rotate Moon
	var angle = (1 - ($game_timer.time_left / starting_time) * 2) * 27.0
	$"../moon_pivot".rotation_degrees = angle
	global_position = $"../moon_pivot/moon_pos_ref".global_position
	
	#Flicker when time is low
	if $game_timer.time_left < 3:
		visible = fmod($game_timer.time_left, 0.3) > 0.15
		if not $tick.is_playing():
			$tick.play()

func _on_game_timer_timeout():
	print("Time over")
	%PlayerCamera.timeover()
	await get_tree().create_timer(1.0).timeout
	%ui.timeover_ui()
