extends Area2D

@onready var death_sound: AudioStreamPlayer = $DeathSound

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		
		death_sound.play()
		
		# Freeze the game
		get_tree().paused = true
		
		# Wait for a few seconds (timer, process_always)
		await get_tree().create_timer(4.0, true).timeout
	
		# Unpause before reloading
		get_tree().paused = false
		
		# Reload the scene
		get_tree().reload_current_scene()
	
