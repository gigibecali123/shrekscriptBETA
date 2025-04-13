local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
 
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")
 
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 350)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BackgroundTransparency = 0.5
frame.Parent = screenGui
 
local backgroundImage = Instance.new("ImageLabel")
backgroundImage.Size = UDim2.new(1, 0, 1, 0)
backgroundImage.BackgroundTransparency = 1
backgroundImage.Image = "rbxassetid://5834104798"
backgroundImage.Parent = frame

-- Drag GUI
local dragging = false
local dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    frame:Destroy()
end)

-- Beta Label
local betaLabel = Instance.new("TextLabel")
betaLabel.Size = UDim2.new(0, 100, 0, 40)
betaLabel.Position = UDim2.new(0, 5, 0, 5)
betaLabel.Text = "Beta"
betaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
betaLabel.BackgroundTransparency = 1
betaLabel.TextSize = 20
betaLabel.Parent = frame

-- Credite
local creditText = Instance.new("TextLabel")
creditText.Size = UDim2.new(0, 350, 0, 40)
creditText.Position = UDim2.new(0, 25, 0, 120)
creditText.Text = ""
creditText.TextColor3 = Color3.fromRGB(255, 255, 255)
creditText.BackgroundTransparency = 1
creditText.TextSize = 20
creditText.Parent = frame

local creditsOpen = false
local creditsButton = Instance.new("TextButton")
creditsButton.Size = UDim2.new(0, 100, 0, 40)
creditsButton.Position = UDim2.new(0, 25, 0, 140)
creditsButton.Text = "Credite"
creditsButton.BackgroundColor3 = Color3.fromRGB(169, 169, 169)
creditsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
creditsButton.Parent = frame

creditsButton.MouseButton1Click:Connect(function()
    if creditsOpen then
        creditText.Text = ""
        creditsOpen = false
    else
        creditText.Text = "Credite: Alin Pericol"
        creditsOpen = true
    end
end)

-- HopWall Button
local hopWallButton = Instance.new("TextButton")
hopWallButton.Size = UDim2.new(0, 100, 0, 40)
hopWallButton.Position = UDim2.new(0, 25, 0, 190)
hopWallButton.Text = "HopWall"
hopWallButton.BackgroundColor3 = Color3.fromRGB(169, 169, 169)
hopWallButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hopWallButton.Parent = frame

-- Flick Camera
local function flickCamera90Degrees()
    local currentCam = workspace.CurrentCamera
    local initialPos = currentCam.CFrame.Position
    local initialRot = currentCam.CFrame - initialPos
    currentCam.CFrame = CFrame.new(initialPos) * CFrame.Angles(0, math.rad(90), 0) * initialRot
end

local function flickCameraBack90Degrees()
    local currentCam = workspace.CurrentCamera
    local initialPos = currentCam.CFrame.Position
    local initialRot = currentCam.CFrame - initialPos
    currentCam.CFrame = CFrame.new(initialPos) * CFrame.Angles(0, math.rad(-90), 0) * initialRot
end

local function flickCameraSequence()
    flickCamera90Degrees()
    wait(0.03)
    flickCameraBack90Degrees()
end

-- HopWall logic: o singura activare
local hopWallEnabled = false

hopWallButton.MouseButton1Click:Connect(function()
    if not hopWallEnabled then
        hopWallEnabled = true
        print("HopWall activat. Apasă Q pentru flick.")
    end
end)

UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Q and hopWallEnabled then
        flickCameraSequence()
    end
end)

-- Noclip
local noclipButton = Instance.new("TextButton")
noclipButton.Size = UDim2.new(0, 100, 0, 40)
noclipButton.Position = UDim2.new(0, 25, 0, 240)
noclipButton.Text = "Noclip"
noclipButton.BackgroundColor3 = Color3.fromRGB(169, 169, 169)
noclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipButton.Parent = frame

local noclipEnabled = false

local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    if noclipEnabled then
        humanoid.PlatformStand = true
        player.Character.HumanoidRootPart.CanCollide = false
        noclipButton.Text = "Dezactivează Noclip"
    else
        humanoid.PlatformStand = false
        player.Character.HumanoidRootPart.CanCollide = true
        noclipButton.Text = "Activează Noclip"
    end
end

noclipButton.MouseButton1Click:Connect(toggleNoclip)

-- Fly
local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0, 150, 0, 50)
flyButton.Position = UDim2.new(0, 150, 0, 200)
flyButton.Text = "Activează Zborul"
flyButton.BackgroundColor3 = Color3.fromRGB(169, 169, 169)
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.Parent = frame

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0, 100, 0, 40)
speedBox.Position = UDim2.new(0, 150, 0, 250)
speedBox.PlaceholderText = "Viteză Fly"
speedBox.Text = "50"
speedBox.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.Parent = frame

