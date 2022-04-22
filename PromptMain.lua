---- Setup ----

if not game:IsLoaded() then
    repeat task.wait() until game:IsLoaded()
end

do
    local Prompt = getgenv().Prompt
    if Prompt then
        return rconsoleprint("Prompt has already been ran!\n"),
        rconsoleprint("Welcome!")
    end
end

---- Main Variables ----

local Services = {
    Players = game:GetService("Players")
}

local split, sub, len, find, lower, format =
      string.split, string.sub, string.len, string.find, string.lower, string.format

local Player = Services.Players.LocalPlayer

---- Main Functions ----

local commandTable = {}
local function addCommand(Names, Description, Func)
    table.insert(commandTable, {Names, Description, Func})
end

local function preCommand()
    rconsoleprint("@@DARK_GRAY@@")
    rconsoleprint("> ")
    rconsoleprint("@@WHITE@@")
    rconsoleprint("Command")
    rconsoleprint("@@DARK_GRAY@@")
    rconsoleprint(": ")
end

if not isfolder("MoonPrompt") then
    makefolder('MoonPrompt')
end
if not isfolder("MoonPrompt/addons") then
    makefolder('MoonPrompt/addons')
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

local function consoleError(Text)
    rconsoleprint("@@YELLOW@@")
    rconsoleprint("[")
    rconsoleprint("@@BROWN@@")
    rconsoleprint("!")
    rconsoleprint("@@YELLOW@@")
    rconsoleprint("] "..Text.."\n")
end

---- Core ----

rconsolename("Prompt")
Logo()
preCommand()

addCommand({"info"}, "Gives you information on a command.", function(Message, Args)
    if #Args >= 1 then
        local foundCommand
        do
            for _,v in pairs(commandTable) do
                local Names = v[1]
                for i,x in pairs(Names) do
                    if find(x:lower(), Args[1]:lower()) then
                        foundCommand = v
                        break
                    end
                end
            end
        end
        
        if foundCommand then
            local Aliases = ""
            if #foundCommand[1] < 1 then
                local Aliases = "None"
            end
            for _,v in pairs(foundCommand[1]) do
                if _ ~= #foundCommand[1] then
                    Aliases = Aliases .. v .. ", "
                else
                    Aliases = Aliases .. v
                end
            end
            return format("Name: %s\nAliases: %s\nDescription: %s\n", foundCommand[1][1], Aliases, foundCommand[2])
        else
            return "Command not found."
        end
    end
end)

addCommand({"clear"}, "Clears the console.", function(Message, Args)
    Logo()
    preCommand()
    Prompt()
    return "Cleared console!"
end)
for _,file in pairs(listfiles('MoonPrompt/addons')) do
    loadstring(readfile(tostring(file)))()
end

---- Final ----

function Prompt()
    local Input = rconsoleinput()
    local Passed = false
    for _,v in pairs(commandTable) do
        local Split = split(Input, " ")
        local Names = v[1]
        local Func = v[3]
        for i,x in pairs(Names) do
            if Split[1] == x then
                local Data = Func(Message, split(sub(Input, len(x)), " "))
                rconsoleprint(Data)
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
