extends Area2D

const SPEED = 300.0/60.0

func _physics_process(delta):
	position += Vector2(cos(rotation), sin(rotation)) * SPEED


func _on_body_entered(body):
	if body == $"../Player":
		$"../Player".hurt()
		queue_free()


func _on_despawn_time_timeout():
	queue_free()
