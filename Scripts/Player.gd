extends CharacterBody2D


var crop_count = 0
@onready var lvl_crops_available = %Crops.get_child_count()
var hearts = 3

@export var fly_speed = 500
var acceleration = fly_speed / 25.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var flap_velocity = -300

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("flap"):
		$AnimatedSprite2D.play("flap",)
		velocity.y = flap_velocity
	
	var move = Input.get_axis("left", "right")
	if move != 0:
		$AnimatedSprite2D.flip_h = move < 0
	velocity.x = move_toward(velocity.x, move * fly_speed, acceleration)
	
	if not is_on_floor():
		$AnimatedSprite2D.speed_scale = 1
		if $AnimatedSprite2D.animation == "walking":
			$AnimatedSprite2D.animation = "gliding"
		rotation = -Vector2(velocity.x, fly_speed*2).angle() + PI/2
	else:
		$AnimatedSprite2D.animation = "walking"
		$AnimatedSprite2D.speed_scale = abs(velocity.x / fly_speed)
		rotation = 0
		
	
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


func _on_animated_sprite_2d_animation_finished():
	match $AnimatedSprite2D.animation:
		"flap":
			$AnimatedSprite2D.play("gliding")
