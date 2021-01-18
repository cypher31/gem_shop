extends KinematicBody2D

#script for handling NPC actions

enum STATE {STATE_MOVE_LEFT, STATE_MOVE_RIGHT, STATE_MOVE_STRAIGHT, STATE_MOVE_BACK}

var direction : Vector2 = Vector2(0,-1)
var state = STATE.STATE_MOVE_STRAIGHT

const SPEED : float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	var timer_move = Timer.new()
	var timer_move_wait_time : float = 10.0 #seconds

	add_child(timer_move)

	timer_move.set_wait_time(timer_move_wait_time)

	timer_move.connect("timeout", self, "_NPC_change_dir")
	timer_move.start()
	pass # Replace with function body.

func _physics_process(delta):
	var collision = move_and_collide(SPEED * direction)
	
	if state == STATE.STATE_MOVE_LEFT:
		direction = Vector2(-1, 0)
	elif state == STATE.STATE_MOVE_RIGHT:
		direction = Vector2(1, 0)
	elif state == STATE.STATE_MOVE_STRAIGHT:
		direction = Vector2(0, -1)
	elif state == STATE.STATE_MOVE_BACK:
		direction = Vector2(0, 1)
	
	if collision:
		_NPC_change_dir()
	
	return


func _NPC_change_dir():
	var rand_dir = randi() % 4

	state = rand_dir
	return
