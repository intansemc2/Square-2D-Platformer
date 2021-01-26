extends Button



func _on_button_resume_game_button_up() -> void:
    PlayerData.score = 0
    
    self.get_tree().paused = false
    self.get_tree().reload_current_scene()

func _unhandled_input(event: InputEvent) -> void:
    if (event.is_action_pressed("quick_resume")):
        self._on_button_resume_game_button_up()
