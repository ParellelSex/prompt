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

addCommand({"jumppower", "jp"}, "Sets players jumppower", function(Message, Args)
	if #Args >= 1 then
		local JumpPower = Args[1]
		if tonumber(JumpPower) then
			local Humanoid = getHumanoid()
			if Humanoid then
				Player.Character:FindFirstChildOfClass("Humanoid").JumpPower = tonumber(JumpPower)
				return "Successfully set jumppower to " .. JumpPower .. "\n"
			else
				return "Player has no humanoid.\n"
			end
		else
			return "Argument is not a number: " .. JumpPower .. "\n"
		end
	else
		return "Invalid argument.\n"
	end
end)
