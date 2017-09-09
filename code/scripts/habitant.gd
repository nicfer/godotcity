#extends Node

func new_hab(b):
	var nh = Habitant.new()
	nh.set_born(b)
	return nh

class Habitant extends Node:
	var home
	var born_in
	var work
	var mudating = false

	func set_born(b):
		born_in = b
		add_to_group("habitants")

	func is_homeless(): return home == null

	func is_unemployed(): return work == null

	func set_home(h):
		if mudating:
			home.leave(self)
			set_mudating(false)
		home = h

	func set_work(w): work = w

	func set_mudating(b): mudating = b

	func is_mudating(): return mudating

	func needs_home(): return is_homeless() or is_mudating()