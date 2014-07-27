local storyboard = require("storyboard");
local scene = storyboard.newScene();
local myapp = require("myapp")

local fadeTimer

function scene:createScene(event)
	local group = self.view;

	local obj = display.newText("SPYKE", display.contentWidth / 2, display.contentHeight / 2 - 15, myapp.font,myapp.fontSize)
	obj.x = (display.contentWidth / 2);
	group:insert(obj);
	local obj2 = display.newText("DEVELOPMENT", display.contentWidth / 2, display.contentHeight / 2 + 10, myapp.font,myapp.fontSize)
	obj2.x = (display.contentWidth / 2);
	group:insert(obj2);
end

function scene:willEnterScene(event)
end

function scene:enterScene(event)
	local fadeToNext = function()
		storyboard.gotoScene("titlescene", "fade", 400);
	end
	fadeTimer = timer.performWithDelay(1500, fadeToNext, 1)
end

function scene:exitScene(event)
	timer.cancel(fadeTimer); fadeTimer = nil;
end

function scene:didExitScene(event)
end

function scene:destroyScene(event)
end

scene:addEventListener("createScene", scene);
scene:addEventListener("willEnterScene", scene);
scene:addEventListener("enterScene", scene);
scene:addEventListener("exitScene", scene);
scene:addEventListener("didExitScene", scene);
scene:addEventListener("destroyScene", scene);

return scene;