local laserTurret = table.deepcopy(data.raw["electric-turret"]["laser-turret"])

laserTurret.minable = { mining_time = 0.5, result = "defense-turret" };
laserTurret.name = "defense-turret";
laserTurret.rotation_speed = 1;
laserTurret.preparing_speed = 1;
laserTurret.attack_parameters = {
      type = "projectile",
      ammo_category = "electric",
      damage_modifier = 1,
      cooldown = 150,
      projectile_center = {0, 0},
      projectile_creation_distance = 0.6,
      range = 3,
      sound =
      {
         filename = "__base__/sound/fight/pulse.ogg",
         volume = 0.7
      },
      ammo_type =
      {
        type = "projectile",
        category = "laser-turret",
        action =
        {
          {
            type = "area",
            radius = 8,
            force = "enemy",
            action_delivery =
            {
             {
               type = "instant",
               target_effects =
               {
                {
                  type = "push-back",
                  distance = 2,
                }
               }
             },
             {
               type = "beam",
               beam = "electric-beam-no-sound",
               max_length = 16,
               duration = 15,
               source_offset = {0, -0.5},
               add_to_shooter = false
             }
            }
          }
        }
      },
    };

data:extend{laserTurret}
