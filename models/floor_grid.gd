extends Spatial

export var grid_from=Vector2()
export var grid_to=Vector2()

export var method_2_max_radius=10000

onready var GM=self


var MeshArray=[]
var MeshGrass=null

var pi2=2*PI
var tt
var tt1
var tt_x=0
var tt_y=0
var tt_z=0
var tt_r=1
var tt_angle=0
onready var tt_a_step_init=0.3
onready var tt_a_step = tt_a_step_init
onready var method_2_max_radius_step= 5
onready var method2_step=method_2_max_radius_step

var lab = null

func _ready():
    var randimax=0
    randomize()
    if has_node("Label"):
        lab = get_node("Label")
    MeshArray=GM.get_mesh_library().get_item_list()
 #    MeshGrass=MeshArray[0]
#    popola_std()
    popola_con_thread()


func _process(delta):
    if lab != null:
        lab.set_text("world radius: " + String(tt_r) + " FPS: " + String(Performance.get_monitor(Performance.TIME_FPS)))




func popola_std():
    var randimax=0
    for i in MeshArray:
     MeshGrass=i
     randimax+=1
     for xx in range (grid_from.x,grid_to.x):
         for yy in range (grid_from.y,grid_to.y):
            if (randi() % randimax) == 0:
                GM.set_cell_item(xx
                                ,cos(float(yy)*.08)*8.0+float(randimax)
                                ,yy
                                ,MeshGrass)

func popola_con_thread():
    tt=Thread.new()
    tt1=Thread.new()
    var esit= tt.start(self,"tt_popola","",0)
    pass

func tt_popola(inp):
  while tt_r < method_2_max_radius:
    var item=GM.get_cell_item(tt_x,tt_y,tt_z)
    if item == GM.INVALID_CELL_ITEM:
       for i in range(0,MeshArray.size()):
           if (randi() % (i * 2 + 1)) == 0:
              GM.set_cell_item(tt_x,tt_y + i,tt_z,i)
    else:
        tt_angle+=tt_a_step
        if tt_angle > (2*PI):
            tt_angle = 0
            tt_r += 1
            tt_a_step=tt_a_step_init / tt_r
            yield(get_tree().create_timer(0.0001), "timeout")
            method2_step -= 1
            if method2_step <=0:
               method2_step = method_2_max_radius_step
#               if tt != null and tt.is_active():
#                 tt1=Thread.new()
#                 tt1.start(self,"tt_popola","",0)
#                 tt.wait_to_finish()
#                 tt=null
#               else:
#                 tt=Thread.new()
#                 tt.start(self,"tt_popola","",0)
#                 tt1.wait_to_finish()
#                 tt1=null

#               return
        tt_x=cos(tt_angle)
        tt_z=sin(tt_angle)
        tt_y=cos( float(tt_r)*.15) * 5.0
        tt_x = tt_x * tt_r
        tt_z = tt_z * tt_r
        tt_null()

  prints(method_2_max_radius,"tiles placed")
  return

func tt_null():
    pass
