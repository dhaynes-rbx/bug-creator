local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Dash = require(ReplicatedStorage.Packages.Dash)

local BugEmitter = Dash.class(
    "BugEmitter",
    function(emitter:ParticleEmitter, event:RemoteEvent)

        emitter.Enabled = false
        
        return {
            emitter = emitter :: ParticleEmitter,
            connection = nil :: RBXScriptConnection,
            emittedRecently = 0 :: number,
            event = event,
        }
    end
)
function BugEmitter:start()
    if self.connection then return end
    self.emitter.Enabled = true

    local timer = 0
    local rate = 1
    self.connection = RunService.PreRender:Connect(function(delta)
        timer += delta
        if timer > rate then
            timer -= rate
            self:emit(1)
            self.event:FireServer(self.emittedRecently)
            self.emittedRecently = 0
        end
    end)
end
function BugEmitter:stop()
    if self.connection then
        self.connection:Disconnect()
        self.connection = nil
    end
end
function BugEmitter:emit(amount)
    self.emittedRecently += amount
    self.emitter:Emit(amount)
    
end
function BugEmitter:updateRate(amount)
    self.emitter.Rate = amount
end

return BugEmitter