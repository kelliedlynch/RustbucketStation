extends MissionComponent
class_name Objective

static var Steal = {
	name = "Steal",
	objective_text = "steal",
	objective_targets = ["the prince's crown jewels", "seven tons of butter", "a suspiciously ticking package", "a seriously offensive but valuable historical artifact", "everyone's left sock"]
}

static var Deliver = {
	name = "Deliver",
	objective_text = "deliver",
	objective_targets = ["seven tons of butter", "a suspiciously ticking package", "a large crate of opossums", "counterfeit postage stamps", "a delegation of cultists"]
}

static var Scout = {
	name = "Scout",
	objective_text = "",
	objective_targets = ["scout for military activity", "plant cameras for a new reality TV show", "find the best Mexican restaurant", "get pictures of the Prime Minister's feet for...reasons"]
}

static var Sabotage = {
	name = "Sabotage",
	objective_text = "",
	objective_targets = ["back up the barracks plumbing system", "damage the President's self-esteem", "bomb the Hospital for Sick Puppies with Cancer", "take down the WiFi"]
}

static var Attack = {
	name = "Destroy Target",
	objective_text = "destroy",
	objective_targets = ["some guy's house", "a beloved planetary monument", "the spy outpost spying on our spy outpost", "a moon. Any moon will do"]
}

static var Rescue = {
	name = "Rescue Target",
	objective_text = "rescue",
	objective_targets = ["the President from an awkward dinner", "the princess from the princess", "a harem full of catboys", "a terrorist cell from a religious cult"]
}

static var AllObjectives = [Steal, Deliver, Scout, Sabotage, Attack, Rescue]
