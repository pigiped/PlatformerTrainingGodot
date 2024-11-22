extends Area2D

@export var jumpPower := -500

func _on_body_entered(body: Node2D) -> void:
	if(body.has_method("Jump")):
		body.Jump(jumpPower)
