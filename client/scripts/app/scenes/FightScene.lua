--[[
战斗的主场景
]]
--local FightSceneUI = class("FightSceneUI", BaseSprite)
local FightController = require("app.controllers.FightController");
local FightModel = require("app.model.FightModel");

--local FightSceneUI = require("app.views.FightSceneUI");
local BaseScene = require("engin.mvcs.view.BaseScene")
local FightScene = class("FightScene", BaseScene)


	
function FightScene:ctor()
	FightScene.super.ctor(self);
	
--	local batch = self:getBatchLayer();
--	self.fightSceneUI_ = FightSceneUI.new();
--	self.fightSceneUI_:init();
--	self.fightSceneUI_:initView();
--	PopUpManager:addPopUp(self.fightSceneUI_, batch, true,true)
	
	
	
	
	
	
	
   	
	local bg = display.newSprite("#beijing.png",display.cx,display.cy);
	self:addChild(bg);
	GameUtil.spriteFullScreen(bg)
	
	
	--[[
	充值   
	local rechargeBtn = cc.ui.UICheckBoxButton.new(TestUIButtonScene.CHECKBOX_BUTTON_IMAGES)
        :setButtonSelected(true)
        :setButtonLabel(cc.ui.UILabel.new({text = "", size = 22, color = ccc3(96, 200, 96)}))
        :setButtonLabelOffset(0, -40)
        :setButtonLabelAlignment(display.CENTER)
        :onButtonStateChanged(function(event)
            updateCheckBoxButtonLabel(event.target)
        end)
        :align(display.LEFT_CENTER, display.left + 260, display.top - 80)
        :addTo(self)
    ]]
	local param = {
		imageName		  = "#btn_normal_recharge.png",
		x     = display.left + 150,
		y     = display.top - 60,
		imageParam = {
	    	imageName = "#txt_recharge.png",
	    },
	    listener =function() 
	    		
	    end,
	}
	local rrechargeBtn = SpriteButton:newButton(param)
    self:addChild(rrechargeBtn);
    
    
    --返回
    local param = {
		imageName		  = "#btn_normal_recharge.png",
		x     = display.right - 150,
		y     = display.top - 60,
		imageParam = {
	    	imageName = "#txt_back.png",
	    },
	    listener =function() 
	    		
	    end,
	}
	local rechargeBtn = SpriteButton:newButton(param)
    self:addChild(rechargeBtn);
    
    
    --元宝数
    local gemSpt = display.newSprite("#txt_gem.png",display.cx,display.top - 60)
	self:addChild(gemSpt); 
    local gemTxt = cc.ui.UILabel.new({text = "1200",align = ui.TEXT_ALIGN_CENTER ,valign = ui.TEXT_VALIGN_CENTER,x= display.cx ,y = display.top - 60, size = 30,  color = ccc3(255, 96, 255)});
    self:addChild(gemTxt)
    
    
    
    
    
    
    
    
    
    
    
    
    
    ----------下方的按钮---------------------------------------------------------------
    
    --加倍
    local param = {
		imageName		  = "#btn_normal_add.png",
		x     = display.left + 130,
		y     = display.bottom + 340,
		imageParam = {
	    	imageName = "#txt_add.png",
	    },
	    listener =function() 
	    		
	    end,
	}
	local rechargeBtn = SpriteButton:newButton(param)
    self:addChild(rechargeBtn);
    
    
    --减倍
    local param = {
		imageName		  = "#btn_normal_add.png",
		x     = display.left + 330,
		y     = display.bottom + 340,
		imageParam = {
	    	imageName = "#txt_reduce.png",
	    },
	    listener =function() 
	    		
	    end,
	}
	local rechargeBtn = SpriteButton:newButton(param)
    self:addChild(rechargeBtn);
    
    --开始
     local param = {
		imageName		  = "#btn_normal_start.png",
		x     = display.right - 130,
		y     = display.bottom + 340,
		imageParam = {
	    	imageName = "#txt_start.png",
	    },
	    listener =function() 
	    	self.fightModel_:start(1);	
	    end,
	}
	local rechargeBtn = SpriteButton:newButton(param)
    self:addChild(rechargeBtn);
    
    
    --圆形按钮积分
     local param = {
		imageName		  = "#btn_normal_circle.png",
		x     = display.right - 330,
		y     = display.bottom + 340,
	    listener =function() 
	    		
	    end,
	}
	local circleBtn = SpriteButton:newButton(param)
    self:addChild(circleBtn);
    
    
    --圆形按钮积分
     local param = {
		imageName		  = "#btn_normal_circle.png",
		x     = display.right - 450,
		y     = display.bottom + 340,
	    listener =function() 
	    		
	    end,
	}
	local circleBtn = SpriteButton:newButton(param)
    self:addChild(circleBtn);
    circleBtn:setFlipX(true);
	
	
	self:initView();
end




--初始化数据
function FightScene:initView()
		 ---中间的各种图片方块
   	local fightController = FightController.new(self);
   	self.fightModel_ = FightModel.new();
   	self.dt_ = 0;
   	
   	
   self.fightModel_:createAllGridSprite(self)
end














--local function oneGridStop(gridSpt,index)
--	local model = self.fightModel_;
--	--定位到下一个格子
----	local index = model.gridSelectSptIndex_;
----	index = index +1 ;
--	if index> 24 then index = 1 end
----	model.gridSelectSptIndex_ = index;
--	
--	local point = model:getPointByIndex(index);
--	gridSpt:pos(point("x"),point("y"));
--end





--stop停止
function FightScene:stop()
	local model = self.fightModel_;
	model.start_ = false;
	
	--手动停止到某个index
	local action = {};
	local winRandom = model.winRandom_;--在经过几个格子停止
	for i = 1, winRandom-1, 1 do 
		local callback = function()
			local index = model.gridSelectSptIndex_;
			index = model:setGridSelectSptPoint(index+1)
		end
		action[#action+1] = CCDelayTime:create(i*0.3);
        action[#action+1] = CCCallFunc:create(callback);
	end
	
	local action = transition.sequence(action);
	self:runAction(action);
end






--tick运行
function FightScene:tick(dt)
 	local model = self.fightModel_;
    if model.start_ then
    	self.dt_ =  self.dt_  + 1
		if self.dt_%2 == 0 then
		
			local index = model.gridSelectSptIndex_;
			index = model:setGridSelectSptPoint(index+1)
			
			if self.dt_ > (model.winRandom_ + 2) * 24 then --跑了有预定的圈以后  开始慢慢的要执行停止动作了
				if not model.winGridBeginIndex_ then --没有指定的话  直接停止
					self:stop();
				elseif index == model.winGridBeginIndex_ then --有指定停到哪一个格子
					self:stop();
				end
				
			end
		end
    end
end




return FightScene;
