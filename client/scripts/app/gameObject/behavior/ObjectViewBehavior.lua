--[[
显示对象
]]
local ObjectViewBehavior = class("ObjectViewBehavior", BehaviorBase)

function ObjectViewBehavior:ctor()
    ObjectViewBehavior.super.ctor(self, "ObjectViewBehavior", nil, 0)
end

function ObjectViewBehavior:bind(object)
--    object.isSelected_ = false
--
--    local function isSelected(object)
--        return object.isSelected_
--    end
--    object:bindMethod(self, "isSelected", isSelected)
--
--    local function setSelected(object, isSelected)
--        object.isSelected_ = isSelected
--    end
--    object:bindMethod(self, "setSelected", setSelected)
--
--	
--	--x,y点是否在当前的对象的范围内
--    local function checkPointIn(object, x, y)
--        return math2d.dist(x,
--                           y,
--                           object.x_ + object.radiusOffsetX_,
--                           object.y_ + object.radiusOffsetY_) <= object.radius_
--    end
--    object:bindMethod(self, "checkPointIn", checkPointIn)

	
	
	
	
--	--[[
--	获取当前显示的视图动画
--	]]
--	local function getAnimation(object, x, y)
--        return self.animation_
--    end
--    object:bindMethod(self, "getAnimation", getAnimation)
--	 
--	
--	
--	
--	
--	
--	
--	
--	
--	
--	
--	
--	
--	
--	
--	
--    --[[
--    	停止所有动作
--    ]]
--     local function pausePlay(object)
--     	 local animation = self.animation_
--     	 animation:stopAnimation();
--     end
--    object:bindMethod(self, "pausePlay", pausePlay)
--    
--      --[[
--   	 重新播放所有动作
--    ]]
--     local function resumePlay(object)
--     	 local animation = self.animation_
--     	animation:resumePlay();
--     end
--    object:bindMethod(self, "resumePlay", resumePlay)
--	--[[
--   	强制播放
--    ]]
--     local function enforcePlay(object)
--     	 local animation = self.animation_
--     	animation:enforcePlay();
--     end
--    object:bindMethod(self, "enforcePlay", enforcePlay)
	
	
	
	
	
	
	
	 local function setButtonLabel(object,number)
	 	object.number_ = number;
	 	
	 	
	 	
	 	
	 	
--		if toint(number) == 0 then 
--			if object.sprite_ then
--				object.sprite_:removeSelf();
--				object.sprite_ =  nil;
--			end
--			return 
--		end;
		
		
--		if not object.sprite1_ then
--			object.sprite_ = display.newSprite("image/Button02.png");
--		 	object.sprite_:align(display.LEFT_BOTTOM,object.x_,object.y_ )
--		 	object.batch_:addChild(object.sprite_);
--	 	else
----	 		object.sprite_:align(display.LEFT_BOTTOM,object.x_,object.y_ )
----	 		transition.moveTo(object.sprite1_, {x=10   ,y = 500,time = 0.2 })
--	 		
--		end
		
		
		
		
		
--		
--	 	
	 
		
		if not object.sprite_  then
		
		
			local loginButtonParam = {
		    on ="image/Button02.png",
		}
	 	object.sprite_ =  cc.ui.UICheckBoxButton.new(loginButtonParam)
	 	
	        :setButtonLabel(cc.ui.UILabel.new({text = number, size = 24,  color = display.COLOR_WHITE}))
	        --:setButtonLabelOffset(0, 40)
	        :setButtonEnabled(false)
	        :setButtonLabelAlignment(display.CENTER)
--	        :onButtonStateChanged(function(event)
--	        	local plane = self.object_.sceneController_.plane;--飞机
--	            plane:decreasePlaneFlyRadians(1);
--	            
--	            local radians = plane:getPlaneFlyRadians();
--	            txt:setString("度数："..radians);
--	        end)
	        :align(display.LEFT_BOTTOM,object.x_,object.y_ )
	        :addTo(object.batch_)
	        
	        
