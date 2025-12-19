extends AnimatableBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var is_on_platform:bool = false
var cooldown:bool = true

func _process(delta: float) -> void:
	#if drop is pressed and the player is on the platform it runs the drop function
	if Input.is_action_just_pressed("down") and is_on_platform:
		drop()

func drop():
	# verifies that the drop function hasnt been aready pressed
	if cooldown:
		#disables the function
		cooldown = false
		# it disables and reanables the colison so the players falls through
		collision_shape_2d.disabled = true
		await get_tree().create_timer(0.5).timeout
		collision_shape_2d.disabled = false
		await get_tree().create_timer(0.5).timeout
		#re-enables the function
		cooldown = true


# it checks if the player is on the platform and assigns a true or fails value accordingly 
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_on_platform = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_on_platform = false
