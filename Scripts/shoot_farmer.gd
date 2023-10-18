extends CharacterBody2D


@onready var player = %Player
var bullet = preload("res://Scenes/bullet_farmer.tscn")

var start_pos
var speed = 40
var walk_speed = 60
var player_walkrange = false
var is_walking = false
var walk_distance = 400

var player_shootrange = false
var can_fire = true
var is_reloading = false

func _ready():
	start_pos = position

func _physics_process(delta):
	#walking
	if player_walkrange and is_reloading == false:
		is_walking = false
		$AnimatedSprite2D.play("walking")
		position.x += (player.position.x - position.x)/speed
	elif player_walkrange == false and is_reloading == false:
		if int(position.x) == start_pos.x or is_walking:
			#walk left walk right
			is_walking = true
			if position.x > start_pos.x + walk_distance:
				position.x -= 5
			if position.x < start_pos.x - walk_distance:
				position.x += 5
		else:
			position.x += (start_pos.x - position.x)/walk_speed 
			
	if player_shootrange:
		shooting()
	
#shooting
func shooting():
	if can_fire:
		#shot start
		can_fire = false
		shoot_bullet()
		$AnimatedSprite2D.play("walking")
		$AnimatedSprite2D2.play("gun")
		#shot end
		await get_tree().create_timer(3.0).timeout
		#reload start
		$AnimatedSprite2D2.play("no_gun")
		is_reloading = true
		$AnimatedSprite2D.play("reload")
		await get_tree().create_timer(1.0).timeout
		is_reloading = false
		can_fire = true
		#reload end

#Bullet
func shoot_bullet():
	print("Bullet shot")


#body
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
