--!strict
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dash = require(ReplicatedStorage.Packages.Dash)


local Cubicle = Dash.class("Cubicle", function(owner: Player, cframe:CFrame)
    return {
      owner = owner :: Player,
      cframe = cframe or CFrame.new() :: CFrame,
      connection = nil :: RBXScriptConnection,
      model = nil :: Model,
      timer = 0 :: number,
      rate = 1 :: number,
      isSeated = false :: boolean,
      highlight = nil :: Highlight,
    }
end)

function Cubicle:getOwner()
  return self.owner
end

function Cubicle:onLaptopMouseEnter()
  if self.highlight then
    self.model.Laptop.Highlight.Enabled = true
  end
end
function Cubicle:onLaptopMouseLeave()
  if self.highlight then
    self.model.Laptop.Highlight.Enabled = false
  end
end
function Cubicle:onLaptopMouseClick()
  self.emitter:Emit(1)
end

function Cubicle:init()
  self.model = ReplicatedStorage.Assets.Cubicles.Cubicle:Clone()
  self.model:PivotTo(self.cframe)
  self.model.Parent = game.Workspace

  local laptop:Model = self.model.Laptop
  self.highlight = Instance.new("Highlight")
  self.highlight.Enabled = false
  self.highlight.FillTransparency = 1
  self.highlight.OutlineColor = Color3.fromRGB(24, 193, 255)
  self.highlight.Parent = laptop
  
  --TODO: Make click detector local only
  local laptopCD = Instance.new("ClickDetector")
  laptopCD.MouseHoverEnter:Connect(function() 
    self:onLaptopMouseEnter() 
  end)
  laptopCD.MouseHoverLeave:Connect(function() 
    self:onLaptopMouseLeave() 
  end)
  laptopCD.MouseClick:Connect(function() 
    self:onLaptopMouseClick() 
  end)
  laptopCD.Parent = laptop

--TODO: Make it so that the Seat is the one listening for the player to sit.
  local humanoid = self.owner.Character.Humanoid
  humanoid.Seated:Connect(function(bool, seat)
    if bool then
      self:startEmitter()
    else
      self:pauseEmitter()
    end
  end)
  -- wait a bit to make sure the humanoid can sit properly.
  task.delay(3, function() 
    self.model.Chair.Seat:Sit(humanoid)
  end)
  
  self.emitter = self.model.Laptop.Emitter.ParticleEmitter
  self.emitter.Enabled = false

  local label = self.model.NamePlate.Plate.SurfaceGui.TextLabel
  label.Text = self.owner.Character.Name
end

function Cubicle:startEmitter()
  if self.connection then return end
  
  self.timer = 0
  self.connection = RunService.Heartbeat:Connect(function(delta)
    self:runEmitter(delta)
  end)
end

function Cubicle:runEmitter(delta)
  self.timer = self.timer + delta
  if self.timer > self.rate then
    self.timer = self.timer - self.rate
    
    if self.emitter then
      self.emitter:Emit(1)
    end
  end
end

function Cubicle:pauseEmitter()
  if self.connection then
    self.connection:Disconnect()
    self.connection = nil
  end
end

function Cubicle:shutdown()
  if self.connection then 
    self.connection:Disconnect()
    self.connection = nil
  end
  if self.model then
    self.model:Destroy()
    self.model = nil
  end
end

return Cubicle
