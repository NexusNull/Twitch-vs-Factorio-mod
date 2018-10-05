local escape_rocket_silo = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"]);
local escape_rocket_silo_rocket = table.deepcopy(data.raw["rocket-silo-rocket"]["rocket-silo-rocket"]);
local escape_rocket_silo_item = table.deepcopy(data.raw["item"]["rocket-silo"]);
local escape_rocket_part = table.deepcopy(data.raw["item"]["rocket-part"]);
local escape_rocket_part_recipe = table.deepcopy(data.raw["recipe"]["rocket-part"]);

--Item
escape_rocket_silo_item.name = "escape_rocket_silo";
escape_rocket_silo_item.place_result = "escape-rocket-silo"

escape_rocket_part.name = "escape-rocket-part";
escape_rocket_part.enabled = true;

--Entity

escape_rocket_silo.falgs = {"not-on-map"}
escape_rocket_silo.name = "escape-rocket-silo"
escape_rocket_silo.allowed_effects = {}
escape_rocket_silo.mineable = {minable = false}
escape_rocket_silo.module_specification =
    {
      module_slots = 0,
      module_info_icon_shift = {0, 4.3}
    }
escape_rocket_silo.fixed_recipe = "escape-rocket-part";
escape_rocket_silo.ingredient_count = 3;
escape_rocket_silo.rocket_parts_required = 100
escape_rocket_silo.fluid_boxes = {{
        production_type = "input",
        pipe_picture = assembler3pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = {{ type="input", position = {0, -5.5} }},
        secondary_draw_orders = { north = -1 }
      }}
--Recipe
escape_rocket_part_recipe.name = "escape-rocket-part"
escape_rocket_part_recipe.result = "escape-rocket-part"
escape_rocket_part_recipe.enabled = true;
escape_rocket_part_recipe.energy_required = 1
escape_rocket_part_recipe.ingredients =
    {
      {type="item", name="iron-plate", amount=10},
      {type="item", name="copper-plate", amount=10},
      {type="item", name="steel-plate", amount=10},
	  {type="fluid", name="heavy-oil", amount=10},
    }
--Rocket
escape_rocket_silo_rocket.name = "escape-rocket-silo-rocket"
data:extend{escape_rocket_part,escape_rocket_part_recipe,escape_rocket_silo, escape_rocket_silo_item, escpae_rocket_silo_rocket}