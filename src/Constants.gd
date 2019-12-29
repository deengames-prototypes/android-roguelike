extends Node

# A list of feature toggles. Setting a value of "true" turns a feature
# on, and setting a value of "false" turns a feature off.
const SHIELD_DIES_AFTER_3_HITS = false
const SHIELD_DIES_AFTER_20_STEPS = false

# extract into a config.json file? godot's ConfigFile?
const TILES_WIDE = 60
const TILES_HIGH = 34
const TILE_WIDTH = 32
const TILE_HEIGHT = 32

const RANDOM_WALK_MULT = 1.5
const RANDOM_WALK_STEPS = TILES_WIDE * TILES_HIGH * RANDOM_WALK_MULT

const PLAYER_MAX_HEALTH = 20
const PLAYER_ATTACK_DAMAGE = 5
const PLAYER_SIGHT = 5

const BOW_DAMAGE = 8

const MIN_ENEMIES_PER_DUNGEON = 8
const MAX_ENEMIES_PER_DUNGEON = 16