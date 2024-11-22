extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var gravityDirection = 1
var slipness := false

func SlipperMove(inputAxis: float)->float:
	inputAxis = lerp(inputAxis, 0.0, 0.1)
	print("Slippin: " + str(inputAxis))
	return inputAxis
	

func changeGravity(gDirection: int) -> void:
	if(gravityDirection != gDirection):
		gravityDirection = gDirection
		set_up_direction(Vector2(0, -gDirection))
		self.rotate(deg_to_rad(180))
		collision_shape.rotate(deg_to_rad(180))
	
func Jump(jumpPower: float) -> void:
	velocity.y = jumpPower * gravityDirection

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * gravityDirection

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		Jump(JUMP_VELOCITY)
	
	# Handle input
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flippin sprite on given direction and gravity
	if(gravityDirection == 1):
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
	else:
		if direction > 0:
			animated_sprite.flip_h = true
		elif direction < 0:
			animated_sprite.flip_h = false
	
	#play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jumpin")
	
	if direction:
		velocity.x = direction * SPEED
	elif slipness:
		velocity.x = move_toward(velocity.x, 0, 1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


#func _on_tile_detector_body_entered(body: Node2D) -> void:
	#if body is TileMap:
		#print(body.get_cell_atlas_coords(1, body.get_coords_for_body_rid(body))
		#if(body.get_cell_atlas_coords(1, body.position) == Vector2i(6,2)):
		#	print("yeah")
