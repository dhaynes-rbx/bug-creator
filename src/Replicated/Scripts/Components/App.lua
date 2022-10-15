local Packages = game:GetService("ReplicatedStorage").Packages
local React = require(Packages.React)

local Components = script.Parent
local PlayerUI = require(Components.PlayerUI)

local App = React.Component:extend()

function App:init()

end

function App:render()
    return (React.createElement(PlayerUI))
end

return App
