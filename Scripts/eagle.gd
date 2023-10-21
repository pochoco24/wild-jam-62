extends Area2D

@onready var player = %Player
var in_range = false
var speed = 350
var slow_speed = 800
var start_pos

func _ready():
	start_pos = position

func _physics_process(delta):
	if in_range:
		look_at(player.position)
		position = position.move_toward(player.position, speed * delta)
		var direction_to_player = player.position - position
		$AnimatedSprite2D.flip_v = direction_to_player.x < 0
	else:
		position += (start_pos - position)/slow_speed
	

func _on_body_entered(body):
	if body == $"../Player":
		$"../Player".hurt()
		queue_free()

func _on_range_body_entered(body):
	if body == player:
		in_range = true


func _on_range_body_exited(body):
	if body == player:
		in_range = false
