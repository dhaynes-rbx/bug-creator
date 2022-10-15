local Packages = game:GetService("ReplicatedStorage").Packages
local React = require(Packages.React)

return function(props)
    return(
        React.createElement("ScreenGui", {
           ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
         }, {
           textButton = React.createElement("TextButton", {
             FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
             TextColor3 = Color3.fromRGB(0, 0, 0),
             TextSize = 14,
             BackgroundColor3 = Color3.fromRGB(255, 255, 255),
             Position = UDim2.fromScale(0.411, 0.89),
             Size = UDim2.fromOffset(200, 50),
           }),
         
           textLabel = React.createElement("TextLabel", {
             FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
             TextColor3 = Color3.fromRGB(0, 0, 0),
             TextSize = 14,
             BackgroundColor3 = Color3.fromRGB(255, 255, 255),
             BackgroundTransparency = 1,
             Position = UDim2.fromScale(0.411, 0.827),
             Size = UDim2.fromOffset(200, 50),
           }),
        })
    )
end