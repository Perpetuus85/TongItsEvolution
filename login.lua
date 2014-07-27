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
	local logo = display.newText("Log In / Sign Up", display.contentWidth / 2, 30, myapp.font,myapp.fontSize);
	logo.x = (display.contentWidth / 2);
	group:insert(logo);
	
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
        y = 100,
        width = display.contentWidth - 40,
        label = "Email : ",
        labelWidth = myLabelWidth,
        labelColor = {0,0,0,1},
        hint = "Email",
        maxChars = 0,
        editFont = myapp.font,
        editFontSize = myapp.fontSize,
        editFontColor = myapp.fontColor,
        listener = textListener,
        submitOnClear = true,
        onSubmit = onSubmit,
        frame = 
          { 
            cornerRadius = 5,
            strokeWidth = 2,
            strokeColor = {.2,.2,.2,1},
            fillColor =   {.9,.9,0.8,1},
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
	
	local passwordField = widget.newEditField
    {
        slideGroup = editGroup,
        x = display.contentCenterX,
        y = 150,
        width = display.contentWidth - 40,
        label = "Password : ",
        labelWidth = myLabelWidth,
        labelColor = {0,0,0,1},
        hint = "Password",
        maxChars = 0,
        editFont = myapp.font,
        editFontSize = myapp.fontSize,
        editFontColor = myapp.fontColor,
        listener = textListener,
        submitOnClear = true,
        onSubmit = onSubmit,
        frame = 
          { 
            cornerRadius = 5,
            strokeWidth = 2,
            strokeColor = {.2,.2,.2,1},
            fillColor =   {.9,.9,0.8,1},
          },
        required = true,
        errorFrame = {
           cornerRadius = 5
        },
        buttons = { 
            {kind = "clear", defaultFile = "images/clear.png"}
        }
        
    }
	
	editGroup:insert(passwordField)
	self.passwordField = passwordField
	
	local aliasField = widget.newEditField
    {
        slideGroup = editGroup,
        x = display.contentCenterX,
        y = 200,
        width = display.contentWidth - 40,
        label = "Username : ",
        labelWidth = myLabelWidth,
        labelColor = {0,0,0,1},
        hint = "Username",
        maxChars = 0,
        editFont = myapp.font,
        editFontSize = myapp.fontSize,
        editFontColor = myapp.fontColor,
        listener = textListener,
        submitOnClear = true,
        onSubmit = onSubmit,
        frame = 
          { 
            cornerRadius = 5,
            strokeWidth = 2,
            strokeColor = {.2,.2,.2,1},
            fillColor =   {.9,.9,0.8,1},
          },
        required = true,
        errorFrame = {
           cornerRadius = 5
        },
        buttons = { 
            {kind = "clear", defaultFile = "images/clear.png"}
        }
        
    }
	
	editGroup:insert(aliasField)
	self.aliasField = aliasField
	
	local function onLoginUser(event)
		if not event.error then
			storyboard.gotoScene("mp-menu-a", "fade", 400);
		else
			native.showAlert("Error", event.error)
		end
	end
	
	local function onRegisterUser(event)
		if not event.error then
			local myEmail = self.emailField:getValue()
			local myPassword = self.passwordField:getValue()
			local dbAdd = [[INSERT INTO userinfo VALUES (NULL, ']] .. myEmail .. [[', ']] .. myPassword .. [[');]];
			db:exec(dbAdd);
			coronium:loginUser(self.emailField:getValue(), self.passwordField:getValue(), onLoginUser)
		else
			print (event.error)
		end
	end
	
	local function onLogin()
		local myAlias = self.aliasField:getValue()
		local myPassword = self.passwordField:getValue()
		local myEmail = self.emailField:getValue()
		myAlias = "Perpetuus"
		myPassword = "test"
		myEmail = "eric.meuse@gmail.com"
		coronium:loginUser(myEmail, myPassword, onLoginUser)
	end
	
	local function onSignUp()
		local myAlias = self.aliasField:getValue()
		local myPassword = self.passwordField:getValue()
		local myEmail = self.emailField:getValue()
		myAlias = "Perpetuus"
		myPassword = "test"
		myEmail = "eric.meuse@gmail.com"
		coronium:registerUser( { email = myEmail, password = myPassword, alias = myAlias}, onRegisterUser )
	end
	
	btnLogin = widget.newButton
	{
		left = 0,
		top = 0;
		width = 150,
		height = 45,
        onRelease = onLogin,
        label = "Log In",
		labelColor = 
		{
			default = {255,255,255,255},
			over = {255,255,255,255},
		},
		defaultFile = "images/mainMenuItem.png",
		overFile = "images/mainMenuItemOver.png",
		id = "btnLogin",
	}
	btnLogin.x = display.contentWidth / 2 - 100
	btnLogin.y = display.contentHeight - 45
	editGroup:insert(btnLogin)
	
	btnSignUp = widget.newButton
	{
		left = 0,
		top = 0;
		width = 150,
		height = 45,
        onRelease = onSignUp,
        label = "Sign Up",
		labelColor = 
		{
			default = {255,255,255,255},
			over = {255,255,255,255},
		},
		defaultFile = "images/mainMenuItem.png",
		overFile = "images/mainMenuItemOver.png",
		id = "btnSignUp",
	}
	btnSignUp.x = display.contentWidth / 2 + 100
	btnSignUp.y = display.contentHeight - 45
	editGroup:insert(btnSignUp)
	
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
