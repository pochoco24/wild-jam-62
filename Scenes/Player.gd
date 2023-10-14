extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var crop_count = 0
var lvl_crops_available = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("flap"):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func set_crop_count(x : int):
	crop_count = x
	%GUI/CropCount.text = str(crop_count) + "/" + str(lvl_crops_available)


func _on_crop_pickup_area_body_entered(body):
	set_crop_count(crop_count + 1)
	body.queue_free()
