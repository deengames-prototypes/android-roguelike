const Entity = preload("res://Ecs/Core/Entity.gd")

const MeleeComponent = preload("res://Ecs/Components/MeleeComponent.gd")
const CameraFollowComponent = preload("res://Ecs/Components/CameraFollowComponent.gd")
const ChasePlayerComponent = preload("res://Ecs/Components/ChasePlayerComponent.gd")
const HealthComponent = preload("res://Ecs/Components/HealthComponent.gd")
const PlayerControlComponent = preload("res://Ecs/Components/PlayerControlComponent.gd")
const SightComponent = preload("res://Ecs/Components/SightComponent.gd")
const SpriteComponent = preload("res://Ecs/Components/SpriteComponent.gd")
const SkillComponent = preload("res://Ecs/Components/SkillComponent.gd")
const PlayableComponent = preload("res://Ecs/Components/PlayableComponent.gd")
const StatusEffectsComponent = preload("res://Ecs/Components/StatusEffectsComponent.gd")

const StunPistol = preload("res://Skills/Components/StunPistol.gd")
const RocketLauncher = preload("res://Skills/Components/RocketLauncher.gd")
const EnergyShield = preload("res://Skills/Components/EnergyShield.gd")

func create_player(x, y):
	return Entity.new(x, y) \
		.add("SpriteComponent", SpriteComponent.new("Creatures", "Player")) \
		.add("PlayableComponent", PlayableComponent.new()) \
		.add("PlayerControlComponent", PlayerControlComponent.new()) \
		.add("CameraFollowComponent", CameraFollowComponent.new()) \
		.add("MeleeComponent", MeleeComponent.new(Constants.PLAYER_ATTACK_DAMAGE)) \
		.add("HealthComponent", HealthComponent.new(Constants.PLAYER_MAX_HEALTH)) \
		.add("SightComponent", SightComponent.new(Constants.PLAYER_SIGHT)) \
		.add("SkillComponent", SkillComponent.new([StunPistol.new(), RocketLauncher.new()])) \
		.add("StatusEffectsComponent", StatusEffectsComponent.new())

func create_sister(x, y):
	return Entity.new(x, y) \
		.add("SpriteComponent", SpriteComponent.new("Creatures", "Sister")) \
		.add("PlayableComponent", PlayableComponent.new()) \
		.add("MeleeComponent", MeleeComponent.new(Constants.PLAYER_ATTACK_DAMAGE)) \
		.add("HealthComponent", HealthComponent.new(Constants.PLAYER_MAX_HEALTH)) \
		.add("SightComponent", SightComponent.new(Constants.PLAYER_SIGHT)) \
		.add("SkillComponent", SkillComponent.new([EnergyShield.new()])) \
		.add("StatusEffectsComponent", StatusEffectsComponent.new())

func create_monster(x, y):
    return Entity.new(x, y) \
        .add("SpriteComponent", SpriteComponent.new("Creatures", "Enemy")) \
        .add("MeleeComponent", MeleeComponent.new(Constants.PLAYER_ATTACK_DAMAGE)) \
        .add("HealthComponent", HealthComponent.new(Constants.PLAYER_MAX_HEALTH)) \
        .add("ChasePlayerComponent", ChasePlayerComponent.new()) \
        .add("SightComponent", SightComponent.new(Constants.MONSTER_SIGHT))

func create_wall(x, y):
	return Entity.new(x, y).add("SpriteComponent", SpriteComponent.new("Ground", "Wall", "DiscoveredWall"))