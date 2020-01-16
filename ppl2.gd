extends Spatial

onready var rotx=find_node("rotx",true,false)
onready var roty=find_node("roty",true,false)
onready var player=find_node("KinematicPlayer",true,false)
onready var playerShape=find_node("ship",true,false)
onready var p3d=find_node("Position3D",true,false)
onready var PosRot=find_node("PosRot",true,false)
onready var rx=find_node("RX",true,false)
onready var ry=find_node("RY",true,false)
onready var camera=null
onready var camera1=get_tree().get_root().find_node("Camera*",true,false)
onready var camera2=find_node("Camera2",true,false)
var camera_already_changed=false

var up=Vector3(0,1,0)


# metodo 1
var thrust=0.0
var speed_t=3.0
var direction=Vector3(0,0,0)
var rotat=Vector3(0,0,0)
var speed_x = 0.01
var speed_y = 0.01
var speed_z = 0.001
var normalizing = 0.01

# metodo 2
var velocity=Vector3()
var gravity = -9.8

var SPEED = 6
var ACCELLERATION = 3
var DE_ACCELLERATION = 5
var camera_tras
#var dir = Vector3(1,1,0)

var angle =Vector3(0,0,1)

func _ready():

    change_cam()


func _physics_process(delta):
    if Input.is_key_pressed(KEY_TAB):
        change_cam()
    else:
        camera_already_changed=false
    metodo_1()

func metodo_2(delta):
    direction=Vector3()

    if Input.is_key_pressed(KEY_W):
        direction += -camera_tras.basis[2]
    if Input.is_key_pressed(KEY_S):
        direction +=  camera_tras.basis[2]
    if Input.is_key_pressed(KEY_A):
        direction += -camera_tras.basis[0]
    if Input.is_key_pressed(KEY_D):
        direction +=  camera_tras.basis[0]
    if Input.is_key_pressed(KEY_SPACE):
        direction= Vector3()
        thrust = 0
    if Input.is_key_pressed(KEY_SHIFT):
        thrust += speed_t
    if Input.is_key_pressed(KEY_CONTROL):
        thrust -= speed_t


    direction=direction.normalized()
    velocity.y=delta * gravity

    var hv = velocity
    hv.y = 0

    var new_pos = direction * SPEED
    var accel = DE_ACCELLERATION

    if direction.dot(hv) > 0:
        accel = ACCELLERATION

    hv = hv.linear_interpolate(new_pos, accel * delta)

    velocity.x = hv.x
    velocity.z = hv.z

    velocity = player.move_and_slide(velocity,up)



func get_input_std():
    if Input.is_key_pressed(KEY_W):
        direction.y += speed_y
    if Input.is_key_pressed(KEY_S):
        direction.y -= speed_y
    if Input.is_key_pressed(KEY_A):
        direction.x -= speed_x
    if Input.is_key_pressed(KEY_D):
        direction.x += speed_x
    if Input.is_key_pressed(KEY_SPACE):
        direction= Vector3()
        thrust = 0

    if Input.is_key_pressed(KEY_SHIFT):
        thrust += speed_t
    if Input.is_key_pressed(KEY_CONTROL):
        thrust -= speed_t

    rotat = direction

func get_input_alt():
    if Input.is_key_pressed(KEY_W):
        rotat.y     += speed_y
    if Input.is_key_pressed(KEY_S):
        rotat.y     -= speed_y
    if Input.is_key_pressed(KEY_Q):
        rotat.x     -= speed_x
    if Input.is_key_pressed(KEY_E):
        rotat.x     += speed_x
    if Input.is_key_pressed(KEY_SPACE):
        direction= Vector3()
        rotat    = Vector3()
        thrust = 0

    if Input.is_key_pressed(KEY_A):
        direction.x -= speed_x
        rotat.x     -= speed_x
    if Input.is_key_pressed(KEY_D):
        direction.x += speed_x
        rotat.x     += speed_x

    if Input.is_key_pressed(KEY_SHIFT):
        thrust += speed_t
    if Input.is_key_pressed(KEY_CONTROL):
        thrust -= speed_t




func metodo_1():
    direction=Vector3()
    rotat=Vector3()
    get_input_alt()

    var dir = Vector3()

    player.rotate_object_local(Vector3(1,0,0),rotat.y)
    player.rotate_object_local(Vector3(0,1,0),-rotat.x)
    player.rotate_object_local(Vector3(0,0,1),(-rotat.x  + direction.x) * 1)

    var t=player.get_transform()

    dir = -t.basis.z - direction
#    var inclinaz_z=(Vector3(-t.basis.x.y,0,0))
    var inclinaz_z=(Vector3(direction.x,0,0))
    var forza_gravita=Vector3(0,gravity/10,0)

    var dir_finale = forza_gravita + (dir + inclinaz_z) * thrust

    player.move_and_slide( dir_finale  ,Vector3(0, 0, 0))


func change_cam():
    if camera_already_changed:
        return
    if camera == camera1:
        camera = camera2
    elif camera == camera2:
        camera = camera1
    else:
        camera = camera1

    camera.make_current()
    camera_tras = camera.get_global_transform()
    camera_already_changed=true
