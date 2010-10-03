
player = {
	x=100,
	y=384,
	MapMark1X=0,
	MapMark1Y=0,
	a=0,
	vy=0,
	onground=true,
	facingleft=false,
}
function player:jump()
	if (self.onground) then
		self.vy=-0.8
	end
end
function player:move(dx)
	self.x = self.x + dx;
	self.a=self.a+.5
	if self.a>100 then 
		self.a = 0	
	end
end
function player:groundcheck(mapx,mapy)
	LocalX = self.x - mapx
	LocalY = self.y - mapy
	self.MapMark1X = math.floor(LocalX/32+0.5)
	self.MapMark1Y = math.floor(LocalY/32)+2  --Get player's feet rather than head

end
function player:render(mapx, mapy)
	local Frame = math.floor(10*self.a/100)
	if self.facingleft then
		if self.onground then
			love.graphics.draw(virawalk[Frame],self.x,self.y,0,-1,1,32,0)
		else
			love.graphics.draw(virajump,self.x,self.y,0,-1,1,32,0)
		end
	else
		if self.onground then
			love.graphics.draw(virawalk[Frame],self.x,self.y,0,1,1)
		else
			love.graphics.draw(virajump,self.x,self.y,0,1,1)
		end
	end
	

end
function player:update(dt)
	self.y=self.y+self.vy*dt*400

	if (self.onground and (self.vy > 0)) then self.vy = 0 end
	
	if self.y<384 then
		self.vy = self.vy+dt*1.4
	end
	
--	if self.y>384 then
--		self.vy = 0
--	end
	
	
end


