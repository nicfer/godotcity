extends Panel
onready var root = get_node("/root/Node")
onready var terrain = root.get_node("bg")
onready var money_node = get_node("money")
onready var hab_label = get_node("hab")
onready var homeless_label = get_node("homeless")
onready var unemp_label = get_node("unemp")
onready var date = get_node("date")
onready var tools = get_node("../tools")
onready var loan_up_button = get_node("loan_up")
onready var loan_down_button = get_node("loan_down")

var ticks = 0
var ticks_speeds = [10,30,60,100,150]
var tspeed_sel = 2
var can_incr_spd = true
var paused = false
var ticks_max = ticks_speeds[tspeed_sel]
var hour = 0
var hour_max = 24
var day = 0
var day_max = 30
var month = 0
var month_max = 12
var year = 0
var jobs = 0
var tset = preload("res://code/tilesets/tset.xml")

var credits = 0
var loan_taken = 0
var loan_max = 10
var loan_step = 1000
var whab = []

func new_hab(h=null):
	var hb = Root.get_class("Habitant").new_hab(h)
	add_child(hb)
	whab.append(hb)
	return hb

func _ready():
	for nh in range(2):
		new_hab()
	money_node.refresh()
	refresh_hab()
	set_fixed_process(true)

func refresh_hab():
	var thab = 0
	var unemp = 0
	var hless = 0
	for hic in get_tree().get_nodes_in_group("habitants"):
		thab += 1
		if hic.is_homeless():
			hless += 1
		elif hic.is_unemployed():
			unemp += 1
	hab_label.set_text(str(thab))
	homeless_label.set_text(str(hless))
	unemp_label.set_text(str(unemp))