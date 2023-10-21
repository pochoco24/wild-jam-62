extends CharacterBody2D


var crop_count = 0
@onready var lvl_crops_available = %Crops.get_child_count()
@onready var hearts = %GUI/Hearts.get_child_count()

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
	
	#Invinsibility Flicker Animation
	$AnimatedSprite2D.visible = fmod($InvinsibilityTimer.time_left, 0.1) < 0.05
	
	move_and_slide()
	
	
	#Detect collisions
	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).get_collider()
		if collider.is_in_group("HurtPlayer"):
			hurt()
			break


func set_crop_count(x : int):
	crop_count = x
	%GUI/CropCount.text = str(crop_count) + "/" + str(lvl_crops_available)
	if crop_count == lvl_crops_available:
		await get_tree().create_timer(1.0).timeout
		%ui.next_lvl()

func hurt():

	if $InvinsibilityTimer.time_left == 0:
		if hearts > 0:
			hearts -= 1
		
		%GUI/Hearts.get_child(hearts).play("break")
		
		if hearts == 0:
			print("You lose")
			%ui.failed()
		
		$InvinsibilityTimer.start(1.0)
		

func _on_crop_pickup_area_body_entered(body):
	
	if body.collect():
		set_crop_count(crop_count + 1)


func _on_animated_sprite_2d_animation_finished():
	match $AnimatedSprite2D.animation:
		"flap":
			$AnimatedSprite2D.play("gliding")

