extends Button

@onready var score = 0

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		$"../../../Timer".start(0.069)


func _on_timer_timeout() -> void:
	if not score == Global.data:
		add_score(Global.data)


func add_score(amount):
	if score < amount:
		score += 1
		if score < amount:
			$"../../../Timer".start(0.042)
	elif score > amount:
		score -= 1
		if score > amount:
			$"../../../Timer".start(0.01)
	self.text = var_to_str(score)
