extends CharacterBody2D

var speed = 30
var walk_speed = 60
var player_range = false
@onready var player = %Player
var gravity = 2000
var start_pos

func _ready():
	start_pos = position

func _physics_process(delta):
	if player_range:
		if not $sound_walking.is_playing(): 
			$sound_walking.play()
		$AnimatedSprite2D.play("walking")
		position += (player.position - position)/speed
	else:
		position += (start_pos - position)/walk_speed

	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

func _on_area_2d_body_entered(body):
	if body == player:
		player_range = true

func _on_area_2d_body_exited(body):
	if body == player:
		player_range = false
