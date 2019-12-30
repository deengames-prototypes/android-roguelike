extends Node

signal move_entity(entity, new_position)
signal spawn_entity(entity)
signal damage_entity(entity, damage)
signal entity_died(entity)

signal end_turn()
signal fov_change(fov)
signal change_entity(entity)
signal set_player(player_entity)

signal add_healthbar(healthbar)
signal remove_healthbar(healthbar)
signal activate_tile(tile)

# skills
signal bow_attack(source_entity, target)