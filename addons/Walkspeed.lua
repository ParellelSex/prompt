local Player = game:GetService("Players").LocalPlayer

addCommand({"walkspeed", "ws", "speed"}, "Sets players walkspeed.", function(Message, Args)
	if #Args < 1 then
		return "Invalid argument.\n"
	end
	
	local Speed = Args[1]
	if not tonumber(Speed) then
		return "Argument is not a number: " .. Speed .. "\n"
	end
	
	local Humanoid = getHumanoid()
	if not Humanoid then
		return "Player has no humanoid.\n"
	end
	
	Humanoid.WalkSpeed = tonumber(Speed)
	return "Successfully changed speed to " .. Speed .. "!\n"
end)
