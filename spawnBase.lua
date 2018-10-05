baseSize = 15
local tiles = {};
for y=0,baseSize-1 do
 for x=0,baseSize-1 do
  table.insert(tiles, {name="grass-1", position={x, y}})
  table.insert(tiles, {name="refined-concrete", position={x, y}})
 end
 game.player.surface.set_tiles(tiles)
end

local entities = game.surfaces[1].find_entities({{0, 0}, {baseSize, baseSize}})
for key, val in pairs(entities) do
	if val.name == "player" then
		val.teleport(game.surfaces[1].find_non_colliding_position("player", {-32,-32}, 0,1))
	else
		val.destroy(nil)
	end
end

local entities = game.surfaces[1].find_entities({{0, 0}, {baseSize, baseSize}})
for key, val in pairs(entities) do
	val.destroy(nil)
end


local baseDesign = {
1,1,1,1,1,1,4,4,4,1,1,1,1,1,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,2,0,0,0,0,0,0,0,0,0,0,2,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
7,0,0,0,0,0,0,0,0,0,0,0,0,0,5,
7,0,0,0,0,0,0,3,0,0,0,0,0,0,5,
7,0,0,0,0,0,0,0,0,0,0,0,0,0,5,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,2,0,0,0,0,0,0,0,0,0,0,2,1,
1,1,1,1,1,1,6,6,6,1,1,1,1,1,1,
};

for x=0, #baseDesign do
	if baseDesign[x] == 1 then
		game.surfaces[1].create_entity({name="stone-wall", position={(x-1) % baseSize, math.floor((x-1)/15)}, force="player"})
	end
	if baseDesign[x] == 2 then
		local entity = game.surfaces[1].create_entity({name="gun-turret", position={(x-1) % baseSize, math.floor((x-1)/15)}, force="player"})
		entity.insert({name="firearm-magazine", count=25})
	end
	if baseDesign[x] == 3 then
		game.surfaces[1].create_entity({name="escape-rocket-silo", position={(x-1) % baseSize, math.floor((x-1)/15)}, force="player"})
	end	
	if baseDesign[x] == 4 then
		game.surfaces[1].create_entity({name="gate", position={(x-1) % baseSize, math.floor((x-1)/15)}, force="player", direction=defines.direction.east})
	end	
	if baseDesign[x] == 5 then
		game.surfaces[1].create_entity({name="gate", position={(x-1) % baseSize, math.floor((x-1)/15)}, force="player", direction=defines.direction.north})
	end	
	if baseDesign[x] == 6 then
		game.surfaces[1].create_entity({name="gate", position={(x-1) % baseSize, math.floor((x-1)/15)}, force="player", direction=defines.direction.east})
	end
	if baseDesign[x] == 7 then
		game.surfaces[1].create_entity({name="gate", position={(x-1) % baseSize, math.floor((x-1)/15)}, force="player", direction=defines.direction.north})
	end
end
