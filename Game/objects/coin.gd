extends Area2D

export var score := 10

func _on_coin_body_entered(body: Node) -> void:
    PlayerData.score = self.score
    $AnimationPlayer.play("fade_out")
