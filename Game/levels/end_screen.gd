extends Control

func _ready() -> void:
    $result.text = "Your final score if %s. You die %s times." % [PlayerData.score, PlayerData.dead]
