local recepie = table.deepcopy(data.raw.recipe["laser-turret"])

recepie.name = "defense-turret"
recepie.result = "defense-turret"
recepie.enabled = true


data:extend{recepie}