extends CharacterBody2D


var crop_count = 0
var lvl_crops_available = 10

const MAX_FLY_SPEED = 600


func _physics_process(delta):
	
	
	
	look_at(get_global_mouse_position())
	rotate(PI)
	$Sprite2D.flip_v = transform.x.x < 0
	var mouse_distance_multiplier = min(get_global_mouse_position().distance_to(position) / 50, 1)
	velocity = -transform.x * MAX_FLY_SPEED * mouse_distance_multiplier
	move_and_slide()

func set_crop_count(x : int):
	crop_count = x
	%GUI/CropCount.text = str(crop_count) + "/" + str(lvl_crops_available)


func _on_crop_pickup_area_body_entered(body):
	set_crop_count(crop_count + 1)
	body.queue_free()