local flying = false
local flySpeed = 50
local keys = {w = false, a = false, s = false, d = false}

local function toggleFly()
    local val = tonumber(speedBox.Text)
    if val then flySpeed = val end

    flying = not flying
    if flying then
        flyButton.Text = "Zbor ON"
        local Core = Instance.new("Part")
        Core.Name = "Core"
        Core.Size = Vector3.new(0.05, 0.05, 0.05)
        Core.Anchored = false
        Core.Transparency = 1
        Core.CanCollide = false
        Core.Parent = workspace

        local Weld = Instance.new("Weld", Core)
        Weld.Part0 = Core
        Weld.Part1 = player.Character:WaitForChild("LowerTorso")
        Weld.C0 = CFrame.new(0, 0, 0)

        local pos = Instance.new("BodyPosition", Core)
        local gyro = Instance.new("BodyGyro", Core)
        pos.Name = "EPIXPOS"
        pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
        pos.position = Core.Position
        gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        gyro.cframe = Core.CFrame

        local mouse = player:GetMouse()
        mouse.KeyDown:Connect(function(key) keys[key:lower()] = true end)
        mouse.KeyUp:Connect(function(key) keys[key:lower()] = false end)

        spawn(function()
            while flying and Core.Parent do
                wait()
                player.Character.Humanoid.PlatformStand = true
                local move = Vector3.new()
                if keys.w then move += workspace.CurrentCamera.CFrame.LookVector end
                if keys.s then move -= workspace.CurrentCamera.CFrame.LookVector end
                if keys.a then move -= workspace.CurrentCamera.CFrame.RightVector end
                if keys.d then move += workspace.CurrentCamera.CFrame.RightVector end

                if move.Magnitude > 0 then
                    pos.Position = Core.Position + move.Unit * flySpeed
                else
                    pos.Position = Core.Position
                end
                gyro.CFrame = workspace.CurrentCamera.CFrame
            end

            player.Character.Humanoid.PlatformStand = false
            if Core then Core:Destroy() end
            flyButton.Text = "Activează Zborul"
        end)
    else
        if workspace:FindFirstChild("Core") then
            workspace.Core:Destroy()
        end
        player.Character.Humanoid.PlatformStand = false
        flyButton.Text = "Activează Zborul"
    end
end

flyButton.MouseButton1Click:Connect(toggleFly)

-- Settings gear button
local gearButton = Instance.new("TextButton")
gearButton.Size = UDim2.new(0, 50, 0, 50)
gearButton.Position = UDim2.new(0, 170, 0, 300)
gearButton.Text = "⚙️"
gearButton.BackgroundColor3 = Color3.fromRGB(169, 169, 169)
gearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
gearButton.Parent = frame

local settingsFrame = Instance.new("Frame")
settingsFrame.Size = UDim2.new(0, 300, 0, 200)
settingsFrame.Position = UDim2.new(0, 50, 0, 50)
settingsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
settingsFrame.Visible = false
settingsFrame.Parent = screenGui

local speedText = Instance.new("TextLabel")
speedText.Size = UDim2.new(0, 200, 0, 40)
speedText.Position = UDim2.new(0, 50, 0, 50)
speedText.Text = "Viteza Generala"
speedText.TextColor3 = Color3.fromRGB(255, 255, 255)
speedText.BackgroundTransparency = 1
speedText.TextSize = 20
speedText.Parent = settingsFrame

local cursorText = Instance.new("TextLabel")
cursorText.Size = UDim2.new(0, 200, 0, 40)
cursorText.Position = UDim2.new(0, 50, 0, 100)
cursorText.Text = "Setari Cursor"
cursorText.TextColor3 = Color3.fromRGB(255, 255, 255)
cursorText.BackgroundTransparency = 1
cursorText.TextSize = 20
cursorText.Parent = settingsFrame

local speedSlider = Instance.new("TextBox")
speedSlider.Size = UDim2.new(0, 200, 0, 40)
speedSlider.Position = UDim2.new(0, 50, 0, 150)
speedSlider.Text = "50"
speedSlider.PlaceholderText = "Viteza Fly"
speedSlider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
speedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
speedSlider.Parent = settingsFrame

gearButton.MouseButton1Click:Connect(function()
    settingsFrame.Visible = not settingsFrame.Visible
end)

speedSlider.FocusLost:Connect(function()
    local newSpeed = tonumber(speedSlider.Text)
    if newSpeed then
        flySpeed = newSpeed
    end
end)
