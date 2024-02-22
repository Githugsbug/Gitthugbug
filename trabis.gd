extends CharacterBody2D

@onready var magnet_stuff = $Magnet/CPUParticles2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0	
const JUMP_HORIZONTAL = 600

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 980

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta


	# Jump Func
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity += Vector2(JUMP_HORIZONTAL,JUMP_VELOCITY)


	#left and right movement
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = lerp(velocity.x, direction * SPEED, .3)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	#character flip
	if get_global_mouse_position().x >= position.x:
		pass
	$Magnet.rotation = atan2(get_global_mouse_position().y - global_position.y, get_global_mouse_position().x - global_position.x)
	move_and_slide()


	#Particles
	if Input.is_action_pressed("repel"):
		magnet_stuff.emitting = true
	else: magnet_stuff.emitting = false


