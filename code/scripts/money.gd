extends Label
onready var loan_up_button = get_node("../loan_up")
onready var loan_down_button = get_node("../loan_down")

var credits = 0
var loan_taken = 0
var loan_max = 10
var loan_step = 1000

func refresh():
	set_text("$"+str(credits))
	if can_take_loan(): loan_up_button.set_modulate(Color(1,1,1,1))
	else: loan_up_button.set_modulate(Color(1,1,1,0.5))
	if can_pay_loan(): loan_down_button.set_modulate(Color(1,1,1,1))
	else: loan_down_button.set_modulate(Color(1,1,1,0.5))

func can_take_loan(): return loan_taken < loan_max

func can_pay_loan(): return credits >= loan_step and loan_taken > 0

func loan(l):
	credits += loan_step * l
	loan_taken += l
	refresh()

func loan_up():
	if can_take_loan():
		loan(1)

func loan_down():
	if can_pay_loan():
		loan(-1)

func has_enough_money(m):
	return credits >= m

func add_money(m):
	credits += m
	refresh()

func deduct_money(m,b=false):
	if has_enough_money(m) or b:
		add_money(-m)