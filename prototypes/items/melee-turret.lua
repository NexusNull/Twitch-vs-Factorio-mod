local laserTurretItem = table.deepcopy(data.raw.item["laser-turret"])

laserTurretItem.name = "defense-turret";
laserTurretItem.place_result = "defense-turret";

data:extend{laserTurretItem}