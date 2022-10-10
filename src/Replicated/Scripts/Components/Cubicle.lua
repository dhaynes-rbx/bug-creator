--!strict
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(game.ReplicatedStorage.Packages.React)
local Roact = require(game.ReplicatedStorage.Packages.Roact)
local ReactRoblox = require(game.ReplicatedStorage.Packages.ReactRoblox)
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
end

function Cubicle:startEmitter()
  print("Starting emitter")
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
    print("Pausing emitter")
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
    
    --Tell the player that their cubicle is ready.

    -- local uiChildren = React.createElement("SurfaceGui", {
    --   ClipsDescendants = true,
    --   LightInfluence = 1,
    --   SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
    --   Face = Enum.NormalId.Top,
    --   ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    -- }, {
    --   frame = React.createElement("Frame", {
    --     BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    --     BackgroundTransparency = 0.8,
    --     Size = UDim2.fromScale(1, 1),
    --   }),
    
    --   textFrame = React.createElement("Frame", {
    --     AnchorPoint = Vector2.new(0.5, 0.5),
    --     BackgroundColor3 = Color3.fromRGB(156, 184, 255),
    --     BorderSizePixel = 0,
    --     Position = UDim2.fromScale(0.5, 0.5),
    --     Size = UDim2.new(1, -10, 1, -10),
    --   }, {
    --     bugs = React.createElement("TextLabel", {
    --       FontFace = Font.new(
    --         "rbxasset://fonts/families/FredokaOne.json",
    --         Enum.FontWeight.Bold,
    --         Enum.FontStyle.Normal
    --       ),
    --       Text = "Bugs: 999,999,999",
    --       TextColor3 = Color3.fromRGB(0, 0, 0),
    --       TextSize = 25,
    --       AnchorPoint = Vector2.new(0.5, 0),
    --       BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    --       BackgroundTransparency = 1,
    --       BorderSizePixel = 0,
    --       LayoutOrder = 1,
    --       Position = UDim2.fromScale(0.5, 0),
    --       Size = UDim2.new(1, 0, 0, 30),
    --     }),
    
    --     level = React.createElement("TextLabel", {
    --       FontFace = Font.new(
    --         "rbxasset://fonts/families/FredokaOne.json",
    --         Enum.FontWeight.Bold,
    --         Enum.FontStyle.Normal
    --       ),
    --       Text = "Level: 17",
    --       TextColor3 = Color3.fromRGB(0, 0, 0),
    --       TextSize = 25,
    --       AnchorPoint = Vector2.new(0.5, 0),
    --       BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    --       BackgroundTransparency = 1,
    --       BorderSizePixel = 0,
    --       Position = UDim2.fromScale(0.5, 0),
    --       Size = UDim2.new(1, 0, 0, 30),
    --     }),
    
    --     uIListLayout = React.createElement("UIListLayout", {
    --       SortOrder = Enum.SortOrder.LayoutOrder,
    --       VerticalAlignment = Enum.VerticalAlignment.Center,
    --     }),
    --   }),
    -- })

    -- local uiRoot = ReactRoblox.createRoot(model.UI.UIRoot):render(uiChildren)

    -- local emitter = 

