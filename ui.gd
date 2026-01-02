extends CanvasLayer

@onready var you_won: Label = $"You won"
@onready var score: Label = $Score


func _ready() -> void:
	GameManager.level_done.connect(level_done)



func level_done(completed:bool):
	if completed:
		you_won.visible = true
		score.visible = true
		score.text = "Your score is" + str(GameManager.coins_collected)
