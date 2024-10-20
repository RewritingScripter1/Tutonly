-- Toggle Gui

local TweenService = game:GetService("TweenService")

local function showNotification(title, message)
    -- Assuming you have a notification function to display messages
    print(title .. ": " .. message)
end

local function createToggleGui()
    local ToggleGui = Instance.new("ScreenGui")
    local Toggle = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")

    ToggleGui.Name = "ToggleGui"
    ToggleGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ToggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ToggleGui.ResetOnSpawn = false

    Toggle.Name = "Toggle"
    Toggle.Parent = ToggleGui
    Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Toggle.Position = UDim2.new(0.5, -25, 1, 50) -- Start off-screen at the bottom center
    Toggle.Size = UDim2.new(0, 50, 0, 50)
    Toggle.Font = Enum.Font.Arcade
    Toggle.Text = "Fraud.lol"
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.TextSize = 8
    Toggle.Draggable = true

    UICorner.CornerRadius = UDim.new(0, 20)
    UICorner.Parent = Toggle

    UIStroke.Parent = Toggle
    UIStroke.Thickness = 3
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Color = Color3.fromRGB(0, 0, 0) -- Start with black

    -- Smooth transition effect for UIStroke color with multiple colors (excluding light pink)
    local function SmoothColorEffect()
        local colors = {
            Color3.fromRGB(0, 0, 0), -- Black
            Color3.fromRGB(125, 125, 125), -- Gray
            Color3.fromRGB(255, 255, 255) -- White
        }
        local transitionSpeed = 0.5-- Time to transition from one color to another

        while ToggleGui and ToggleGui.Parent do
            for i = 1, #colors do
                local startColor = colors[i]
                local endColor = colors[(i % #colors) + 1]
                for t = 0, 1, 0.01 do
                    local interpolatedColor = startColor:Lerp(endColor, t)
                    UIStroke.Color = interpolatedColor
                    wait(transitionSpeed * 0.01) -- Adjust the speed of the transition
                end
            end
        end
    end

    spawn(SmoothColorEffect)

    -- Toggle button functionality to open/close the GUI
    Toggle.MouseButton1Click:Connect(function()
        local VirtualInputManager = game:GetService("VirtualInputManager")
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    end)

    -- Animate the entrance of the Toggle GUI
    local TweenInfoToggleGui = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local TargetPositionToggleGui = UDim2.new(0.5, -25, 0.05, 0) -- Final position at the top center
    local TweenToggleGui = TweenService:Create(Toggle, TweenInfoToggleGui, {Position = TargetPositionToggleGui})
    TweenToggleGui:Play()

    return ToggleGui
end

-- Initialize the toggle GUI
local ToggleGui = createToggleGui()

-- Show an initial notification when the script starts
showNotification("Info", "Type /e hidetoggle to hide the toggle, type /e showtoggle to show the toggle")

-- Function to handle the chat commands
local function onChatMessage(message)
    if message:lower() == "/e hidetoggle" then
        -- Destroy the toggle GUI and show a notification
        if ToggleGui then
            ToggleGui:Destroy()
            ToggleGui = nil
            showNotification("Info", "Hides Toggle")
        end
    elseif message:lower() == "/e showtoggle" then
        -- Recreate the toggle button if it's not already active
        if not ToggleGui then
            ToggleGui = createToggleGui()
            showNotification("Info", "Shows Toggle")
        end
    end
end

-- Connect the chat listener
game.Players.LocalPlayer.Chatted:Connect(onChatMessage)


local introCompleted = false

if game:IsLoaded() then   
    local ShowIntro = true

    local TweenService = game:GetService("TweenService")
    local Blur = Instance.new("BlurEffect", game.Lighting)
    local ScreenGui = Instance.new("ScreenGui")
    local TextLabel = Instance.new("TextLabel")
    local ImageLabel = Instance.new("ImageLabel")

    Blur.Size = 0

    if ShowIntro then
        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        -- Configure TextLabel
        TextLabel.Parent = ScreenGui
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.BorderSizePixel = 0
        TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0) -- Centered on the screen
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        TextLabel.Size = UDim2.new(0, 730, 0, 175)
        TextLabel.Text = "¿Fraud.lol?"
        TextLabel.TextColor3 = Color3.fromRGB(1, 1, 1)
        TextLabel.TextTransparency = 1.000
        TextLabel.TextScaled = true
        TextLabel.Font = Enum.Font.Arcade

        ImageLabel.Parent = ScreenGui
        ImageLabel.BackgroundTransparency = 1.000
        ImageLabel.Size = UDim2.new(0, 375, 0, 375) -- Original size
        ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0) -- Start position
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        ImageLabel.Image = "rbxassetid://11781066658" -- New asset ID
        ImageLabel.ImageTransparency = 1.000 

        local tweenStartBlur = TweenService:Create(Blur, TweenInfo.new(0.70), {Size = 24})
        local tweenStartTextTransparency = TweenService:Create(TextLabel, TweenInfo.new(0.70), {TextTransparency = 0})
        local tweenEndTextTransparency = TweenService:Create(TextLabel, TweenInfo.new(0.80), {TextTransparency = 1})
        local tweenStartImageTransparency = TweenService:Create(ImageLabel, TweenInfo.new(0.70), {ImageTransparency = 0})

        local tweenZoomIn = TweenService:Create(ImageLabel, TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 800, 0, 800), -- End size (larger)
            Position = UDim2.new(0.5, 0, 0.5, 0), -- End position (centered)
            ImageTransparency = 1 -- Fade out
        })

        tweenStartBlur:Play()
        tweenStartTextTransparency:Play()

        tweenStartTextTransparency.Completed:Connect(function()
            task.wait(1) 
            tweenEndTextTransparency:Play()
        end)

        tweenEndTextTransparency.Completed:Connect(function()
            tweenStartImageTransparency:Play()
        end)

        tweenStartImageTransparency.Completed:Connect(function()
            -- Play zoom-in and fade-out animation
            tweenZoomIn:Play()
            tweenZoomIn.Completed:Connect(function()
                Blur:Destroy()
                ScreenGui:Destroy()
                introCompleted = true 
            end)
        end)
    else
        introCompleted = true 
    end

    while not introCompleted do
        task.wait(0.1)
    end
