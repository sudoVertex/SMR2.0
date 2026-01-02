extends Node

signal level_done(value:bool)


var coins_collected:int = 0

func add_coins():
	coins_collected += 1

func  reset_points():
	coins_collected= 0
