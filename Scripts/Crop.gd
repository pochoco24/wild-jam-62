@tool
extends StaticBody2D

var harvested = false
@export var crop_texture : Texture2D = null : 
	set(state):
		$Sprite2D.texture = state


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
