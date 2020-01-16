extends KinematicBody



var up=Vector3(0,1,0)

var thrust=0.0
var speed_t=3.0
var direction=Vector3(0,0,0)
var speed_x = 0.01
var speed_y = 0.01
var speed_z = 0.001
var normalizing = 0.01
#var dir = Vector3(1,1,0)

var angle =0

func _physics_process(delta):
#    direction.y=0
    direction=Vector3()
    set_as_toplevel(true)
    if Input.is_key_pressed(KEY_W):
        direction.y += speed_y
    if Input.is_key_pressed(KEY_S):
        direction.y -= speed_y
    if Input.is_key_pressed(KEY_A):
        direction.x -= speed_x
    if Input.is_key_pressed(KEY_D):
        direction.x += speed_x

    if Input.is_key_pressed(KEY_SHIFT):
        thrust += speed_t
    if Input.is_key_pressed(KEY_CONTROL):
        thrust -= speed_t

    if Input.is_key_pressed(KEY_SPACE):
        direction= Vector3()
        thrust =0

    var input_movement_vector = direction.normalized()
    var dir = Vector3()

    rotate_object_local(Vector3(1,0,0),direction.y)
#    rotate_object_local(Vector3(0,1,0),-direction.x)
    rotate_object_local(Vector3(0,0,1),-direction.x)

    var angle1 = get_rotation()
    angle = -angle1.z

    if thrust !=0:
        var t=get_transform()
        dir = -t.basis.z #+ Vector3(0,1,0) *  -direction.x * 300
#        if  angle < 0:
#            dir = Vector3(angle-dir.x,angle-dir.y,dir.z)
#        elif angle > 0:
#            dir = Vector3(angle-dir.x,angle-dir.y,dir.z)
        move_and_slide(dir * thrust ,Vector3(0, 0, 0))
##        if angle != 0:
#            force_update_transform()
#            dir = Vector3(5*thrust*angle*(1-dir.x),dir.y,dir.z)
#            move_and_slide( dir ,Vector3(0, 0, 0))

    orthonormalize()
    $Label.set_text("Angle:" + String(angle) + "\nAngle: " + String(angle1))
