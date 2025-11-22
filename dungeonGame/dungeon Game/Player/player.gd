extends CharacterBody2D

class_name Player

var type: Character = preload("res://Player/Characters/basic.tres")
var speed: int = type.speed
var health: float = type.health

var isDash: bool = false
var dashSpeed: int = 1000
var dashDirection: Vector2
var dashDuration: float = 0.2
var dashTimer: float
var dashCD: float

func _ready() -> void:
	print("Health: ", health)

func _physics_process(delta: float) -> void:
	var inputDirection = Input.get_vector("Left","Right","Up","Down")
	
	movement(inputDirection, delta)
	
	move_and_slide()

func movement(inputDirection: Vector2, delta: float):
	if isDash:
		position += dashDirection * dashSpeed * delta
		dashTimer -= delta
		
		if dashTimer <= 0.0:
			isDash = false
			dashCD = 4.0
	else:
		position += inputDirection * speed * delta
		dashCD -= delta
		
		if Input.is_action_just_pressed("Dash") and inputDirection != Vector2.ZERO and dashCD <= 0.0:
			dashDirection = inputDirection
			isDash = true
			dashTimer = dashDuration
