extends Node

# we need to set things up so that the proper textures get 
# assigned when we enter a given animation
# i.e. set the proper textures for idle, run, attack, death, etc.

# sprites will change when a certain weapon is equipped
# i.e. sword and shield weapon will evoke different textures 
# for run and jump

# the handling of assigning the appropriate animations should be handled in code
# Equipping a weapon should automatically assign the appropriate textures
# Based on an index position
# for example - within the shirts key 0 belongs to green nomad shirt
# this index should be universal regardless if I have a sword/shield equipped,
# a wand equipped or nothing equipped

# idea -- create a dictionary that contains dictionaries for each weapon type
# -- each inner dictionary's keyword will be the name of the weapon type
# The way each weapon dictionary is setup should be universal so that things
# can easily be swapped out 
# (i.e. a texture for a given body part or piece of equipment should have a universal index)
# we will probably need to consider grouping fragmented textures i.e. shirt

# when entering a state I should call a method that sets the approprait textures
# for example -- if I enter run state and I have :
# I'll set the head texture to PlayerTexture.texture_atlas[weapon_type]["Run"]["Head"][head_index]
# If I have no weapon equipped, and my character has white skin,
# The call will look like this: PlayerTexture.texture_atlas["Standard"]["Run"]["Head"][0]
# **We'll get the appropriate state dictionary by grabbing the name of the state node
# **We'll get the weapon type by grabbing the name of the weapon class -- if there is no weapon equipped it will return standard
# **We'll get the appropriate index based on index variable that I set inside of the corresponding resource 
#   -- The body parts will have to be handled differently since they won't
#	   be reliant on a resource -- this is set during character creation or cosmetic change in game

