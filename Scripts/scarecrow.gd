extends CharacterBody2D

var speed = 30
var walk_speed = 60
var player_range = false
var player = null
var gravity = 2000
var start_pos

func _ready():
	start_pos = position

func _physics_process(delta):
	if player_range:
		$AnimatedSprite2D.play("walking")
		position += (player.position - position)/speed
	else:
		position += (start_pos - position)/walk_speed
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()

func _on_detection_area_body_entered(body):
	player = body
	player_range = true


func _on_detection_area_body_exited(body):
	player = null
	player_range = false
