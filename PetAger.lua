local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local PetESP = Instance.new("TextButton")
local Randomize = Instance.new("TextButton")
local StopT_Rex = Instance.new("TextButton")
local StopQueenBee = Instance.new("TextButton")
local StopMimic = Instance.new("TextButton")

local runRandomizer = false
local stopAtPet = nil

-- Setup UI
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Position = UDim2.new(0.05, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 250, 0, 220)
Frame.Active = true
Frame.Draggable = true

local function makeButton(text, position)
	local btn = Instance.new("TextButton")
	btn.Parent = Frame
	btn.Size = UDim2.new(0, 230, 0, 40)
	btn.Position = position
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 20
	return btn
end

PetESP = makeButton("Pet ESP", UDim2.new(0, 10, 0, 10))
Randomize = makeButton("Randomize Egg: OFF", UDim2.new(0, 10, 0, 60))
StopT_Rex = makeButton("Stop at T-Rex", UDim2.new(0, 10, 0, 110))
StopQueenBee = makeButton("Stop at Queen Bee", UDim2.new(0, 10, 0, 160))
StopMimic = makeButton("Stop at Mimic Octopus", UDim2.new(0, 10, 0, 210))

-- Pet ESP
PetESP.MouseButton1Click:Connect(function()
	for _, egg in pairs(workspace:GetDescendants()) do
		if egg:IsA("Model") and egg:FindFirstChild("Egg") and egg:FindFirstChild("PetInside") then
			local tag = Instance.new("BillboardGui", egg)
			tag.Size = UDim2.new(0, 100, 0, 40)
			tag.AlwaysOnTop = true
			tag.Adornee = egg
			local label = Instance.new("TextLabel", tag)
			label.Size = UDim2.new(1, 0, 1, 0)
			label.BackgroundTransparency = 1
			label.TextColor3 = Color3.new(1, 1, 0)
			label.Text = egg.PetInside.Value or "Unknown"
		end
	end
end)

-- Randomizer loop
task.spawn(function()
	while true do
		task.wait(1)
		if runRandomizer then
			for _, egg in pairs(workspace:GetDescendants()) do
				if egg:IsA("Model") and egg:FindFirstChild("PetInside") then
					local pets = {"T-Rex", "Queen Bee", "Mimic Octopus", "Cat", "Dog", "Elephant"}
					local randomPet = pets[math.random(1, #pets)]
					egg.PetInside.Value = randomPet

					if stopAtPet and randomPet == stopAtPet then
						runRandomizer = false
						Randomize.Text = "Randomize Egg: OFF"
					end
				end
			end
		end
	end
end)

-- Toggle button
Randomize.MouseButton1Click:Connect(function()
	runRandomizer = not runRandomizer
	Randomize.Text = "Randomize Egg: " .. (runRandomizer and "ON" or "OFF")
end)

-- Stop buttons
StopT_Rex.MouseButton1Click:Connect(function()
	stopAtPet = "T-Rex"
end)

StopQueenBee.MouseButton1Click:Connect(function()
	stopAtPet = "Queen Bee"
end)

StopMimic.MouseButton1Click:Connect(function()
	stopAtPet = "Mimic Octopus"
end)
