-- GUI Elements (Plant Theme)
local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.BackgroundColor3 = Color3.fromRGB(34, 139, 34) -- Forest green
frame.Position = UDim2.new(0, 50, 0, 200)
frame.Size = UDim2.new(0, 270, 0, 250)
frame.Active = true
frame.Draggable = true

local roundFrame = Instance.new("UICorner", frame)
roundFrame.CornerRadius = UDim.new(0, 12)

local function makeButton(text, y)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0, 240, 0, 40)
	btn.Position = UDim2.new(0, 15, 0, y)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(85, 170, 85) -- Light plant green
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 18

	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0, 8)

	return btn
end

local petESPBtn = makeButton("🌿 Pet ESP", 10)
local randomizeBtn = makeButton("🔄 Randomize Egg: OFF", 60)
local stopTrexBtn = makeButton("⛔ Stop when T-Rex", 110)

-- Core Logic
local pets = {
    "T-Rex",
    "Brontosaurus",
    "Pterodactyl",
    "Triceratops",
    "Stegosaurus",
    "Raptor"
}
local activeTags = {}
local running = false
local stopAt = nil

-- Function to apply fake ESP
local function applyFakeESP()
	for _, part in pairs(workspace:GetDescendants()) do
		if part:IsA("Part") and part.Name:lower():find("egg") and not activeTags[part] then
			local gui = Instance.new("BillboardGui", part)
			gui.Size = UDim2.new(0, 100, 0, 50)
			gui.Adornee = part
			gui.AlwaysOnTop = true
			gui.Name = "FakePetESP"

			local label = Instance.new("TextLabel", gui)
			label.Size = UDim2.new(1, 0, 1, 0)
			label.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- White background
			label.BorderSizePixel = 0
			label.BackgroundTransparency = 0.2
			label.TextColor3 = Color3.fromRGB(128, 0, 128) -- Purple text
			label.Text = pets[math.random(1, #pets)]
			label.Font = Enum.Font.SourceSansBold
			label.TextScaled = true
			label.Name = "PetNameLabel"

			local corner = Instance.new("UICorner", label)
			corner.CornerRadius = UDim.new(0, 8)

			activeTags[part] = {gui = gui, label = label}
		end
	end
end

-- Function to randomize
task.spawn(function()
	while true do
		wait(1)
		if running then
			for _, tag
