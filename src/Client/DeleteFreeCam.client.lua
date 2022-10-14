local Players = game:GetService("Players")
-- Delete the FreeCam to limit players to their character attached camera and avoid camera based exploits.
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui", 5)
if playerGui then
    local freecam = playerGui:WaitForChild("Freecam", 5)
    if freecam then
        freecam:Destroy()
    end
end