extends Camera2D

func _physics_process(delta):
	
	position.x += (%Player.position.x - position.x) / 20.0
