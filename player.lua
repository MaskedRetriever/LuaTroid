
player = {
	x=100,
	y=384,
	a=0,
	vy=0,
	facingleft=false,
}
function player:jump()
	self.jumping=false
	self.vy=-0.2
end
function player:move(dx)
	self.x = self.x + dx;
	self.a=self.a+.5
	if self.a>100 then 
		self.a = 0	
	end
end
function player:render()
	local Frame = math.floor(10*self.a/100)
	if self.facingleft then
		if self.y > 383 then
			love.graphics.draw(virawalk[Frame],self.x,self.y,0,-1,1,32,0)
		else
			love.graphics.draw(virajump,self.x,self.y,0,-1,1,32,0)
		end
	else
		if self.y > 383 then
			love.graphics.draw(virawalk[Frame],self.x,self.y,0,1,1)
		else
			love.graphics.draw(virajump,self.x,self.y,0,1,1)
		end
	end
end
function player:update(dt)
	self.y=self.y+self.vy

	if self.y<384 then
		self.vy = self.vy+dt*.4
	end
	
	if self.y>384 then
		self.vy = 0
	end

	
end

