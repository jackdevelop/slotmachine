
require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")
	

require("engin.config.EnginInit")
require("app.config.init")

local UIDemoApp = class("UIDemoApp", cc.mvc.AppBase)




function UIDemoApp:ctor()
    UIDemoApp.super.ctor(self)
end






function UIDemoApp:run()
     CCFileUtils:sharedFileUtils():addSearchPath("res/")
    local sceneName,backScaneName = SceneConstants.FightLoadingScene();
    self:enterScene(sceneName,backScaneName)
  	--self:enterScene(SceneConstants.FightLoadingScene, nil, "flipy")
end






--[[
进入某个场景
]]
function UIDemoApp:enterScene(sceneName,backScaneName, param,...)
	local function enterSceneFun(sceneName, args, transitionType, time, more)
	    local scenePackageName = self. packageRoot .. ".scenes." .. sceneName
	    local sceneClass = require(scenePackageName)
	    local scene = sceneClass.new(args)
	    display.replaceScene(scene, transitionType, time, more)
	    
	    return scene
	end

	if not param then param = {} end
	param.sceneName = sceneName;
    local scene = enterSceneFun(sceneName,param, ...);
    
    self.previousSceneName_ = self.currentSceneName_;--上一场景的名称
    self.currentSceneName_ = sceneName;--当前场景名称
    self.currentScene_ = scene;--当前场景
end



--[[
回退到某个场景
]]
function UIDemoApp:back()
	local sceneName,backScaneName =  clone(SceneConstants[self.currentSceneName_]()) --SceneConstants.FightScene();
	if backScaneName then 
		self:enterScene(sceneName,backScaneName)
	else	
		self:exit();
	end
end


return UIDemoApp
