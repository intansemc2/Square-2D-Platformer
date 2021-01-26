extends Actor

###################################################
export var smash_peek := 1000.0

export var is_allow_air_control := false
export var is_allow_jump_interrupted := false

var _direction = Vector2.ZERO


###################################################
func _init() -> void:
    self.speed.x = 900.0


###################################################
func _on_enemy_detecter_area_entered(area: Area2D) -> void:
    self._velocity = self.calculate_smash_velocity(self._velocity, self.smash_peek)


func _on_enemy_detecter_body_entered(body: Node) -> void:
    self.die()
    
func _on_kill_zone_check_area_entered(area: Area2D) -> void:
    self.die()


###################################################
func get_direction() -> Vector2:
    var strength_move_x = (
        Input.get_action_strength("move_right")
        - Input.get_action_strength("move_left")
    )

    if self.is_allow_air_control == false:
        if self.is_on_floor() == false:
            strength_move_x = self._direction.x

    var vertical_direction = 1.0
    if Input.is_action_just_pressed("jump") and self.is_on_floor():
        vertical_direction = -1.0

    var direction = Vector2(strength_move_x, vertical_direction)
    return direction


func calculate_move_velocity(
    linear_velocity: Vector2, speed: Vector2, direction: Vector2, is_jump_interrupted: bool
) -> Vector2:
    var new_velocity = linear_velocity
    new_velocity.x = speed.x * direction.x
    new_velocity.y += self.gravity

    if direction.y == -1.0:
        new_velocity.y = speed.y * direction.y
    
    if (is_allow_jump_interrupted):
        if is_jump_interrupted:
            new_velocity.y = 0

    return new_velocity


func calculate_smash_velocity(linear_velocity: Vector2, smash_peek: float) -> Vector2:
    var new_velocity = linear_velocity

    new_velocity.y = -smash_peek

    return new_velocity

func die():
    PlayerData.dead = 1

###################################################
func _physics_process(delta: float) -> void:
    var is_jump_interrupted = Input.is_action_just_released("jump")

    self._direction = self.get_direction()
    self._velocity = self.calculate_move_velocity(
        self._velocity, self.speed, self._direction, is_jump_interrupted
    )
    self._velocity = self.move_and_slide(self._velocity, self.FLOOR_NORMAL)
