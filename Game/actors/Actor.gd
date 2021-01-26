extends KinematicBody2D

class_name Actor

###################################################

const FLOOR_NORMAL = Vector2.UP

export var gravity := 50.0
export var speed := Vector2(500.0, 1500.0)
var _velocity := Vector2.ZERO

###################################################
