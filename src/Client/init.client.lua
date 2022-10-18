local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local React = require(Packages.React)
local ReactRoblox = require(Packages.ReactRoblox)

local Components = ReplicatedStorage.Scripts.Components
local App = require(Components.App)

local container = Instance.new("Folder")
container.Name = "GameUI"
container.Parent = LocalPlayer.PlayerGui

local root = ReactRoblox.createRoot(container)
root:render(React.createElement(App))