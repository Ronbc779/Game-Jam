extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

const SPEED = 300.0
const SPRINT_MULT = 1.5

# Audio containers
@export var sfx_footsteps : AudioStreamRandomizer
# Set foot hit frames relative to spritesheet 
var footstep_frames : Array = [3,9] # TO EDIT WITH LEI'S SPRITE

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("left", "right")	
	# Sprite changes
	if abs(velocity.x) > 1:
		animated_sprite_2d.sprite_frames.set_animation_speed("walk", 10)
		animated_sprite_2d.animation = "walk"
	else:
		animated_sprite_2d.animation = "idle"
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_pressed("sprint"):
		animated_sprite_2d.sprite_frames.set_animation_speed("walk", 15)
		velocity *= SPRINT_MULT

	move_and_slide()
	
	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1.0:
		animated_sprite_2d.flip_h = true
		
# Audio handling
func load_sfx(sfx_to_load):
	if sfx_player.stream != sfx_to_load:
		sfx_player.stop()
		sfx_player.stream = sfx_to_load

# Footsteps randomizer 
func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite_2d.animation == "idle": return 
	load_sfx(sfx_footsteps)
	if animated_sprite_2d.frame in footstep_frames: sfx_player.play()
