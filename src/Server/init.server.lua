local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local CollectionService = game:GetService("CollectionService")

local Classes = ReplicatedStorage.Scripts.Classes
local Cubicle = require(Classes.Cubicle)

local OnCubicleAdded:RemoteEvent = ReplicatedStorage.Scripts.Events.OnCubicleAdded

local cubicles = {}
local playerIndex = 0
local function onPlayerAdded(player:Player)
    player.CharacterAdded:Connect(function(character)
        if cubicles[player] then 
            return
        end
        
        playerIndex = playerIndex + 1
        
        local cframe = CFrame.new((playerIndex - 1) * 10, 0, 0)
        local cubicle = Cubicle.new(player, cframe)
        cubicle:init()

        local model = cubicle.model
        
        CollectionService:AddTag(model, "Cubicle")
        cubicles[player] = cubicle

        OnCubicleAdded:FireClient(player, model)
        print("Server: Cubicle added and assigned to", player)
    end)
end

Players.PlayerAdded:Connect(onPlayerAdded)

--Loop through all connected players to make sure each player is added!
for _, player in pairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

local OnCubicleAdded: RemoteEvent = ReplicatedStorage.Scripts.Events.OnCubicleAdded
OnCubicleAdded:FireAllClients()