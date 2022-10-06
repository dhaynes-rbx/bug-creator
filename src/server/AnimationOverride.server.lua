local Players = game:GetService("Players")

local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")

    for _, playingTracks in pairs(humanoid:GetPlayingAnimationTracks()) do
        playingTracks:Stop(0)
    end

    local animateScript = character:WaitForChild("Animate")
    animateScript.sit.SitAnim.AnimationId = "rbxassetid://11188590043"
end

local function onPlayerAdded(player)
    player.CharacterAppearanceLoaded:Connect(onCharacterAdded)
end

Players.PlayerAdded:Connect(onPlayerAdded)