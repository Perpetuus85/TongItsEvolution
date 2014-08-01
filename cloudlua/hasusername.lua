local in_data = coronium.input();
local myEmail = in_data.email;

local answer = coronium.user.getUsers({email = myEmail});

local user_records = answer.result;
local checkUsername = false;
for _, user in ipairs( user_records ) do
	if (user.username) then
		checkUsername = true;
	end
end

local out_data = {hasUsername = checkUsername}

coronium.output(coronium.answer(out_data));