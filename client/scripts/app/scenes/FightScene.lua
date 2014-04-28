--[[
战斗的主场景
]]
local FightSceneUI = require("app.views.FightSceneUI");
local BaseScene = require("engin.mvcs.view.BaseScene")
local FightScene = class("FightScene", BaseScene)


	
function FightScene:ctor()
	FightScene.super.ctor(self);
	
	local batch = self:getBatchLayer();
	self.fightSceneUI_ = FightSceneUI.new();
	self.fightSceneUI_:init();
	self.fightSceneUI_:initView();
	PopUpManager:addPopUp(self.fightSceneUI_, batch, true,true)
end




--tick
function FightScene:tick(dt)
	self.fightSceneUI_:tick(dt);
end




return FightScene;
