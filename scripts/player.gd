extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const SPRINT_MULT = 1.5

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("left", "right")
	# Sprite changes
	if abs(velocity.x) > 1:
		animated_sprite_2d.animation = "walk"
	else:
		animated_sprite_2d.animation = "idle"
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_pressed("sprint"):
		velocity *= SPRINT_MULT

	move_and_slide()
	
	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1.0:
		animated_sprite_2d.flip_h = true
