extends Area2D

@onready var game_manager: Node = %GameManager #da sostituire con un signal
@onready var animation_player: AnimationPlayer = $PickupSound/AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point()
	animation_player.play("pickup")
