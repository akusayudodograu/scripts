-- Criando a interface principal
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Criar a interface ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GUHHUBMenu"
screenGui.Parent = playerGui

-- Função para criar comportamento de arrastar
local function makeDraggable(frame, dragHandle)
    local dragging = false
    local dragInput, mousePos, framePos

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Criar botão para alternar o menu
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleMenuButton"
toggleButton.Size = UDim2.new(0, 100, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Text = "GUHHUB"
toggleButton.BackgroundColor3 = Color3.new(1, 1, 1) -- Branco inicial
toggleButton.TextColor3 = Color3.new(0, 0, 0) -- Preto inicial
toggleButton.Parent = screenGui

-- Criar o menu
local menuFrame = Instance.new("Frame")
menuFrame.Name = "MenuFrame"
menuFrame.Size = UDim2.new(0, 300, 0, 200)
menuFrame.Position = UDim2.new(0, 10, 0, 70)
menuFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2) -- Cinza escuro inicial
menuFrame.Parent = screenGui

-- Título do menu
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Text = "GUH HUB"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = menuFrame

-- Botão de minimizar
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -60, 0, 0)
minimizeButton.Text = "-"
minimizeButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.Parent = menuFrame

-- Botão de fechar
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.new(1, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Parent = menuFrame

-- Botão de configurações
local settingsButton = Instance.new("TextButton")
settingsButton.Size = UDim2.new(0, 100, 0, 30)
settingsButton.Position = UDim2.new(0, 10, 0, 40)
settingsButton.Text = "Configurações"
settingsButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
settingsButton.TextColor3 = Color3.new(1, 1, 1)
settingsButton.Parent = menuFrame

-- Minimizar menu
local minimized = false
local function toggleMinimize()
    minimized = not minimized
    for _, child in ipairs(menuFrame:GetChildren()) do
        if child ~= titleLabel and child ~= minimizeButton and child ~= closeButton then
            child.Visible = not minimized
        end
    end
    menuFrame.Size = minimized and UDim2.new(0, 300, 0, 30) or UDim2.new(0, 300, 0, 200)
end
minimizeButton.MouseButton1Click:Connect(toggleMinimize)

-- Fechar menu
local function confirmClose()
    menuFrame.Visible = false
    toggleButton.Visible = false
end

local function showConfirmation()
    local confirmationFrame = Instance.new("Frame")
    confirmationFrame.Size = UDim2.new(0, 200, 0, 100)
    confirmationFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
    confirmationFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    confirmationFrame.Parent = screenGui

    local confirmationLabel = Instance.new("TextLabel")
    confirmationLabel.Size = UDim2.new(1, 0, 0.5, 0)
    confirmationLabel.Text = "Deseja fechar?"
    confirmationLabel.TextColor3 = Color3.new(1, 1, 1)
    confirmationLabel.BackgroundTransparency = 1
    confirmationLabel.Parent = confirmationFrame

    local yesButton = Instance.new("TextButton")
    yesButton.Size = UDim2.new(0.5, -5, 0.5, 0)
    yesButton.Position = UDim2.new(0, 0, 0.5, 0)
    yesButton.Text = "Sim"
    yesButton.BackgroundColor3 = Color3.new(1, 0, 0)
    yesButton.TextColor3 = Color3.new(1, 1, 1)
    yesButton.Parent = confirmationFrame

    local noButton = Instance.new("TextButton")
    noButton.Size = UDim2.new(0.5, -5, 0.5, 0)
    noButton.Position = UDim2.new(0.5, 5, 0.5, 0)
    noButton.Text = "Não"
    noButton.BackgroundColor3 = Color3.new(0, 1, 0)
    noButton.TextColor3 = Color3.new(1, 1, 1)
    noButton.Parent = confirmationFrame

    yesButton.MouseButton1Click:Connect(function()
        confirmClose()
        confirmationFrame:Destroy()
    end)

    noButton.MouseButton1Click:Connect(function()
        confirmationFrame:Destroy()
    end)
end

closeButton.MouseButton1Click:Connect(showConfirmation)

-- Alternar visibilidade do menu
local menuVisible = true
local function toggleMenu()
    menuVisible = not menuVisible
    menuFrame.Visible = menuVisible
end
toggleButton.MouseButton1Click:Connect(toggleMenu)

-- Tornar o menu arrastável
makeDraggable(menuFrame, titleLabel)

-- Criar interface de configurações
local settingsFrame = Instance.new("Frame")
settingsFrame.Size = UDim2.new(0, 300, 0, 150)
settingsFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
settingsFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
settingsFrame.Visible = false
settingsFrame.Parent = screenGui

-- Título do menu de configurações
local settingsTitle = Instance.new("TextLabel")
settingsTitle.Size = UDim2.new(1, 0, 0, 30)
settingsTitle.Text = "Configurações"
settingsTitle.TextColor3 = Color3.new(1, 1, 1)
settingsTitle.BackgroundTransparency = 1
settingsTitle.Parent = settingsFrame

-- Botão para fechar configurações
local settingsCloseButton = Instance.new("TextButton")
settingsCloseButton.Size = UDim2.new(0, 30, 0, 30)
settingsCloseButton.Position = UDim2.new(1, -30, 0, 0)
settingsCloseButton.Text = "X"
settingsCloseButton.BackgroundColor3 = Color3.new(1, 0, 0)
settingsCloseButton.TextColor3 = Color3.new(1, 1, 1)
settingsCloseButton.Parent = settingsFrame

settingsCloseButton.MouseButton1Click:Connect(function()
    settingsFrame.Visible = false
end)

-- Tornar o menu de configurações arrastável
makeDraggable(settingsFrame, settingsTitle)

-- Adicionar seletor de cores
local colorPickerLabel = Instance.new("TextLabel")
colorPickerLabel.Size = UDim2.new(1, 0, 0, 30)
colorPickerLabel.Position = UDim2.new(0, 0, 0, 40)
colorPickerLabel.Text = "Escolha a cor do menu"
colorPickerLabel.TextColor3 = Color3.new(1, 1, 1)
colorPickerLabel.BackgroundTransparency = 1
colorPickerLabel.Parent = settingsFrame

local colorPickerFrame = Instance.new("Frame")
colorPickerFrame.Size = UDim2.new(0, 200, 0, 30)
colorPickerFrame.Position = UDim2.new(0.5, -100, 0.5, -15)
colorPickerFrame.BackgroundColor3 = Color3.new(1, 1, 1)
colorPickerFrame.BorderSizePixel = 1
colorPickerFrame.Parent = settingsFrame

local draggableBall = Instance.new("Frame")
draggableBall.Size = UDim2.new(0, 30, 0, 30)
draggableBall.Position = UDim2.new(0, 0, 0, 0)
draggableBall.BackgroundColor3 = Color3.new(0, 0, 0)
draggableBall.Parent = colorPickerFrame
makeDraggable(draggableBall, draggableBall)

colorPickerFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggableBall.Position = UDim2.new(0, input.Position.X - colorPickerFrame.AbsolutePosition.X, 0, 0)
        local newColor = Color3.new((draggableBall.Position.X.Offset / colorPickerFrame.Size.X.Offset), 0.5, 0.5)
        menuFrame.BackgroundColor3 = newColor
    end
end)

settingsButton.MouseButton1Click:Connect(function()
    settingsFrame.Visible = not settingsFrame.Visible
end)
