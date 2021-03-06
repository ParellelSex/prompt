---- Setup ----

repeat task.wait() until game:IsLoaded() == true

local user = 'ParellelSex'
local branch = 'prompt'
local link = 'https://raw.githubusercontent.com/'

local function GetURL(url)
    local get = '%s/%s/%s/main/%s'
    return game:HttpGet(string.format(get,link,user,branch,url))
end

do
    local Prompt = getgenv().Prompt
    if Prompt then
        return rconsoleprint("Prompt has already been ran!\n"),
        rconsoleprint("Welcome!")
    end
end

makefolder("MoonPrompt")
makefolder("MoonPrompt/addons")

---- Main Variables ----

local Services = {
    Players = game:GetService("Players")
}

local split, sub, len, find, lower, format =
      string.split, string.sub, string.len, string.find, string.lower, string.format

local Player = Services.Players.LocalPlayer

---- Main Functions ----

commandTable = {}
function addCommand(Names, Description, Func)
    table.insert(commandTable, {Names, Description, Func})
end

function getCmd(cmd)
	for _,v in pairs(commandTable) do
		if table.find(v[1], cmd) then
			return v
		else
			return false
		end
	end
end

function addAlias(cmd, alias)
	local Command = getCmd(cmd)
	if Command then
		table.insert(Command[1], alias)
		return Command
	else
		return false
	end
end

function removeAlias(cmd, alias)
	local Command = getCmd(cmd)
	if Command then
		if table.find(Command[1], alias) then
			table.insert(Command[1], table.find(Command[1], alias))
		end
		return Command
	else
		return false
	end
end

function getPlayer(Str)
    for _,v in pairs(Services.Players:GetPlayers()) do
        if find(v.Name:lower(), Str:lower()) or find(v.DisplayName:lower(), Str:lower()) then
            return v
        end
    end
    return false
end

function getCharacter(Plr)
    return (Plr and Plr.Character) or (Player and Player.Character) or false
end

