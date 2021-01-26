extends Actor

export var score := 20

###################################################
func _ready() -> void:
    self.set_physics_process(false)
    self._velocity.x = -self.speed.x
    $Enemy.play("normal")


###################################################


func _on_smash_detactor_body_entered(body: PhysicsBody2D) -> void:
    if body.global_position.y <= $smash_detactor.global_position.y:
        # Disable collision with player 
        self.set_collision_mask_bit(0, false)
        self.set_collision_layer_bit(1, false)

        # Disable detector 
        $smash_detactor.set_collision_mask_bit(0, false)
        $smash_detactor.set_collision_mask_bit(1, false)
        $smash_detactor.get_node("CollisionShape2D").disabled = true

        # Stop 
        self._velocity.x = 0

        # Change animation to dead 
        $Enemy.play("dead")
        $Timer.start()


func _on_smash_detactor_area_entered(area: Area2D) -> void:
    $smash_detactor.set_collision_mask_bit(4, false)
    $smash_detactor.set_collision_layer_bit(4, false)


func _on_Timer_timeout() -> void:
    PlayerData.score = self.score
    self.queue_free()


###################################################


func _physics_process(delta: float) -> void:
    self._velocity.y += self.gravity

    if self.is_on_wall():
        self._velocity *= -1.0

    self._velocity.y = self.move_and_slide(self._velocity, self.FLOOR_NORMAL).y

###################################################
