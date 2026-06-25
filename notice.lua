print("NOTICE LOADED")

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local function Notify(Theme, Title, Text, Duration)

    print("NOTIFY CALLED")

    Duration = Duration or 5

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CUCUMBER_NOTIFY"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = gethui()

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 280, 0, 80)
    Main.Position = UDim2.new(0, 100, 0, 100)
    Main.BackgroundColor3 = Theme.Background
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui

    local Corner = Instance.new("UICorner", Main)

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(0, 6, 1, 0)
    Bar.BackgroundColor3 = Theme.SchemeColor
    Bar.BorderSizePixel = 0
    Bar.Parent = Main

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -20, 0, 25)
    TitleLabel.Position = UDim2.new(0, 15, 0, 5)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = Title
    TitleLabel.TextColor3 = Theme.TextColor
    TitleLabel.Parent = Main

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, -20, 0, 40)
    TextLabel.Position = UDim2.new(0, 15, 0, 28)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = Text
    TextLabel.TextColor3 = Theme.TextColor
    TextLabel.Parent = Main

    TweenService:Create(
        Main,
        TweenInfo.new(0.3),
        {Position = UDim2.new(0, 100, 0, 100)}
    ):Play()

    task.delay(Duration, function()
        Main:Destroy()
        ScreenGui:Destroy()
    end)
end

return Notify
