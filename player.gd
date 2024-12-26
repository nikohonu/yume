extends CharacterBody2D

@export var speed = 300

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()

func get_input():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
