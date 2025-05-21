extends Node2D


func _on_death_zone_body_entered(body):
	if body is CharacterBody2D:
		await get_tree().create_timer(1.0).timeout  # Wait for 1 second
		get_tree().reload_current_scene()


func _on_end_body_entered(body: Node2D):
	if body is CharacterBody2D:
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://level2.tscn") 
