script.on_init(function()
	global.camera = nil;
	global.entity = nil;
	global.tracked_biters = {}
	global.last_change = 0;
	global.following_attack = false;
	global.eclipse = false;
	global.hydra_biter = {}
	global.hydra_biter.multiplication_rate = 2
	if game.forces.twitch == nil then
		local twitch_force = game.create_force("twitch");
		local enemy = game.forces["enemy"];
		twitch_force.set_friend(enemy,true);
		enemy.set_friend(twitch_force,true);
	end
	
end)


script.on_event(defines.events.on_player_joined_game, function(event)
	if game.players[event.player_index].name == "NexusNull_Bot" then
		global.camera = game.players[event.player_index];
		global.camera.name = "";
		local char = global.camera.character;
		if char then
			global.camera.character = nil;
			char.destroy();
		end
	end
end)

script.on_event(defines.events.on_tick, function(event)
	if global.camera then
		if global.entity then
			global.camera.teleport(global.entity.position);
		else
			global.camera.teleport(game.players[1].position);
		end
	end
	
	if global.last_change > 60*20 and not following_attack then
		local target = nil;
		local level = 0;
		for key, val in pairs(global.tracked_biters) do
			if val.valid and val.unit_group and #val.unit_group.members > 4 then
				if val.unit_group.state > level and val.unit_group.state ~= 4 then
					level = val.unit_group.state;
					target = val
				end
			end
		end
		if target == nil then
			local last = nil;
			for key, val in pairs(game.players) do
				if val.connected and val.name ~= "" then
					if not last then
						last = val;
					elseif val.afk_time < last.afk_time then
						last = val;
					end
				end
			end
			global.entity = last;
		else
			global.entity = target;
		end
		global.last_change = 0;
	end

	global.last_change = global.last_change+1;
	if global.eclipse then
		game.surfaces[1].ticks_per_day = 50;
		if game.surfaces[1].daytime > 0.25 and game.surfaces[1].daytime < 0.45 then
			game.surfaces[1].ticks_per_day = 4000;
		end
	end
	if game.surfaces[1].daytime < 0.55 and game.surfaces[1].daytime > 0.45 then
		game.surfaces[1].ticks_per_day = 50000;
	end
	if game.surfaces[1].daytime > 0.55 and global.eclipse then
		game.surfaces[1].ticks_per_day = 25000;
		global.eclipse = false;
	end
	
end)

script.on_event(defines.events.on_player_left_game, function(event)
	if game.players[event.player_index] == global.camera then
		global.camera = nil;
	end
end)

script.on_event(defines.events.on_entity_died, function(event)
	game.players[1].print(event.entity.name)
	if event.entity.name == "medium-hydra-biter" then
		for i=0, global.hydra_biter.multiplication_rate do
			pos = game.surfaces[1].find_non_colliding_position("small-hydra-biter", {0,0}, 0,1)
			event.entity.surface.create_entity({name="small-hydra-biter", position = pos, force="twitch"})
		end
	elseif event.entity.name == "big-hydra-biter" then
			for i=0, global.hydra_biter.multiplication_rate do
			pos = game.surfaces[1].find_non_colliding_position("small-hydra-biter", {0,0}, 0,1)
			event.entity.surface.create_entity({name="small-hydra-biter", position = pos, force="twitch"})
		end
	elseif event.entity.name == "behemoth-hydra-biter" then
			for i=0, global.hydra_biter.multiplication_rate do
			pos = game.surfaces[1].find_non_colliding_position("small-hydra-biter", {0,0}, 0,1)
			event.entity.surface.create_entity({name="small-hydra-biter", position = pos, force="twitch"})
		end
	end
	if event.entity.force.name == "twitch" then
		global.tracked_biters[event.entity.unit_number] = nil;
		if global.entity == event.entity then 
			local entity = game.surfaces[1].find_entities_filtered({
			area = {{-15+event.entity.position.x, -15+event.entity.position.y}, {15+event.entity.position.x, 15+event.entity.position.y}},
			force = "twitch",
			limit = 1
			})[1];
			if entity == nil then
				following_attack = false
				global.last_change = 60*20
			else
				global.entity = enity;
			end
		end
	elseif event.entity.force.name == "player" and event.force == "twitch" then
		if global.last_change > 60*5 and not following_attack then
			following_attack = true;
			global.entity = event.cause;
		end
	end
end)

checkChunk = function(x,y)
	return game.surfaces[1].count_entities_filtered({
	area = {{x*32, y*32}, {x*32+32,y*32+32}},
	force = "player",
	limit = 1
	});
end




remote.add_interface("twitch_vs_nexus",{
	spawn_twitch_attack = function (list, position)
		local unit_group = nil;
		for key, val in pairs(list) do
			if game.entity_prototypes[key] and val > 0 then
				if unit_group == nil then
					unit_group = game.surfaces[1].create_unit_group({position= position,force="twitch"});
				end
				for i=1,val do
					local freePos = game.surfaces[1].find_non_colliding_position(key, position, math.sqrt(#list), 1) 
					local entity = game.surfaces[1].create_entity({name=key, position=freePos, force="twitch"})
					if entity then
						global.tracked_biters[entity.unit_number] = entity;
					end
					unit_group.add_member(entity);
				end
			end
		end
		unit_group.set_command({type=defines.command.attack_area, destination={0,0}, radius = 50, distraction = defines.distraction.by_anything})
	end,
	get_blocked_chunks = function()
		list = {};
		local x,y,right,left,top,bottom = 0,0,1,-1,-1,1;
		local count = 0;
		local limit = 10000;
		while count < limit do
			while x ~= right and count < limit do
				if checkChunk(x,y) == 1 then
					table.insert(list,{x,y});
				end
				count=count+1
				x=x+1
			end
			right = right+1;
			
			while y ~= top and count < limit do
				if checkChunk(x,y) == 1 then
					table.insert(list,{x,y});
				end
				count=count+1
				y=y-1
			end
			top = top-1
		  
			while x ~= left and count < limit do
				if checkChunk(x,y) == 1 then
					table.insert(list,{x,y});
				end
				count=count+1
				x=x-1
			end
			left=left-1
			
			while y ~= bottom and count < limit do
				if checkChunk(x,y) == 1 then
					table.insert(list,{x,y});
				end
				count=count+1
				y=y+1
			end
			bottom=bottom+1;
		end
		return list;
	end,
	
	cause_eclipse = function()
		global.eclipse = true;
	end,
	
	can_cause_eclipse = function() 
		return not global.eclipse;
	end,
	
	spawn_escape_rocket_silo = function (list, position)
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
	end
});