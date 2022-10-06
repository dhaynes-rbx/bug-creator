--!strict
local Trivia = require(game.ReplicatedStorage.Scripts.Types.Trivia)
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local React = require(game.ReplicatedStorage.Packages.React);
local Promise = require(game.ReplicatedStorage.Scripts.Packages.Promise)

local Components = game.ReplicatedStorage.Scripts.Components;

export type Props = {
    id: number,
    PlayerId: number,
}

function Cubicle(props: Props)
    print("Cubicle")
end

return function(props: Props)
    return React.createElement(Cubicle, props)
end