function getHumanoid(Plr)
    return (Plr and Plr.Character and Plr.Character:FindFirstChildOfClass("Humanoid")) or (Player and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")) or false
end

function preCommand()
    rconsoleprint("@@DARK_GRAY@@")
    rconsoleprint("> ")
    rconsoleprint("@@WHITE@@")
    rconsoleprint("Command: ")
end

local CCamera = game:GetService('Workspace').CurrentCamera
local res = string.format('%sx%s',tostring(CCamera.ViewportSize.X),tostring(CCamera.ViewportSize.Y))
getgenv().ExecutionTimes = 0
getgenv().ExecutionTimesm = 0
getgenv().ExecutionTime = string.format('%s minutes, %s seconds.',getgenv().ExecutionTimesm,getgenv().ExecutionTimes)

local Months = {
    [1] = 'January',[2] = 'February',[3] = 'March',
    [4] = 'April',[5] = 'May',[6] = 'June',
    [7] = 'July',[8] = 'August',[9] = 'September',
    [10] = 'October',[11] = 'November',[12] = 'December'
}

spawn(function()
    while wait(1) do
        getgenv().ExecutionTimes=getgenv().ExecutionTimes+1
        if getgenv().ExecutionTimes == 60 then
            getgenv().ExecutionTimes = 0
            getgenv().ExecutionTimesm = getgenv().ExecutionTimesm+1
        end
        getgenv().ExecutionTime = string.format('%s minutes, %s seconds.',getgenv().ExecutionTimesm,getgenv().ExecutionTimes)
    end
end)

local function getMDYT()
    return string.format('%s %s, %s | %s',Months[tonumber(os.date('%m'))],tonumber(os.date('%d')),tostring(os.date('%Y')),tostring(os.date('%X')))
end

local function Logo()
    rconsoleclear()
    rconsoleprint('@@DARK_GRAY@@')
    rconsoleprint([[     _.._
  .' .-'`    ]]..' Resolution: '..res..'\n'..[[
 /  /        ]]..' Instance time: '..getgenv().ExecutionTime..'\n'..
     " |")
    rconsoleprint('@@WHITE@@')
    rconsoleprint([[  |         ]]..getMDYT()..'\n'..[[
 \  '.___.;
  '.____.'
    ]])
    rconsoleprint("\n")
    rconsoleprint("@@DARK_GRAY@@")
    rconsoleprint("[")
    rconsoleprint("@@WHITE@@")
    rconsoleprint("!")
    rconsoleprint("@@DARK_GRAY@@")
    rconsoleprint("] ")
    rconsoleprint("@@WHITE@@")
    rconsoleprint("Welcome back, ")
    rconsoleprint('@@DARK_GRAY@@')
    rconsoleprint(Player.Name.."\n")
end

function consoleError(Text)
    rconsoleprint("@@YELLOW@@")
    rconsoleprint("[")
    rconsoleprint("@@BROWN@@")
    rconsoleprint("!")
    rconsoleprint("@@YELLOW@@")
    rconsoleprint("] "..Text.."\n")
end

---- Core ----

rconsolename("Moon Prompt - By PeaPattern & ParellelSex")
Logo()
preCommand()

for i,v in next, listfiles('MoonPrompt/addons') do
    loadfile(v)()
end
addCommand({"info"}, "Gives you information on a command.", function(Message, Args)
    if #Args >= 1 then
        local Command = Args[1]
        local foundCommand
        if Command then
            for _,v in pairs(commandTable) do
                local Names = v[1]
                local Description = v[2]
                for i,x in pairs(Names) do
                    if x:lower() == Command:lower() then
                        foundCommand = v
                        break
                    end
                end
            end
            
            if foundCommand then
                local Aliases = ""
                for _,v in pairs(foundCommand[1]) do
                    if _ ~= #foundCommand[1] then
                        Aliases = Aliases .. v .. ", "
                    else
                        Aliases = Aliases .. v
                    end
                end
                return string.format("\nName: %s\nAliases: %s\nDescription: %s\n\n", foundCommand[1][1], Aliases, foundCommand[2])
            else
                return "Could not find command: " .. Command .. "\n"
            end
        else
            return "Invalid command argument."
        end
    end
end)

addCommand({"clear", "clr"}, "Clears the console.", function(Message, Args)
    Logo()
    preCommand()
    Prompt()
    return "Cleared console!"
end)

addCommand({"import"}, "Imports a addon into the console.", function(Message, Args)
    if #Args >= 1 then
        pcall(function()
        writefile("MoonPrompt/addons/"..Args[1],GetURL("addons/"..Args[1]))
        loadfile('MoonPrompt/addons/'..Args[1])()
        end)
    end
    preCommand()
    Prompt()
    return "ImportHelp"
end)

addCommand({"commands", "cmds", "help"}, "Lists out the commands.", function(Message, Args)
    local cmdList = "\n"
    for _,v in pairs(commandTable) do
        local Names = v[1]
        cmdList = cmdList .. Names[1] .. "\n"
    end
    cmdList = cmdList .. "\n"
    return cmdList
end)

---- Final ----

function Prompt()
    local Input = rconsoleinput()
    local Passed = false
    for _,v in pairs(commandTable) do
        local Split = split(Input, " ")
        local Names = v[1]
        local Func = v[3]
        for i,x in pairs(Names) do
            local Args = split(Input:sub(x:len()+2), " ")
            if Split[1] == x then
                local Data = Func(Input, Args)
                if Data then
                    rconsoleprint(Data)
                else
                    consoleError("No command data found.")
                end
                Passed = true
            end
        end
    end
    if not Passed then
        consoleError("Invalid command!")
        preCommand()
        Prompt()
    else
        preCommand()
        Prompt()
    end
    task.wait()
end
Prompt()

---- Finished ----
