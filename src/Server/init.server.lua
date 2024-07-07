local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local function onPlayerAdded(player:Player)
    player.CharacterAdded:Connect(function(character)
        print("Player Character added: "..player.Name)
        local humanoid = character:WaitForChild("Humanoid")

        --Swap out the sitting animation to show a keyboard-typing animation
        for _, playingTracks in pairs(humanoid:GetPlayingAnimationTracks()) do
            playingTracks:Stop(0)
        end

        local animateScript = character:WaitForChild("Animate")
        animateScript.sit.SitAnim.AnimationId = "rbxassetid://11188590043"
    end)
end

local function onPlayerRemoving(player:Player)
    print("Player removed: "..player.Name)
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

--Loop through all connected players to make sure each player is added!
for _, player in pairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end