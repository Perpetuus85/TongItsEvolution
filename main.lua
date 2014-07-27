-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local storyboard = require "storyboard";
local myapp = require("myapp")

require("widgets.widgetext")
require("widgets.storyboardext")

local coronium = require ( "mod_coronium" )
coronium:init ( { appId = "ec2-54-186-188-40.us-west-2.compute.amazonaws.com" , apiKey = "f04037ae-d06a-4359-bb8a-6a2275f9826d" } )
--coronium:appOpened()

display.setStatusBar( display.TranslucentStatusBar )

myapp.statusBarVisible = false -- change this to false if you wish statusBar to be hidden. 
myapp.statusBarHeight = display.topStatusBarContentHeight

if not myapp.statusBarVisible then
    myapp.statusBarHeight = 0
    display.setStatusBar( display.HiddenStatusBar )
end

if system.getInfo("platformName") == "Android" then
    myapp.font = "DroidSans"
    myapp.fontColor = {255,255,255,1}
    myapp.labelColor = {255,255,255,1}
else
    myapp.font = "HelveticaNeue-Light"
    myapp.fontColor = {255,255,255,1}
    myapp.labelColor = {255,255,255,1}
end

myapp.fontSize = 24;

require "sqlite3";
local path = system.pathForFile("data.db", system.DocumentsDirectory);
db = sqlite3.open( path ); 

local tablesetup = [[CREATE TABLE IF NOT EXISTS userinfo (userinfoid INTEGER PRIMARY KEY, email, password);]];
db:exec( tablesetup );
myapp.hasUserInfo = false;
for row in db:nrows("SELECT COUNT(*) as numOfRows FROM userinfo") do
	if(row.numOfRows > 0) then
		myapp.hasUserInfo = true;
	end
end
if(myapp.hasUserInfo) then
	for row in db:nrows("SELECT email, password FROM userinfo") do
		myapp.email = row.email
		myapp.password = row.password
	end
end

local function onSystemEvent( event )
    if( event.type == "applicationExit" ) then             
		--DELETE ONLY ON DEBUG
		local tableDelete = [[DROP TABLE userinfo]];
		db:exec(tableDelete);
        db:close()
    end
end

Runtime:addEventListener( "system", onSystemEvent );

storyboard.gotoScene("logoscene", "fade", 400);