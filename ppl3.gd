extends Spatial


onready var player=find_node("KinematicPlayer",true,false)
onready var camera=find_node("CamPlayer",true,false)
onready var LabelAngle=find_node("LabelAngle",true,false)

var up=Vector3(0,1,0)

var thrust=0.0
var speed_t=3.0
var direction=Vector3(0,0,0)
var speed_x = 0.03
var speed_y = 0.01
var speed_z = 0.003
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

    player.rotate_object_local(Vector3(1,0,0),direction.y)
#   player.rotate_object_local(Vector3(0,1,0),-direction.x)
    player.rotate_object_local(Vector3(0,0,1),-direction.x)

    var angle1 = player.get_rotation()
    angle = -angle1.z

    if thrust !=0:
        var t=player.get_transform()
        dir = -t.basis.z
        var vel=player.move_and_slide(dir * thrust ,Vector3(0, 0, 0))
        var camtrans=camera.get_transform().translated(vel*delta)
        camera.set_transform(camtrans)
    orthonormalize()
    LabelAngle.set_text("Angle:" + String(angle)
                        + "\nAngle: " + String(angle1)
                        + "\nThrust: " + String(thrust))
