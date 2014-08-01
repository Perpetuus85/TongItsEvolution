local widget = require("widget");
local storyboard = require("storyboard");
local scene = storyboard.newScene();
local myapp = require("myapp")
local coronium = require ( "mod_coronium" )
local findGameButton, hostGameButton

require "sqlite3";
local path = system.pathForFile("data.db", system.DocumentsDirectory);
db = sqlite3.open( path );  

function scene:createScene(event)

	local group = self.view;
	
	--TODO: Replace with logo instead of text
	local logo = display.newText("Tong Its", display.contentWidth / 2, display.contentHeight / 4 - 15, myapp.font,myapp.fontSize);
	logo.x = (display.contentWidth / 2);
	group:insert(logo);
	local obj2 = display.newText("Evolution", display.contentWidth / 2, display.contentHeight / 4 + 10, myapp.font,myapp.fontSize)
	obj2.x = (display.contentWidth / 2);
	group:insert(obj2);
	
	local function logoutCallback(event)
		if not event.error then
			local dbStuff = [[DELETE FROM userinfo]];
			db:exec(dbStuff);
			myapp.hasUserInfo = false;
			myapp.email = ""
			myapp.password = ""
			print ("go to titlescene");
			storyboard.gotoScene("titlescene", "fade", 400)
		else
			native.showAlert("Error", "Error on Log Out");
		end
	end
	
	local function onLogOut(event)
		coronium:logoutUser(logoutCallback)
	end
	
	local function onGetMe(event)
		if not event.error then
			myapp.username = event.result.username;
			local obj3 = display.newText("Welcome, " .. myapp.username, 0, 0, myapp.font, 14);
			obj3.x = obj3.width / 2 + 1;
			obj3.y = obj3.height / 2;
			group:insert(obj3);
			local btnLogOut = widget.newButton
			{
				width = 70,
				height = 30,
				onRelease = onLogOut,
				font = myapp.font,
        		fontSize = 14,
				label = "LOG OUT",
				labelColor = 
				{
					default = {255,0,0,255},
					over = {255,0,0,255},
				},
				id="btnLogOut",
			}
			btnLogOut.x = obj3.width + 40
			btnLogOut.y = obj3.y
			group:insert(btnLogOut);
		else
			native.showAlert("Error", event.error);
		end
	end
	
	local myUser = coronium:getMe(onGetMe)
	
	local function findGameButtonEvent(event)
		print ("find game event")
	end
	
	local function hostGameButtonEvent(event)
		print ("host game event")
	end
	
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
		onRelease = findGameButtonEvent,
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
		onRelease = hostGameButtonEvent,
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
