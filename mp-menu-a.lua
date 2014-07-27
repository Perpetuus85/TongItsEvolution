local widget = require("widget");
local storyboard = require("storyboard");
local scene = storyboard.newScene();
local myapp = require("myapp")
local findGameButton, hostGameButton

function scene:createScene(event)

	local group = self.view;
	
	--TODO: Replace with logo instead of text
	local logo = display.newText("Tong Its", display.contentWidth / 2, display.contentHeight / 4 - 15, myapp.font,myapp.fontSize);
	logo.x = (display.contentWidth / 2);
	group:insert(logo);
	local obj2 = display.newText("Evolution", display.contentWidth / 2, display.contentHeight / 4 + 10, myapp.font,myapp.fontSize)
	obj2.x = (display.contentWidth / 2);
	obj2:setTextColor(255,255,255);
	group:insert(obj2);
	
	findGameButton = widget.newButton
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
		id = "findGameButton",
		label = "Find Game",
		onEvent = findGameButtonEvent,
	};
	findGameButton.x = display.contentWidth / 2;
	findGameButton.y = display.contentHeight - 120;
	group:insert(findGameButton);
	
	hostGameButton = widget.newButton
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
		id = "hostGameButton",
		label = "Host Game",
		onEvent = hostGameButtonEvent,
	};
	hostGameButton.x = display.contentWidth / 2;
	hostGameButton.y = display.contentHeight - 50;
	
	group:insert(hostGameButton);
	
end

function scene:willEnterScene(event)
end

function scene:enterScene(event)
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
