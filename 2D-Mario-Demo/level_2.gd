extends Node2D

func _on_death_zone_body_entered(body):
	if body is CharacterBody2D:
		await get_tree().create_timer(1.0).timeout
		get_tree().reload_current_scene()


func _on_go_to_level_1_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("You finished Level 2!")
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://main.tscn")  # Go back to main
