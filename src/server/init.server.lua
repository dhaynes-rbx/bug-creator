local ReplicatedStorage = game:GetService("ReplicatedStorage");
local React = require(ReplicatedStorage.Packages.React)

local Cubicle = require(ReplicatedStorage.Components.Cubicle)

local worldRoot = React.createElement("Folder", {}, {
    React.createElement(Cubicle),
})

-- Mount to Workspace:
React.mount(worldRoot, game.Workspace, "WorldRoot")