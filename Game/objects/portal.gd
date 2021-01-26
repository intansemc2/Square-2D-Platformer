tool
extends Area2D

###################################################
export (String, FILE) var next_scene_name := ''


###################################################
func _get_configuration_warning() -> String:
    if not self.next_scene_name:
        return "The next scene name property can't be empty"
    return ""

###################################################
 
func _on_portal_body_entered(body: Node) -> void:
    self.teleport()

###################################################

func teleport():
    $AnimationPlayer.play("fade_in")
    yield($AnimationPlayer, "animation_finished")
    self.get_tree().change_scene(self.next_scene_name)



