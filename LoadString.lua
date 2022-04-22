repeat task.wait() until game:IsLoaded() == true

local user = 'ParellelSex'
local branch = 'prompt'
local link = 'https://raw.githubusercontent.com/'

local function GetURL(url)
    local get = '%s/%s/%s/main/%s'
    return game:HttpGet(string.format(get,link,user,branch,url))
end

loadstring(GetURL('MoonPromptMain.lua.lua'))();
