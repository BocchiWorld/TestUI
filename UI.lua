local UILib = {}

-- Create a new UI window
function UILib:CreateWindow(title, size)
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")

    -- Check if executor supports `gethui()` (places UI in the hidden GUI container)
    if gethui then
        ScreenGui.Parent = gethui()
    else
        ScreenGui.Parent = game:GetService("CoreGui") -- Some executors may not support this
    end

    -- Style the window
    ScreenGui.Name = "CustomUI"
    Frame.Parent = ScreenGui
    Frame.Size = UDim2.new(0, size.X, 0, size.Y)
    Frame.Position = UDim2.new(0.5, -size.X/2, 0.5, -size.Y/2)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.BorderSizePixel = 2
    Frame.Draggable = true
    Frame.Active = true

    -- Title bar
    Title.Parent = Frame
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 20

    return Frame -- Return the main frame for adding buttons and labels
end

-- Create a button
function UILib:CreateButton(parent, text, position, callback)
    local Button = Instance.new("TextButton")

    Button.Parent = parent
    Button.Size = UDim2.new(0, 100, 0, 30)
    Button.Position = position
    Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.SourceSans
    Button.TextSize = 18

    -- Connect function
    Button.MouseButton1Click:Connect(function()
        pcall(callback) -- Run function safely
    end)

    return Button
end

-- Create a label
function UILib:CreateLabel(parent, text, position)
    local Label = Instance.new("TextLabel")

    Label.Parent = parent
    Label.Size = UDim2.new(0, 150, 0, 30)
    Label.Position = position
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 18

    return Label
end

return UILib
