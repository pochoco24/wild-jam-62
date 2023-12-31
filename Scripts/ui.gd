extends CanvasLayer

var fail_screen = false


#PAUSED
func _unhandled_input(event):
	if event.is_action_pressed("esc") and fail_screen == false:
		get_tree().paused = true
		$pause/ui.show()
		$music.play()


func _on_restart_pressed():
	print("???")
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_continue_pressed():
	get_tree().paused = false
	$pause/ui.hide()
	$music.stop()

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/ui_menu.tscn")

#FAILED
func failed():
	fail_screen = true
	get_tree().paused = true
	$failed/ui.show()
	$music.play()


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
	$music.play()

func _on_next_lvl_pressed():
	get_tree().paused = false
	var current_scene = get_tree().current_scene.scene_file_path
	var next_level = current_scene.to_int() + 1
	get_tree().change_scene_to_file("res://Scenes/Levels/Level_" + str(next_level) + ".tscn")
	
func the_end():
	$the_end/ui.show()
	get_tree().paused = true
	$music.play()
	
func timeover_ui():
	$timeover/ui.show()
	get_tree().paused = true
	$music.play()
	
func description():
	$description.show()
	await get_tree().create_timer(5.0).timeout
	$description.hide()
