extends Spatial

onready var rotx=find_node("rotx",true,false)
onready var roty=find_node("roty",true,false)
onready var player=find_node("KinematicPlayer",true,false)
onready var playerShape=find_node("ship",true,false)
onready var p3d=find_node("Position3D",true,false)
onready var PosRot=find_node("PosRot",true,false)


var up=Vector3(0,1,0)

var thrust=0.0
var speed_t=1.0
var direction=Vector3(0,0,0)
var direction_normal=Vector3(0,0,0)
var speed_x = 0.001
var speed_y = 0.001
var speed_z = 0.001
var normalizing = 0.01
#var dir = Vector3(1,1,0)

func _ready():
#    player.look_at($miss.get_translation(),Vector3(0,1,0))

     #player.look_at(p3d.get_translation(),up)
    pass

func _physics_process(delta):
    direction.y=0


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

    if Input.is_key_pressed(KEY_SHIFT):
        thrust += speed_t
    if Input.is_key_pressed(KEY_CONTROL):
        thrust -= speed_t

    var input_movement_vector = direction.normalized()
    var dir = Vector3()


    PosRot.rotate_object_local(Vector3(1,0,0),direction.y)
    PosRot.rotate_object_local(Vector3(0,1,0),-direction.x)
#    p3drot.rotate_object_local(Vector3(0,0,1),-direction.y)

    var ppltras=player.get_global_transform()
    var postras=p3d.get_global_transform()
    var pplvec= ppltras.origin
    var posvec= postras.origin
#
    var posdir=pplvec.direction_to(posvec)
#    var posdir_old=posdir
#
#    var posdis=pplvec.distance_to(posvec)

    if direction.x != 0 or direction.y!=0:
        pass

    player.rotate_object_local(Vector3(1,0,0),direction.y * 3)   # up down
    player.rotate_object_local(Vector3(0,0,1),-direction.x)  # destra sinistra

    player.move_and_slide(posdir * thrust,up)

    var afterPlayer=player.get_transform()
    var afterPosRot=PosRot.get_transform()
    player.set_transform(afterPlayer)
    afterPosRot.origin=afterPlayer.origin
    PosRot.set_transform(afterPosRot)

    player.force_update_transform()
    var afterp3d=p3d.get_global_transform()
    var afterPlayer2=player.get_global_transform()
    afterPlayer2=afterPlayer2.looking_at(afterp3d.origin,up)

    player.set_global_transform(afterPlayer2)




