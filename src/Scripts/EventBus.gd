extends Node

signal spawn_entity(entity)
signal change_entity(entity)
signal entity_died(entity)

signal move_entity(entity, new_position)
signal damage_entity(entity, damage)
signal damage_entity_modified(entity, damage)
signal stun_entity(entity, turns)

signal end_turn()
signal fov_change(fov)
signal set_player(player_entity)
signal switched_skill(entity, new_skill)

signal add_healthbar(healthbar)
signal remove_healthbar(healthbar)
signal activate_tile(tile)

signal create_explosion(target, damage, radius)

# skills
signal stun_pistol(source_entity, target)
signal rocket_launcher(source_entity, target)
signal lightning_cannon(source_entity, target)
signal energy_shield(entity)