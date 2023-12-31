extends CharacterBody2D


@onready var player = %Player
var bullet = preload("res://Scenes/bullet.tscn")

var start_pos
var speed = 50
var walk_speed = 80
var player_walkrange = false
var is_walking = false
var walking_right = false
var walking_distance = 300

var player_shootrange = false
var can_fire = true
var is_reloading = false

func _ready():
	start_pos = position

func _physics_process(delta):
	if player_walkrange and is_reloading == false:
		walk_to_player()
	elif player_walkrange == false and is_reloading == false:
		# startpos +/-1 because it wouldn't work without it
		if int(position.x) == start_pos.x or int(position.x) == start_pos.x + 1 or int(position.x) == start_pos.x -1 or is_walking == true:
			walk_leftandright()
		else:
			walk_to_start()
			
	if player_shootrange:
		shooting()

# walking
# to player
func walk_to_player():
	is_walking = false
	var direction_to_player = player.position - position
	position.x += direction_to_player.x / speed
	
	#aim gun
	
	$SpriteFarmer.play("walking")
	
# to start
func walk_to_start():
	position.x += (start_pos.x + 1 - position.x)/walk_speed
	$SpriteFarmer.play("walking")
	
# left and right
func walk_leftandright():
	is_walking = true
	if int(position.x) > start_pos.x + walking_distance:
		walking_right = false
	if int(position.x) < start_pos.x - walking_distance:
		walking_right = true
	if walking_right:
		walk_right()
	else:
		walk_left()
	$SpriteFarmer.play("walking")

func walk_right():
	position.x += 1
	
func walk_left():
	position.x -= 1
	

# shooting
func shooting():
	var direction_to_player = player.position - position
	$GunPivotPoint.rotation = direction_to_player.angle()
	$SpriteFarmer.flip_h = direction_to_player.x < 0
	$GunPivotPoint.scale.y = -3 if direction_to_player.x < 0 else 3
	if can_fire:
		#shot start
		can_fire = false
		$SpriteFarmer.play("walking")
		$GunPivotPoint/SpriteGun.play("gun")
		$sound_grunt.play()
		shoot_bullet()
		#shot end
		await get_tree().create_timer(2.0).timeout
		#reload start
		$GunPivotPoint/SpriteGun.play("no_gun")
		is_reloading = true
		$SpriteFarmer.play("reload")
		await get_tree().create_timer(1.0).timeout
		is_reloading = false
		can_fire = true
		#reload end

# Bullet
func shoot_bullet():
	$sound_shoot.play()
	var bullet_instance = bullet.instantiate().duplicate()
	bullet_instance.position = position
	bullet_instance.rotation = $GunPivotPoint.rotation
	$"..".add_child(bullet_instance)


# body
func _on_walk_body_entered(body):
	if body == player:
		player_walkrange = true

func _on_walk_body_exited(body):
	if body == player:
		player_walkrange = false


func _on_shoot_body_entered(body):
	if body == player:
		player_shootrange = true
		$sound_mumble.play()

func _on_shoot_body_exited(body):
	if body == player:
		player_shootrange = false
