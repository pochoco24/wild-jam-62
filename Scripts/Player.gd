extends CharacterBody2D


var crop_count = 0
@onready var lvl_crops_available = %Crops.get_child_count()
var hearts = 3

@export var fly_speed = 600


func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_left"):
		hurt()
	
	look_at(get_global_mouse_position())
	rotate(PI)
	$Sprite2D.flip_v = transform.x.x < 0
	var mouse_distance_multiplier = min(get_global_mouse_position().distance_to(position) / 50, 1)
	velocity = -transform.x * fly_speed * mouse_distance_multiplier
	move_and_slide()

func set_crop_count(x : int):
	crop_count = x
	%GUI/CropCount.text = str(crop_count) + "/" + str(lvl_crops_available)

func hurt():
	hearts -= 1
	
	if hearts == 0:
		print("You lose")
	
	for i in %GUI/Hearts.get_child_count():
		%GUI/Hearts.get_child(i).visible = i + 1 <= hearts

func _on_crop_pickup_area_body_entered(body):
	set_crop_count(crop_count + 1)
	body.queue_free()
