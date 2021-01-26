extends Node

signal score_updated
signal player_die

var score := 0 setget set_score
var dead := 0 setget set_dead

func reset():
    self.score = 0
    self.dead = 0

func set_score(value: int) -> void:
    score += value
    
    if (score < 0):
        score = 0
    
    emit_signal("score_updated")

func set_dead(value: int) -> void:
    dead += value
    
    if (dead < 0):
        dead = 0
        
    emit_signal("player_die")
