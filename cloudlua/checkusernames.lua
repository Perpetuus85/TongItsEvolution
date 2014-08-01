local in_data = coronium.input();
local myUsername = in_data.username;

local answer = coronium.user.getUsers({username = myUsername});

local user_records = answer.result;
local hasUniqueUsername = true;
for _, user in ipairs( user_records ) do
	hasUniqueUsername = false;
end

local out_data = {uniqueUsername = hasUniqueUsername}

coronium.output(coronium.answer(out_data));