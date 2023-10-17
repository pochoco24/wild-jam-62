extends StaticBody2D

var harvested = false

func collect():
	if !harvested:
		$AnimationPlayer.play("picked")
		harvested = true
		return true
	else:
		return false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "picked":
		queue_free()
