extends Node

# extract into a config.json file? godot's ConfigFile?
const TILES_WIDE = 60
const TILES_HIGH = 34
const TILE_WIDTH = 48
const TILE_HEIGHT = 48

const RANDOM_WALK_MULT = 1.5
const RANDOM_WALK_STEPS = TILES_WIDE * TILES_HIGH * RANDOM_WALK_MULT

const PLAYER_MAX_HEALTH = 20
const PLAYER_ATTACK_DAMAGE = 5
const PLAYER_SIGHT = 4

const PISTOL_DAMAGE = 3
const PISTOL_TURNS_STUNNED = 2

const ROCKET_EXPLOSION_DAMAGE = 6
const ROCKET_EXPLOSION_RADIUS = 2

const LIGHTNING_CANNON_DAMAGE = 4
const LIGHTNING_CANNON_RADIUS = 3

const ENERGY_SHIELD_STRENGTH = 3  # -1 == infinite strength
const ENERGY_SHIELD_TURNS = 20  # -1 == infinite turns

const MIN_ENEMIES_PER_DUNGEON = 8
const MAX_ENEMIES_PER_DUNGEON = 16
const MONSTER_SIGHT = 3