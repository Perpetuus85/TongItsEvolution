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
	local logo = display.newText("Forgot Password", display.contentWidth / 2, 30, myapp.font,myapp.fontSize);
	logo.x = (display.contentWidth / 2);
	group:insert(logo);
	
	local description = display.newText("Please enter your email address below.", 0, 60, myapp.font, 18);
	description.x = display.contentWidth / 2;
	group:insert(description);
	
	local descriptionNext = display.newText("We will send you an email to confirm your password.", 0, 80, myapp.font, 18);
	descriptionNext.x = display.contentWidth / 2;
	group:insert(descriptionNext);
	
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
	
	local myLabelWidth = 80 
	
	local emailField = widget.newEditField
    {
        slideGroup = editGroup,
        x = display.contentCenterX,
        y = 150,
        width = display.contentWidth - 40,
        label = "Email : ",
        labelWidth = myLabelWidth,
        labelColor = {0,0,0,1},
        hint = "Email",
        maxChars = 0,
        editFont = myapp.font,
        editFontSize = 18,
        editFontColor = {0,0,0,1},
        listener = textListener,
        submitOnClear = true,
        onSubmit = onSubmit,
        frame = 
          { 
            cornerRadius = 5,
            strokeWidth = 2,
            strokeColor = {.2,.2,.2,1},
            fillColor =   {255,255,255,1},
          },
        required = true,
        errorFrame = {
           cornerRadius = 5
        },
        buttons = { 
            {kind = "clear", defaultFile = "images/clear.png"}
        }
        
    }
	
	editGroup:insert(emailField)
	self.emailField = emailField
	
	local function onSentEmail(event)
		if not event.error then
			storyboard.gotoScene("sentemail", "fade", 400);
		else
			native.showAlert("Error", event.error)
		end
	end
	
	local function onEmailPassword()
		local myEmail = self.emailField:getValue()
		--myEmail = "eric.meuse@gmail.com"
		coronium:requestPassword(myEmail, onSentEmail)
	end
	
	local function onSignIn()
		storyboard.gotoScene("login", "fade" ,400);
	end
	
	btnEmailPassword = widget.newButton
	{
		left = 0,
		top = 0;
		width = 140,
		height = 45,
        onRelease = onEmailPassword,
        font = myapp.font,
        fontSize = 18,
        label = "Submit",
		labelColor = 
		{
			default = {255,255,255,255},
			over = {255,255,255,255},
		},
		defaultFile = "images/mainMenuItem.png",
		overFile = "images/mainMenuItemOver.png",
		id = "btnLogin",
	}
	btnEmailPassword.x = display.contentWidth / 2
	btnEmailPassword.y = emailField.y + 40
	editGroup:insert(btnEmailPassword)	
	
	btnSignIn = widget.newButton
	{
		left = 0,
		top = 0,
		width = 90,
		height = 30,
		onRelease = onSignIn,
		font = myapp.font,
        fontSize = 14,
		label = "LOG IN",
		labelColor = 
		{
			default = {255,0,0,255},
			over = {255,0,0,255},
		},
		id="btnSignIn",
	}
	local accountSignIn = display.newText("Already have an account?", 0, 0, myapp.font, 14);
	
	btnSignIn.x = (display.contentWidth / 2) + (btnSignIn.width) - 10
	btnSignIn.y = display.contentHeight - 27
	editGroup:insert(btnSignIn)
	
	
	accountSignIn.x = (display.contentWidth / 2) - (accountSignIn.width / 2) + (btnSignIn.width / 2)
	accountSignIn.y = display.contentHeight - 27
	editGroup:insert(accountSignIn)
		
	
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
