local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local OnCubicleAdded:RemoteEvent = ReplicatedStorage.Scripts.Events.OnCubicleAdded

--Create the environment
local environment = ReplicatedStorage.Assets.Environment.Office:Clone()
environment.Parent = game.Workspace
local cubicleSlots = environment.CubicleSlots

local cubicles = {}
local playerIndex = 0
local function onPlayerAdded(player:Player)
    player.CharacterAdded:Connect(function(character)
        if cubicles[player] then
            return
        end
        if playerIndex >= #cubicleSlots:GetChildren() then
            return
        end
        
        playerIndex = playerIndex + 1
        
        local cframe = cubicleSlots[tostring(playerIndex)]:GetPivot()
        local cubicleModel = ReplicatedStorage.Assets.Cubicles.Cubicle:Clone()
        cubicleModel:PivotTo(cframe)
        cubicleModel.Parent = game.Workspace
        
        CollectionService:AddTag(cubicleModel, "Cubicle")
        cubicles[player] = cubicleModel

        OnCubicleAdded:FireClient(player, cubicleModel)
    end)
end

local function onPlayerRemoving(player:Player)
    if cubicles[player] then
        cubicles[player]:Destroy()
        cubicles[player] = nil
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

--Loop through all connected players to make sure each player is added!
for _, player in pairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

local bugLeaderboard = environment.Scoreboard.SurfaceGui.Frame.TextLabel
local totalBugs = 0
local OnBugCountUpdated:RemoteEvent = ReplicatedStorage.Scripts.Events.OnBugCountUpdated
OnBugCountUpdated.OnServerEvent:Connect(function(client, bugCount)
    totalBugs += bugCount
    bugLeaderboard.Text = "Bugs created: "..tostring(totalBugs)
end)