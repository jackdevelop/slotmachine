--[[
战斗场景
]]
local FightSceneUI = class("FightSceneUI", CCSBaseUI)



	
function FightSceneUI:ctor()
   	local ccsPanelName = "css/laohuji_1.ExportJson"; 
	FightSceneUI.super.ctor(self,ccsPanelName)
	
	
	--随机替换加载icon
	for i=1,16 do
		local name = "image_icon"..i;
		local image_icon = tolua.cast( self:getCCSPanel():getWidgetByName(name),"ImageView")
		
		local num = math.random(1, 23);
		local imageName = "#"..num..".png"
		local sprite = display.newSprite(imageName)
		image_icon:getVirtualRenderer():setTexture(sprite:getTexture());
		image_icon:getVirtualRenderer():setTextureRect(sprite:getTextureRect(),sprite:isTextureRectRotated(),sprite:getContentSize());
	end
	
	
	--开始
	self.btn_start_ = tolua.cast( self:getCCSPanel():getWidgetByName("btn_start"),"Button")
	CCSButton:registerEventScript(self.btn_start_ ,false,function() self:start() end);
	
	local btn_recharge =	self.ccsPanel_:getWidgetByName("btn_recharge");
	--CCSButton:registerEventScript(btn_start,false,function() self:start() end);
	
end






function FightSceneUI:init()
	self.start_ = false;
	self.dt_ = 0;
end








--[[
开始运行
@param 指定最后的停止索引 1- 16
]]
function FightSceneUI:start(winGridIndex)
	if self.start_ then return end
	
	self.gridSelectSptIndex_ =1;
	self.start_ = true;
	self.btn_start_:setTouchEnabled(false)
	 
	 
	self.winRandom_ = math.random(2, 5);--随机一个变慢的节奏 即前几个圈就开始慢慢变停下来
	if winGridIndex then 
		self.winGridIndex_ = winGridIndex;
		self.winGridBeginIndex_ = winGridIndex - self.winRandom_;
		if self.winGridBeginIndex_ < 1 then self.winGridBeginIndex_ = 16 + self.winGridBeginIndex_ end --为了一个假的动作  模拟到这个index即慢慢的减速
	end
end









--stop停止
function FightSceneUI:stop()
	self.start_ = false;
	self.dt_ = 0;
		
	
	
	--彻底停止
	local endFun = function()
		self:performWithDelay(function()
			self.btn_start_:setTouchEnabled(true)
		end, 2)
	end
	
	
	
	
	--手动停止到某个index
	local action = {};
	local winRandom = self.winRandom_;--在经过几个格子停止
	for i = 1, winRandom-1, 1 do 
		local callback = function()
			local index = self.gridSelectSptIndex_;
			index = self:setGridSelectSptPoint(index+1)
			
			if i == winRandom-1 then
				endFun();
			end
		end
		
		
		action[#action+1] = CCDelayTime:create(i*0.3);
        action[#action+1] = CCCallFunc:create(callback);
	end
	
	local action = transition.sequence(action);
	self:runAction(action);
end





--设置选中框到某个index中
function FightSceneUI:setGridSelectSptPoint(index)
	if index> 15 then index = 1 end
	
	local name = "image_icon"..index;
	local image_icon = tolua.cast( self:getCCSPanel():getWidgetByName(name),"ImageView")
	local x,y = image_icon:getPosition();
	local image_select = tolua.cast( self:getCCSPanel():getWidgetByName("image_select"),"ImageView")
	image_select:setPosition(ccp(x,y));
	self.gridSelectSptIndex_ = index; 
	 
	 return index
end








----tick运行
function FightSceneUI:tick(dt)
    if self.start_ then
    	self.dt_ =  self.dt_  + 1
		if self.dt_%2 == 0 then
		
			local index = self.gridSelectSptIndex_;
			index = self:setGridSelectSptPoint(index+1)
			
			if self.dt_ > (self.winRandom_ + 2) * 15 then --跑了有预定的圈以后  开始慢慢的要执行停止动作了
				if not self.winGridBeginIndex_ then --没有指定的话  直接停止
					self:stop();
				elseif index == self.winGridBeginIndex_ then --有指定停到哪一个格子
					self:stop();
				end
			end
		end
    end
end





return FightSceneUI
