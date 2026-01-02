extends Area2D

var level_completed: bool = false 
@onready var pipe: AudioStreamPlayer = $Pipe
var is_on_platform:bool = false
var cooldown:bool = true
@export var cooldown_duration:float = 1.
var player:CharacterBody2D
var player_collision:CollisionShape2D

# it checks if the player is on top of the platform and assigns a true or fails value accordingly 
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body.global_position.y < global_position.y:
		is_on_platform = true
		player = body
		player_collision = body.get_node("CollisionShape2D")

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_on_platform = false
	is_on_platform = false


func _physics_process(_delta: float) -> void:
	#if drop is pressed and the player is on the platform it runs the drop function
	if Input.is_action_just_pressed("down") and is_on_platform:
		drop()


func drop():
	# verifies that the drop function hasnt been aready pressed
	if cooldown:
		#disables the function
		cooldown = false
		
		# it disables the colison so the players falls through and makes him go in the background
		player.z_index = -1
		player_collision.disabled = true
		await get_tree().create_timer(cooldown_duration).timeout
		
		#play the pipe sound
		pipe.play()
		
		#Make the win mesege and score visible 
		level_completed = true
		GameManager.level_done.emit(level_completed)
		
		# Freeze the game
		get_tree().paused = true
		
		# Wait for a few seconds (timer, process_always)
		await get_tree().create_timer(2.0, true).timeout
	
		# Unpause before reloading
		get_tree().paused = false
		
		# Reset the coins (temporary for testing)
		GameManager.reset_points()
		
		# Reload the scene
		get_tree().reload_current_scene()
