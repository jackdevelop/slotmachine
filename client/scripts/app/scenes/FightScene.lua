--[[
战斗的主场景
]]
--local FightSceneUI = class("FightSceneUI", BaseSprite)
local FightSceneUI = require("app.views.FightSceneUI");

--local FightSceneUI = require("app.views.FightSceneUI");
local BaseScene = require("engin.mvcs.view.BaseScene")
local FightScene = class("FightScene", BaseScene)


	
function FightScene:ctor()
	FightScene.super.ctor(self);
	
	
	
	local fightSceneUI = FightSceneUI.new();
	fightSceneUI:init();
	self:getUILayer():addChild(fightSceneUI);
	self.fightSceneUI_ = fightSceneUI;
	
	
end














--stop停止
--function FightScene:stop()
--	local model = self.fightModel_;
--	model.start_ = false;
--	
--	--手动停止到某个index
--	local action = {};
--	local winRandom = model.winRandom_;--在经过几个格子停止
--	for i = 1, winRandom-1, 1 do 
--		local callback = function()
--			local index = model.gridSelectSptIndex_;
--			index = model:setGridSelectSptPoint(index+1)
--		end
--		action[#action+1] = CCDelayTime:create(i*0.3);
--        action[#action+1] = CCCallFunc:create(callback);
--	end
--	
--	local action = transition.sequence(action);
--	self:runAction(action);
--end
--
--
--
--
--
--
----tick运行
function FightScene:tick(dt)
	self.fightSceneUI_:tick(dt);
-- 	local model = self.fightModel_;
--    if model.start_ then
--    	self.dt_ =  self.dt_  + 1
--		if self.dt_%2 == 0 then
--		
--			local index = model.gridSelectSptIndex_;
--			index = model:setGridSelectSptPoint(index+1)
--			
--			if self.dt_ > (model.winRandom_ + 2) * 24 then --跑了有预定的圈以后  开始慢慢的要执行停止动作了
--				if not model.winGridBeginIndex_ then --没有指定的话  直接停止
--					self:stop();
--				elseif index == model.winGridBeginIndex_ then --有指定停到哪一个格子
--					self:stop();
--				end
--				
--			end
--		end
--    end
end




return FightScene;
