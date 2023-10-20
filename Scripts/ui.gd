extends CanvasLayer

var fail_screen = false


#PAUSED
func _unhandled_input(event):
	if event.is_action_pressed("esc") and fail_screen == false:
		get_tree().paused = true
		$pause/ui.show()


func _on_restart_pressed():
	print("???")
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_continue_pressed():
	print("pressed")
	get_tree().paused = false
	$pause/ui.hide()

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/ui_menu.tscn")

#FAILED
func failed():
	fail_screen = true
	get_tree().paused = true
	$failed/ui.show()


func _on_restart_2_pressed():
	fail_screen = false
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_menu_2_pressed():
	fail_screen = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/ui_menu.tscn")


#NEXT LEVEL
func next_lvl():
	$next_lvl/ui.show()
	get_tree().paused = true

func _on_next_lvl_pressed():
	get_tree().paused = false
