local CCamera = game:GetService('Workspace').CurrentCamera
local Months = {
[1] = 'January',[2] = 'February',[3] = 'March',
[4] = 'April',[5] = 'May',[6] = 'June',
[7] = 'July',[8] = 'August',[9] = 'September',
[10] = 'October',[11] = 'November',[12] = 'December'
}
local function getMDYT()
    return string.format('%s %s, %s | %s',Months[tonumber(os.date('%m'))],tonumber(os.date('%d')),tostring(os.date('%Y')),tostring(os.date('%X')))
end
local ms = rconsoleinput()
if ms:sub(1,5):lower() == 'dump ' then
    local HttpService = game:GetService("HttpService")
local function GetURL(url)
    return game:HttpGet(url)
end
function dumpUser(name)
pcall(function()
    local dumpplr = game:GetService('Players')[name]
    local ID = dumpplr.UserId
    local info = HttpService:JSONDecode(GetURL(
    'https://users.roblox.com/v1/users/'..ID
    ))
    local followersTable = HttpService:JSONDecode(GetURL(
    'https://friends.roblox.com/v1/users/'..ID..'/followers/count'
    ))
    local followingTable = HttpService:JSONDecode(GetURL(
    'https://friends.roblox.com/v1/users/'..ID..'/followings/count'
    ))
    local friendsTable = HttpService:JSONDecode(GetURL(
    'https://friends.roblox.com/v1/users/'..ID..'/friends'
    ))
    local selffriendsTable = HttpService:JSONDecode(GetURL(
    'https://friends.roblox.com/v1/users/'..game:GetService('Players')
    .LocalPlayer.UserId..'/friends'
    ))
    local UserName = dumpplr.Name
    local DisplayName = dumpplr.DisplayName
    local JoinDate = info['created']:sub(1,10)
    local Followers = followersTable['count']
    local Following = followingTable['count']
    local Friends = #friendsTable['data']
    local Mutuals = {}
    for i,c in next, friendsTable['data'] do
    for i,v in next, c do
    for k,l in next, selffriendsTable['data'] do
    for s,e in next, l do
    if i == 'name' then
    if v == e then
    table.insert(Mutuals,v)
    end end end end end end
    rconsoleprint('User ID: '..ID)
    rconsoleprint('\n')
    rconsoleprint('User Name: '..UserName)
    rconsoleprint('\n')
    rconsoleprint('User Display Name: '..DisplayName)
    rconsoleprint('\n')
    rconsoleprint('Join Date: '..JoinDate)
    rconsoleprint('\n')
    rconsoleprint('Followers: '..Followers)
    rconsoleprint('\n')
    rconsoleprint('Following: '..Following)
    rconsoleprint('\n')
    rconsoleprint('Friends: '..Friends)
    rconsoleprint('\n')
    rconsoleprint('Mutuals: ')
    for i,v in next, Mutuals do
       rconsoleprint(v..' ')
    end
    end)
    end
    dumpUser(ms:sub(6))
    rconsoleprint('\n')
    text()
elseif ms:lower() == 'clear' then
    rconsoleclear()
    rconsoleprint('@@DARK_GRAY@@')
    rconsoleprint([[    _.._
      .' .-'`    ]]..'Resolution: '..res..'\n'..[[
     /  /        ]]..'Instance time: '..getgenv().ExecutionTime..'\n'..[[
     |]])
    rconsoleprint('@@WHITE@@')
    rconsoleprint([[  |        ]]..getMDYT()..'\n'..[[
     \  '.___.;
      '.____.']])
    rconsoleprint('\n')
    rconsoleprint('\n')
    rconsoleprint('@@DARK_GRAY@@')
    rconsoleprint('[')
    rconsoleprint('@@WHITE@@')
    rconsoleprint('!')
    rconsoleprint('@@DARK_GRAY@@')
    rconsoleprint('] ')
    rconsoleprint('@@WHITE@@')
    rconsoleprint('Welcome back, ')
    rconsoleprint('@@DARK_GRAY@@')
    rconsoleprint(tostring(game:GetService('Players').LocalPlayer.Name))
    rconsoleprint('\n')
    text()
