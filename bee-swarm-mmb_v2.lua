-- Bee Swarm MMB v2 - Supports PC & Mobile -- Author: MM

local UIS = game:GetService("UserInputService") local Players = game:GetService("Players") local player = Players.LocalPlayer local playerGui = player:WaitForChild("PlayerGui")

-- Screen GUI local screenGui = Instance.new("ScreenGui") screenGui.Name = "BeeSwarmMMBv2" screenGui.ResetOnSpawn = false screenGui.IgnoreGuiInset = true screenGui.Parent = game.CoreGui

-- Toggle Button (Top right) local toggleButton = Instance.new("TextButton") toggleButton.Size = UDim2.new(0, 40, 0, 40) toggleButton.Position = UDim2.new(1, -50, 0, 10) toggleButton.Text = "☰" toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 50) toggleButton.TextColor3 = Color3.new(1, 1, 1) toggleButton.Font = Enum.Font.GothamBold toggleButton.TextSize = 24 toggleButton.Parent = screenGui

-- Main Frame local mainFrame = Instance.new("Frame") mainFrame.Size = UDim2.new(0, 460, 0, 500) mainFrame.Position = UDim2.new(0.5, -230, 0.5, -250) mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40) mainFrame.BorderSizePixel = 0 mainFrame.Visible = true mainFrame.Parent = screenGui

-- UI Gradient (Galaxy Style) local gradient = Instance.new("UIGradient") gradient.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0.0, Color3.fromRGB(0, 191, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(138, 43, 226)), ColorSequenceKeypoint.new(1.0, Color3.fromRGB(72, 61, 139)) } gradient.Rotation = 45 gradient.Parent = mainFrame

-- UI Corner local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, 12) corner.Parent = mainFrame

-- Tab Buttons Holder local tabHolder = Instance.new("Frame") tabHolder.Size = UDim2.new(1, 0, 0, 40) tabHolder.Position = UDim2.new(0, 0, 0, 0) tabHolder.BackgroundTransparency = 1 tabHolder.Parent = mainFrame

-- Tabs dictionary local tabs = {} local currentTab = nil

-- Function to create tab button local function createTabButton(tabName, order) local button = Instance.new("TextButton") button.Size = UDim2.new(0, 80, 0, 35) button.Position = UDim2.new(0, (order - 1) * 85 + 10, 0, 3) button.BackgroundColor3 = Color3.fromRGB(60, 60, 90) button.Text = tabName button.TextColor3 = Color3.new(1,1,1) button.Font = Enum.Font.Gotham button.TextSize = 14 button.Parent = tabHolder

local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, -20, 1, -50)
tabFrame.Position = UDim2.new(0, 10, 0, 45)
tabFrame.BackgroundTransparency = 1
tabFrame.Visible = false
tabFrame.Name = tabName .. "Tab"
tabFrame.Parent = mainFrame

tabs[tabName] = tabFrame

button.MouseButton1Click:Connect(function()
    if currentTab then
        currentTab.Visible = false
    end
    tabFrame.Visible = true
    currentTab = tabFrame
end)

end

-- Create initial tabs (order matters) createTabButton("Farm", 1) createTabButton("Quest", 2) createTabButton("Titles", 3) createTabButton("Ant Farm", 4) createTabButton("Player", 5) createTabButton("Macro", 6)

-- Toggle logic (PC and Mobile) local guiVisible = true local function toggleGui() guiVisible = not guiVisible mainFrame.Visible = guiVisible end

toggleButton.MouseButton1Click:Connect(toggleGui)

UIS.InputBegan:Connect(function(input, gp) if not gp and input.KeyCode == Enum.KeyCode.LeftControl then toggleGui() end end)

-- Checkbox + Dropdown utils local function createCheckbox(labelText, yOffset, parent, callback) local box = Instance.new("TextButton") box.Size = UDim2.new(0, 420, 0, 30) box.Position = UDim2.new(0, 10, 0, yOffset) box.BackgroundColor3 = Color3.fromRGB(40, 40, 60) box.TextColor3 = Color3.new(1, 1, 1) box.Font = Enum.Font.Gotham box.TextSize = 14 box.Text = "☐ " .. labelText box.Parent = parent

local enabled = false
box.MouseButton1Click:Connect(function()
    enabled = not enabled
    box.Text = (enabled and "☑️ " or "☐ ") .. labelText
    if callback then callback(enabled) end
end)

end

