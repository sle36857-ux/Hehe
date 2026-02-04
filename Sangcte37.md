repeat wait() until game:IsLoaded()

getgenv().Config = {
    AutoFarm = true,
    AutoHaki = true,
    FastAttack = true,
    BringMob = true,
    UseSkill = true
}

local plr = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local VirtualInput = game:GetService("VirtualInputManager")
local Quest = require(game.ReplicatedStorage.Quests)

-------------------------------------------------
-- ANTI AFK
-------------------------------------------------
plr.Idled:Connect(function()
    VirtualInput:SendMouseButtonEvent(0,0,0,true,game,0)
end)

-------------------------------------------------
-- FAST ATTACK x100
-------------------------------------------------
spawn(function()
    while Config.FastAttack do
        pcall(function()
            for i,v in pairs(getupvalues(require(plr.PlayerScripts.CombatFramework))) do
                v.activeController.timeToNextAttack = 0
                v.activeController.hitboxMagnitude = 60
            end
        end)
        task.wait()
    end
end)

-------------------------------------------------
-- HAKI
-------------------------------------------------
spawn(function()
    while Config.AutoHaki do
        VirtualInput:SendKeyEvent(true,"J",false,game)
        wait(1)
    end
end)

-------------------------------------------------
-- TELEPORT
-------------------------------------------------
function topos(cf)
    local hrp = plr.Character.HumanoidRootPart
    TweenService:Create(hrp, TweenInfo.new((hrp.Position-cf.Position).Magnitude/350, Enum.EasingStyle.Linear), {CFrame = cf}):Play()
end

-------------------------------------------------
-- ATTACK
-------------------------------------------------
function attack()
    VirtualInput:SendMouseButtonEvent(0,0,0,true,game,0)
    if Config.UseSkill then
        VirtualInput:SendKeyEvent(true,"Z",false,game)
        VirtualInput:SendKeyEvent(true,"X",false,game)
        VirtualInput:SendKeyEvent(true,"C",false,game)
    end
end

-------------------------------------------------
-- AUTO QUEST
-------------------------------------------------
function StartQuest(name, level)
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", name, level)
end

-------------------------------------------------
-- BRING MOB
-------------------------------------------------
function BringMob(mobName)
    for _,v in pairs(game.Workspace.Enemies:GetChildren()) do
        if v.Name == mobName and v:FindFirstChild("HumanoidRootPart") then
            v.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-5)
            v.Humanoid.WalkSpeed = 0
            v.Humanoid.JumpPower = 0
        end
    end
end

-------------------------------------------------
-- LEVEL TABLE (FULL SEA 1-3)
-------------------------------------------------
LevelData = {
    {1, "BanditQuest1", 1, "Bandit"},
    {10, "JungleQuest", 1, "Monkey"},
    {30, "BuggyQuest1", 1, "Pirate"},
    {60, "DesertQuest", 1, "Desert Bandit"},
    {100, "SnowQuest", 1, "Snow Bandit"},
    {150, "MarineQuest2", 1, "Chief Petty Officer"},
    {250, "SkyQuest", 1, "Sky Bandit"},
    {400, "FishmanQuest", 1, "Fishman Warrior"},
    {700, "Area1Quest", 1, "Raider"},
    {900, "Area2Quest", 1, "Swan Pirate"},
    {1100, "MarineQuest3", 1, "Marine Captain"},
    {1400, "FrostQuest", 1, "Arctic Warrior"},
    {1700, "PiratePortQuest", 1, "Pirate Millionaire"},
    {2000, "HauntedQuest1", 1, "Living Zombie"},
    {2300, "CandyQuest1", 1, "Candy Pirate"},
    {2500, "TikiQuest1", 1, "Tiki Warrior"}
}

-------------------------------------------------
-- MAIN FARM
-------------------------------------------------
spawn(function()
    while Config.AutoFarm do
        pcall(function()

            local level = plr.Data.Level.Value

            for i = #LevelData,1,-1 do
                if level >= LevelData[i][1] then
                    local questName = LevelData[i][2]
                    local questLv = LevelData[i][3]
                    local mob = LevelData[i][4]

                    StartQuest(questName, questLv)

                    repeat
                        if Config.BringMob then
                            BringMob(mob)
                        end

                        for _,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v.Name == mob and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                topos(v.HumanoidRootPart.CFrame * CFrame.new(0,0,5))
                                attack()
                            end
                        end

                        wait()
                    until plr.PlayerGui.Main.Quest.Visible == false or not Config.AutoFarm

                    break
                end
            end

        end)
        wait()
    end
end)          
