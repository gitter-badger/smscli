local parseCommand
parseCommand = function(body)
	index =  string.find(body, " ")
	if not (index == nil) then
		command = string.sub(body,1,index-1)
		rest = string.sub(body, index+1)
		
		if string.upper(command) == "CALL" then
				return {command = "CALL", number = storage.myLocalNumber, body = "calltest"}
		elseif string.upper(command) == "SMS" then
				return {command = "SMS", number = storage.myLocalNumber, body = "smstest"}
		elseif command == "." then
				return {command = "SMS", number = storage.lastOutbound, body = rest}
		elseif command == "#" then
				return {command = "SMS", number = storage.lastInbound, body = rest}
		elseif not (findNumber(body).number == nil) then
				return {command = "SMS", number = findNumber(body).number, body = findNumber(body).body}
		end		
	end
	return {command = "SMS", number = storage.lastOutbound, body = body}
end

-- this fuction finds a number as the first word in a string 
-- and returns it or plus the body or nothing
findNumber = function(body)
	index =  string.find(body, " ")
	if not (index == nil) then
		number = string.sub(body,1,index-1)
		rest = string.sub(body, index+1)
		
		if tonumber(number) and string.len(number) > 4 then
			return {body = rest, number = number}
		elseif string.sub(number,1,1) == "+"  and string.len(number) > 4 then
			if tonumber(string.sub(number,2)) then			
				return {body = rest, number = number}
			end
		end
	end
	return {body = body}
end