extends Button

export (String, FILE) var next_scene_name: = ''



func _on_button_change_scene_button_up() -> void:
    self.get_tree().change_scene(self.next_scene_name)
