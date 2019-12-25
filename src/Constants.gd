extends Node

# extract into a config.json file? godot's ConfigFile?
const TILES_WIDE = 60
const TILES_HIGH = 34
const TILE_WIDTH = 32
const TILE_HEIGHT = 32

const RANDOM_WALK_MULT = 1.5
const RANDOM_WALK_STEPS = TILES_WIDE * TILES_HIGH * RANDOM_WALK_MULT

const PLAYER_MAX_HEALTH = 20

const MIN_ENEMIES_PER_DUNGEON = 8
const MAX_ENEMIES_PER_DUNGEON = 16