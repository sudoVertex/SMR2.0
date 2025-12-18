extends Area2D

@onready var game_manager:Node = GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		game_manager.add_coins()
		print("youve collected " +str(game_manager.coins_collected) + " coins")
		animation_player.play("Coin")

func remove_visibility():
	collision_shape_2d.disabled = true
	visible = false
	await get_tree().create_timer(1.0, true).timeout
	queue_free()
