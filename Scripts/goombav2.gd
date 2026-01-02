extends Node2D
# NOTE: add a group check so it only changes direction when the right and left raycast
#find a wall/elevated ground and nothing else 
# NOTE:
# Raycasts intentionally ignore coins (Area2D)
# and platforms (AnimatableBody2D).
# Enemy logic assumes only solid ground is PhysicsBody2D / TileMap.

@export var speed:int = 60 

var direction:int = 1 

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_left_down: RayCast2D = $RayCastLeftDown
@onready var ray_cast_right_down: RayCast2D = $RayCastRightDown


# this function checks the surrounding of the goomba and if it finds something it cnanges direction
func _process(delta: float) -> void:
	# chesck if something is on the right and changes direction if it is 
	if direction == 1:
		var wall_hit:bool = ray_cast_right.is_colliding() 
		var no_ground:bool = !ray_cast_right_down.is_colliding()
		if wall_hit or no_ground:
			direction = -1
	elif direction == -1:
		var wall_hit:bool = ray_cast_left.is_colliding() 
		var no_ground:bool = !ray_cast_left_down.is_colliding()
		if wall_hit or no_ground:
			direction = 1
	
	# gives the dirction to the goomba
	position.x += direction * speed * delta
