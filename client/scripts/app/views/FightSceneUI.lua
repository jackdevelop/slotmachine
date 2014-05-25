--[[
战斗场景
]]
local FightSceneUI = class("FightSceneUI", CCSBaseUI)



	
function FightSceneUI:ctor()
   	local ccsPanelName = "css/laohuji_1.ExportJson"; 
	FightSceneUI.super.ctor(self,ccsPanelName)
	
	
	--随机替换加载icon
	for i=1,16 do
		local index = i%8;
		if index == 0 then index = 8 end;
		
		local name = "image_icon"..i;
		local image_icon = tolua.cast( self:getCCSPanel():getWidgetByName(name),"ImageView")
		
		local num = index --math.random(1, 23);
		local imageName = "#"..num..".png"
		local sprite = display.newSprite(imageName)
		image_icon:getVirtualRenderer():setTexture(sprite:getTexture());
		image_icon:getVirtualRenderer():setTextureRect(sprite:getTextureRect(),sprite:isTextureRectRotated(),sprite:getContentSize());
	end
	
	
	--开始
	self.btn_start_ = tolua.cast( self:getCCSPanel():getWidgetByName("btn_start"),"Button")
	CCSButton:registerEventScript(self.btn_start_ ,false,function() self:start(1) end);
	
	--充值
	local btn_recharge =	self.ccsPanel_:getWidgetByName("btn_recharge");
	--CCSButton:registerEventScript(btn_start,false,function() self:start() end);
	
	for i=1,8 do 
		local name = "btn_bet"..i;
		local btn_bet =	self.ccsPanel_:getWidgetByName(name);
		CCSButton:registerEventScript(btn_bet,false,function() self:betHandle(i) end);
	end
	
	
end






function FightSceneUI:init()
	self.start_ = 0; --0没在运行 1正在运行 2进入ai的模拟倒计时停止
	self.dt_ = 0;
end








--[[
开始运行
@param 指定最后的停止索引 1- 16
]]
function FightSceneUI:start(winGridIndex)
	if self.start_~=0 then return end
	
	self.gridSelectSptIndex_ =1;
	self.start_ = 1;
--	self.btn_start_:setTouchEnabled(false)
	 
	 
	self.winRandom_ = math.random(2, 5);--随机一个变慢的节奏 即前几个圈就开始慢慢变停下来
	if winGridIndex then 
		self.winGridIndex_ = winGridIndex;
		self.winGridBeginIndex_ = winGridIndex - self.winRandom_;
		if self.winGridBeginIndex_ < 1 then self.winGridBeginIndex_ = 16 + self.winGridBeginIndex_ end --为了一个假的动作  模拟到这个index即慢慢的减速
	end
end



--下注
function FightSceneUI:betHandle(index)
	if self.start_~=0  then return end
	
	local name = "txt_bet"..index;
	local txt_bet = tolua.cast( self:getCCSPanel():getWidgetByName(name),"Label")
	local currentSocle = checkint(txt_bet:getStringValue());
	
	txt_bet:setText(currentSocle+1);
end




--结算
function FightSceneUI:result(winIndex)
	local winIndex = winIndex%8;
	if winIndex == 0 then winIndex = 8 end;
	
	
	local winName = "txt_bet"..winIndex;
	local winNameTxt = tolua.cast( self:getCCSPanel():getWidgetByName(winName),"Label")
	local winNameSocle = checkint(winNameTxt:getStringValue());
	
	
	local allSocle = 0;
	for i=1,8 do 
		if i ~= winIndex then
			local name = "txt_bet"..i;
			local nameTxt = tolua.cast( self:getCCSPanel():getWidgetByName(name),"Label")
			local nameSocle = checkint(nameTxt:getStringValue());
			allSocle = allSocle + nameSocle;
		end
	end
	
	
	allSocle = - allSocle + winNameSocle;
	local txt_score = tolua.cast( self:getCCSPanel():getWidgetByName("txt_score"),"Label")
	txt_score:setText(allSocle);
	echoj("总共赢了："..allSocle);
end








--stop停止
function FightSceneUI:stop()
	self.start_ = 2;
	self.dt_ = 0;
		
	
	
	--彻底停止
	local endFun = function()
		self:performWithDelay(function()
			self:result(self.winGridIndex_);
--			self.btn_start_:setTouchEnabled(true)
			self.start_ = 0;
		end, 2)
	end
	
	
	
	
	--手动停止到某个index
	local action = {};
	local winRandom = self.winRandom_;--在经过几个格子停止
	for i = 1, winRandom, 1 do 
		local callback = function()
			local index = self.gridSelectSptIndex_;
			index = self:setGridSelectSptPoint(index+1)
			
			if i == winRandom then
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
	if index> 16 then index = 1 end
	
	local name = "image_icon"..index;
	local image_icon = tolua.cast( self:getCCSPanel():getWidgetByName(name),"ImageView")
	local x,y = image_icon:getPosition();
	local image_select = tolua.cast( self:getCCSPanel():getWidgetByName("image_select"),"ImageView")
	image_select:setPosition(ccp(x,y));
	self.gridSelectSptIndex_ = index; 
	 
	 return index
end










--重置界面
function FightSceneUI:reseat()
--	self.btn_start_:setTouchEnabled(true)
	self.winGridIndex_ = nil;
	for i=1,8 do 
		local name = "txt_bet"..i;
		local nameTxt = tolua.cast( self:getCCSPanel():getWidgetByName(name),"Label")
		nameTxt:setText("0");
	end
	self.winGridIndex_ = nil;
end









----tick运行
function FightSceneUI:tick(dt)
    if self.start_==1 then
    	self.dt_ =  self.dt_  + 1
		if self.dt_%2 == 0 then
		
			local index = self.gridSelectSptIndex_;
			index = self:setGridSelectSptPoint(index+1)
			
			if self.dt_ > (self.winRandom_ + 2) * 16 then --跑了有预定的圈以后  开始慢慢的要执行停止动作了
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
