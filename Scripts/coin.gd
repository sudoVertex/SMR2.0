extends Area2D

@onready var game_manager:Node = GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_body_entered(body: Node2D) -> void:
	# checks if the body is player
	if body.is_in_group("Player"):
		
		#adds +1 coin
		game_manager.add_coins()
		
		animation_player.play("Coin")

func remove_visibility():
	#temporarily "reoves" the coins
	collision_shape_2d.disabled = true
	visible = false
	# waits for the sound to finish and deletes the coint from the game
	await get_tree().create_timer(1.0, true).timeout
	queue_free()
