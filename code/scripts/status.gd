extends Panel
onready var money_node = get_node("money")
onready var date = get_node("date")
onready var buttons = get_node("buttons")
onready var loan_up_button = get_node("loan_up")
onready var loan_down_button = get_node("loan_down")

var ticks = 0
var ticks_max = 60
var hour = 0
var hour_max = 24
var day = 0
var day_max = 30
var month = 0
var month_max = 12
var year = 0
var tset = preload("res://code/tilesets/tset.xml")

var credits = 0
var loan_taken = 0
var loan_max = 10000
var loan_step = 1000

var tools = {\
		"place":{\
			0:-1,\
			1:13,\
			2:1,\
			3:16,\
			4:14\
		}\
	}

func _ready():
	refresh_loan_buttons()
	set_fixed_process(true)
#	for t in tools.textures:
#		tools.textures[t].set_size_override(Vector2(16,16))
#		buttons.add_icon_button(tools.textures[t])

func get_tool():
	return tools.place[buttons.get_selected()]

func next_hour():
	ticks -= ticks_max
	hour += 1
	if hour < hour_max: return
	hour -= hour_max
	day += 1
	if day < day_max: return
	day -= day_max
	month += 1
	if month < month_max: return
	month -= month_max
	year += 1

func refresh_date():
	var td = str(year) + "/"
	if month < 10: td += "0"
	td += str(month) + "/"
	if day < 10: td += "0"
	td += str(day) + ":"
	if hour < 10: td += "0"
	td += str(hour)
	date.set_text(td)

func _fixed_process(d):
	ticks += 1
	if ticks >= ticks_max:
		next_hour()
		refresh_date()

func can_take_loan(): return loan_taken <= loan_max-loan_step

func can_pay_loan(): return credits >= loan_step and loan_taken >= loan_step

func refresh_loan_buttons():
	if can_take_loan(): loan_up_button.set_modulate(Color(1,1,1,1))
	else: loan_up_button.set_modulate(Color(1,1,1,0.5))
	if can_pay_loan(): loan_down_button.set_modulate(Color(1,1,1,1))
	else: loan_down_button.set_modulate(Color(1,1,1,0.5))

func _loan_up():
	if can_take_loan():
		credits += loan_step
		loan_taken += loan_step
		money_node.set_text("$"+str(credits))
		refresh_loan_buttons()

func _loan_down():
	if can_pay_loan():
		credits -= loan_step
		loan_taken -= loan_step
		money_node.set_text("$"+str(credits))
		refresh_loan_buttons()