--// BLOX FRUITS AUTO FRUIT (ANTI LAG + TET GUI)

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local PlaceID = game.PlaceId

-------------------------------------------------
-- GUI (NHẸ + ÍT INSTANCE)
-------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "TetFruitLite"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

-- Avatar ảnh Tết (mở/tắt menu)
local avatar = Instance.new("ImageButton")
avatar.Parent = gui
avatar.Size = UDim2.fromOffset(55,55)
avatar.Position = UDim2.new(0.03,0,0.45,0)
avatar.BackgroundTransparency = 1
avatar.Image = "rbxassetid://12111668767" -- đổi id nếu muốn

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.fromOffset(200,110)
frame.Position = UDim2.new(0.1,0,0.43,0)
frame.BackgroundColor3 = Color3.fromRGB(28,28,28)
frame.Active = true
frame.Draggable = true

Instance.new("UICorner",frame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "🌸 Fruit Farm 🌸"
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255,210,0)

local farmBtn = Instance.new("TextButton", frame)
farmBtn.Size = UDim2.new(0.9,0,0,45)
farmBtn.Position = UDim2.new(0.05,0,0.45,0)
farmBtn.Text = "Auto Farm : OFF"
farmBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
farmBtn.TextColor3 = Color3.new(1,1,1)
farmBtn.TextScaled = true
Instance.new("UICorner",farmBtn)

-------------------------------------------------
-- TOGGLE MENU
-------------------------------------------------
avatar.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
end)

-------------------------------------------------
-- FUNCTIONS (TỐI ƯU)
-------------------------------------------------
local farming = false
local hrp

local function getHRP()
	local char = player.Character or player.CharacterAdded:Wait()
	hrp = char:WaitForChild("HumanoidRootPart")
	return hrp
end

player.CharacterAdded:Connect(function()
	task.wait(1)
	getHRP()
end)

getHRP()

-- tìm fruit (scan nhẹ hơn)
local function findFruit()
	for _,v in ipairs(workspace:GetChildren()) do
		if v:IsA("Tool") and v:FindFirstChild("Handle") then
			if string.find(v.Name:lower(),"fruit") then
				return v
			end
		end
	end
end

-------------------------------------------------
-- SERVER HOP (NHẸ + NHANH)
-------------------------------------------------
local function serverHop()
	local data = HttpService:JSONDecode(
		game:HttpGet("https://games.roblox.com/v1/games/"..PlaceID.."/servers/Public?limit=100")
	)

	for _,s in ipairs(data.data) do
		if s.playing < s.maxPlayers then
			TeleportService:TeleportToPlaceInstance(PlaceID, s.id, player)
			break
		end
	end
end

-------------------------------------------------
-- BUTTON
-------------------------------------------------
farmBtn.MouseButton1Click:Connect(function()
	farming = not farming
	farmBtn.Text = farming and "Auto Farm : ON" or "Auto Farm : OFF"
end)

-------------------------------------------------
-- MAIN LOOP (ANTI LAG)
-------------------------------------------------
task.spawn(function()
	while true do
		if farming then
			local fruit = findFruit()

			if fruit then
				hrp.CFrame = fruit.Handle.CFrame + Vector3.new(0,3,0)

				firetouchinterest(hrp, fruit.Handle, 0)
				firetouchinterest(hrp, fruit.Handle, 1)

				task.wait(1.5) -- đợi nhặt xong (giảm lag)

			else
				task.wait(2)
				serverHop()
			end
		end

		task.wait(2) -- quét chậm để nhẹ máy
	end
end)
