local FightModel = class("FightModel")



local point ={
	Jpoint(-204,325),--1
	Jpoint(-204+68,325),
	Jpoint(-204+68*2,325),
	Jpoint(-204+68*3,325),
	Jpoint(-204+68*4,325),
	Jpoint(-204+68*5,325),
	Jpoint(204,325), --7
	
	
	Jpoint(204,325-68),--8
	Jpoint(204,325-68*2),
	Jpoint(204,325-68*3),
	Jpoint(204,325-68*4),
	Jpoint(204,325-68*5),
	Jpoint(204,-85),--13
	
	
	Jpoint(-204+68*5,-85),--14
	Jpoint(-204+68*4,-85),
	Jpoint(-204+68*3,-85),
	Jpoint(-204+68*2,-85),
	Jpoint(-204+68,-85),
	Jpoint(-204,-85),--19
	
	
	Jpoint(-204,325-68*5),--20
	Jpoint(-204,325-68*4),
	Jpoint(-204,325-68*3),
	Jpoint(-204,325-68*2),
	Jpoint(-204,325-68),--24
}


local gridImageName = {"#grid1.png","#grid2.png","#grid3.png"};


--[[
初始化
]]
function FightModel:ctor()
	self.allGridSpt_ = nil;
	self.gridSelectSpt_ = nil;
	self.gridSelectSptIndex_ = nil; 
	self.winGridIndex_ = nil; --赢了的index坐标点
	
	self.start_ = false;
end



function FightModel:getPointByIndex(index)
	return point[index] or point[1];
end




--设置选中框到某个index中
function FightModel:setGridSelectSptPoint(index)
	if index> 24 then index = 1 end
	local point = self:getPointByIndex(index);
	self.gridSelectSpt_:pos(point("x"),point("y"));
	self.gridSelectSptIndex_ = index; 
	 
	 return index
end



--[[
启动
@param winGridIndex 是否提前指定赢的定位格子
]]
function FightModel:start(winGridIndex)
	self.start_ = true;
	
	self.winRandom_ = math.random(2, 5);
	if winGridIndex then
		self.winGridIndex_ = winGridIndex;
		self.winGridBeginIndex_ = winGridIndex - self.winRandom_;
		if self.winGridBeginIndex_ < 1 then self.winGridBeginIndex_ = 25 + self.winGridBeginIndex_ end --为了一个假的动作  模拟到这个index即慢慢的减速
	end
end





--创建格子
function FightModel:createAllGridSprite(batch)
	 --所有格子初始化
    self.allGridSpt_ = {};
    for index = 1, 24, 1 do 
		local num = math.random(1, 3);
		
	
		local point =  self:getPointByIndex(index);
		local spt = display.newSprite(gridImageName[num],point("x"),point("y"))
		batch:addChild(spt);
    	
    	
    	self.allGridSpt_[index] = spt;
    end
    
    
    --选中格子的状态
    self.gridSelectSptIndex_ = 1;
   	local point =  self:getPointByIndex(self.gridSelectSptIndex_);
    self.gridSelectSpt_ = display.newSprite("#gridSelect.png",point("x"),point("y"))
    batch:addChild(self.gridSelectSpt_);
end












--销毁数据
function FightModel:dispose()
	 for index = 1, 24, 1 do 
	 	if self.allGridSpt_[index] then
    		self.allGridSpt_[index]:removeSelf();
    	end
	 end
	 
	 if self.gridSelectSpt_ then self.gridSelectSpt_:removeSelf(); end
	 
	 
	self.allGridSpt_ = nil;
	self.gridSelectSpt_ = nil;
	self.gridSelectSptIndex_ = nil;
end


return FightModel