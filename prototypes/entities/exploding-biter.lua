local small_biter = table.deepcopy(data.raw["unit"]["small-biter"]);
local medium_biter = table.deepcopy(data.raw["unit"]["medium-biter"]);
local big_biter = table.deepcopy(data.raw["unit"]["big-biter"]);
local behemoth_biter = table.deepcopy(data.raw["unit"]["behemoth-biter"]);

normal_explosion = {
target_type = "entity",
category = "melee",
action =
	  {
		type = "direct",
		action_delivery =
		{
			type = "instant",
			source_effects =
			{
			  {
				type = "nested-result",
				affects_target = true,
				action =
				{
				  type = "area",
				  radius = 6,
				  action_delivery =
				  {
					type = "instant",
					target_effects =
					{
					  {
						type = "damage",
						damage = { amount = 30, type = "explosion"}
					  }
					}
				  }
				},
			  },
			  {
				type = "create-entity",
				entity_name = "blood-explosion-huge",
			  },
			  {
            type = "create-entity",
            entity_name = "small-scorchmark",
            check_buildability = true
		      },
			}
			
		}
	  }
};

nuclear_explosion = {
target_type = "entity",
category = "melee",
action = {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          {
              repeat_count = 100,
              type = "create-trivial-smoke",
              smoke_name = "nuclear-smoke",
              offset_deviation = {{-1, -1}, {1, 1}},
              slow_down_factor = 1,
              starting_frame = 3,
              starting_frame_deviation = 5,
              starting_frame_speed = 0,
              starting_frame_speed_deviation = 5,
              speed_from_center = 0.5,
              speed_deviation = 0.2
          },
          {
            type = "create-entity",
            entity_name = "explosion"
          },
          {
            type = "damage",
            damage = {amount = 400, type = "explosion"}
          },
          {
            type = "create-entity",
            entity_name = "small-scorchmark",
            check_buildability = true
          },
          {
            type = "nested-result",
            action =
            {
              type = "area",
              target_entities = false,
              repeat_count = 2000,
              radius = 35,
              action_delivery =
              {
                type = "projectile",
                projectile = "atomic-bomb-wave",
                starting_speed = 0.5
              }
            }
          }
        }
      }
    },
};



small_biter_scale = 0.7
small_biter_tint1 = {r=0.6, g=0.8, b=0.1, a=1}
small_biter_tint2 = {r=1, g=0, b=0, a=0}

medium_biter_scale = 0.8
medium_biter_tint1 = {r=0.7, g=0.8, b=0.3, a=1}
medium_biter_tint2 = {r=1, g=0, b=0, a=0}

big_biter_scale = 0.9
big_biter_tint1 = {r=0.71, g=0.8, b=0.6, a=1}
big_biter_tint2 = {r=1, g=0, b=0, a=0}

behemoth_biter_scale = 1
behemoth_biter_tint1 = {r=0.73, g=0.9, b=0.7, a=1}
behemoth_biter_tint2 = {r=1, g=0, b=0, a=0}



--Small exploding biter
small_biter.name = "small-exploding-biter";
small_biter.max_health = 15;
small_biter.attack_parameters.ammo_type = normal_explosion;
small_biter.attack_parameters.ammo_type.action.action_delivery.source_effects[1].action.radius = 3
small_biter.attack_parameters.ammo_type.action.action_delivery.source_effects[1].action.action_delivery.target_effects[1].damage.amount = 15;
small_biter.attack_parameters.animations = biterattackanimation(small_biter_scale, small_biter_tint1, small_biter_tint2)
small_biter.run_animation = biterrunanimation(small_biter_scale, small_biter_tint1, small_biter_tint2)
small_biter.corpse = nil;
--medium exploding biter
medium_biter.name = "medium-exploding-biter";
medium_biter.max_health = 45;
medium_biter.attack_parameters.ammo_type = normal_explosion;
medium_biter.attack_parameters.ammo_type.action.action_delivery.source_effects[1].action.radius = 5
medium_biter.attack_parameters.ammo_type.action.action_delivery.source_effects[1].action.action_delivery.target_effects[1].damage.amount = 45;
medium_biter.attack_parameters.animations = biterattackanimation(medium_biter_scale, medium_biter_tint1, medium_biter_tint2)
medium_biter.run_animation = biterrunanimation(medium_biter_scale, medium_biter_tint1, medium_biter_tint2)
medium_biter.corpse = nil;
medium_biter.resistances =
    {
      {
        type = "physical",
        decrease = 4,
        percent = 10,
      }
    };
	
--big exploding biter
big_biter.name = "big-exploding-biter";
big_biter.max_health = 120;
big_biter.attack_parameters.ammo_type = normal_explosion;
big_biter.attack_parameters.ammo_type.action.action_delivery.source_effects[1].action.radius = 6
big_biter.attack_parameters.ammo_type.action.action_delivery.source_effects[1].action.action_delivery.target_effects[1].damage.amount = 120;
big_biter.attack_parameters.animations = biterattackanimation(big_biter_scale, big_biter_tint1, big_biter_tint2)
big_biter.run_animation = biterrunanimation(big_biter_scale, big_biter_tint1, big_biter_tint2)
big_biter.corpse = nil;
big_biter.resistances =
    {
      {
        type = "physical",
        decrease = 8,
        percent = 10,
      }
    };
	
--behemoth exploding biter
behemoth_biter.name = "behemoth-exploding-biter";
behemoth_biter.max_health = 250;
behemoth_biter.attack_parameters.ammo_type = normal_explosion;
behemoth_biter.attack_parameters.ammo_type.action.action_delivery.source_effects[1].action.radius = 6
behemoth_biter.attack_parameters.ammo_type.action.action_delivery.source_effects[1].action.action_delivery.target_effects[1].damage.amount = 250;
behemoth_biter.attack_parameters.animations = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2)
behemoth_biter.run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2)
behemoth_biter.corpse = nil;
behemoth_biter.resistances =
    {
      {
        type = "physical",
        decrease = 12,
        percent = 10,
      }
    };
	
data:extend{small_biter,medium_biter,big_biter,behemoth_biter}