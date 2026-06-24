print("NOTICE LOADED")

return function(Theme)

    print("NOTICE INIT")
    
    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")

    local Player = Players.LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CUCUMBER_NOTIFY"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    return function(Title, Text, Duration)
        print("NOTIFY CALLED", Title, Text)
        Duration = Duration or 5

        local Main = Instance.new("Frame")
        Main.Size = UDim2.new(0, 280, 0, 80)
        Main.Position = UDim2.new(1, 300, 1, -100)
        Main.BackgroundColor3 = Theme.Background
        Main.BorderSizePixel = 0
        Main.Parent = ScreenGui

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 8)
        Corner.Parent = Main

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
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.TextSize = 16
        TitleLabel.Parent = Main

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, -20, 0, 40)
        TextLabel.Position = UDim2.new(0, 15, 0, 28)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = Text
        TextLabel.TextWrapped = true
        TextLabel.TextColor3 = Theme.TextColor
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.TextYAlignment = Enum.TextYAlignment.Top
        TextLabel.Font = Enum.Font.Gotham
        TextLabel.TextSize = 14
        TextLabel.Parent = Main

        TweenService:Create(
            Main,
            TweenInfo.new(0.3),
            {Position = UDim2.new(1, -300, 1, -100)}
        ):Play()

        task.delay(Duration, function()
            local Tween = TweenService:Create(
                Main,
                TweenInfo.new(0.3),
                {Position = UDim2.new(1, 300, 1, -100)}
            )

            Tween:Play()
            Tween.Completed:Wait()
            Main:Destroy()
        end)
    end
end
