local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- local React = require(ReplicatedStorage.Packages.React)
-- local Roact = require(ReplicatedStorage.Packages.Roact)
-- local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local Components = ReplicatedStorage.Scripts.Components
local Cubicle = require(Components.Cubicle)



local cubicles = {}
local function createCubicle(player:Player, playerIndex)
    if cubicles[player] then return end
    local cframe = CFrame.new((playerIndex - 1) * 10, 0, 0)
    cubicles[player] = Cubicle.new(player, cframe):init()
end

local playerIndex = 0
local function onPlayerAdded(player:Player)
    player.CharacterAdded:Connect(function(character)
        playerIndex = playerIndex + 1
        createCubicle(player, playerIndex)
    end)
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(function(player)
    --remove the cubicle
    --reorganize the cubicles
end)

--Loop through all connected players to make sure each player is added!
for _, player in pairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

