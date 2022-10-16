--!strict
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dash = require(ReplicatedStorage.Packages.Dash)


local Cubicle = Dash.class("Cubicle", function(owner: Player, cframe:CFrame)
    return {
      owner = owner :: Player,
      humanoid = nil :: Humanoid,
      cframe = cframe or CFrame.new() :: CFrame,
      connection = nil :: RBXScriptConnection,
      model = nil :: Model,
      timer = 0 :: number,
      rate = 1 :: number,
      isSeated = false :: boolean,
      highlight = nil :: Highlight,
    }
end)

function Cubicle:init()
  self.model = ReplicatedStorage.Assets.Cubicles.Cubicle:Clone()
  self.model:PivotTo(self.cframe)
  self.model.Parent = game.Workspace

  self.humanoid = self.owner.Character.Humanoid

  local seat:Seat = self.model.Chair.Seat
  seat.Changed:Connect(function(propertyName)
    if propertyName == "Occupant" and seat.Occupant then
      self:startEmitter()
    else
      self:pauseEmitter()
    end
  end)

  -- wait a bit to make sure the humanoid can sit properly.
  task.delay(3, function() 
    self.model.Chair.Seat:Sit(self.humanoid)
  end)
  
  self.emitter = self.model.Laptop.Emitter.ParticleEmitter
  self.emitter.Enabled = false
  self.emitter.Changed:Connect(function(propertyName)
    if propertyName == "Enabled" then
      print("Emitter enabled changed")
    end
  end)

  local label = self.model.NamePlate.Plate.SurfaceGui.TextLabel
  label.Text = self.owner.Character.Name
end

function Cubicle:getModel()
  return self.model
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
