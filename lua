-- Steal a Brainrot | Stylish GUI by find my
-- Aimbot + TP Bat + Anti Reset + Instant Reset

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

-- ==================== SETTINGS ====================
local Settings = {
    Aimbot = false,
    AimbotFOV = 180,
    AimbotSmooth = 0.18,
    TPBat = false,
    AntiReset = true,
    InstantReset = false,
    Noclip = false,
    InfJump = false,
    Speed = 50,
    ESP = false,
    AutoSteal = false,
    InstantPrompt = true,
}

-- ==================== STYLISH GUI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FindMyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- Главный фрейм
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 320, 0, 480)
Main.Position = UDim2.new(0.5, -160, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = Main

-- Неоновая обводка
local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0, 255, 170)
Stroke.Thickness = 1.8
Stroke.Transparency = 0.3
Stroke.Parent = Main

-- Градиент сверху
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 170)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 120, 255))
}
Gradient.Rotation = 45
Gradient.Parent = Stroke

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 52)
TitleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 16)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 18, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "FIND MY  •  STEAL A BRAINROT"
Title.TextColor3 = Color3.fromRGB(0, 255, 170)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Кнопка закрытия
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 32, 0, 32)
Close.Position = UDim2.new(1, -42, 0, 10)
Close.BackgroundColor3 = Color3.fromRGB(255, 60, 80)
Close.Text = "✕"
Close.TextColor3 = Color3.new(1,1,1)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 14
Close.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = Close

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Функция создания стильных переключателей
local yOffset = 68
local function CreateToggle(text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -28, 0, 38)
    frame.Position = UDim2.new(0, 14, 0, yOffset)
    frame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    frame.Parent = Main

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.72, 0, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(230, 230, 240)
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 54, 0, 26)
    btn.Position = UDim2.new(1, -66, 0.5, -13)
    btn.BackgroundColor3 = default and Color3.fromRGB(0, 220, 140) or Color3.fromRGB(50, 50, 60)
    btn.Text = default and "ON" or "OFF"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.Parent = frame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 7)
    btnCorner.Parent = btn

    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and "ON" or "OFF"
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = state and Color3.fromRGB(0, 220, 140) or Color3.fromRGB(50, 50, 60)
        }):Play()
        callback(state)
    end)

    yOffset = yOffset + 44
    return btn
end

-- Создание кнопок
CreateToggle("Aimbot (Bat)", false, function(v) Settings.Aimbot = v end)
CreateToggle("TP Bat (к игроку)", false, function(v) Settings.TPBat = v end)
CreateToggle("Anti Reset", true, function(v) Settings.AntiReset = v end)
CreateToggle("Instant Reset", false, function(v) Settings.InstantReset = v end)
CreateToggle("Auto Steal", false, function(v) Settings.AutoSteal = v end)
CreateToggle("Instant Prompt", true, function(v) Settings.InstantPrompt = v end)
CreateToggle("Noclip", false, function(v) Settings.Noclip = v end)
CreateToggle("Infinite Jump", false, function(v) Settings.InfJump = v end)

-- Кнопка Instant Reset
local ResetBtn = Instance.new("TextButton")
ResetBtn.Size = UDim2.new(1, -28, 0, 38)
ResetBtn.Position = UDim2.new(0, 14, 0, yOffset + 8)
ResetBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 80)
ResetBtn.Text = "⚡ INSTANT RESET"
ResetBtn.TextColor3 = Color3.new(1,1,1)
ResetBtn.Font = Enum.Font.GothamBold
ResetBtn.TextSize = 14
ResetBtn.Parent = Main

local ResetCorner = Instance.new("UICorner")
ResetCorner.CornerRadius = UDim.new(0, 10)
ResetCorner.Parent = ResetBtn

ResetBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = 0
    end
end)

-- ==================== НАДПИСЬ НАД ГОЛОВОЙ ====================
local function CreateNameTag()
    local char = player.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    -- Удаляем старый
    if head:FindFirstChild("FindMyTag") then
        head.FindMyTag:Destroy()
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "FindMyTag"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2.8, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "by find my"
    label.TextColor3 = Color3.fromRGB(0, 255, 170)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.TextStrokeTransparency = 0.4
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.Parent = billboard

    -- Лёгкое свечение
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 255, 170)
    stroke.Thickness = 1.2
    stroke.Transparency = 0.6
    stroke.Parent = label
end

-- ==================== ФУНКЦИИ ====================

-- Aimbot (для биты / slap)
local function GetClosestPlayer()
    local closest = nil
    local shortest = Settings.AimbotFOV
    local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
            local targetRoot = plr.Character.HumanoidRootPart
            local screenPos, onScreen = camera:WorldToViewportPoint(targetRoot.Position)
            if onScreen then
                local dist = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = targetRoot
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if Settings.Aimbot then
        local target = GetClosestPlayer()
        if target then
            local lookAt = CFrame.lookAt(camera.CFrame.Position, target.Position)
            camera.CFrame = camera.CFrame:Lerp(lookAt, Settings.AimbotSmooth)
        end
    end
end)

-- TP Bat (телепорт к ближайшему игроку + экипировка биты)
task.spawn(function()
    while task.wait(0.4) do
        if Settings.TPBat and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local closest = nil
            local shortest = 999
            local myRoot = player.Character.HumanoidRootPart

            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (plr.Character.HumanoidRootPart.Position - myRoot.Position).Magnitude
                    if dist < shortest and dist > 5 then
                        shortest = dist
                        closest = plr.Character.HumanoidRootPart
                    end
                end
            end

            if closest then
                myRoot.CFrame = closest.CFrame * CFrame.new(0, 0, 3)
                -- Пробуем экипировать биту
                local bat = player.Backpack:FindFirstChild("Tung Bat") or player.Character:FindFirstChild("Tung Bat")
                    or player.Backpack:FindFirstChild("Bat") or player.Character:FindFirstChild("Bat")
                if bat and bat:IsA("Tool") then
                    bat.Parent = player.Character
                end
            end
        end
    end
end)

-- Anti Reset
player.CharacterAdded:Connect(function(char)
    task.wait(0.3)
    CreateNameTag()

    local hum = char:WaitForChild("Humanoid")
    if Settings.AntiReset then
        hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        hum.BreakJointsOnDeath = false
    end
end)

-- Instant Reset loop
RunService.Heartbeat:Connect(function()
    if Settings.InstantReset and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = 0
    end
end)

-- Noclip
RunService.Stepped:Connect(function()
    if Settings.Noclip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if Settings.InfJump and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Auto Steal + Instant Prompt
task.spawn(function()
    while task.wait(0.3) do
        if Settings.InstantPrompt then
            for _, prompt in pairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    prompt.HoldDuration = 0
                    prompt.RequiresLineOfSight = false
                end
            end
        end

        if Settings.AutoSteal and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local root = player.Character.HumanoidRootPart
            for _, prompt in pairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then
                    local text = (prompt.ActionText or ""):lower()
                    if text:find("steal") or text:find("collect") then
                        local part = prompt.Parent
                        if part and part:IsA("BasePart") and (part.Position - root.Position).Magnitude < 16 then
                            pcall(function()
                                if fireproximityprompt then
                                    fireproximityprompt(prompt)
                                else
                                    prompt:InputHoldBegin()
                                    task.wait(0.03)
                                    prompt:InputHoldEnd()
                                end
                            end)
                        end
                    end
                end
            end
        end
    end
end)

-- Anti AFK
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Создаём надпись сразу
if player.Character then
    CreateNameTag()
end

print("✅ Find My Hub загружен | by find my")
