extends Area2D

@onready var player = %Player

func _ready():
	look_at(player.position)
	
func _physics_process(delta):
	position = global_position
	