# Standard -- no weapon is equipped
# Swordshield -- sword and shield weapon type is equipped
const texture_atlas = {
	"Standard": {
		"Idle": {
			"Head" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Idle.png")
			},
			"Eyes" : {
				"Green" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Idle.png")
				}
			},
			"Hair" : {
				"Black": { #Black Colors
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Idle.png")
				}
			},
			"Left Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Idle.png")
			},
			
			"Gloves" : {
				
				"Left Glove" : {
					#Nomad Left Glove
					0 : preload("res://Assets/Player/Male/LeftArm_Male/GlovesLeftHandMale/NomadGloveLM/NomadsGlove_Standard_LM-Idle.png")
				}, 
				"Right Glove" : {
					#Nomad Right Glove
					0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_Standard_RM-Idle.png")
				}
			},
			
			"Torso" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Idle.png")
			},
			"Right Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Idle.png")
			},
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Standard_Male-Idle.png") ,
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM-Idle.png") ,
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Standard_RM-Idle.png")
				}
			},
			"Legs" : {
				#White skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Idle.png")
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM-Idle.png")
			},
			"Shoes": {
				#Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Idle.png")
			},
			"Cape": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Idle.png")
			},
		},
		"Move" : {
			"Head" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Run1.png")
			},
			"Eyes" : {
				"Green" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Run1.png")
				}
			},
			"Hair" : {
				"Black": { #Black Colors
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Run1.png")
				}
			},
			"Left Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Run1.png")
			},
			"Torso" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Run1.png")
			},
			"Right Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Run1.png")
			},
			
			"Gloves" : {
				"Left Glove" : {
					#Nomad Left Glove
					0 : preload("res://Assets/Player/Male/LeftArm_Male/GlovesLeftHandMale/NomadGloveLM/NomadsGlove_Standard_LM-Run1.png")
				}, 
				"Right Glove" : {
					#Nomad Right Glove
					0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_Standard_RM-Run1.png")
				}
			},
			
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Standard_Male-Run1.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM-Run1.png") ,
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Standard_RM-Run1.png")
				}
			},
			"Legs" : {
				#White skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Run1.png")
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM-Run1.png")
			},
			"Shoes": {
				#Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Run1.png")
			},
			"Cape": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Run1.png")
			},
		},
		"Jump": {
			"Head" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Jump_Standard.png")
			},
			"Eyes" : {
				"Green" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Jump_Standard.png")
				}
			},
			"Hair" : {
				"Black": { #Black Colors
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Jump_Standard.png")
				}
			},
			
			"Left Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Jump_Standard.png")
			},
			"Torso" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Jump_Standard.png")
			},
			"Right Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Jump_Standard.png")
			},

			"Gloves" : {
				"Left Glove" : {
					#Nomad Left Glove
					0 : preload("res://Assets/Player/Male/LeftArm_Male/GlovesLeftHandMale/NomadGloveLM/NomadsGlove_Standard_LM-Jump_Standard.png")
				}, 
				"Right Glove" : {
					#Nomad Right Glove
					0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_Standard_RM-Jump_Standard.png")
				}
			},
						
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Standard_Male-Jump_Standard.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM-Jump_Standard.png") ,
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Standard_RM-Jump_Standard.png")
				}
			},
			"Legs" : {
				#White skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Jump_Standard.png")
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM-Jump_Standard.png")
			},
			"Shoes": {
				#Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Jump_Standard.png")
			},
			"Cape": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Jump_Standard.png")
			},			
			
		},
		"Fall": {
			"Head" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Jump_Standard.png")
			},
			"Eyes" : {
				"Green" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Jump_Standard.png")
				}
			},
			"Hair" : {
				"Black": { #Black Colors
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Jump_Standard.png")
				}
			},
			"Left Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Jump_Standard.png")
			},
			"Torso" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Jump_Standard.png")
			},
			"Right Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Jump_Standard.png")
			},
			"Gloves" : {
				"Left Glove" : {
					#Nomad Left Glove
					0 : preload("res://Assets/Player/Male/LeftArm_Male/GlovesLeftHandMale/NomadGloveLM/NomadsGlove_Standard_LM-Jump_Standard.png")
				}, 
				"Right Glove" : {
					#Nomad Right Glove
					0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_Standard_RM-Jump_Standard.png")
				}
			},
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Standard_Male-Jump_Standard.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM-Jump_Standard.png") ,
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Standard_RM-Jump_Standard.png")
				}
			},
			"Legs" : {
				#White skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Jump_Standard.png")
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM-Jump_Standard.png")
			},
			"Shoes": {
				#Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Jump_Standard.png")
			},
			"Cape": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Jump_Standard.png")
			},			
					
		},
		
		"Climb": {
			"Head" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-ClimbLadder.png")
			},
			
			"Hair" : {
				"Black": { #Black Colors
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-ClimbLadder.png")
				}
			},
			"Torso" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-ClimbLadder.png")
			},
			"Right Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-ClimbLadder.png")
			},
			"Gloves" : {
				"Right Glove" : {
					#Nomad Right Glove
					0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_Standard_RM-ClimbLadder.png")
				}
			},
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM-Run1.png") ,
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Standard_RM-ClimbLadder.png")
				}
			},
			"Legs" : {
				#White skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-ClimbLadder.png")
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM-ClimbLadder.png")
			},
			"Shoes": {
				#Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-ClimbLadder.png")
			},
			"Cape on Climb": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Climb_Back_Mounts/Cape_On_Clumb/Nomad_Backpack_Back_Mount-ClimbLadder.png")
			}		
		},
		
		"Hit": {
			"Head" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Jump_Standard.png")
			},
			"Eyes" : {
				"Green" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Jump_Standard.png")
				}
			},
			"Hair" : {
				"Black": { #Black Colors
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Jump_Standard.png")
				}
			},
			"Left Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Jump_Standard.png")
			},
			"Torso" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Jump_Standard.png")
			},
			"Right Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Jump_Standard.png")
			},
			"Gloves" : {
				"Left Glove" : {
					#Nomad Left Glove
					0 : preload("res://Assets/Player/Male/LeftArm_Male/GlovesLeftHandMale/NomadGloveLM/NomadsGlove_Standard_LM-Jump_Standard.png")
				}, 
				"Right Glove" : {
					#Nomad Right Glove
					0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_Standard_RM-Jump_Standard.png")
				}
			},
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Standard_Male-Jump_Standard.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM-Jump_Standard.png") ,
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Standard_RM-Jump_Standard.png")
				}
			},
			"Legs" : {
				#White skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Jump_Standard.png")
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM-Jump_Standard.png")
			},
			"Shoes": {
				#Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Jump_Standard.png")
			},
			"Cape": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Jump_Standard.png")
			},			
		
		},
		"Dead": {
			"Head" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Death.png")
			},
			"Eyes" : {
				"DeathEyes" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/DeathEyes-Death.png")
				}
			},
			"Hair" : {
				"Black": { #Black Colors
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Death.png")
				}
			},
			"Left Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Standard_Male-Death.png")
			},
			"Torso" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Death.png")
			},
			"Right Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Death.png")
			},
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Standard_Male-Death.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM-Death.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Standard_RM-Death.png")
				}
			},
			"Legs" : {
				#White skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Death.png")
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM-Death.png")
			},
			"Shoes": {
				#Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Death.png")
			},
			"Cape": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Death.png")
			},			
		}
	},
	"Sword and Shield": {
		"Idle": {
			"Head" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Idle.png")
			},
			"Eyes" : {
				"Green" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Idle.png")
				}
			},
			"Hair" : {
				"Black": { #Black Colors
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Idle.png")
				}
			},
			"Left Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Idle.png")
			},
			
			"Gloves" : {
				
				"Left Glove" : {
					#Nomad Left Glove
					0 : preload("res://Assets/Player/Male/LeftArm_Male/GlovesLeftHandMale/NomadGloveLM/NomadsGlove_Standard_LM-Idle.png")
				}, 
				"Right Glove" : {
					#Nomad Right Glove
					0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_Standard_RM-Idle.png")
				}
			},
			
			"Torso" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Idle.png")
			},
			"Right Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Idle.png")
			},
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Standard_Male-Idle.png") ,
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM-Idle.png") ,
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Standard_RM-Idle.png")
				}
			},
			"Legs" : {
				#White skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Idle.png")
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM-Idle.png")
			},
			"Shoes": {
				#Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Idle.png")
			},
			"Cape": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Idle.png")
			},
			"Sword" : {
				#Wooden Sword
				0 : preload("res://Assets/Player/Male/OneHandedSwords/WoodenSword-Idle.png")
			},
			"Shield" : {
				0 : preload("res://Assets/Player/Male/Shields/WoodenShield-Idle.png")
			}
			
		},
		"Move" : {
			"Head" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Run1.png")
			},
			"Eyes" : {
				"Green" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Run1.png")
				}
			},
			"Hair" : {
				"Black": { #Black Colors
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Run1.png")
				}
			},
			"Left Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Run1.png")
			},
			"Torso" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Run1.png")
			},
			"Right Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_White-Run1.png")
			},
			
			"Gloves" : {
				"Left Glove" : {
					#Nomad Left Glove
					0 : preload("res://Assets/Player/Male/LeftArm_Male/GlovesLeftHandMale/NomadGloveLM/NomadsGlove_SWS_LM-Run1.png")
				}, 
				"Right Glove" : {
					#Nomad Right Glove
					0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_SWS_RM-Run1.png")
				}
			},
			
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_SWS_Male-Run1.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM-Run1.png") ,
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_SWS_RM-Run1.png")
				}
			},
			"Legs" : {
				#White skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Run1.png")
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM-Run1.png")
			},
			"Shoes": {
				#Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Run1.png")
			},
			"Cape": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Run1.png")
			},
			"Sword" : {
				#Wooden Sword
				0 : preload("res://Assets/Player/Male/OneHandedSwords/WoodenSword-Run1.png")
			},
			"Shield" : {
				0 : preload("res://Assets/Player/Male/Shields/WoodenShield-Run1.png")
			}
		},
		"Jump": { # need to remember to set to frame 0 since jump and fall are same frame
			"Head" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Jump_SWS.png")
			},
			"Eyes" : {
				"Green" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Jump_SWS.png")
				}
			},
			"Hair" : {
				"Black": { #Black Colors
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Jump_SWS.png")
				}
			},
			
			"Left Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_White-Jump_SWS.png")
			},
			"Torso" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Jump_SWS.png")
			},
			"Right Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_White-Jump_SWS.png")
			},

			"Gloves" : {
				"Left Glove" : {
					#Nomad Left Glove
					0 : preload("res://Assets/Player/Male/LeftArm_Male/GlovesLeftHandMale/NomadGloveLM/NomadsGlove_SWS_LM-Jump_SWS.png")
				}, 
				"Right Glove" : {
					#Nomad Right Glove
					0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_SWS_RM-Jump_SWS.png")
				}
			},
						
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_SWS_Male-Jump_SWS.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM-Jump_SWS.png") ,
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_SWS_RM-Jump_SWS.png")
				}
			},
			"Legs" : {
				#White skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Jump_SWS.png")
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM-Jump_SWS.png")
			},
			"Shoes": {
				#Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Jump_SWS.png")
			},
			"Cape": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Jump_SWS.png")
			},
			"Sword" : {
				#Wooden Sword
				0 : preload("res://Assets/Player/Male/OneHandedSwords/WoodenSword-Jump_SWS.png")
			},
			"Shield" : {
				0 : preload("res://Assets/Player/Male/Shields/WoodenShield-Jump_SWS.png")
			}
					
			
		},
		"Fall": {
			"Head" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Jump_SWS.png")
			},
			"Eyes" : {
				"Green" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Jump_Standard.png")
				}
			},
			"Hair" : {
				"Black": { #Black Colors
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Jump_Standard.png")
				}
			},
			"Left Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Jump_Standard.png")
			},
			"Torso" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Jump_Standard.png")
			},
			"Right Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Jump_Standard.png")
			},
			"Gloves" : {
				"Left Glove" : {
					#Nomad Left Glove
					0 : preload("res://Assets/Player/Male/LeftArm_Male/GlovesLeftHandMale/NomadGloveLM/NomadsGlove_Standard_LM-Jump_Standard.png")
				}, 
				"Right Glove" : {
					#Nomad Right Glove
					0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_Standard_RM-Jump_Standard.png")
				}
			},
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Standard_Male-Jump_Standard.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM-Jump_Standard.png") ,
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Standard_RM-Jump_Standard.png")
				}
			},
			"Legs" : {
				#White skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Jump_Standard.png")
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM-Jump_Standard.png")
			},
			"Shoes": {
				#Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Jump_Standard.png")
			},
			"Cape": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Jump_Standard.png")
			},
			"Sword" : {
				#Wooden Sword
				0 : preload("res://Assets/Player/Male/OneHandedSwords/WoodenSword-Jump_SWS.png")
			},
			"Shield" : {
				0 : preload("res://Assets/Player/Male/Shields/WoodenShield-Jump_SWS.png")
			}		
					
		},
		
		"Climb": {
			"Head" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-ClimbLadder.png")
			},
			
			"Hair" : {
				"Black": { #Black Colors
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-ClimbLadder.png")
				}
			},
			"Torso" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-ClimbLadder.png")
			},
			"Right Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-ClimbLadder.png")
			},
			"Gloves" : {
				"Right Glove" : {
					#Nomad Right Glove
					0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_Standard_RM-ClimbLadder.png")
				}
			},
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM-Run1.png") ,
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Standard_RM-ClimbLadder.png")
				}
			},
			"Legs" : {
				#White skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-ClimbLadder.png")
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM-ClimbLadder.png")
			},
			"Shoes": {
				#Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-ClimbLadder.png")
			},
			"Cape on Climb": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Climb_Back_Mounts/Cape_On_Clumb/Nomad_Backpack_Back_Mount-ClimbLadder.png")
			},
			"Weapon on Climb" : {
				#Wooden Sword and shield
				0 : preload("res://Assets/Player/Male/Climb_Back_Mounts/Weapon_On_Climb/Wooden_Sword_Shield_Back_Mound-ClimbLadder.png")
			}	
		},
		
		"Hit": {
			"Head" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Jump_Standard.png")
			},
			"Eyes" : {
				"Green" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Jump_Standard.png")
				}
			},
			"Hair" : {
				"Black": { #Black Colors
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Jump_Standard.png")
				}
			},
			"Left Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Jump_Standard.png")
			},
			"Torso" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Jump_Standard.png")
			},
			"Right Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Jump_Standard.png")
			},
			"Gloves" : {
				"Left Glove" : {
					#Nomad Left Glove
					0 : preload("res://Assets/Player/Male/LeftArm_Male/GlovesLeftHandMale/NomadGloveLM/NomadsGlove_Standard_LM-Jump_Standard.png")
				}, 
				"Right Glove" : {
					#Nomad Right Glove
					0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_Standard_RM-Jump_Standard.png")
				}
			},
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Standard_Male-Jump_Standard.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM-Jump_Standard.png") ,
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Standard_RM-Jump_Standard.png")
				}
			},
			"Legs" : {
				#White skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Jump_Standard.png")
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM-Jump_Standard.png")
			},
			"Shoes": {
				#Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Jump_Standard.png")
			},
			"Cape": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Jump_Standard.png")
			},			
		
		},
		"Dead": {
			"Head" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Death.png")
			},
			"Eyes" : {
				"DeathEyes" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/DeathEyes-Death.png")
				}
			},
			"Hair" : {
				"Black": { #Black Colors
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Death.png")
				}
			},
			"Left Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Standard_Male-Death.png")
			},
			"Torso" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Death.png")
			},
			"Right Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Death.png")
			},
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Standard_Male-Death.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM-Death.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Standard_RM-Death.png")
				}
			},
			"Legs" : {
				#White skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Death.png")
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM-Death.png")
			},
			"Shoes": {
				#Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Death.png")
			},
			"Cape": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Death.png")
			},			
		}		
	}
}
