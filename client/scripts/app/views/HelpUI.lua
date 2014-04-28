
--[[--

	帮组的ui

]]
local HelpUI = class("HelpUI", BaseSprite)



function HelpUI:initView()
   	SpriteButton:newButton("#instructions.png", nil,false, function()
   		 local object = self.object_;
    	 object.sceneController_:resumePlay();
    	 
    	 
		 PopUpManager:deletePopUp(self)
	end)
	--:align(display.CENTER,display.width-100, display.bottom + 50)
	:addTo(self)
end




return HelpUI
