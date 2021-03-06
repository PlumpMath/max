extends KinematicBody2D

var PetState

var Sprite
var Timer

export var speed = 50
var new_direction = Vector2(0, 0)

func _ready():
	set_process(true)
	set_fixed_process(true)

	PetState = get_node("/root/PetState")

	# Initialize Sprite
	Sprite = get_node("Sprite")
	Sprite.set_texture(load(get_texture(PetState.get_evolution())))
	Sprite.set_hframes(2)

	# Random Pet Movement
	Timer = get_node("Timer")
	Timer.connect("timeout", self, "set_direction")

func _process(delta):
	# Check If Fully Evolved & Don't Run If So!
	Sprite.set_texture(load(get_texture(PetState.get_evolution())))

func _fixed_process(delta):
	# Prevent Movement If Pet Is Dead
	if (PetState.get_evolution() == 0):
		return

	var motion
	var direction = Vector2(0, 0)

	direction += new_direction

	motion = direction.normalized() * speed * delta
	motion = move(motion)

func set_direction():
	new_direction = Vector2(range(-1, 2)[randi() % 3], 0)

func get_texture(evolution):
	if (evolution == 0):
		return "res://Sprites/pet-dead.png"
	elif (evolution == 1):
		return "res://Sprites/pet-infant.png"
	elif (evolution == 2):
		return "res://Sprites/pet-child.png"
	elif (evolution == 3):
		return "res://Sprites/pet-adolescent.png"
	elif (evolution == 4):
		return "res://Sprites/pet-adult-one.png"
	elif (evolution == 5):
		return "res://Sprites/pet-adult-two.png"
	elif (evolution == 6):
		return "res://Sprites/pet-isaac.png"
	else:
		return "res://Sprites/pet-infant.png"
