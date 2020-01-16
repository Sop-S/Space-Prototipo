extends Camera

var up=Vector3(0,0,0)

var speed_t=1.0
var direction=Vector3(0,0,0)
var direction_normal=Vector3(0,0,0)
var speed_x = 0.001
var speed_y = 0.001
var speed_z = 1
var speed=Vector3()
var rotate=Vector3()

func _input(event):

	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index==BUTTON_WHEEL_UP:
				speed.z-=speed_z * 3
			if event.button_index==BUTTON_WHEEL_DOWN:
				speed.z+=speed_z * 3


func _physics_process(delta):
	var bb =Input.get_mouse_button_mask()
	if  bb == BUTTON_LEFT:
		var speedv = Input.get_last_mouse_speed()
		speed.x=speedv.x * -speed_x
		speed.y=speedv.y * -speed_y
	if  bb == BUTTON_RIGHT:
		var speedv = Input.get_last_mouse_speed()
		speed.x=speedv.x * -speed_x
		speed.y=speedv.y * -speed_y

	var trans=get_transform().translated(speed)
	set_transform(trans)

	speed=Vector3()
	rotate=Vector3()


