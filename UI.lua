-- UI Library: Executor-Compatible Version
local plr = game:GetService('Players').LocalPlayer
local runS = game:GetService('RunService')
local uis = game:GetService("UserInputService")

local UILib = {}

-- Ensure no duplicate UIs exist
for i,v in next,game:GetService("CoreGui"):GetChildren() do
    if v.Name == "ScriptedUI" then
        v:Destroy()
    end
end

local baseui = Instance.new("ScreenGui")
if not runS:IsStudio() then
    if syn then
        syn.protect_gui(baseui)
    end
    baseui.Parent = game:GetService('CoreGui')
else
    baseui.Parent = plr.PlayerGui
end
baseui.Name = "ScriptedUI"
baseui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Function to create a custom Frame
function UILib.CreateFrame(parent, name, position, size, color, cornerRadius)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = UDim2.new(size.X.Scale, size.X.Offset, size.Y.Scale, size.Y.Offset)
    frame.Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset)
    frame.BackgroundColor3 = color or Color3.fromRGB(50, 50, 50)
    frame.Parent = parent
    
    if cornerRadius then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, cornerRadius)
        corner.Parent = frame
    end
    
    return frame
end

-- Function to create a custom Title Label inside a Frame
function UILib.CreateTitle(parent, name, position, size, text, textSize, textColor)
    local title = Instance.new("TextLabel")
    title.Name = name
    title.Size = UDim2.new(size.X.Scale, size.X.Offset, size.Y.Scale, size.Y.Offset)
    title.Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset)
    title.BackgroundTransparency = 1
    title.Text = text
    title.Font = Enum.Font.GothamBold
    title.TextSize = textSize or 24
    title.TextColor3 = textColor or Color3.fromRGB(255, 255, 255)
    title.Parent = parent
    return title
end

-- Function to create a custom Button inside a Frame
function UILib.CreateButton(parent, name, position, size, text, textSize, textColor, backgroundColor, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(size.X.Scale, size.X.Offset, size.Y.Scale, size.Y.Offset)
    button.Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset)
    button.Text = text
    button.Font = Enum.Font.GothamBold
    button.TextSize = textSize or 18
    button.TextColor3 = textColor or Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = backgroundColor or Color3.fromRGB(100, 100, 100)
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.Parent = button
    
    if callback then
        button.MouseButton1Click:Connect(callback)
    end
    
    return button
end

-- Function to create a custom ImageLabel inside a Frame
function UILib.CreateImageLabel(parent, name, position, size, imageId, backgroundTransparency)
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Name = name
    imageLabel.Size = UDim2.new(size.X.Scale, size.X.Offset, size.Y.Scale, size.Y.Offset)
    imageLabel.Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset)
    imageLabel.BackgroundTransparency = backgroundTransparency or 1
    imageLabel.Image = imageId
    imageLabel.Parent = parent
    return imageLabel
end

-- Function to create a custom Scrolling Frame with UI Grid Layout
function UILib.CreateScrollingFrame(parent, name, position, size)
    local scrollingFrame = Instance.new("ScrollingFrame")
    scrollingFrame.Name = name
    scrollingFrame.Size = UDim2.new(size.X.Scale, size.X.Offset, size.Y.Scale, size.Y.Offset)
    scrollingFrame.Position = UDim2.new(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset)
    scrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    scrollingFrame.ScrollBarThickness = 6
    scrollingFrame.Parent = parent
    
    local gridLayout = Instance.new("UIGridLayout")
    gridLayout.Parent = scrollingFrame
    gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    gridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
    gridLayout.CellSize = UDim2.new(0.25, 100, 0.01, 50)
    
    return scrollingFrame
end

-- Toggle UI Visibility
function UILib.ToggleUI()
    baseui.Enabled = not baseui.Enabled
end

uis.InputBegan:Connect(function(key, gp)
    if gp then return end
    if key.KeyCode == Enum.KeyCode.LeftControl then
        UILib.ToggleUI()
    end
end)

return UILib
