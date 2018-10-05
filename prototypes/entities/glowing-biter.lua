local small_biter = table.deepcopy(data.raw["unit"]["small-biter"]);


small_biter_scale = 0.7
small_biter_tint1 = {r=0.7, g=0.6, b=0, a=0.7}
small_biter_tint2 = {r=.8, g=.8, b=.8, a=0.4}

--Small exploding biter
small_biter.name = "small-glowing-biter";
small_biter.max_health = 15;
small_biter.attack_parameters.animations = biterattackanimation(small_biter_scale, small_biter_tint1, small_biter_tint2)
small_biter.run_animation = biterrunanimation(small_biter_scale, small_biter_tint1, small_biter_tint2)
small_biter.light = {intensity = 0.8, size = 15},
data:extend{small_biter}