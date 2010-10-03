-------------------------------------------------
-- LOVE: Tiled Game Practice Range
-------------------------------------------------
require("map.lua")
require("player.lua")

function love.load()
	Debug = true

	
	-- The amazing music.
	--music = love.audio.newSource("wip1.it")
	--music:setLooping(true)
	--music:setPitch(1)
	--love.audio.play(music)
	--love.audio.setVolume(1.5)	





	
	TilePicking = false
	
	--Create the tileset
	TilesImageData = love.image.newImageData("alphatiles.png")
	TilesImage = love.graphics.newImage("alphatiles.png")
	tileImagepile = {}
	
	--a 640x480 graphic is 20x15 tiles
	for j=0,14 do
		for i=0,19 do
			tileImagepile[i+j*15]= love.image.newImageData(32,32)
			tileImagepile[i+j*15]:paste(TilesImageData,0,0,32*i,32*j,32,32)
		end
	end

	--load and Image-ify the map
	map:load()
	map:generate()
	player:groundcheck(map.x,map.y)

	--Create the player character
	virawalk = {}
	virawalk[0] = love.graphics.newImage("virwalk0001.png")
	virawalk[1] = love.graphics.newImage("virwalk0002.png")
	virawalk[2] = love.graphics.newImage("virwalk0003.png")
	virawalk[3] = love.graphics.newImage("virwalk0004.png")
	virawalk[4] = love.graphics.newImage("virwalk0005.png")
	virawalk[5] = love.graphics.newImage("virwalk0006.png")
	virawalk[6] = love.graphics.newImage("virwalk0007.png")
	virawalk[7] = love.graphics.newImage("virwalk0008.png")
	virawalk[8] = love.graphics.newImage("virwalk0009.png")
	virawalk[9] = love.graphics.newImage("virwalk0010.png")
	virawalk[10] = love.graphics.newImage("virwalk0011.png")
	viracrouch = love.graphics.newImage("viracrouch.png")
	virajump = love.graphics.newImage("virajump.png")
	
	
	
	love.graphics.setBackgroundColor(0x00, 0x00, 0x22)
	
	love.graphics.setColor(255, 255, 255, 200)
	love.graphics.setColorMode("modulate")


	--success = love.graphics.setMode( 640, 480, false )
end



function love.draw()
	if TilePicking then
		love.graphics.draw(TilesImage)
	else
		map:render()
		player:render(map.x,map.y)
	end
	
	if Debug then
		love.graphics.print("TX = " .. player.MapMark1X, 0, 15)
		love.graphics.print("TY = " .. player.MapMark1Y, 0, 30)
		love.graphics.print("Map[ty][tx] = " .. map.mapdata[player.MapMark1Y][player.MapMark1X], 0, 45)
		love.graphics.print("FPS = " .. love.timer.getFPS(), 0, 60)
		
		--Draw the MapMarker
		mmx = player.MapMark1X
		mmy = player.MapMark1Y-1
		if(player.onground) then
			love.graphics.line(mmx*32+map.x,mmy*32,(mmx+1)*32+map.x,(mmy+1)*32)
		end
		love.graphics.line(mmx*32+map.x,mmy*32,
						(mmx+1)*32+map.x,mmy*32,
						(mmx+1)*32+map.x,(mmy+1)*32,
						mmx*32+map.x,(mmy+1)*32,
						mmx*32+map.x,mmy*32)
	
	end
end

function love.keypressed(k)
	if k == "r" then
		love.filesystem.load("main.lua")()
	end
	if k == "0" then
		changed = love.graphics.toggleFullscreen( )
	end
	
	if k == "w" then
		if(not player.jumping) then
			player:jump();
		end
	end
	
    if k == 'escape' then
        love.event.push('q') -- quit the game
    end 		
		
		
	if k == '`' then
		TilePicking = true
	end
		
	if k == "." then
		map:save()
	end
	if k == "," then
		map:load()
	end
	
	if k == "1" then
		Debug = not Debug
	end
	
end

function love.mousepressed(x, y, button)

end


function love.update(dt)
		
	player:update(dt)
	player:groundcheck(map.x,map.y)	
	player.onground = map:groundtilecheck(player.MapMark1X,player.MapMark1Y)
	
	
	if(love.keyboard.isDown("a")) then
		if(player.x<100) then
			map.x=map.x+200*dt
			player.a = player.a+0.5
			if player.a>100 then 
				player.a = 0	
			end
		else
			player:move(-200*dt)
			player.facingleft = false

		end
	end
	if(love.keyboard.isDown("d")) then
		if(player.x>540) then
			map.x=map.x-200*dt		
			player.a = player.a+0.5
			if player.a>100 then 
				player.a = 0	
			end
		else
			player:move(200*dt)
			player.facingleft = true
		end
	end

	if(love.mouse.isDown("l")) then
		cx = love.mouse.getX()
		cy = love.mouse.getY()
		if TilePicking then
			TilePicking = false
			map:picktile(cx,cy)
		else
			map:clicked(cx,cy)
		end
	end
	
end


