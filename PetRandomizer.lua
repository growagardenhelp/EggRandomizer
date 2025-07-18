-- Create main UI local gui = Instance.new("ScreenGui") gui.Name = "EggVisualizerGUI" gui.ResetOnSpawn = false pcall(function() gui.Parent = game:GetService("CoreGui") end)

-- Main Frame local frame = Instance.new("Frame") frame.Size = UDim2.new(0, 320, 0, 360) frame.Position = UDim2.new(0, 50, 0, 100) frame.BackgroundColor3 = Color3.fromRGB(34, 139, 34) -- green plant theme frame.BorderSizePixel = 0 frame.Parent = gui

local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, 12) corner.Parent = frame

-- Title Label local title = Instance.new("TextLabel") title.Size = UDim2.new(1, 0, 0, 40) title.BackgroundColor3 = Color3.fromRGB(255, 255, 255) title.Text = "🌿 Egg Visualizer GUI" title.TextColor3 = Color3.fromRGB(128, 0, 128) -- purple title.Font = Enum.Font.GothamBold title.TextSize = 18 title.Parent = frame

local titleCorner = Instance.new("UICorner") titleCorner.CornerRadius = UDim.new(0, 12) titleCorner.Parent = title

-- Button generator local function createButton(text, positionY) local btn = Instance.new("TextButton") btn.Size = UDim2.new(0, 280, 0, 40) btn.Position = UDim2.new(0, 20, 0, positionY) btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255) btn.TextColor3 = Color3.fromRGB(128, 0, 128) btn.Font = Enum.Font.Gotham btn.TextSize = 16 btn.Text = text btn.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = btn

return btn

end

-- Buttons local petEspBtn = createButton("Pet ESP (Visual Only)", 60) local randomToggle = createButton("Randomize Egg: OFF", 110) local stopTrex = createButton("Stop when T-Rex", 160) local stopBron = createButton("Stop when Brontosaurus", 210) local stopPtera = createButton("Stop when Pterodactyl", 260) local stopTrice = createButton("Stop when Triceratops", 310) local stopStego = createButton("Stop when Stegosaurus", 360) local stopRaptor = createButton("Stop when Raptor", 410)

-- Toggle logic local isRandomizing = false randomToggle.MouseButton1Click:Connect(function() isRandomizing = not isRandomizing randomToggle.Text = "Randomize Egg: " .. (isRandomizing and "ON" or "OFF") end)

-- Click logs petEspBtn.MouseButton1Click:Connect(function() print("[Visual] Pet ESP toggled") end)

stopTrex.MouseButton1Click:Connect(function() print("[Visual] Stop when T-Rex selected") end) stopBron.MouseButton1Click:Connect(function() print("[Visual] Stop when Brontosaurus selected") end) stopPtera.MouseButton1Click:Connect(function() print("[Visual] Stop when Pterodactyl selected") end) stopTrice.MouseButton1Click:Connect(function() print("[Visual] Stop when Triceratops selected") end) stopStego.MouseButton1Click:Connect(function() print("[Visual] Stop when Stegosaurus selected") end) stopRaptor.MouseButton1Click:Connect(function() print("[Visual] Stop when Raptor selected") end)

print("[EggVisualizerGUI] Visual-only script loaded.")

