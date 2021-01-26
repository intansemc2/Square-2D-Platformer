extends Control

var paused = false setget set_paused

var is_player_dead = false

func set_paused(value: bool) -> void:
    paused = value
    self.get_tree().paused = value
    $pause_overlay.visible = value
    
func _ready() -> void:
    $pause_overlay.visible = false
    
    PlayerData.connect("score_updated", self, "update_interface")
    PlayerData.connect("player_die", self, "player_die")
    
    update_interface()

func _unhandled_input(event: InputEvent) -> void:
    if (event.is_action_pressed("paused") and not self.is_player_dead):
        self.paused = not paused
        self.get_tree().set_input_as_handled()

func update_interface() -> void:
    $score.text = "Score: %s, Dead: %s" % [PlayerData.score, PlayerData.dead]
    
func player_die() -> void:
    self.paused = true 
    $pause_overlay/paused_title.text = "You died"
    
    self.is_player_dead = true
