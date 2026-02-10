-- Script Blox Fruit Tết - Farm Level & Auto Quest
local plr = game.Players.LocalPlayer
local char = plr.Character

-- UI Tết
local screenGui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0.3, 0, 0.3, 0)
frame.Position = UDim2.new(0.35, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(255, 153, 0)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 0, 0)

-- Text Tết
local text = Instance.new("TextLabel", frame)
text.Text = "Sangdz Farm Tết 🎉"
text.Size = UDim2.new(1, 0, 0.3, 0)
text.TextScaled = true
text.BackgroundTransparency = 1

-- Nút Farm Level
local btn1 = Instance.new("TextButton", frame)
btn1.Size = UDim2.new(1, 0, 0.3, 0)
btn1.Position = UDim2.new(0, 0, 0.4, 0)
btn1.Text = "Farm Level"
btn1.TextScaled = true
btn1.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

-- Nút Auto Quest
local btn2 = Instance.new("TextButton", frame)
btn2.Size = UDim2.new(1, 0, 0.3, 0)
btn2.Position = UDim2.new(0, 0, 0.7, 0)
btn2.Text = "Auto Quest"
btn2.TextScaled = true
btn2.BackgroundColor3 = Color3.fromRGB(0, 0, 255)

-- Chức năng
btn1.MouseButton1Click:Connect(function()
    while true do
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Level")
        wait(0.1)
    end
end)

btn2.MouseButton1Click:Connect(function()
    while true do
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Quest")
        wait(1)
    end
end)
