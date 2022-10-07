print("Hello world, from client!")
local Players = game:GetService("Players")
local Packages = game:GetService("ReplicatedStorage").Packages
local Roact = require(Packages.Roact)


-- local HelloWorldComponent = require(script.HelloWorldComponent)

-- local app = Roact.createElement("ScreenGui", {}, {HelloWorldComponent})

-- Roact.mount(app, Players.LocalPlayer.PlayerGui

--Setup the camera

--Place the player
-- local seat = scene:WaitForChild("Chair").Seat
-- local Player = Players.LocalPlayer
-- Player.CharacterAdded:Connect(function(char)
--     local Humanoid = char:WaitForChild("Humanoid")
--     task.wait(3)
--     seat:Sit(Humanoid)
-- end
-- )