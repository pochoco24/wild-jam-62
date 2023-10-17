extends CharacterBody2D

var speed = 40
var walk_speed = 60
var player_walkrange = false
@onready var player = %Player
var gravity = 2000
var start_pos

var player_shootrange = false
var can_fire = true
var is_reloading = false

func _ready():
	start_pos = position

func _physics_process(delta):
	#walking
	if player_walkrange and is_reloading == false:
		$AnimatedSprite2D.play("walking")
		position.x += (player.position.x - position.x)/speed
	elif player_walkrange == false and is_reloading:
		position += (start_pos - position)/walk_speed
	
	if player_shootrange:
		shooting()
	
#shooting
func shooting():
	if can_fire:
		$AnimatedSprite2D.play("walking")
		$AnimatedSprite2D2.play("gun")
		can_fire = false
		await get_tree().create_timer(3.0).timeout
		$AnimatedSprite2D2.play("no_gun")
		is_reloading = true
		$AnimatedSprite2D.play("reload")
		await get_tree().create_timer(1.0).timeout
		is_reloading = false
		can_fire = true


func _on_walk_body_entered(body):
	if body == player:
		player_walkrange = true

func _on_walk_body_exited(body):
	if body == player:
		player_walkrange = false


func _on_shoot_body_entered(body):
	if body == player:
		player_shootrange = true

func _on_shoot_body_exited(body):
	if body == player:
		player_shootrange = false
