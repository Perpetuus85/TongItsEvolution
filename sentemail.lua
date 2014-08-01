local widget = require("widget");
local storyboard = require("storyboard");
local scene = storyboard.newScene();
local myapp = require("myapp")
local coronium = require ( "mod_coronium" )
local btnLogin, btnSignUp

require "sqlite3";
local path = system.pathForFile("data.db", system.DocumentsDirectory);
db = sqlite3.open( path );  

function scene:createScene(event)

	local group = self.view;
	
	--TODO: Replace with logo instead of text
	local logo = display.newText("Email Sent", display.contentWidth / 2, 30, myapp.font,myapp.fontSize);
	logo.x = (display.contentWidth / 2);
	group:insert(logo);
	
	local description = display.newText("An email containing information on how", 0, 60, myapp.font, 18);
	description.x = display.contentWidth / 2;
	group:insert(description);
	
	local description2 = display.newText("to reset your password has been sent.", 0, 90, myapp.font, 18);
	description2.x = display.contentWidth / 2;
	group:insert(description2);
	
	local function textListener( event )
        --print(event.phase)
        if ( event.phase == "began" ) then

            -- user begins editing text field
            print( event.text )

        elseif ( event.phase == "ended" ) then

        elseif ( event.phase == "ended" or event.phase == "submitted" ) then

            -- do something with defaulField's text
            print("reset")
            
        elseif ( event.phase == "editing" ) then

            print( event.newCharacters )
            print( event.oldText )
            print( event.startPosition )
            print( event.text )
            --print( "isModified? ", event.target:isModified() )

        end
    end
	
	local function onSubmit(event)
        local text = event.target:getText();
                
        local label = event.target.label       
        if label == nil then 
            label = ""
        end
        print ("onSubmit ", event.phase) 
        if event.phase == "submitted" then
             --if self.isModified() then
                -- This means the screen was loaded with a record and one field was submitted
                -- need to enable Update button
                --if myapp.loadParams == true then 
                --    setBtnState(btnUpdate, "on")
                --else
                --    setBtnState(btnCreate, "on") 
                --end
            --else
                --setBtnState(btnUpdate, "off")
                --setBtnState(btnCreate, "off")                  
            --end           
        end    
    end
	
	local editGroup = display.newGroup()
    group:insert(editGroup)
	
	local function onLogIn()
		storyboard.gotoScene("login", "fade" ,400);
	end
	
	btnLogIn = widget.newButton
	{
		left = 0,
		top = 0,
		width = 90,
		height = 30,
		onRelease = onLogIn,
		font = myapp.font,
        fontSize = 14,
		label = "LOG IN",
		labelColor = 
		{
			default = {255,0,0,255},
			over = {255,0,0,255},
		},
		id="btnLogIn",
	}
	btnLogIn.x = display.contentWidth / 2
	btnLogIn.y = display.contentHeight / 2
	editGroup:insert(btnLogIn)
		
	
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
