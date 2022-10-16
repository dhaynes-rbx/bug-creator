local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local OnCubicleAdded:RemoteEvent = ReplicatedStorage.Scripts.Events.OnCubicleAdded

OnCubicleAdded.OnClientEvent:Connect(function(cubicle)
    --Get the model
    print("Cubicle assigned to", Players.LocalPlayer)

    local laptop:Model = cubicle.Laptop
    local highlight:Highlight = Instance.new("Highlight")
    highlight.Enabled = false
    highlight.FillTransparency = 1
    highlight.OutlineColor = Color3.fromRGB(24, 193, 255)
    highlight.Parent = laptop

    local emitter = cubicle.Laptop.Emitter.ParticleEmitter

    local function onLaptopMouseEnter()
        highlight.Enabled = true
    end
    local function onLaptopMouseLeave()
        if highlight then
            highlight.Enabled = false
        end
    end
    local function onLaptopMouseClick()
        emitter:Emit(1)
    end
    
    --TODO: Make click detector local only
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

