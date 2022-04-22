local Player = game:GetService("Players").LocalPlayer

addCommand({"walkspeed", "ws", "speed"}, "Sets players walkspeed.", function(Message, Args)
	if #Args >= 1 then
		local Speed = Args[1]
		if tonumber(Speed) then
			local Humanoid = getHumanoid()
			if Humanoid then
				Player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = tonumber(Speed)
				return "Successfully set speed to " .. Speed .. "\n"
			else
				return "Player has no humanoid.\n"
			end
		else
			return "Argument is not a number: " .. Speed .. "\n"
		end
	else
		return "Invalid argument.\n"
	end
end)
