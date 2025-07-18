-- GUI Elements
local gui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", gui)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Position = UDim2.new(0, 50, 0, 200)
frame.Size = UDim2.new(0, 250, 0, 160)
frame.Active = true
frame.Draggable = true

local function makeButton(text, y)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0, 230, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, y)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 18
	return btn
end

local petESPBtn = makeButton("Pet ESP", 10)
local randomizeBtn = makeButton("Randomize Egg: OFF", 60)
local stopTrexBtn = makeButton("Stop when T-Rex", 110)

-- Core Logic (Raptor most common, T-Rex rare)
local pets = {
	"Raptor", "Raptor", "Raptor", "Raptor", -- 40%
	"Brontosaurus",                        -- 10%
	"Pterodactyl",                         -- 10%
	"Triceratops",                         -- 10%
	"Stegosaurus",                         -- 10%
	"T-Rex"                                -- 10%
}

local activeTags = {}
local running = false
local stopAt = nil

-- Function to apply fake ESP
local function applyFakeESP()
	for _, part in pairs(workspace:GetDescendants()) do
		if part:IsA("Part") and part.Name:lower():find("egg") and not activeTags[part] then
			local gui = Instance.new("BillboardGui", part)
			gui.Size = UDim2.new(0, 100, 0, 40)
			gui.Adornee = part
			gui.AlwaysOnTop = true

			local label = Instance.new("TextLabel", gui)
			label.Size = UDim2.new(1, 0, 1, 0)
			label.BackgroundTransparency = 1
			label.TextColor3 = Color3.fromRGB(255,255,0)
			label.Text = pets[math.random(1, #pets)]
			label.Font = Enum.Font.SourceSansBold
			label.TextScaled = true

			activeTags[part] = {gui = gui, label = label}
		end
	end
end

-- Function to randomize
task.spawn(function()
	while true do
		wait(1)
		if running then
			for _, tag in pairs(activeTags) do
				local newPet = pets[math.random(1, #pets)]
				tag.label.Text = newPet
				if stopAt and newPet == stopAt then
					running = false
				end
			end
		end
	end
end)

-- Button functionality
petESPBtn.MouseButton1Click:Connect(applyFakeESP)

randomizeBtn.MouseButton1Click:Connect(function()
	running = not running
	randomizeBtn.Text = "Randomize Egg: " .. (running and "ON" or "OFF")
end)

stopTrexBtn.MouseButton1Click:Connect(function()
	stopAt = "T-Rex"
end)
