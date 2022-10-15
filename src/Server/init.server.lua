local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local CollectionService = game:GetService("CollectionService")

local Classes = ReplicatedStorage.Scripts.Classes
local Cubicle = require(Classes.Cubicle)

local cubicles = {}
local function createCubicle(player:Player, playerIndex)
    if cubicles[player] then return end
    local cframe = CFrame.new((playerIndex - 1) * 10, 0, 0)
    local cubicle = Cubicle.new(player, cframe):init()
    CollectionService:AddTag(cubicle, "Cubicle")
    cubicles[player] = cubicle
end

local playerIndex = 0
local function onPlayerAdded(player:Player)
    player.CharacterAdded:Connect(function(character)
        playerIndex = playerIndex + 1
        createCubicle(player, playerIndex)
    end)
end

-- Players.PlayerRemoving:Connect(function(player)
--     --remove the cubicle
--     --reorganize the cubicles
-- end)

Players.PlayerAdded:Connect(onPlayerAdded)
--Loop through all connected players to make sure each player is added!
for _, player in pairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

local OnCubicleAdded: RemoteEvent = ReplicatedStorage.Scripts.Events.OnCubicleAdded
OnCubicleAdded:FireAllClients()