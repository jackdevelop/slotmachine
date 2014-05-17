--[[
战斗场景
]]
--local FightSceneUI = class("FightSceneUI", Base)
local FightSceneUI = class("FightSceneUI", BaseSprite)
local FightController = require("app.controllers.FightController");
local FightModel = require("app.model.FightModel");


	
function FightSceneUI:init()
	 ---中间的各种图片方块
   	local fightController = FightController.new(self);
   	self.fightModel_ = FightModel.new();
   	self.dt_ = 0;
   	
   	
	local bg = display.newSprite("#beijing.png");
	self:addChild(bg);
	GameUtil.spriteFullScreen(bg)
	
--	local kuang = display.newSprite("#kuang.png",0,95)
--	self:addChild(kuang);
--	
--	local kuang = display.newSprite("#centerKuang.png",0,95)
--	self:addChild(kuang);
	
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
		x     = display.left + 30,
		y     = display.top - 20,
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
		x     = display.right - 10,
		y     = 435,
		imageParam = {
	    	imageName = "#txt_back.png",
	    },
	    listener =function() 
	    		
	    end,
	}
	local rechargeBtn = SpriteButton:newButton(param)
    self:addChild(rechargeBtn);
    
    
    --元宝数
    local gemSpt = display.newSprite("#txt_gem.png",0,435)
	self:addChild(gemSpt); 
    local gemTxt = cc.ui.UILabel.new({text = "", size = 22,  color = ccc3(255, 96, 255)});
    self:addChild(gemTxt)
    
    
    
    
    
    
    
    
    
    
    
    
    
    ----------下方的按钮---------------------------------------------------------------
    
    --加倍
    local param = {
		imageName		  = "#btn_normal_add.png",
		x     = -200,
		y     = -250,
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
		x     = -80,
		y     = -250,
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
		x     = 200,
		y     = -250,
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
		x     = 30,
		y     = -250,
	    listener =function() 
	    		
	    end,
	}
	local circleBtn = SpriteButton:newButton(param)
    self:addChild(circleBtn);
    
    
    --圆形按钮积分
     local param = {
		imageName		  = "#btn_normal_circle.png",
		x     = 100,
		y     = -250,
	    listener =function() 
	    		
	    end,
	}
	local circleBtn = SpriteButton:newButton(param)
    self:addChild(circleBtn);
    
end




--初始化数据
function FightSceneUI:initView()
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
function FightSceneUI:stop()
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
function FightSceneUI:tick(dt)
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





return FightSceneUI
