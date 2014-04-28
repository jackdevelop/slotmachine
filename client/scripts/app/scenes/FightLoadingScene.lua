--[[
战斗的loading场景
]]
local BaseScene = require("engin.mvcs.view.BaseScene")
local FightLoadingScene = class("FightLoadingScene", BaseScene)



function FightLoadingScene:ctor(param)
--	self.currentSceneName_ = GameSoundProperties.bg_sound;
--	audio.playBackgroundMusic(self.currentSceneName_());
	
	
	self.stepIndex   = 0

    self.steps = {}
    
    
    self.steps[#self.steps + 1] = function()
       --加载数据
    end
    
    
    self.steps[#self.steps + 1] = function()
        display.addSpriteFramesWithFileListName(GamePlistProperties.Sheet_Map());
    end
end




function FightLoadingScene:tick()
    local count = #self.steps
    if self.stepIndex < count then
    	self.stepIndex = self.stepIndex + 1
	    local ok, err = pcall(self.steps[self.stepIndex])
	    if ok then
	        echoj("加载进度：",self.stepIndex / count * 100)
	    else
	        echoError(err)
	    end
    elseif self.stepIndex >= count then
        self:unscheduleUpdate()
    	local sceneName,backScaneName = SceneConstants.FightScene()
    	app:enterScene(sceneName,backScaneName,self.param_)
    end
end



function FightLoadingScene:onTouch(event, x, y)
end


function FightLoadingScene:onCleanup()
end


return FightLoadingScene
