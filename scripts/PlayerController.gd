extends CharacterBody2D


@export var SPEED: float
@export var JUMP_VELOCITY: float
@export var GRAV_MULT: float
@export var SQUISH_TIME: float
@export var SQUISH: float
@export var COYOTE_TIME: float


@onready var sprite: Sprite2D = $Sprite2D
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var leftward_running_particles: CPUParticles2D = $LeftwardRunningParticles
@onready var rightward_running_particles: CPUParticles2D = $RightwardRunningParticles
@onready var jump_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

var original_jump_pitch: float
var jumping: bool = false
var original_scale: Vector2
var in_coyote_time: bool = false

func _ready() -> void:
	original_scale = sprite.scale
	original_jump_pitch = jump_sound.pitch_scale

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		stop_particles()
		velocity += get_gravity() * delta * GRAV_MULT
		if jumping:
			sprite.scale = sprite.scale.lerp(original_scale, delta / SQUISH_TIME)
		elif !in_coyote_time:
			print("COYOTE TIMER STARTED")
			coyote_timer.start()
			in_coyote_time = true
	else:
		if jumping:
			jumping = false
			sprite.scale = original_scale
		coyote_timer.stop()
		in_coyote_time = false

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or !coyote_timer.is_stopped():
			jump_sound.pitch_scale = original_jump_pitch + randf_range(-0.2, 0.3)
			jump_sound.play()
			velocity.y = JUMP_VELOCITY
			var squished = Vector2(original_scale.x * (1 - SQUISH), original_scale.y * (1 + SQUISH))
			sprite.scale = squished
			jumping = true
			coyote_timer.stop()
			in_coyote_time = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		if is_on_floor():
			if direction < 0:
				leftward_running_particles.emitting = true
			if direction > 0:
				rightward_running_particles.emitting = true
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		stop_particles()

	move_and_slide()
	
func stop_particles() -> void:
	leftward_running_particles.emitting = false
	rightward_running_particles.emitting = false
