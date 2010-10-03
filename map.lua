map = {
	x=-32,
	y=-32,
	xtiles=21,
	ytiles=16,
	mapdata = {
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	{1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0},
	{0,1,2,3,4,5,6,7,8,9,10,11,12,13,1,1,0,0,0,0,0},
	{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
	},
	MapImageData = love.image.newImageData(32*21,32*16),
	SelectedTile=0,
}
function map:generate()
	
	for ytile = 1, #self.mapdata do
		for xtile = 1, #self.mapdata[1] do
			self.MapImageData:paste(tileImagepile[self.mapdata[ytile][xtile]],xtile*32,ytile*32,0,0,32,32)
		end
	end
	MapImage = love.graphics.newImage(self.MapImageData)
end

function map:clicked(xc,yc)
	if(xc>self.x and xc<(self.x+32*21)) and yc>self.y and yc<(self.y+32*16) then
		xtile = math.floor((xc-self.x)/32)
		ytile = math.floor((yc-self.y)/32)
		--Value =	self.mapdata[ytile][xtile]
		--Value = Value +1
		--if Value > 15 then Value = 0 end
		--self.mapdata[ytile][xtile] = Value
		self.mapdata[ytile][xtile] = self.SelectedTile
	end
	self:generate()
end

function map:picktile(xc,yc)
	XSel = math.floor(xc/32)
	YSel = math.floor(yc/32)
	self.SelectedTile = XSel + 15*YSel
end

--Map is saved to mapdata.lua
function map:save()
	f = love.filesystem.newFile("mapdata.lua")
	f:open('w')
	
	f:write("mapfile = {}")
	f:write("mapfile[1] = {\n")
	for ytile = 1, #self.mapdata do
		f:write("{")
		for xtile = 1, #self.mapdata[1] do
			f:write(self.mapdata[ytile][xtile] .. ", ")
		end
		f:write("},\n")
	end
	f:write("}")
	f:close()
end

function map:load()
	love.filesystem.load("mapdata.lua")()
	self.mapdata = mapfile[1]
	self:generate()
end

function map:groundtilecheck(tx,ty)
	if(not tx) then return false end
	if(not ty) then return false end
	if(self.mapdata[ty][tx] == 0) then
		return true
	else
		return false
	end
		

end


function map:render()
	love.graphics.draw(MapImage,self.x,self.y)
end