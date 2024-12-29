-- Guh Hub Avançado com ESP Melhorado
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local ToggleButton = Instance.new("TextButton")
local ESPButton = Instance.new("TextButton")
local isMinimized = false
local isESPActive = false

-- Configurações da ScreenGui
ScreenGui.Name = "GuhHub"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Configurações do MainFrame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Active = true
MainFrame.Draggable = true

-- Configurações do título
Title.Name = "Title"
Title.Parent = MainFrame
Title.Text = "Guh Hub"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Size = UDim2.new(1, 0, 0.2, 0)

-- Botão de fechar
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 18
CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
CloseButton.Size = UDim2.new(0.1, 0, 0.2, 0)
CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Botão de minimizar
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame
MinimizeButton.Text = "-"
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 18
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
MinimizeButton.Size = UDim2.new(0.1, 0, 0.2, 0)
MinimizeButton.Position = UDim2.new(0.8, 0, 0, 0)
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        MainFrame.Size = UDim2.new(0, 300, 0, 40)
    else
        MainFrame.Size = UDim2.new(0, 300, 0, 200)
    end
end)

-- Botão ESP
ESPButton.Name = "ESPButton"
ESPButton.Parent = MainFrame
ESPButton.Text = "Ativar ESP"
ESPButton.Font = Enum.Font.SourceSans
ESPButton.TextSize = 18
ESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ESPButton.Size = UDim2.new(0.8, 0, 0.2, 0)
ESPButton.Position = UDim2.new(0.1, 0, 0.4, 0)

ESPButton.MouseButton1Click:Connect(function()
    isESPActive = not isESPActive
    ESPButton.Text = isESPActive and "Desativar ESP" or "Ativar ESP"

    -- Função ESP
    local function createESP(player)
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            -- Linha do jogador local ao alvo
            local line = Instance.new("Part")
            line.Name = "ESPLine"
            line.Parent = player.Character
            line.Anchored = true
            line.CanCollide = false
            line.Size = Vector3.new(0.1, 0.1, 0.1)
            line.Material = Enum.Material.Neon
            line.Color = Color3.new(math.random(), math.random(), math.random())

            -- Caixa ao redor do personagem
            local box = Instance.new("SelectionBox")
            box.Name = "ESPBox"
            box.Parent = player.Character
            box.Adornee = player.Character
            box.LineThickness = 0.05
            box.Color3 = Color3.new(math.random(), math.random(), math.random())

            -- Nome do jogador
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "ESPBillboard"
            billboard.Parent = player.Character
            billboard.Adornee = player.Character.HumanoidRootPart
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.AlwaysOnTop = true

            local textLabel = Instance.new("TextLabel")
            textLabel.Parent = billboard
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.Text = player.Name
            textLabel.TextColor3 = Color3.new(math.random(), math.random(), math.random())
            textLabel.BackgroundTransparency = 1

            -- Atualizar a posição da linha
            game:GetService("RunService").RenderStepped:Connect(function()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    line.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, player.Character.HumanoidRootPart.Position) * CFrame.new(0, 0, -((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude / 2))
                    line.Size = Vector3.new(0.1, 0.1, (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude)
                end
            end)
        end
    end

    if isESPActive then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                createESP(player)
            end
        end
    else
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                for _, child in pairs(player.Character:GetChildren()) do
                    if child.Name == "ESPLine" or child.Name == "ESPBox" or child.Name == "ESPBillboard" then
                        child:Destroy()
                    end
                end
            end
        end
    end
end)

-- Botão GUH
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.Text = "GUH"
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 18
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 255)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.Size = UDim2.new(0, 100, 0, 50)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
