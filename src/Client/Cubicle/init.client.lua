local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BugEmitter = require(script.BugEmitter)
local OnCubicleAdded:RemoteEvent = ReplicatedStorage.Scripts.Events.OnCubicleAdded

OnCubicleAdded.OnClientEvent:Connect(function(cubicleModel)
    --Make sure the character is loaded...
    Players.LocalPlayer.CharacterAdded:Connect(function(character)

        local event:RemoteEvent = ReplicatedStorage.Scripts.Events.OnBugCountUpdated
        local bugEmitter = BugEmitter.new(cubicleModel.Laptop.Emitter.ParticleEmitter, event)
        
        local seat:Seat = cubicleModel.Chair.Seat
        seat.Changed:Connect(function(propertyName)
            if propertyName == "Occupant" and seat.Occupant then
                bugEmitter:start()
            else
                bugEmitter:stop()
            end
        end)

        local humanoid = Players.LocalPlayer.Character:WaitForChild("Humanoid")
        -- wait a bit to make sure the humanoid can sit properly.
        task.delay(3, function()
            seat:Sit(humanoid)
            bugEmitter:start()
        end)
        
        
        local label = cubicleModel.NamePlate.Plate.SurfaceGui.TextLabel
        label.Text = Players.LocalPlayer.Name
        
        local laptop:Model = cubicleModel.Laptop
        local highlight:Highlight = Instance.new("Highlight")
        highlight.Enabled = false
        highlight.FillTransparency = 1
        highlight.OutlineColor = Color3.fromRGB(24, 193, 255)
        highlight.Parent = laptop
    
        local function onLaptopMouseEnter()
            highlight.Enabled = true
        end
        local function onLaptopMouseLeave()
            if highlight then
                highlight.Enabled = false
            end
        end
        local function onLaptopMouseClick()
            bugEmitter:emit(1)
        end
        
        local laptopCD = Instance.new("ClickDetector")
        laptopCD.MouseHoverEnter:Connect(function()
            onLaptopMouseEnter()
        end)
        laptopCD.MouseHoverLeave:Connect(function()
            onLaptopMouseLeave()
        end)
        laptopCD.MouseClick:Connect(function()
            onLaptopMouseClick()
        end)
        laptopCD.Parent = laptop
    end)
end)

