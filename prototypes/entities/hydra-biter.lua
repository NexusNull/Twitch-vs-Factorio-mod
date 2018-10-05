local small_biter = table.deepcopy(data.raw["unit"]["small-biter"]);
local medium_biter = table.deepcopy(data.raw["unit"]["medium-biter"]);
local big_biter = table.deepcopy(data.raw["unit"]["big-biter"]);
local behemoth_biter = table.deepcopy(data.raw["unit"]["behemoth-biter"]);

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



--Small hydra biter
small_biter.name = "small-hydra-biter";
small_biter.max_health = 15;
small_biter.attack_parameters.animations = biterattackanimation(small_biter_scale, small_biter_tint1, small_biter_tint2)
small_biter.run_animation = biterrunanimation(small_biter_scale, small_biter_tint1, small_biter_tint2)

--medium hydra biter
medium_biter.name = "medium-hydra-biter";
medium_biter.max_health = 60;
medium_biter.attack_parameters.animations = biterattackanimation(medium_biter_scale, medium_biter_tint1, medium_biter_tint2)
medium_biter.run_animation = biterrunanimation(medium_biter_scale, medium_biter_tint1, medium_biter_tint2)
medium_biter.resistances =
    {
      {
        type = "physical",
        decrease = 4,
        percent = 10,
      }
    };
	
--big hydra biter
big_biter.name = "big-hydra-biter";
big_biter.max_health = 170;
big_biter.attack_parameters.animations = biterattackanimation(big_biter_scale, big_biter_tint1, big_biter_tint2)
big_biter.run_animation = biterrunanimation(big_biter_scale, big_biter_tint1, big_biter_tint2)
big_biter.resistances =
    {
      {
        type = "physical",
        decrease = 8,
        percent = 10,
      }
    };
	
--behemoth hydra biter
behemoth_biter.name = "behemoth-hydra-biter";
behemoth_biter.max_health = 2000;
behemoth_biter.attack_parameters.animations = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2)
behemoth_biter.run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2)
	
data:extend{small_biter,medium_biter,big_biter,behemoth_biter}