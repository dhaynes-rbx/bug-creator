--!strict
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local React = require(game.ReplicatedStorage.Packages.React);
local ReactRoblox = require(game.ReplicatedStorage.Packages.ReactRoblox)

local Cubicle = {
    --current upgrades
    owner = nil
}

function Cubicle:new(owner:Player, cframe:CFrame)
    self.owner = owner
    local model: Model = ReplicatedStorage.Assets.Cubicles.Cubicle:Clone()
    model.NamePlate.Plate.SurfaceGui.TextLabel.Text = owner.Character.Name
    model:PivotTo(cframe)
    model.Parent = game.Workspace

    local uiChildren = React.createElement("SurfaceGui", {
      ClipsDescendants = true,
      LightInfluence = 1,
      SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
      Face = Enum.NormalId.Top,
      ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, {
      frame = React.createElement("Frame", {
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.8,
        Size = UDim2.fromScale(1, 1),
      }),
    
      textFrame = React.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(105, 147, 255),
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, -10, 1, -10),
      }, {
        bugs = React.createElement("TextLabel", {
          FontFace = Font.new(
            "rbxasset://fonts/families/FredokaOne.json",
            Enum.FontWeight.Bold,
            Enum.FontStyle.Normal
          ),
          Text = "Bugs: 1,000,400",
          TextColor3 = Color3.fromRGB(0, 0, 0),
          TextSize = 25,
          AnchorPoint = Vector2.new(0.5, 0),
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 1,
          BorderSizePixel = 0,
          LayoutOrder = 1,
          Position = UDim2.fromScale(0.5, 0),
          Size = UDim2.new(1, 0, 0, 30),
        }),
    
        level = React.createElement("TextLabel", {
          FontFace = Font.new(
            "rbxasset://fonts/families/FredokaOne.json",
            Enum.FontWeight.Bold,
            Enum.FontStyle.Normal
          ),
          Text = "Level: 17",
          TextColor3 = Color3.fromRGB(0, 0, 0),
          TextSize = 25,
          AnchorPoint = Vector2.new(0.5, 0),
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 1,
          BorderSizePixel = 0,
          Position = UDim2.fromScale(0.5, 0),
          Size = UDim2.new(1, 0, 0, 30),
        }),
    
        uIListLayout = React.createElement("UIListLayout", {
          SortOrder = Enum.SortOrder.LayoutOrder,
          VerticalAlignment = Enum.VerticalAlignment.Center,
        }),
      }),
    })

    local uiRoot = ReactRoblox.createRoot(model.UI.UIRoot):render(uiChildren)
end

return Cubicle