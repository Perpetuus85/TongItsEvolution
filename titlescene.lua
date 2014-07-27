local widget = require("widget");
local storyboard = require("storyboard");
local coronium = require ( "mod_coronium" )
local scene = storyboard.newScene();
local myapp = require("myapp")
local playButton, settingsButton

local function getMeCallback(event)
	if not event.error then
		print (event.result.value)
	end
end

local function playButtonEvent(event)
	if(event.phase == "began") then
	elseif (event.phase == "ended" or event.phase == "cancelled") then
		local minX = playButton.x - (playButton.width / 2);
		local maxX = playButton.x + (playButton.width / 2);
		local minY = playButton.y - (playButton.height / 2);
		local maxY = playButton.y + (playButton.height / 2);
		
		if(event.x >= minX and event.x <= maxX and 
			event.y >= minY and event.y <= maxY and
			event.xStart >= minX and event.xStart <= maxX and
			event.yStart >= minY and event.yStart <= maxY) then
				--check if userinfo exists
				if(myapp.hasUserInfo) then
					coronium:loginUser(myapp.email, myapp.password)
					storyboard.gotoScene("mp-menu-a", "fade", 400);
				else
					storyboard.gotoScene("login", "fade", 400);
				end
		end
	end
end

local function settingsButtonEvent(event)
	if(event.phase == "began") then
	elseif (event.phase == "ended" or event.phase == "cancelled") then
		local minX = settingsButton.x - (settingsButton.width / 2);
		local maxX = settingsButton.x + (settingsButton.width / 2);
		local minY = settingsButton.y - (settingsButton.height / 2);
		local maxY = settingsButton.y + (settingsButton.height / 2);
		
		if(event.x >= minX and event.x <= maxX and 
			event.y >= minY and event.y <= maxY and
			event.xStart >= minX and event.xStart <= maxX and
			event.yStart >= minY and event.yStart <= maxY) then
				storyboard.gotoScene("settings-menu", "fade", 400);
		end
	end
end

function scene:createScene(event)

	local group = self.view;
	
	--TODO: Replace with logo instead of text
	local logo = display.newText("Tong Its", display.contentWidth / 2, display.contentHeight / 4 - 15, myapp.font,myapp.fontSize);
	logo.x = (display.contentWidth / 2);
	group:insert(logo);
	local obj2 = display.newText("Evolution", display.contentWidth / 2, display.contentHeight / 4 + 10, myapp.font,myapp.fontSize)
	obj2.x = (display.contentWidth / 2);
	group:insert(obj2);
	
	playButton = widget.newButton
	{
		left = 0,
		top = 0;
		width = 210,
		height = 45,
		font = myapp.font,
		fontSize = myapp.fontSize,
		labelColor =
		{
			default = {255,255,255,255},
			over = {255,255,255,255},
		},
		id = "playButton",
		label = "Play",
		onEvent = playButtonEvent,
	};
	playButton.x = display.contentWidth / 2;
	playButton.y = display.contentHeight - 120;
	group:insert(playButton);
	
	settingsButton = widget.newButton
	{
		left = 0,
		top = 0;
		width = 210,
		height = 45,
		font = myapp.font,
		fontSize = myapp.fontSize,
		labelColor =
		{
			default = {255,255,255,255},
			over = {255,255,255,255},
		},
		id = "settingsButton",
		label = "Settings",
		onEvent = settingsButtonEvent,
	};
	settingsButton.x = display.contentWidth / 2;
	settingsButton.y = display.contentHeight - 50;
	
	group:insert(settingsButton);
	
	
end

function scene:willEnterScene(event)
end

function scene:enterScene(event)
	storyboard.purgeScene("logoscene");
	storyboard.purgeScene("mp-menu-a");
	storyboard.purgeScene("settings-menu");
end

function scene:exitScene(event)
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