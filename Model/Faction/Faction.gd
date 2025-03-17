extends MissionComponent
class_name Faction

@export var name: String
@export var abbreviation: String
@export var icon: Texture2D

static var Station: Faction = load("uid://bp8l1wo8avjr1")
static var SpaceWizards: Faction = load("uid://gdy230o1m8va")
static var SpaceFascists: Faction = load("uid://cdnhushyoojdf")
static var GrossAliens: Faction = load("uid://ceu3385komw6s")
static var SexyAliens: Faction = load("uid://c6goux6qls0wk")
static var PluckyRebels: Faction = load("uid://b1elkkb1yqgl2")

static var AllFactions: Array[Faction] = [SpaceWizards, PluckyRebels, SpaceFascists, SexyAliens, GrossAliens]