--	        transition.moveTo(object.sprite1_, {x=10   ,y = 500,time = 0.2 })
	    else
	    	object.sprite_:setButtonLabelString(toint(number))
	    end
	 end
	 object:bindMethod(self, "setButtonLabel", setButtonLabel)
	
	
	
	
	
	
	
	
	
	
	--创建动画
    local function createView(object, batch, marksLayer, debugLayer)
    	
		local position = tonum(object.positon_);
		local x,y = toint(position%4)*90, math.floor(position/4)*90;
		object.x_,object.y_ = x,y;
		
--		local loginButtonParam = {
--		    on ="image/Button02.png",
--		}
--		display.newSprite("image/Button02.png",x,y)
--		:addTo(batch)
		local sprite = cc.ui.UIImage.new("image/Button02.png", {scale9 = true})
--        :setLayoutSize(200, 100)
        :align(display.LEFT_BOTTOM, x, y)
        :addTo(batch)
        
        sprite:setColor(ccc3(255, 0, 0));
		
--		object.sprite_ =  cc.ui.UICheckBoxButton.new(loginButtonParam)
--	        :setButtonLabel(cc.ui.UILabel.new({text = txt, size = 24,  color = display.COLOR_WHITE}))
--	        --:setButtonLabelOffset(0, 40)
--	        :setButtonEnabled(false)
--	        :setButtonLabelAlignment(display.CENTER)
----	        :onButtonStateChanged(function(event)
----	        	local plane = self.object_.sceneController_.plane;--飞机
----	            plane:decreasePlaneFlyRadians(1);
----	            
----	            local radians = plane:getPlaneFlyRadians();
----	            txt:setString("度数："..radians);
----	        end)
--	        :align(display.LEFT_BOTTOM,x,y)
--	        :addTo(batch)
	        
	        
	        
    
    
--       if object.framesName_ then
--	        local frames = display.newFrames(object.framesName_, object.framesBegin_, object.framesLength_)
--	        object.sprite_ = display.newSprite();--display.newSpriteFrame(frames[1])
--	        object.sprite_:playAnimationForever(display.newAnimation(frames, object.framesTime_))
--	        object.sprite_:displayFrame(frames[1])
--	   else
--	        local imageName = object.imageName_
--	        if type(imageName) == "table" then
--	            imageName = imageName[1]
--	        end
--	        object.sprite_ = display.newSprite(imageName)
--	    end
	
--        local animation = AnimationCache.new()
--     	local animationParam  = AnimationProperties.get(object.animation_);
--     	animation:initData(object.animation_,animationParam)
--        animation:createView(batch)
--        animation:updateView(true);
--        local view = animation:getView()
--        object.sprite_ = view;
--        self.animation_ = animation;
--	
--	    local size = object.sprite_:getContentSize()
--	    object.spriteSize_ = {size.width, size.height}
--	
--	    if object.scale_ then
--	        object.sprite_:setScale(self.scale_)
--	    end

		object:setButtonLabel(0);
    end
    object:bindMethod(self, "createView", createView)

	
	
	
	
	
	
    local function removeView(object)
    	if object.sprite_ then
			object.sprite_:removeSelf()
			object.sprite_ = nil
		end
    end
    object:bindMethod(self, "removeView", removeView, true)



	
    local function updateView(object)		
        local x, y = math.floor(object.x_), math.floor(object.y_)
        if object.sprite_ then
--        	object.sprite_:setPosition(x,y)
        end
    end
    object:bindMethod(self, "updateView", updateView)
end

function ObjectViewBehavior:unbind(object)
    object.isSelected_ = nil

    object:unbindMethod(self, "isSelected")
    object:unbindMethod(self, "setSelected")
    object:unbindMethod(self, "checkPointIn")
    object:unbindMethod(self, "createView")
    object:unbindMethod(self, "removeView")
    object:unbindMethod(self, "updateView")
    object:unbindMethod(self, "fastUpdateView")
end

return ObjectViewBehavior
