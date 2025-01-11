-- Check if there's an active sprite
if app.activeSprite == nil then
    app.alert("No active sprite found.")
    return
end

local sprite = app.activeSprite
local spritePath = sprite.filename
local baseOutputDir = spritePath:match("(.*[/\\])") .. "exported_layers/"

-- Function to create a folder path based on layer's group hierarchy
local function getLayerOutputPath(layer, groupHierarchy)
    local pathParts = groupHierarchy or {}
    table.insert(pathParts, layer.name) -- Add the current layer's name
    local folderPath = baseOutputDir .. table.concat(pathParts, "/") .. "/"
    app.fs.makeDirectory(folderPath)
    return folderPath
end

-- Function to export a layer
local function exportLayer(layer, outputDir)
    -- Hide all layers
    for _, otherLayer in ipairs(sprite.layers) do
        otherLayer.isVisible = false
    end

    -- Show the current layer
    layer.isVisible = true

    -- Set the filename for the exported layer
    local filename = outputDir .. layer.name .. ".png"

    -- Export the current visible layer
    app.command.ExportSpriteSheet {
        ui = false,
        askOverwrite = false,
        type = SpriteSheetType.LAYERS,
        columns = 1,
        rows = 1,
        textureFilename = filename,
        textureFilter = "nearest", -- Use nearest filter to retain pixel clarity
        bounds = SpriteSheetBounds.CONTENT,
    }
end

-- Recursive function to handle groups and layers
local function processLayer(layer, groupHierarchy)
    local groupPath = groupHierarchy or {}
    if layer.isGroup then
        -- If the layer is a group, process its children
        table.insert(groupPath, layer.name) -- Add group name to hierarchy
        for _, childLayer in ipairs(layer.layers) do
            processLayer(childLayer, groupPath) -- Recursive call
        end
    else
        -- If the layer is not a group, export it
        local outputDir = getLayerOutputPath(layer, groupPath)
        exportLayer(layer, outputDir)
        app.alert("Exported " .. layer.name .. " to " .. outputDir)
    end
end

-- Iterate through each top-level layer
for _, layer in ipairs(sprite.layers) do
    processLayer(layer, {})
end

app.alert("Exporting layers completed.")
