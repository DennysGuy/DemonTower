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
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Idle.png"),
				#Medium Skin
				1: preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-Idle.png"),
				#Dark Skin
				2: preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-Idle.png")
			},
			"Eyes" : {
				"Green" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Idle.png")
				},
				"Brown" : {
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Brown-Idle.png")
				},
				"Blue" : {
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Blue-Idle.png")
				}
			},
			"Hair" : {
				"Black": { #Black Colors
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Idle.png")
				},
				"Brown": {
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-Idle.png")
				},
				"Blond": {
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-Idle.png")
				}
			},
			"Left Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Idle.png"),
				1 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Med-Idle.png"),
				2: preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Dark-Idle.png")
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
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Idle.png"),
				1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-Idle.png"),
				2: preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-Idle.png")
			},
			"Right Arm" : {
				#White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Idle.png"),
				1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Med-Idle.png"),
				2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Dark-Idle.png")
			},
			"Shirt": {
				0: { #Nomad Shirt Green
					"Left Sleeve": preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Green_Standard_Male-Idle.png"),
					"Torso Shirt": preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-Idle.png"),
					"Right Sleeve": preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_Standard_RM-Idle.png")
				},
				1: { #Nomad Shirt Red
					"Left Sleeve": preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Red_Standard_Male-Idle.png"),
					"Torso Shirt": preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-Idle.png"),
					"Right Sleeve": preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_Standard_RM-Idle.png")
				},
				2: { #Nomad Shirt Blue
					"Left Sleeve": preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Blue_Standard_Male-Idle.png"),
					"Torso Shirt": preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-Idle.png"),
					"Right Sleeve": preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_Standard_RM-Idle.png")
				}
			},
			"Legs" : {
				#White skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Idle.png"),
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-Idle.png"),
				2: preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-Idle.png")
			},
			"Pants": {
				0: preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-Idle.png"), # Nomad Pants Green
				1: preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-Idle.png"),   # Nomad Pants Red
				2: preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-Idle.png")  # Nomad Pants Blue
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
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Run1.png"),
				# Additional entry for Dark Skin
				1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-Run1.png"),
				# Another entry for Med Skin
				2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-Run1.png"),
			},
			"Eyes" : {
				"Green" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Run1.png")
				},
				"Brown" : { # Brown Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Brown-Run1.png")
				},
				"Blue" : { # Blue Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Blue-Run1.png")
				}
			},
			"Hair" : {
				"Black" : { # Black Hair
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Run1.png")
				},
				"Brown" : { # Brown Hair
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-Run1.png")
				},
				"Blond" : { # Blond Hair
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-Run1.png")
				}
			},
			"Left Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Run1.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Med-Run1.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Dark-Run1.png"),
			},

		"Torso" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Run1.png"),
			
			# Med Skin
			1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-Run1.png"),
			
			# Dark Skin
			2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-Run1.png"),
		},

		"Right Arm" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Run1.png"),
			
			# Med Skin
			1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Med-Run1.png"),
			
			# Dark Skin
			2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Dark-Run1.png"),
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
				0: { # Nomad Shirt Green
					"Left Sleeve": preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Green_Standard_Male-Run1.png"),
					"Torso Shirt": preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-Run1.png"),
					"Right Sleeve": preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_Standard_RM-Run1.png")
				},
				1: { # Nomad Shirt Red
					"Left Sleeve": preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Red_Standard_Male-Run1.png"),
					"Torso Shirt": preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-Run1.png"),
					"Right Sleeve": preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_Standard_RM-Run1.png")
				},
				2: { # Nomad Shirt Blue
					"Left Sleeve": preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Blue_Standard_Male-Run1.png"),
					"Torso Shirt": preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-Run1.png"),
					"Right Sleeve": preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_Standard_RM-Run1.png")
				}
			},

			"Legs" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Run1.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-Run1.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-Run1.png"),
			},
			"Pants": {
				0: preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-Run1.png"), # Nomad Pants Green
				1: preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-Run1.png"),   # Nomad Pants Red
				2: preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-Run1.png")  # Nomad Pants Blue
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
				# White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Jump_Standard.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-Jump_Standard.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-Jump_Standard.png"),
			},

			"Eyes" : {
				"Green" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Jump_Standard.png")
				},
				"Brown" : { # Brown Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Brown-Jump_Standard.png")
				},
				"Blue" : { # Blue Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Blue-Jump_Standard.png")
				}
			},
			"Hair" : {
				"Black" : { # Black Hair
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Jump_Standard.png")
				},
				"Brown" : { # Brown Hair
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-Jump_Standard.png")
				},
				"Blond" : { # Blond Hair
					#Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-Jump_Standard.png")
				}
		},
			
		"Left Arm" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Jump_Standard.png"),
			
			# Med Skin
			1 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Med-Jump_Standard.png"),
			
			# Dark Skin
			2 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Dark-Jump_Standard.png"),
		},

		"Torso" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Jump_Standard.png"),
			
			# Med Skin
			1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-Jump_Standard.png"),
			
			# Dark Skin
			2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-Jump_Standard.png"),
		},

		"Right Arm" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Jump_Standard.png"),
			
			# Med Skin
			1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Med-Jump_Standard.png"),
			
			# Dark Skin
			2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Dark-Jump_Standard.png"),
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
			0 : { # Nomad Shirt Green
				"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Green_Standard_Male-Jump_Standard.png"),
				"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-Jump_Standard.png"),
				"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_Standard_RM-Jump_Standard.png")
			},
			1 : { # Nomad Shirt Red
				"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Red_Standard_Male-Jump_Standard.png"),
				"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-Jump_Standard.png"),
				"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_Standard_RM-Jump_Standard.png")
			},
			2 : { # Nomad Shirt Blue
				"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Blue_Standard_Male-Jump_Standard.png"),
				"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-Jump_Standard.png"),
				"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_Standard_RM-Jump_Standard.png")
			}
		},
		"Legs" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Jump_Standard.png"),
			# Med Skin
			1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-Jump_Standard.png"),
			# Dark Skin
			2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-Jump_Standard.png"),
		},
		
		"Pants": {
			0: preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-Jump_Standard.png"), # Nomad Pants Green
			1: preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-Jump_Standard.png"),   # Nomad Pants Red
			2: preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-Jump_Standard.png")  # Nomad Pants Blue
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
				# White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Jump_Standard.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-Jump_Standard.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-Jump_Standard.png"),
			},

		"Eyes" : {
			"Green" : { # Green Eyes
				#Eyes Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Jump_Standard.png")
			},
			"Brown" : { # Brown Eyes
				#Eyes Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Brown-Jump_Standard.png")
			},
			"Blue" : { # Blue Eyes
				#Eyes Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Blue-Jump_Standard.png")
			}
		},
		"Hair" : {
			"Black" : { # Black Hair
				#Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Jump_Standard.png")
			},
			"Brown" : { # Brown Hair
				#Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-Jump_Standard.png")
			},
			"Blond" : { # Blond Hair
				#Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-Jump_Standard.png")
			}
		},
			"Left Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Jump_Standard.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Med-Jump_Standard.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Dark-Jump_Standard.png"),
			},
			"Torso" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Jump_Standard.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-Jump_Standard.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-Jump_Standard.png"),
			},
			"Right Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Jump_Standard.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Med-Jump_Standard.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Dark-Jump_Standard.png"),
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
				0: { # Nomad Shirt Green
					"Left Sleeve": preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Green_Standard_Male-Jump_Standard.png"),
					"Torso Shirt": preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-Jump_Standard.png"),
					"Right Sleeve": preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_Standard_RM-Jump_Standard.png")
				},
				1: { # Nomad Shirt Red
					"Left Sleeve": preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Red_Standard_Male-Jump_Standard.png"),
					"Torso Shirt": preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-Jump_Standard.png"),
					"Right Sleeve": preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_Standard_RM-Jump_Standard.png")
				},
				2: { # Nomad Shirt Blue
					"Left Sleeve": preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Blue_Standard_Male-Jump_Standard.png"),
					"Torso Shirt": preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-Jump_Standard.png"),
					"Right Sleeve": preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_Standard_RM-Jump_Standard.png")
				}
			},

			"Legs" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Jump_Standard.png"),
				# Med Skin
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-Jump_Standard.png"),
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-Jump_Standard.png"),
			},
			"Pants": {
				0: preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-Jump_Standard.png"),
				1: preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-Jump_Standard.png"),
				2: preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-Jump_Standard.png"),
			},
			"Shoes" : {
				0: preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Jump_Standard.png")
			},
			"Cape": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Jump_Standard.png")
			},			
					
		},
		
		"Climb": {
			"Head" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-ClimbLadder.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-ClimbLadder.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-ClimbLadder.png"),
			},
		"Hair" : {
			"Black" : { # Black Hair
				#Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-ClimbLadder.png")
			},
			"Brown" : { # Brown Hair
				#Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-ClimbLadder.png")
			},
			"Blond" : { # Blond Hair
				#Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-ClimbLadder.png")
			}
		},
		"Torso" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-ClimbLadder.png"),
			
			# Med Skin
			1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-ClimbLadder.png"),
			
			# Dark Skin
			2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-ClimbLadder.png"),
		},

		"Right Arm" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-ClimbLadder.png"),
			
			# Med Skin
			1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Med-ClimbLadder.png"),
			
			# Dark Skin
			2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Dark-ClimbLadder.png"),
		},

			"Gloves" : {
				"Right Glove" : {
					#Nomad Right Glove
					0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_Standard_RM-ClimbLadder.png")
				}
			},
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-ClimbLadder.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_Standard_RM-ClimbLadder.png")
				},
				1 : { #Nomad Shirt Red
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-ClimbLadder.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_Standard_RM-ClimbLadder.png")
				},
				2 : { #Nomad Shirt Blue
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-ClimbLadder.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_Standard_RM-ClimbLadder.png")
				}
			},
			"Legs" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-ClimbLadder.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-ClimbLadder.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-ClimbLadder.png"),
			},
			"Pants": {
				0 : { #Nomad Pants Green
					0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-ClimbLadder.png")
				},
				1 : { #Nomad Pants Red
					0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-ClimbLadder.png")
				},
				2 : { #Nomad Pants Blue
					0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-ClimbLadder.png")
				}
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
				# White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Jump_Standard.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-Jump_Standard.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-Jump_Standard.png"),
			},

		"Eyes" : {
			"Green" : { # Green Eyes
				#Eyes Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Jump_Standard.png")
			},
			"Brown" : { # Brown Eyes
				#Eyes Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Brown-Jump_Standard.png")
			},
			"Blue" : { # Blue Eyes
				#Eyes Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Blue-Jump_Standard.png")
			}
		},
		"Hair" : {
			"Black" : { # Black Hair
				#Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Jump_Standard.png")
			},
			"Brown" : { # Brown Hair
				#Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-Jump_Standard.png")
			},
			"Blond" : { # Blond Hair
				#Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-Jump_Standard.png")
			}
		},
			
		"Left Arm" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Jump_Standard.png"),
			
			# Med Skin
			1 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Med-Jump_Standard.png"),
			
			# Dark Skin
			2 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Dark-Jump_Standard.png"),
		},

		"Torso" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Jump_Standard.png"),
			
			# Med Skin
			1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-Jump_Standard.png"),
			
			# Dark Skin
			2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-Jump_Standard.png"),
		},

		"Right Arm" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Jump_Standard.png"),
			
			# Med Skin
			1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Med-Jump_Standard.png"),
			
			# Dark Skin
			2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Dark-Jump_Standard.png"),
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
				"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Green_Standard_Male-Jump_Standard.png"),
				"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-Jump_Standard.png"),
				"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_Standard_RM-Jump_Standard.png")
			},
			1 : { #Nomad Shirt Red
				"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Red_Standard_Male-Jump_Standard.png"),
				"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-Jump_Standard.png"),
				"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_Standard_RM-Jump_Standard.png")
			},
			2 : { #Nomad Shirt Blue
				"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Blue_Standard_Male-Jump_Standard.png"),
				"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-Jump_Standard.png"),
				"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_Standard_RM-Jump_Standard.png")
			}
		},
		"Legs" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Jump_Standard.png"),
			# Med Skin
			1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-Jump_Standard.png"),
			# Dark Skin
			2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-Jump_Standard.png"),
		},
		
		"Pants" : {
			0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-Jump_Standard.png"),
			1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-Jump_Standard.png"),
			2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-Jump_Standard.png")
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
				# White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Death.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-Death.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-Death.png"),
			},

			"Eyes" : {
				"DeathEyes" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/DeathEyes-Death.png")
				}
			},
			"Hair" : {
				"Black": { # Black Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Death.png")
				},
				"Brown": { # Brown Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-Death.png")
				},
				"Blond": { # Blond Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-Death.png")
				}
			},
			"Left Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Death.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Med-Death.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Dark-Death.png"),
			},

			"Torso" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Death.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-Death.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-Death.png"),
			},

			"Right Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Death.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Med-Death.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Dark-Death.png"),
			},

			"Shirt": {
				0 : { #Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Green_Standard_Male-Death.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-Death.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_Standard_RM-Death.png")
				},
				1 : { #Nomad Shirt Red
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Red_Standard_Male-Death.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-Death.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_Standard_RM-Death.png")
				},
				2 : { #Nomad Shirt Blue
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Blue_Standard_Male-Death.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-Death.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_Standard_RM-Death.png")
				}
			},

			"Legs" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Death.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-Death.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-Death.png"),
			},

			"Pants": {
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-Death.png"),
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-Death.png"),
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-Death.png")
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
				# White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Idle.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-Idle.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-Idle.png"),
			},
			"Eyes" : {
				"Green" : { # Green Eyes
					# Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Idle.png")
				},
				"Brown" : { # Brown Eyes
					# Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Brown-Idle.png")
				},
				"Blue" : { # Blue Eyes
					# Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Blue-Idle.png")
				}
			},
			"Hair" : {
				"Black": { # Black Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Idle.png")
				},
				"Brown": { # Brown Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-Idle.png")
				},
				"Blond": { # Blond Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-Idle.png")
				}
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
			
			"Left Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Idle.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Med-Idle.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Dark-Idle.png"),
			},

			"Torso" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Idle.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-Idle.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-Idle.png"),
			},

			"Right Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Idle.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Med-Idle.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Dark-Idle.png"),
			},

			"Shirt": {
				0 : { #Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Green_Standard_Male-Idle.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-Idle.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_Standard_RM-Idle.png")
				},
				1 : { #Nomad Shirt Red
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Red_Standard_Male-Idle.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-Idle.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_Standard_RM-Idle.png")
				},
				2 : { #Nomad Shirt Blue
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Blue_Standard_Male-Idle.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-Idle.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_Standard_RM-Idle.png")
				}
			},

			"Legs" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Idle.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-Idle.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-Idle.png"),
			},
			"Pants": {
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-Idle.png"),
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-Idle.png"),
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-Idle.png")
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
				#Wooden Shield
				0 : preload("res://Assets/Player/Male/Shields/WoodenShield-Idle.png")
			}
		},
		"Move" : {
			"Head" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Run1.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-Run1.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-Run1.png"),
			},
			"Eyes" : {
				"Green" : { # Green Eyes
					# Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Run1.png")
				},
				"Brown" : { # Brown Eyes
					# Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Brown-Run1.png")
				},
				"Blue" : { # Blue Eyes
					# Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Blue-Run1.png")
				}
			},
			"Hair" : {
				"Black": { # Black Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Run1.png")
				},
				"Brown": { # Brown Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-Run1.png")
				},
				"Blond": { # Blond Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-Run1.png")
				}
			},
			"Left Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_White-Run1.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_Med-Run1.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_Dark-Run1.png"),
			},

			"Torso" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Run1.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-Run1.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-Run1.png"),
			},

			"Right Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_White-Run1.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_Med-Run1.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_Dark-Run1.png"),
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
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Green_Standard_Male-Basic_SWS_Attack.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-Run1.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_SWS_RM-Run1.png")
				},
				1 : { #Nomad Shirt Red
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Red_SWS_Male-Run1.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-Run1.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_SWS_RM-Run1.png")
				},
				2 : { #Nomad Shirt Blue
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Blue_SWS_Male-Run1.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-Run1.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_SWS_RM-Run1.png")
				}
			},
			"Legs" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Run1.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-Run1.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-Run1.png"),
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-Run1.png"),
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-Run1.png"),
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-Run1.png"),
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
				# White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Jump_SWS.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-Jump_SWS.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-Jump_SWS.png"),
			},

			"Eyes" : {
				"Green" : { # Green Eyes
					# Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Jump_SWS.png")
				},
				"Brown" : { # Brown Eyes
					# Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Brown-Jump_SWS.png")
				},
				"Blue" : { # Blue Eyes
					# Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Blue-Jump_SWS.png")
				}
			},
			"Hair" : {
				"Black": { # Black Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Jump_SWS.png")
				},
				"Brown": { # Brown Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-Jump_SWS.png")
				},
				"Blond": { # Blond Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-Jump_SWS.png")
				}
			},
			"Left Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_White-Jump_SWS.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_Med-Jump_SWS.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_Dark-Jump_SWS.png"),
			},

			"Torso" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Jump_SWS.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-Jump_SWS.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-Jump_SWS.png"),
			},

			"Right Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_White-Jump_SWS.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_Med-Jump_SWS.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_Dark-Jump_SWS.png"),
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
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Green_SWS_Male-Jump_SWS.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-Jump_SWS.png") ,
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_SWS_RM-Jump_SWS.png")
				},
				1 : { #Nomad Shirt Red
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Red_SWS_Male-Jump_SWS.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-Jump_SWS.png") ,
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_SWS_RM-Jump_SWS.png")
				},
				2 : { #Nomad Shirt Blue
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Blue_SWS_Male-Jump_SWS.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-Jump_SWS.png") ,
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_SWS_RM-Jump_SWS.png")
				}
			},

			"Legs" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Jump_SWS.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-Jump_SWS.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-Jump_SWS.png"),
			},
			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-Jump_SWS.png"),
				#Nomad Pants Red
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-Jump_SWS.png"),
				#Nomad Pants Blue
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-Jump_SWS.png")
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
				# White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Jump_SWS.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-Jump_SWS.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-Jump_SWS.png"),
			},

			"Eyes" : {
				"Green" : { # Green Eyes
					# Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Jump_SWS.png")
				},
				"Brown" : { # Brown Eyes
					# Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Brown-Jump_SWS.png")
				},
				"Blue" : { # Blue Eyes
					# Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Blue-Jump_SWS.png")
				}
			},
			"Hair" : {
				"Black": { # Black Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Jump_SWS.png")
				},
				"Brown": { # Brown Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-Jump_SWS.png")
				},
				"Blond": { # Blond Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-Jump_SWS.png")
				}
			},
			"Left Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_White-Jump_SWS.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_Med-Jump_SWS.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_Dark-Jump_SWS.png"),
			},

			"Torso" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Jump_SWS.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-Jump_SWS.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-Jump_SWS.png"),
			},

			"Right Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_White-Jump_SWS.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_Med-Jump_SWS.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_Dark-Jump_SWS.png"),
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
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Green_SWS_Male-Jump_SWS.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-Jump_SWS.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_SWS_RM-Jump_SWS.png")
				},
				1 : { #Nomad Shirt Red
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Red_SWS_Male-Jump_SWS.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-Jump_SWS.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_SWS_RM-Jump_SWS.png")
				},
				2 : { #Nomad Shirt Blue
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Blue_SWS_Male-Jump_SWS.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-Jump_SWS.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_SWS_RM-Jump_SWS.png")
				}
			},
			"Legs" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Jump_SWS.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-Jump_SWS.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-Jump_SWS.png"),
			},

			"Pants" : {
				#Nomad Pants Green
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-Jump_SWS.png"),
				
				#Nomad Pants Red
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-Jump_SWS.png"),
				
				#Nomad Pants Blue
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-Jump_SWS.png")
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
		
		"Climb": {
			"Head" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-ClimbLadder.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-ClimbLadder.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-ClimbLadder.png"),
			},
			
			"Hair" : {
				"Black": { # Black Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-ClimbLadder.png")
				},
				"Brown": { # Brown Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-ClimbLadder.png")
				},
				"Blond": { # Blond Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-ClimbLadder.png")
				}
			},
			"Torso" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-ClimbLadder.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-ClimbLadder.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-ClimbLadder.png"),
			},

			"Right Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-ClimbLadder.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Med-ClimbLadder.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Dark-ClimbLadder.png"),
			},
			"Gloves" : {
				"Right Glove" : {
					#Nomad Right Glove
					0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_Standard_RM-ClimbLadder.png")
				}
			},
			"Shirt": {
				0 : { #Nomad Shirt Green
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-ClimbLadder.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_Standard_RM-ClimbLadder.png")
				},
				1 : { #Nomad Shirt Red
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-ClimbLadder.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_Standard_RM-ClimbLadder.png")
				},
				2 : { #Nomad Shirt Blue
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-ClimbLadder.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_Standard_RM-ClimbLadder.png")
				}
			},
			"Legs" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-ClimbLadder.png"),
				# Medium Skin
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-ClimbLadder.png"),
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-ClimbLadder.png")
			},
			"Pants" : {
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-ClimbLadder.png"),
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-ClimbLadder.png"),
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-ClimbLadder.png")
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
				# White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Jump_Standard.png"),
				# Medium Skin
				1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-Jump_Standard.png"),
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-Jump_Standard.png")
			},
			"Eyes" : {
				"Green" : { # Green Eyes
					# Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Jump_Standard.png")
				},
				"Brown" : { # Brown Eyes
					# Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Brown-Jump_Standard.png")
				},
				"Blue" : { # Blue Eyes
					# Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Blue-Jump_Standard.png")
				}
			},
			"Hair" : {
				"Black": { # Black Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Jump_Standard.png")
				},
				"Brown": { # Brown Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-Jump_Standard.png")
				},
				"Blond": { # Blond Hair
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-Jump_Standard.png")
				}
			},
			"Left Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Jump_Standard.png"),
				# Medium Skin
				1 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Med-Jump_Standard.png"),
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Dark-Jump_Standard.png")
			},
			"Torso" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Jump_Standard.png"),
				# Medium Skin
				1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-Jump_Standard.png"),
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-Jump_Standard.png")
			},
			"Right Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Jump_Standard.png"),
				# Medium Skin
				1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Med-Jump_Standard.png"),
				# Dark Skin
				2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Dark-Jump_Standard.png")
			},
			"Gloves" : {
				"Left Glove" : {
					# Nomad Left Glove
					0 : preload("res://Assets/Player/Male/LeftArm_Male/GlovesLeftHandMale/NomadGloveLM/NomadsGlove_Standard_LM-Jump_Standard.png")
				}, 
				"Right Glove" : {
					# Nomad Right Glove
					0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_Standard_RM-Jump_Standard.png")
				}
			},
			"Shirt": {
				0 : { # Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Green_Standard_Male-Jump_Standard.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-Jump_Standard.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_Standard_RM-Jump_Standard.png")
				},
				1 : { # Nomad Shirt Red
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Red_Standard_Male-Jump_Standard.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-Jump_Standard.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_Standard_RM-Jump_Standard.png")
				},
				2 : { # Nomad Shirt Blue
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Blue_Standard_Male-Jump_Standard.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-Jump_Standard.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_Standard_RM-Jump_Standard.png")
				}
			},
			"Legs" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Jump_Standard.png"),
				# Medium Skin
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-Jump_Standard.png"),
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-Jump_Standard.png")
			},
			"Pants" : {
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-Jump_Standard.png"),
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-Jump_Standard.png"),
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-Jump_Standard.png")
			},
			"Shoes": {
				# Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Jump_Standard.png")
			},
			"Cape": {
				# Nomad Backpack
				0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Jump_Standard.png")
			}
		},

		"Dead": {
			"Head" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Death.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-Death.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-Death.png"),
			},

			"Eyes" : {
				"DeathEyes" : { # Green Eyes
					#Eyes Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/DeathEyes-Death.png")
				}
			},
			"Hair" : {
				"Black": { # Black Colors
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Death.png")
				},
				"Brown": { # Brown Colors
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-Death.png")
				},
				"Blond": { # Blond Colors
					# Hair Style 1
					0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-Death.png")
				}
			},
			"Left Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_White-Death.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Med-Death.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_Standard_Dark-Death.png"),
			},

			"Torso" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Death.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-Death.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-Death.png"),
			},

			"Right Arm" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_White-Death.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Med-Death.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_Standard_Dark-Death.png"),
			},

			"Shirt": {
				0 : { #Nomad Shirt Green
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Green_Standard_Male-Death.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-Death.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_Standard_RM-Death.png")
				},
				1 : { #Nomad Shirt Red
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Red_Standard_Male-Death.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-Death.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_Standard_RM-Death.png")
				},
				2 : { #Nomad Shirt Blue
					"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Blue_Standard_Male-Death.png"),
					"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-Death.png"),
					"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_Standard_RM-Death.png")
				}
			},
			"Legs" : {
				# White Skin
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Death.png"),
				
				# Med Skin
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-Death.png"),
				
				# Dark Skin
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-Death.png"),
			},

			"Pants" : {
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-Death.png"),
				1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-Death.png"),
				2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-Death.png")
			},
			"Shoes": {
				#Nomad Shoes
				0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Death.png")
			},
			"Cape": {
				#Nomad Backpack
				0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Death.png")
			},			
	},
	"Attack1": {
		"Head" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Basic_SWS_Attack.png"),
			# Med Skin
			1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-Basic_SWS_Attack.png"),
			# Dark Skin
			2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-Basic_SWS_Attack.png")
		},
		"Eyes" : {
			"Green" : { # Green Eyes
				# Eyes Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Basic_SWS_Attack.png")
			},
			"Brown" : { # Brown Eyes
				# Eyes Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Brown-Basic_SWS_Attack.png")
			},
			"Blue" : { # Blue Eyes
				# Eyes Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Blue-Basic_SWS_Attack.png")
			}
		},
		"Hair" : {
			"Black": { # Black Colors
				# Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Basic_SWS_Attack.png")
			},
			"Brown": { # Brown Colors
				# Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-Basic_SWS_Attack.png")
			},
			"Blond": { # Blond Colors
				# Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-Basic_SWS_Attack.png")
			}
		},
		"Left Arm" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_White-Basic_SWS_Attack.png"),
			# Med Skin (Set to White_Skin subfolder)
			1 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_Med-Basic_SWS_Attack.png"),
			# Dark Skin (Set to White_Skin subfolder)
			2 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_Dark-Basic_SWS_Attack.png")
		},
		
		"Gloves" : {
			"Left Glove" : {
				# Nomad Left Glove
				0 : preload("res://Assets/Player/Male/LeftArm_Male/GlovesLeftHandMale/NomadGloveLM/NomadsGlove_SWS_LM-Basic_SWS_Attack.png")
			}, 
			"Right Glove" : {
				# Nomad Right Glove
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_SWS_RM-Basic_SWS_Attack.png")
			}
		},
		
		"Torso" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Basic_SWS_Attack.png"),
			# Med Skin
			1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-Basic_SWS_Attack.png"),
			# Dark Skin
			2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-Basic_SWS_Attack.png")
		},
		"Right Arm" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_White-Basic_SWS_Attack.png"),
			# Med Skin (Set to White_Skin subfolder)
			1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_Med-Basic_SWS_Attack.png"),
			# Dark Skin (Set to White_Skin subfolder)
			2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_Dark-Basic_SWS_Attack.png")
		},
		"Shirt": {
			0 : { # Nomad Shirt Green
				"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Green_SWS_Male-Basic_SWS_Attack.png"),
				"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-Basic_SWS_Attack.png"),
				"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_SWS_RM-Basic_SWS_Attack.png")
			},
			1 : { # Nomad Shirt Red
				"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Red_SWS_Male-Basic_SWS_Attack.png"),
				"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-Basic_SWS_Attack.png"),
				"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_SWS_RM-Basic_SWS_Attack.png")
			},
			2 : { # Nomad Shirt Blue
				"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Blue_SWS_Male-Basic_SWS_Attack.png"),
				"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-Basic_SWS_Attack.png"),
				"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_SWS_RM-Basic_SWS_Attack.png")
			}
		},
		"Legs" : {
			# White Skin
			0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Basic_SWS_Attack.png"),
			# Med Skin
			1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-Basic_SWS_Attack.png"),
			# Dark Skin
			2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-Basic_SWS_Attack.png")
		},
		"Pants" : {
			# Nomad Pants Green
			0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-Basic_SWS_Attack.png"),
			
			# Nomad Pants Red
			1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-Basic_SWS_Attack.png"),
			
			# Nomad Pants Blue
			2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-Basic_SWS_Attack.png")
		},
		"Shoes": {
			# Nomad Shoes
			0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Basic_SWS_Attack.png")
		},
		"Cape": {
			# Nomad Backpack
			0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Basic_SWS_Attack.png")
		},
		"Sword" : {
			# Wooden Sword
			0 : preload("res://Assets/Player/Male/OneHandedSwords/WoodenSword-Basic_SWS_Attack.png")
		},
		"Shield" : {
			0 : preload("res://Assets/Player/Male/Shields/WoodenShield-Basic_SWS_Attack.png")
		},
		"Effect" : {
			0 : preload("res://Assets/Player/Effects-Basic_SWS_Attack.png")
		}
	},
	"Attack2": {
		"Head" : {
			#White Skin
			0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Basic_SWS_Attack.png"),
			#Med Skin
			1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-Basic_SWS_Attack.png"),
			#Dark Skin
			2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-Basic_SWS_Attack.png")
		},
		"Eyes" : {
			"Green" : { # Green Eyes
				# Eyes Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Basic_SWS_Attack.png")
			},
			"Brown" : { # Brown Eyes
				# Eyes Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Brown-Basic_SWS_Attack.png")
			},
			"Blue" : { # Blue Eyes
				# Eyes Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Blue-Basic_SWS_Attack.png")
			}
		},
		"Hair" : {
			"Black": { # Black Colors
				# Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Basic_SWS_Attack.png")
			},
			"Brown": { # Brown Colors
				# Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-Basic_SWS_Attack.png")
			},
			"Blond": { # Blond Colors
				# Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-Basic_SWS_Attack.png")
			}
		},
		"Left Arm" : {
			#White Skin
			0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_White-Basic_SWS_Attack.png"),
			#Med Skin (under White_Skin)
			1 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_Med-Basic_SWS_Attack.png"),
			#Dark Skin (under White_Skin)
			2 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_Dark-Basic_SWS_Attack.png")
		},

		"Gloves" : {
			"Left Glove" : {
				#Nomad Left Glove
				0 : preload("res://Assets/Player/Male/LeftArm_Male/GlovesLeftHandMale/NomadGloveLM/NomadsGlove_SWS_LM-Basic_SWS_Attack.png")
			}, 
			"Right Glove" : {
				#Nomad Right Glove
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_SWS_RM-Basic_SWS_Attack.png")
			}
		},

		"Torso" : {
			#White Skin
			0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Basic_SWS_Attack.png"),
			#Med Skin
			1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-Basic_SWS_Attack.png"),
			#Dark Skin
			2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-Basic_SWS_Attack.png")
		},
		"Right Arm" : {
			#White Skin
			0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_White-Basic_SWS_Attack.png"),
			#Med Skin (under White_Skin)
			1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_Med-Basic_SWS_Attack.png"),
			#Dark Skin (under White_Skin)
			2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_Dark-Basic_SWS_Attack.png")
		},
		"Shirt": {
			0 : { # Nomad Shirt Green
				"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Green_SWS_Male-Basic_SWS_Attack.png"),
				"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-Basic_SWS_Attack.png"),
				"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_SWS_RM-Basic_SWS_Attack.png")
			},
			
			1 : { # Nomad Shirt Red
				"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Red_SWS_Male-Basic_SWS_Attack.png"),
				"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-Basic_SWS_Attack.png"),
				"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_SWS_RM-Basic_SWS_Attack.png")
			},
			
			2 : { # Nomad Shirt Blue
				"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Blue_SWS_Male-Basic_SWS_Attack.png"),
				"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-Basic_SWS_Attack.png"),
				"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_SWS_RM-Basic_SWS_Attack.png")
			}
		},
		"Legs" : {
			#White Skin
			0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Basic_SWS_Attack.png"),
			#Med Skin
			1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-Basic_SWS_Attack.png"),
			#Dark Skin
			2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-Basic_SWS_Attack.png")
		},
		"Pants" : {
			0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-Basic_SWS_Attack.png"),
			
			1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-Basic_SWS_Attack.png"),
			
			2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-Basic_SWS_Attack.png")
		},
		"Shoes": {
			#Nomad Shoes
			0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Basic_SWS_Attack.png")
		},
		"Cape": {
			#Nomad Backpack
			0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Basic_SWS_Attack.png")
		},
		"Sword" : {
			#Wooden Sword
			0 : preload("res://Assets/Player/Male/OneHandedSwords/WoodenSword-Basic_SWS_Attack.png")
		},
		"Shield" : {
			0 : preload("res://Assets/Player/Male/Shields/WoodenShield-Basic_SWS_Attack.png")
		},
		"Effect" : {
			0 : preload("res://Assets/Player/Effects-Basic_SWS_Attack.png")
		}
	},

	"Attack3": {
		"Head" : {
			#White Skin
			0 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_White_Male-Basic_SWS_Attack.png"),
			#Med Skin (under White_Skin)
			1 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Med_Male-Basic_SWS_Attack.png"),
			#Dark Skin (under White_Skin)
			2 : preload("res://Assets/Player/Male/Head_Male/Heads_Male/Head_Dark_Male-Basic_SWS_Attack.png")
		},
		"Eyes" : {
			"Green" : { # Green Eyes
				# Eyes Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Green-Basic_SWS_Attack.png")
			},
			"Brown" : { # Brown Eyes
				# Eyes Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Brown-Basic_SWS_Attack.png")
			},
			"Blue" : { # Blue Eyes
				# Eyes Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Eyes_Male/Eyes1Blue-Basic_SWS_Attack.png")
			}
		},
		"Hair" : {
			"Black": { # Black Colors
				# Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Black-Basic_SWS_Attack.png")
			},
			"Brown": { # Brown Colors
				# Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Brown-Basic_SWS_Attack.png")
			},
			"Blond": { # Blond Colors
				# Hair Style 1
				0 : preload("res://Assets/Player/Male/Head_Male/Hair_Male/Hair1Blond-Basic_SWS_Attack.png")
			}
		},
		"Left Arm" : {
			#White Skin
			0 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_White-Basic_SWS_Attack.png"),
			#Med Skin (under White_Skin)
			1 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_Med-Basic_SWS_Attack.png"),
			#Dark Skin (under White_Skin)
			2 : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/White_Skin/LeftArm_SWS_Dark-Basic_SWS_Attack.png")
		},

		"Gloves" : {
			"Left Glove" : {
				#Nomad Left Glove
				0 : preload("res://Assets/Player/Male/LeftArm_Male/GlovesLeftHandMale/NomadGloveLM/NomadsGlove_SWS_LM-Basic_SWS_Attack.png")
			}, 
			"Right Glove" : {
				#Nomad Right Glove
				0 : preload("res://Assets/Player/Male/RightArm_Male/RightGloves_Male/NomadGloveRM/NomadGlove_SWS_RM-Basic_SWS_Attack.png")
			}
		},

		"Torso" : {
			#White Skin
			0 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_White_M-Basic_SWS_Attack.png"),
			#Med Skin (under White_Skin)
			1 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Med_M-Basic_SWS_Attack.png"),
			#Dark Skin (under White_Skin)
			2 : preload("res://Assets/Player/Male/Torso_Male/Torsos_Male/Torso_Dark_M-Basic_SWS_Attack.png")
		},
		"Right Arm" : {
			#White Skin
			0 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_White-Basic_SWS_Attack.png"),
			#Med Skin (under White_Skin)
			1 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_Med-Basic_SWS_Attack.png"),
			#Dark Skin (under White_Skin)
			2 : preload("res://Assets/Player/Male/RightArm_Male/RightArms_Male/White_Skin/RightArm_SWS_Dark-Basic_SWS_Attack.png")
		},
		"Shirt": {
			0 : { # Nomad Shirt Green
				"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Green_SWS_Male-Basic_SWS_Attack.png"),
				"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Green-Basic_SWS_Attack.png"),
				"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Green_SWS_RM-Basic_SWS_Attack.png")
			},
			1 : { # Nomad Shirt Red
				"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Red_SWS_Male-Basic_SWS_Attack.png"),
				"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Red-Basic_SWS_Attack.png"),
				"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Red_SWS_RM-Basic_SWS_Attack.png")
			},
			2 : { # Nomad Shirt Blue
				"Left Sleeve" : preload("res://Assets/Player/Male/LeftArm_Male/LeftArmsMale/ShirtsLeftSleevesMale/NomadShirtSleeveLeft_Male/NomadShirtLSleeve_Blue_SWS_Male-Basic_SWS_Attack.png"),
				"Torso Shirt" : preload("res://Assets/Player/Male/Torso_Male/ShirtTorsos_Male/NomadShirtTorsoM_Blue-Basic_SWS_Attack.png"),
				"Right Sleeve" : preload("res://Assets/Player/Male/RightArm_Male/RightShirtSleeves_Male/NomadShirtSleeve_Blue_SWS_RM-Basic_SWS_Attack.png")
			}
		},
		"Legs" : {
			#White skin
			0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_White-Basic_SWS_Attack.png"),
			#Med Skin (under White_Skin)
			1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Med-Basic_SWS_Attack.png"),
			#Dark Skin (under White_Skin)
			2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/Legs_Dark-Basic_SWS_Attack.png")
		},
		"Pants" : {
			0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Green-Basic_SWS_Attack.png"),
			1 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Red-Basic_SWS_Attack.png"),
			2 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/PantsMale/NomadPantsM_Blue-Basic_SWS_Attack.png")
		},
		"Shoes": {
			#Nomad Shoes
			0 : preload("res://Assets/Player/Male/LowerBody_Male/LegsMale/BottomsMale/NomadBootsM-Basic_SWS_Attack.png")
		},
		"Cape": {
			#Nomad Backpack
			0 : preload("res://Assets/Player/Male/Capes/NomadBackPack-Basic_SWS_Attack.png")
		},
		"Sword" : {
			#Wooden Sword
			0 : preload("res://Assets/Player/Male/OneHandedSwords/WoodenSword-Basic_SWS_Attack.png")
		},
		"Shield" : {
			0 : preload("res://Assets/Player/Male/Shields/WoodenShield-Basic_SWS_Attack.png")
		},
		"Effect" : {
			0 : preload("res://Assets/Player/Effects-Basic_SWS_Attack.png")
		}
	},
	
	}
}
