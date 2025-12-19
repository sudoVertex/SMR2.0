extends CharacterBody2D

@export var SPEED :int = 150
@export var JUMP_FORCE :int =  1100
@export var GRAVITY :int = 1500
@export var AnSprite :AnimatedSprite2D
@export var JumpSFX: AudioStreamPlayer2D

func _physics_process(delta: float) -> void:
	
	
	var direction = Input.get_axis("Left", "Right")
	
	if direction !=0:
		velocity.x = direction * SPEED
		
		#if is_on_floor():
			#$AnSprite.play("Run")
	else:
		velocity.x = 0
		
		#if is_on_floor():
			#$AnSprite.play("Idle")
	
	#Rotate
	#if direction == 1:
		#$AnSprite.flip_h =false
	#elif direction == -1:
		#$AnSprite.flip_h =true
	
	#Gravity
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		#if velocity.y > 0:
			#$AnSprite.play("Fall")
	
	#Jump
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y -= JUMP_FORCE
		JumpSFX.play()
		
		#$AnSprite.play("Jump")
	
	if Input.is_action_just_released("Jump") and velocity.y <0:
		velocity.y *= 0.3
		
	move_and_slide()
