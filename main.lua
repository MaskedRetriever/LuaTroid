-------------------------------------------------
-- LOVE: Intro Slides
-------------------------------------------------

function love.load()
	-- The amazing music.
	--music = love.audio.newSource("wip1.it")
	music = love.audio.newSource("thruspace.ogg")
	music:setLooping(true)
	music:setPitch(1)
	love.audio.play(music)
	love.audio.setVolume(0.1)	

	Slides = {}
	
	Slides[1] = love.graphics.newImage("tmr_640.png")
	Slides[2] = love.graphics.newImage("OGAlogo_640.png")
	
	i=1 --slide#
	a=255 --alpha
	deltat=0 --delay time
	state = 0
	maxslide = 2 --highest slide number

	success = love.graphics.setMode( 640, 480, false )
	love.graphics.setColorMode("replace")
end



function love.draw()
	
	love.graphics.draw(Slides[i])
	love.graphics.setColor( 0,0,0,a)
	love.graphics.rectangle( 'fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight() )
	
end

function love.keypressed(k)
	--todo: skip out of intro
end


function love.update(dt)

	if (state == 0) then
		a = a-1.3
		if a<0 then
			a = 0
			state = 1
		end
	end
	
	if (state == 1) then
		--state = 2
		deltat = deltat+1
		if deltat>20 then
			deltat=0
			state = 2
		end
	end
	
	if (state == 2) then
		a = a+1.3
		if a>255 then
			a = 255
			state = 3
		end
	end
	
	if (state == 3) then
		if(i==maxslide) then
			startGame()
		end
		if(i<maxslide) then
			i = i+1
			state = 0
		end
	end
	
end

function startGame()
	local game = love.filesystem.load("game.lua")

	print("Starting game...")
	game()
	love.load()
end