end

local function fadeInGui(gui)
    gui.Enabled = true
    gui.ResetOnSpawn = false
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    gui:SetAttribute("Transparency", 1)

    local tweenService = game:GetService("TweenService")
    local tween = tweenService:Create(gui, TweenInfo.new(0.5), { ["Transparency"] = 0 })

    tween:Play()
end

wait(1)
game.StarterGui:SetCore("SendNotification", {
    Title = "Fraud.lol";
    Text = "Script Is On Beta";
    Icon = "rbxassetid://11781066658";

})

wait(5)
game.StarterGui:SetCore("SendNotification", {
    Title = "Fraud.lol";
    Text = "Script Loaded";
    Icon = "rbxassetid://11781066658";

})

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RewritingScripter1/Files-Of-Script/refs/heads/main/FraudLoLGui.lua"))() --you can go into the github link and copy all of it and modify it for yourself.

local watermark = Library:CreateWatermark("Fraud.lol | v0.1 | {fps} | {game} ")

local Window = Library:CreateWindow("Fraud.lol", Vector2.new(430, 310), --[[ you can change the numbers to make the gui smaller/bigger.]] Enum.KeyCode.E) --you can change your UI keybind
local LockTab = Window:CreateTab("Main") --you can rename this tab to whatever you want --you can also change the tabs code, for example "AimingTab" can be changed to "FunnyCoolTab" etc.
local VisualTab = Window:CreateTab("Visual")
local ConfigTab = Window:CreateTab("Configs")

local testSection = LockTab:CreateSector("Target", "left")  --you can  change the section code, for example "testsection" can be changed to "FunnyCoolSection" etc.

getgenv().FraudLiar = {
    ['Target Part'] = "HumanoidRootPart",
    ['Prediction'] = {
        ['Amount'] = 0.148672,
    },
    ['Offset'] = {
        ['Jump'] = 0.15
    },
    ['Auto Prediction'] = false,
    ['Features'] = {
        ['Look At'] = false,
        ['Auto Air'] = false
    },
}