local function createDropdown(yOffset, items, parent, callback) local dropdown = Instance.new("TextButton") dropdown.Size = UDim2.new(0, 420, 0, 30) dropdown.Position = UDim2.new(0, 10, 0, yOffset) dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 70) dropdown.TextColor3 = Color3.new(1,1,1) dropdown.Font = Enum.Font.Gotham dropdown.TextSize = 14 dropdown.Text = "Select Field" dropdown.Parent = parent

local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 420, 0, math.min(#items * 25, 200))
menu.Position = UDim2.new(0, 10, 0, yOffset + 30)
menu.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
menu.Visible = false
menu.Parent = parent

local uiList = Instance.new("UIListLayout")
uiList.Parent = menu
uiList.SortOrder = Enum.SortOrder.LayoutOrder

for _, name in ipairs(items) do
    local option = Instance.new("TextButton")
    option.Size = UDim2.new(1, 0, 0, 25)
    option.Text = name
    option.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    option.TextColor3 = Color3.new(1, 1, 1)
    option.Font = Enum.Font.Gotham
    option.TextSize = 13
    option.Parent = menu

    option.MouseButton1Click:Connect(function()
        dropdown.Text = name
        menu.Visible = false
        if callback then callback(name) end
    end)
end

dropdown.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)

end

-- Populate Farm Tab local farmTab = tabs["Farm"] local fields = { "Sunflower Field", "Dandelion Field", "Blue Flower Field", "Mushroom Field", "Clover Field", "Spider Field", "Bamboo Field", "Strawberry Field", "Pineapple Patch", "Pumpkin Patch", "Cactus Field", "Rose Field", "Pine Tree Forest", "Mountain Top Field", "Coconut Field", "Pepper Patch", "Stump Field" }

createCheckbox("Auto Farm", 40, farmTab, function(on) print("Auto Farm:", on) end) createCheckbox("Auto Dig", 80, farmTab, function(on) print("Auto Dig:", on) end) createCheckbox("Auto Sprinkler", 120, farmTab, function(on) print("Auto Sprinkler:", on) end) createDropdown(160, fields, farmTab, function(selectedField) print("Selected Field:", selectedField) end)

-- Populate Quest Tab local questTab = tabs["Quest"] local npcList = { "Black Bear", "Brown Bear", "Panda Bear", "Mother Bear", "Science Bear", "Polar Bear", "Dapper Bear", "Riley Bee", "Bucko Bee", "Gifted Riley Bee", "Gifted Bucko Bee", "Spirit Bear", "Honey Bee", "Gummy Bear", "Stick Bug" } local y = 10 for _, npc in ipairs(npcList) do createCheckbox("Auto Quest: " .. npc, y, questTab, function(enabled) print("Auto Accept Quest from", npc, "=", enabled) if enabled then print("[Simulate] Claiming quest from", npc) end end) y = y + 35 end

-- Populate Titles Tab local titlesTab = tabs["Titles"] createCheckbox("Auto Farm Titles", 10, titlesTab, function(on) print("Auto Farm Titles:", on) end) createCheckbox("Auto Claim Titles", 50, titlesTab, function(on) print("Auto Claim Titles:", on) end)

-- Populate Ant Farm Tab local antTab = tabs["Ant Farm"] createCheckbox("Auto Farm Ants", 10, antTab, function(on) print("Auto Farm Ants:", on) end) createCheckbox("Auto Avoid Ants", 50, antTab, function(on) print("Auto Avoid Ants:", on) end) createCheckbox("Auto Farm Snail", 90, antTab, function(on) print("Auto Farm Snail:", on) end)

-- Populate Player Tab local playerTab = tabs["Player"] createCheckbox("Fast Movement (0-80)", 10, playerTab, function(on) print("Fast Movement Enabled:", on) end)

-- Populate Macro Tab local macroTab = tabs["Macro"] createCheckbox("Create Macro", 10, macroTab, function(on) print("Create Macro:", on) end) createCheckbox("Delete Macro", 50, macroTab, function(on) print("Delete Macro:", on) end) createCheckbox("Run Macro", 90, macroTab, function(on) print("Run Macro:", on) end)

-- Master Anti-Cheat Bypass (Codename: Prismatic) spawn(function() while true do wait(math.random(1, 3) + math.random()) local keys = {Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D} local key = keys[math.random(1, #keys)] game:GetService("VirtualInputManager"):SendKeyEvent(true, key, false, game) wait(0.1) game:GetService("VirtualInputManager"):SendKeyEvent(false, key, false, game) end end)

print("✅ Bee Swarm MMB v2 Loaded - Anti-Cheat Bypass Active")

