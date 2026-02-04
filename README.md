repeat wait() until game:IsLoaded()

-- AUTO FARM FULL 1 -> MAX
getgenv().Config = {
    AutoFarm = true,
    AutoHaki = true,
    FastAttack = true,
    UseSkillZ = true,
    UseSkillX = true,
    UseSkillC = true,
    UseSkillV = false
}

local plr = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- FAST ATTACK
spawn(function()
    while Config.FastAttack do
        pcall(function()
            for i,v in pairs(getupvalues(require(plr.PlayerScripts.CombatFramework))) do
                v.activeController.timeToNextAttack = 0
            end
        end)
        task.wait()
    end
end)

-- AUTO HAKI
spawn(function()
    while Config.AutoHaki do
        game:GetService("VirtualInputManager"):SendKeyEvent(true,"J",false,game)
        wait(1)
    end
end)

-- TELEPORT
function topos(cf)
    local hrp = plr.Character.HumanoidRootPart
    TweenService:Create(hrp, TweenInfo.new((hrp.Position - cf.Position).Magnitude/300, Enum.EasingStyle.Linear), {CFrame = cf}):Play()
end

-- ATTACK FUNCTION
function attack()
    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,true,game,0)
end

-- AUTO FARM LOOP
spawn(function()
    while Config.AutoFarm do
        pcall(function()

            for _,v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    repeat
                        topos(v.HumanoidRootPart.CFrame * CFrame.new(0,0,5))
                        attack()

                        if Config.UseSkillZ then game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game) end
                        if Config.UseSkillX then game:GetService("VirtualInputManager"):SendKeyEvent(true,"X",false,game) end
                        if Config.UseSkillC then game:GetService("VirtualInputManager"):SendKeyEvent(true,"C",false,game) end
                        if Config.UseSkillV then game:GetService("VirtualInputManager"):SendKeyEvent(true,"V",false,game) end

                        wait()
                    until v.Humanoid.Health <= 0 or not Config.AutoFarm
                end
            end

        end)
        wait()
    end
end)
