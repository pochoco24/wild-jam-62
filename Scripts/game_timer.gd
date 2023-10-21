extends Sprite2D

var start_moon
var change_moon
var moon_times
@onready var player = %Player

func _ready():
	$game_timer.start()
	start_moon = int($game_timer.time_left)
	change_moon = int($game_timer.time_left)
	moon_times = int(change_moon / 10)
	

func _physics_process(delta):
#	print_debug(int($game_timer.time_left))
	if int($game_timer.time_left) == change_moon:
		print(change_moon)
		print(moon_times)
		if change_moon < start_moon / 2:
			position.x += 110
			position.y += 10
		else:
			position.x += 110
			position.y += -10
		change_moon += -moon_times


func _on_game_timer_timeout():
	print("Time over")
	%PlayerCamera.timeover()
	await get_tree().create_timer(1.0).timeout
	%ui.timeover_ui()
