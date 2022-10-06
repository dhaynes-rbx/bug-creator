--[[
    How to setup:
        Scenes (Terrain + Static scenery objects)
            Add place(s) to `src/Places/Scenes/*.rbxlx` (Note: the name of the rbxlx will be used to load the scene at runtime)
                Setup the terrain
                Add scenery objects to the workspace under `Scene`
        Assets (Dynamically managed)
            Add place(s) to `src/Places/Assets/`
                Add assets to the workspace under `Assets`

    How to run:
        1. Open a terminal at the root of the project
        2. In the terminal run: `foreman install`
        3. In the same terminal run: `remodel run tools/ImportAssets.lua`
]]

local SCENE_SOURCE_PATH = "src/Places/Scenes"
local SCENE_SOURCE_CONTAINER = "Scene"
local SCENE_DESTINATION_PATH = "remote-assets/Models/Scenes"
local ASSETS_SOURCE_PATH = "src/Places/Assets"
local ASSETS_SOURCE_CONTAINER = "Assets"
local ASSETS_DESTINATION_PATH = "remote-assets/Models/Assets"
local PLACE_EXTENSION = ".rbxlx"
local PLACE_EXTENSION_LENGTH = string.len(PLACE_EXTENSION)

local DEBUG_LOCAL_ANIMATIONS = false

assert(remodel.isDir(SCENE_SOURCE_PATH), "Missing scene source folder `" .. SCENE_SOURCE_PATH .. "`")
assert(remodel.isDir(ASSETS_SOURCE_PATH), "Missing asset source folder `" .. ASSETS_SOURCE_PATH .. "`")

-- Cleanup scenes(DO IT FROM SHELL)

local function importChildAssets(root, destination, _)
    if root == nil then
        return
    end
    local nameUsageCounters = {}
    for _, child in ipairs(root:GetChildren()) do
        if child.ClassName == "Folder" then
            print("Processing children of " .. child.Name)
            local childPath = destination .. "/" .. child.Name
            local success, result = pcall(function()
                return remodel.isDir(childPath)
            end)
            if success == false or result == false then
                remodel.createDirAll(childPath)
            end
            importChildAssets(child, childPath)
        else
            local childName = child.Name
            if nameUsageCounters[childName] ~= nil then
                print("****** Name collision with " .. childName .. ". If this needs to be unique you should revise.")
                nameUsageCounters[childName] = nameUsageCounters[childName] + 1
                childName = childName .. "-" .. nameUsageCounters[childName]
            else
                nameUsageCounters[childName] = 1
            end

            -- Remove package links from the root or loading will fail.
            local packageLink = child:FindFirstChild("PackageLink")
            if packageLink then
                packageLink.Parent = nil
            end

            local filePath = destination .. "/" .. childName .. ".rbxmx"
            print("Writing " .. filePath)
            remodel.writeModelFile(child, filePath)
        end
    end
end

local function importScene(scene, destination, placeName)
    -- Remove all animations
    for _, descendant in ipairs(scene:GetDescendants()) do
        if descendant.Name == "AnimSaves" then
            descendant.Parent = nil
        end
    end
    local success, result = pcall(function()
        return remodel.isDir(destination)
    end)
    if success == false or result == false then
        remodel.createDirAll(destination)
    end
    destination = destination .. "/" .. placeName .. ".rbxmx"
    print("Writing " .. destination)
    remodel.writeModelFile(scene, destination)
end

local function importAll(sourcePath, sourceContainer, destinationPath, importFunction)
    for _, placeFilename in ipairs(remodel.readDir(sourcePath)) do
        local placeFilenameLength = string.len(placeFilename)
        if string.find(placeFilename, ".rbxlx", placeFilenameLength - PLACE_EXTENSION_LENGTH) then
            local placeName = string.sub(placeFilename, 1, placeFilenameLength - PLACE_EXTENSION_LENGTH)
            local placePath = sourcePath .. "/" .. placeFilename

            local place = remodel.readPlaceFile(placePath)
            local scene = place.Workspace:FindFirstChild(sourceContainer)
            if scene == nil then
                print("Missing `Scene` Folder in `Workspace`")
            else
                importFunction(scene, destinationPath, placeName)
            end
        end
    end
end

-- Load scenes
-- importAll(SCENE_SOURCE_PATH, SCENE_SOURCE_CONTAINER, SCENE_DESTINATION_PATH, importScene)

-- Load Assets
importAll(ASSETS_SOURCE_PATH, ASSETS_SOURCE_CONTAINER, ASSETS_DESTINATION_PATH, importChildAssets)
