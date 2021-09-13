extends Node2D

var Asteroid = preload("res://Entities/Asteroid/Asteroid.tscn")

onready var player := $Player

export var spawn_distance := 800

func _init() -> void:
	randomize()

func _ready() -> void:
	EventBus.connect("player_died", self, "_restart")
	
	var timer = get_tree().create_timer(0.5)
	yield(timer, "timeout")
	spawn_asteroid()
	
func _restart() -> void:
	var all_asteroids = get_tree().get_nodes_in_group("asteroids")
	for asteroid in all_asteroids:
		asteroid.queue_free()
		
	var timer = get_tree().create_timer(0.1)
	yield(timer, "timeout")
	get_tree().reload_current_scene()

func spawn_asteroid() -> void:
	var asteroid = Asteroid.instance()
	asteroid.position = player.position + Vector2(randf(), randf()).normalized() * spawn_distance
	get_tree().root.add_child(asteroid)