testSection:AddDropdown(
    "HitPart",
    {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso", "Penis"},
    "HumanoidRootPart",
    false,
    function(Option)
        getgenv().FraudLiar['Target Part'] = Option  
    end
)

testSection:AddTextbox(
    "Prediction",
    0.148672,
    function(State)
        getgenv().FraudLiar['Prediction']['Amount'] = State
    end
)

testSection:AddTextbox(
    "Offset",
    0.15,
    function(State)
        getgenv().FraudLiar['Offset']['Jump'] = State
    end
) 

testSection:AddToggle(
    " Auto Pred",
    false,
    function(first)
        getgenv().FraudLiar['Auto Prediction'] = first
    end
) 

testSection:AddToggle(
    "Look At",
    false, 
    function(first)
       getgenv().FraudLiar['Features']['Look At'] = first
    end
) 

testSection:AddToggle(
    "Auto Air", 
    false, 
    function(first)
        getgenv().FraudLiar['Features']['Auto Air'] = first
    end
) 

local testSection = VisualTab:CreateSector("Misc", "left")

testSection:AddButton("Macro shift", function(IhateGayPeople)
loadstring(game:HttpGet('https://raw.githubusercontent.com/Unknownproootest/Permanent-Shift-Lock-Alt/alt/PermShiftlockAlt'))()
     end) 
testSection:AddButton("Trash talk (q tool)", function(IhateGayPeople)
loadstring(game:HttpGet("https://pastebin.com/raw/Ux74dpcY", true))()
    end)
 testSection:AddButton(" headless and korblox ", function(IhateGayPeople)
loadstring(game:HttpGet("https://pastebin.com/raw/zCJc1WZC"))()
     end) 
testSection:AddButton("Resolver", function(IhateGayPeople)
loadstring(game:HttpGet("https://raw.githubusercontent.com/FeliciaXxxTop/FuckRoblox/main/ResolverV1.lua"))();
     end)
testSection:AddButton("Anti Vf Mods", function(IhateGayPeople)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Jeunaisalive/antimodvf/main/beta-v0"))()
      end)
testSection:AddButton("stretch res", function(IhateGayPeople)
loadstring(game:HttpGet("https://pastefy.app/wZ2S5oxr/raw"))()
     end) 
testSection:AddButton("shaders", function(IhateGayPeople)
loadstring(game:HttpGet(('https://pastefy.app/xXkUxA0P/raw'),true))()
     end)
testSection:AddButton(" sets generator do /console ", function(IhateGayPeople)
loadstring(game:HttpGet("https://raw.githubusercontent.com/meowguy1/Meowguylastsetgen/main/Byebyeguys"))()
     end) 
testSection:AddButton("infinite jumps", function(IhateGayPeople)
loadstring(game:HttpGet("https://pastebin.com/raw/9w4qUCYe", true))()
      end) 
testSection:AddButton("farm stomps (vf only)", function(IhateGayPeople)
loadstring(game:HttpGet("https://raw.githubusercontent.com/plah911/whitelister/main/farmstompslikeamonkey"))();
      end) 
   testSection:AddButton("auto reload", function(IhateGayPeople)
loadstring(game:HttpGet("https://raw.githubusercontent.com/acsun124/pluh-s-properties/main/Protected_3489994584822399.txt"))();
      end)
 testSection:AddButton("Fe Emotes", function(IhateGayPeople)
loadstring(game:HttpGet("https://pastebin.com/raw/eCpipCTH"))()
     end)

local testSection = VisualTab:CreateSector("Misc2", "Right")

testSection:AddButton("rightclick", function(IhateGayPeople)
loadstring(game:HttpGet("https://raw.githubusercontent.com/DHBCommunity/DHBOfficialScript/main/RightClick"))()
     end) 
testSection:AddButton("anti-fling", function(IhateGayPeople)
loadstring(game:HttpGet("https://pastebin.com/raw/L5SphSrU"))()
     end) testSection:AddButton("Keyboard", function(IhateGayPeople)
loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
     end) 
testSection:AddButton("fly v1", function(IhateGayPeople)
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fly-Gui-18103"))()
     end)      testSection:AddButton("animation", function(IhateGayPeople)
loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Animation-Hub/main/Animation%20Gui", true))()
     end) 
testSection:AddButton("Esp", function(IhateGayPeople)
loadstring(game:HttpGet("https://raw.githubusercontent.com/RewritingScripter1/ScriptPlace/refs/heads/main/FraudEsp"))()
     end)
 testSection:AddButton("adonis anti", function(IhateGayPeople)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua",true))()
     end)
  testSection:AddButton("macro", function(IhateGayPeople)
loadstring(game:HttpGet("https://raw.githubusercontent.com/DHBCommunity/DHBOfficialScript/main/macromobbyballigusapo"))()
     end) 
  testSection:AddButton("tpwalk", function(IhateGayPeople)
loadstring(Game:HttpGet("https://raw.githubusercontent.com/TheRealXORA/Roblox/Scripts/Tpwalk%20V4%20%5B%20REVAMP%20%5D.lua", true))()
     end)
   testSection:AddButton("anti lock", function(IhateGayPeople)
loadstring(game:HttpGet('https://raw.githubusercontent.com/wenny69420/KirbswareScripts/main/MobileV3'))()
     end)
     testSection:AddButton("fps boost", function(IhateGayPeople)
local a = tick()
if not game:IsLoaded() then
    game.Loaded:Wait()
end
wait(.1)
sethiddenproperty(game.Lighting, "Technology", 2)
sethiddenproperty(workspace:FindFirstChildOfClass("Terrain"), "Decoration", false)
settings().Rendering.QualityLevel = 1
setsimulationradius(0,0)
game.Lighting.GlobalShadows = false
game.Lighting.FogEnd = 9e9
workspace:FindFirstChildOfClass("Terrain").Elasticity = 0
for b, c in pairs(game:GetDescendants()) do
    task.spawn(
        function()
            wait()
            if c:IsA("DataModelMesh") then
                sethiddenproperty(c, "LODX", Enum.LevelOfDetailSetting.Low)
                sethiddenproperty(c, "LODY", Enum.LevelOfDetailSetting.Low)
                c.CollisionFidelity = "Hull"
            elseif c:IsA("UnionOperation") then
                c.CollisionFidelity = "Hull"
            elseif c:IsA("Model") then
                sethiddenproperty(c, "LevelOfDetail", 1)
            elseif c:IsA("BasePart") then
                c.Reflectance = 0
                c.CastShadow = false
            end
        end
    )
end
for d, e in pairs(game.Lighting:GetChildren()) do
    if e:IsA("PostEffect") then
        e.Enabled = false
    end
end
warn("Low graphics loaded! (" .. math.floor(tick() - a) .. "s)")
     end) 

local testSection = ConfigTab:CreateSector("Config Menu", "left")

ConfigTab:CreateConfigSystem("right")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local NotificationHolder = loadstring(game:HttpGet("https://rentry.co/senopos/raw", true))()
local Notification = loadstring(game:HttpGet("https://rentry.co/senopos2/raw", true))()

local FraudLiarGUI = Instance.new("ScreenGui")
local LockButton = Instance.new("ImageButton")
local ButtonCorner = Instance.new("UICorner")
local Target = nil
local Locking = false
local PlayerData = {}

FraudLiarGUI.Name = "Fraud.lua"
FraudLiarGUI.Parent = game.CoreGui
FraudLiarGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
FraudLiarGUI.ResetOnSpawn = false

LockButton.Name = "LockButton"
LockButton.Parent = FraudLiarGUI
LockButton.Active = true
LockButton.Draggable = true
LockButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LockButton.BackgroundTransparency = 0.350
LockButton.Size = UDim2.new(0, 90, 0, 90)
LockButton.Image = "rbxassetid://134820707156642"
LockButton.Position = UDim2.new(0.5, -25, 0.5, -25)

ButtonCorner.CornerRadius = UDim.new(0.2, 0)
ButtonCorner.Parent = LockButton

Script = {}

local Arguments = loadstring(game:HttpGet("https://raw.githubusercontent.com/xaxaxaxaxaxaxaxaxaxaxaxax/Primordial/refs/heads/main/Arguments.lua"))()

Script.GetEvent = function()
    local RemoteNames = {"MainEvent", "Bullets", "Remote", "MAINEVENT"}
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if table.find(RemoteNames, remote.Name) and remote:IsA("RemoteEvent") then
            return remote
        end
    end
    return nil
end

Script.GetArguments = function()
    return Arguments[game.PlaceId] or "UpdateMousePos"
end

local Remote = Script.GetEvent()
local Argument = Script.GetArguments()

Script.FindClosestPlayer = function()
    local ClosestPlayer
    local ShortestDistance = math.huge
    local ScreenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health ~= 0 and Player.Character:FindFirstChild("HumanoidRootPart") then
            local Position = Camera:WorldToViewportPoint(Player.Character.PrimaryPart.Position)
            local Distance = (Vector2.new(Position.X, Position.Y) - ScreenCenter).magnitude
            if Distance < ShortestDistance then
                ClosestPlayer = Player
                ShortestDistance = Distance
            end
        end
    end
    return ClosestPlayer
end

Script.CalculateVelocity = function(player)
    if not player or not player.Character then return Vector3.new(0, 0, 0) end
    local primary_part = player.Character:FindFirstChild("HumanoidRootPart")
    if not primary_part then return Vector3.new(0, 0, 0) end
    
    if not PlayerData[player] then
        PlayerData[player] = {
            PreviousPosition = primary_part.Position,
            Velocity = Vector3.new(0, 0, 0)
        }
    end
    
    local current_position = primary_part.Position
    local previous_position = PlayerData[player].PreviousPosition
    local displacement = current_position - previous_position
    local delta_time = RunService.Heartbeat:Wait()
    local velocity = displacement / delta_time
    
    PlayerData[player].Velocity = velocity
    PlayerData[player].PreviousPosition = current_position
    
    return velocity
end

Script.LookAt = function(Target)
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    if RootPart and getgenv().FraudLiar['Features']['Look At'] then
        if Target and Target.Character and Target.Character:FindFirstChild(getgenv().FraudLiar['Target Part']) then
            local TargetPart = Target.Character[getgenv().FraudLiar['Target Part']]
            local TargetPos = TargetPart.Position
            local TargetVel = Script.CalculateVelocity(Target)
            local PredictedPos = TargetPos
            
            if getgenv().FraudLiar['Auto Prediction'] then
                local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
                getgenv().FraudLiar['Prediction']['Amount'] = 0.1 + (ping / 2500) * 0.88
            end
            
            PredictedPos = TargetPos + (TargetVel * getgenv().FraudLiar['Prediction']['Amount'])
            
            if TargetVel.Y > 15 then
                PredictedPos = PredictedPos + Vector3.new(0, getgenv().FraudLiar['Offset']['Jump'], 0)
            end
            
            local LocalPos = RootPart.Position
            local AimDirection = (PredictedPos - LocalPos).Unit
            AimDirection = Vector3.new(AimDirection.X, 0, AimDirection.Z).Unit
            RootPart.CFrame = CFrame.new(LocalPos, LocalPos + AimDirection)
        end
    end
end

Script.AutoAir = function(Target)
    if getgenv().FraudLiar['Features']['Auto Air'] and Target and Target.Character then
        local TargetRootPart = Target.Character:FindFirstChild("HumanoidRootPart")
        if TargetRootPart then
            local TargetVel = Script.CalculateVelocity(Target)
            if TargetVel.Y > 15 then
                local Character = LocalPlayer.Character
                if Character then
                    local Tool = Character:FindFirstChildOfClass("Tool")
                    if Tool then
                        Tool:Activate()
                    end
                end
            end
        end
    end
end

Script.GetGun = function(player)
    if not player.Character then return end
    local tool = player.Character:FindFirstChildOfClass("Tool")
    if not tool then return end
    local info = {}
    for _, obj in pairs(tool:GetDescendants()) do
        if obj.Name:lower():find("ammo") and not obj.Name:lower():find("max") and (obj:IsA("IntValue") or obj:IsA("NumberValue")) then
            info.ammo = obj
            info.tool = tool
            return info
        end
    end
end

Script.OnToolActivated = function()
    if Locking and Target and Target.Character then
        local part = Target.Character:FindFirstChild(getgenv().FraudLiar['Target Part'])
        if part then
            local position = part.Position + (PlayerData[Target].Velocity * getgenv().FraudLiar['Prediction']['Amount'])
            Remote:FireServer(Argument, position)
        end
    end
end

Script.SetupConnections = function()
    LocalPlayer.Character.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            child.Activated:Connect(Script.OnToolActivated)
        end
    end)
end

Script.SetupConnections()
LocalPlayer.CharacterAdded:Connect(Script.SetupConnections)

RunService.Heartbeat:Connect(function()
    if Locking and Target then
        Script.LookAt(Target)
        Script.AutoAir(Target)
    end
end)

LockButton.MouseButton1Click:Connect(function()
    if Locking then
        LockButton.Image = "rbxassetid://134820707156642"
        Locking = false
        Target = nil
        Notification:Notify(
            {Title = "Fraud.lol", Description = "Fraud.lol Lock Disabled"},
            {OutlineColor = Color3.fromRGB(0, 0, 0), Time = 1.5, Type = "default"}
        )
    else
        Target = Script.FindClosestPlayer()
        if Target then  
            Locking = true
            LockButton.Image = "rbxassetid://78342062013795"
            Notification:Notify(
                {
                    Title = "Fraud.lol",
                    Description = "Fraud.lol Targetting On: " .. tostring(Target.Character.Humanoid.DisplayName)
                },
                {
                    OutlineColor = Color3.fromRGB(0, 0, 0),
                    Time = 1.5,
                    Type = "default"
                }
            )
        end
    end
end)
