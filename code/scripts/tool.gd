extends TextureButton
onready var root = get_node("/root/Node")
onready var terrain = root.get_node("bg")
onready var tools = get_node("..")
onready var bg = get_node("Panel")
onready var script = get_node("class")

func get_cost(): return script.cost

func on_click(pm):
	return script.on_click(pm)

func set_selected(b):
	bg.get_material().set_shader_param("md",0.75*int(b))

func _ready():
	connect("pressed",tools,"set_selected",[get_name()])