-- [[ SILVAHXZ18 INTELLIGENT HIDE & SEEK HUB V1 ]] --
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Evitar duplicação do menu
if CoreGui:FindFirstChild("SilvahxzMenuHub") then
    CoreGui:FindFirstChild("SilvahxzMenuHub"):Destroy()
end

-- Criando a ScreenGui principal
local SilvahxzMenuHub = Instance.new("ScreenGui")
SilvahxzMenuHub.Name = "SilvahxzMenuHub"
SilvahxzMenuHub.Parent = CoreGui
SilvahxzMenuHub.ResetOnSpawn = false

-- =========================================================
-- SISTEMA DE LOGIN / CARREGAMENTO (30 SEGUNDOS)
-- =========================================================
local LoginFrame = Instance.new("Frame")
LoginFrame.Name = "LoginFrame"
LoginFrame.Parent = SilvahxzMenuHub
LoginFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
LoginFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
LoginFrame.Size = UDim2.new(0, 300, 0, 200)
LoginFrame.Visible = true

local LoginStroke = Instance.new("UIStroke")
LoginStroke.Parent = LoginFrame
LoginStroke.Color = Color3.fromRGB(0, 0, 255)
LoginStroke.Thickness = 3

local LoginCorner = Instance.new("UICorner")
LoginCorner.CornerRadius = UDim.new(0, 15)
LoginCorner.Parent = LoginFrame

local LoginTitle = Instance.new("TextLabel")
LoginTitle.Name = "LoginTitle"
LoginTitle.Parent = LoginFrame
LoginTitle.BackgroundTransparency = 1
LoginTitle.Position = UDim2.new(0, 0, 0, 15)
LoginTitle.Size = UDim2.new(1, 0, 0, 25)
LoginTitle.Font = Enum.Font.SourceSansBold
LoginTitle.Text = "SILVAHXZ HUB V2 - LOGIN SYSTEM"
LoginTitle.TextColor3 = Color3.fromRGB(0, 255, 255)
LoginTitle.TextSize = 16

local LogConsole = Instance.new("TextLabel")
LogConsole.Name = "LogConsole"
LogConsole.Parent = LoginFrame
LogConsole.BackgroundTransparency = 1
LogConsole.Position = UDim2.new(0, 15, 0, 50)
LogConsole.Size = UDim2.new(1, -30, 0, 100)
LogConsole.Font = Enum.Font.Code
LogConsole.Text = "Aguardando inicialização..."
LogConsole.TextColor3 = Color3.fromRGB(255, 255, 255)
LogConsole.TextSize = 11
LogConsole.TextXAlignment = Enum.TextXAlignment.Left
LogConsole.TextYAlignment = Enum.TextYAlignment.Top
LogConsole.TextWrapped = true

local ProgressBarBackground = Instance.new("Frame")
ProgressBarBackground.Parent = LoginFrame
ProgressBarBackground.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ProgressBarBackground.Position = UDim2.new(0, 15, 1, -30)
ProgressBarBackground.Size = UDim2.new(1, -30, 0, 15)
Instance.new("UICorner", ProgressBarBackground).CornerRadius = UDim.new(0, 4)

local ProgressBar = Instance.new("Frame")
ProgressBar.Parent = ProgressBarBackground
ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
ProgressBar.Size = UDim2.new(0, 0, 1, 0)
Instance.new("UICorner", ProgressBar).CornerRadius = UDim.new(0, 4)

-- =========================================================
-- PAINEL PRINCIPAL (300x200 com Imagem do Kaneki)
-- =========================================================
local MainFrame = Instance.new("ImageLabel")
MainFrame.Name = "MainFrame"
MainFrame.Parent = SilvahxzMenuHub
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Image = "rbxassetid://95240563873925"
MainFrame.ScaleType = Enum.ScaleType.Stretch
MainFrame.Visible = false 

local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = Color3.fromRGB(0, 0, 255)
MainStroke.Thickness = 3

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- INDICADOR DE VERSÃO (Canto Inferior Direito)
local VersionLabel = Instance.new("TextLabel")
VersionLabel.Name = "VersionLabel"
VersionLabel.Parent = MainFrame
VersionLabel.BackgroundTransparency = 1
VersionLabel.Position = UDim2.new(1, -95, 1, -22)
VersionLabel.Size = UDim2.new(0, 80, 0, 15)
VersionLabel.Font = Enum.Font.SourceSansBold
VersionLabel.Text = "Versão 1.0.0"
VersionLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
VersionLabel.TextSize = 12
VersionLabel.TextXAlignment = Enum.TextXAlignment.Right

-- =========================================================
-- PAINEL LATERAL ESQUERDO (SISTEMA DE ABAS FIXAS)
-- =========================================================
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Parent = MainFrame
TabContainer.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TabContainer.BackgroundTransparency = 0.4
TabContainer.Position = UDim2.new(0, 10, 0, 15)
TabContainer.Size = UDim2.new(0, 75, 1, -30)

local TabContainerCorner = Instance.new("UICorner")
TabContainerCorner.CornerRadius = UDim.new(0, 8)
TabContainerCorner.Parent = TabContainer

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabContainer
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 5)

-- Containers de Conteúdo das Abas (Lado Direito)
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.BackgroundTransparency = 1
ContentContainer.Position = UDim2.new(0, 95, 0, 15)
ContentContainer.Size = UDim2.new(1, -110, 1, -30)

-- =========================================================
-- FUNÇÃO REALTIME PARA IDENTIFICAR QUEM ESTÁ ESCONDIDO
-- =========================================================
local function isPlayerHiding(player)
    if not player or player == LocalPlayer then return false end
    
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return false end

    if player.Team then
        local teamName = string.lower(player.Team.Name)
        if string.find(teamName, "seek") or string.find(teamName, "caça") or string.find(teamName, "pegador") then
            return false
        end
    end

    local backpack = player:FindFirstChild("Backpack")
    local itemsToCheck = {"gun", "weapon", "radar", "arma", "pistol", "rifle", "caçador", "seeker"}
    
    for _, itemName in pairs(itemsToCheck) do
        if backpack and backpack:FindFirstChildOfClass("Tool") and string.find(string.lower(backpack:FindFirstChildOfClass("Tool").Name), itemName) then
            return false
        end
        if char:FindFirstChildOfClass("Tool") and string.find(string.lower(char:FindFirstChildOfClass("Tool").Name), itemName) then
            return false
        end
    end

    return true
end

-- =========================================================
-- CRIAÇÃO DA ABA 1: HACK (TELEPORTE FILTRADO)
-- =========================================================
local HackContent = Instance.new("Frame")
HackContent.Name = "HackContent"
HackContent.Parent = ContentContainer
HackContent.BackgroundTransparency = 1
HackContent.Size = UDim2.new(1, 0, 1, 0)
HackContent.Visible = true

local SelectedPlayer = nil

local DropdownButton = Instance.new("TextButton")
DropdownButton.Name = "DropdownButton"
DropdownButton.Parent = HackContent
DropdownButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
DropdownButton.BackgroundTransparency = 0.2
DropdownButton.Position = UDim2.new(0, 0, 0, 10)
DropdownButton.Size = UDim2.new(1, 0, 0, 30)
DropdownButton.Font = Enum.Font.SourceSansBold
DropdownButton.Text = "Selecionar Escondido..."
DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DropdownButton.TextSize = 13

local DropdownStroke = Instance.new("UIStroke")
DropdownStroke.Parent = DropdownButton
DropdownStroke.Color = Color3.fromRGB(0, 0, 255)

local DropdownCorner = Instance.new("UICorner")
DropdownCorner.CornerRadius = UDim.new(0, 6)
DropdownCorner.Parent = DropdownButton

local PlayerListFrame = Instance.new("ScrollingFrame")
PlayerListFrame.Name = "PlayerListFrame"
PlayerListFrame.Parent = HackContent
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
PlayerListFrame.Position = UDim2.new(0, 0, 0, 45)
PlayerListFrame.Size = UDim2.new(1, 0, 0, 80)
PlayerListFrame.Visible = false
PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerListFrame.ScrollBarThickness = 4

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = PlayerListFrame

local TeleportButton = Instance.new("TextButton")
TeleportButton.Name = "TeleportButton"
TeleportButton.Parent = HackContent
TeleportButton.BackgroundColor3 = Color3.fromRGB(0, 0, 150)
TeleportButton.Position = UDim2.new(0, 0, 1, -35)
TeleportButton.Size = UDim2.new(1, 0, 0, 30)
TeleportButton.Font = Enum.Font.SourceSansBold
TeleportButton.Text = "TELEPORT"
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.TextSize = 14

local TeleportCorner = Instance.new("UICorner")
TeleportCorner.CornerRadius = UDim.new(0, 6)
TeleportCorner.Parent = TeleportButton

local TeleportStroke = Instance.new("UIStroke")
TeleportStroke.Parent = TeleportButton
TeleportStroke.Color = Color3.fromRGB(0, 255, 255)

local function updatePlayerList()
    for _, child in pairs(PlayerListFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local count = 0
    for _, p in pairs(Players:GetPlayers()) do
        if isPlayerHiding(p) then
            count = count + 1
            local PButton = Instance.new("TextButton")
            PButton.Size = UDim2.new(1, 0, 0, 25)
            PButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            PButton.Font = Enum.Font.SourceSans
            PButton.Text = p.DisplayName
            PButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            PButton.TextSize = 12
            PButton.Parent = PlayerListFrame

            PButton.MouseButton1Click:Connect(function()
                SelectedPlayer = p
                DropdownButton.Text = p.DisplayName
                PlayerListFrame.Visible = false
            end)
        end
    end
    PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, count * 25)
end

DropdownButton.MouseButton1Click:Connect(function()
    updatePlayerList()
    PlayerListFrame.Visible = not PlayerListFrame.Visible
end)

TeleportButton.MouseButton1Click:Connect(function()
    if SelectedPlayer and SelectedPlayer.Character and SelectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            myChar.HumanoidRootPart.CFrame = SelectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0)
        end
    else
        DropdownButton.Text = "Selecione um Escondido!"
    end
end)

-- =========================================================
-- CRIAÇÃO DA ABA 2: ESPS
-- =========================================================
local EspContent = Instance.new("Frame")
EspContent.Name = "EspContent"
EspContent.Parent = ContentContainer
EspContent.BackgroundTransparency = 1
EspContent.Size = UDim2.new(1, 0, 1, 0)
EspContent.Visible = false

local EspNameEnabled = false
local EspBoxEnabled = false

local EspNameButton = Instance.new("TextButton")
EspNameButton.Name = "EspNameButton"
EspNameButton.Parent = EspContent
EspNameButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
EspNameButton.BackgroundTransparency = 0.2
EspNameButton.Position = UDim2.new(0, 0, 0, 10)
EspNameButton.Size = UDim2.new(1, 0, 0, 35)
EspNameButton.Font = Enum.Font.SourceSansBold
EspNameButton.Text = "ESP Nome: DESLIGADO"
EspNameButton.TextColor3 = Color3.fromRGB(255, 0, 0)
EspNameButton.TextSize = 14
Instance.new("UICorner", EspNameButton).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", EspNameButton).Color = Color3.fromRGB(0, 0, 255)

local EspBoxButton = Instance.new("TextButton")
EspBoxButton.Name = "EspBoxButton"
EspBoxButton.Parent = EspContent
EspBoxButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
EspBoxButton.BackgroundTransparency = 0.2
EspBoxButton.Position = UDim2.new(0, 0, 0, 55)
EspBoxButton.Size = UDim2.new(1, 0, 0, 35)
EspBoxButton.Font = Enum.Font.SourceSansBold
EspBoxButton.Text = "ESP Caixa: DESLIGADO"
EspBoxButton.TextColor3 = Color3.fromRGB(255, 0, 0)
EspBoxButton.TextSize = 14
Instance.new("UICorner", EspBoxButton).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", EspBoxButton).Color = Color3.fromRGB(0, 0, 255)

EspNameButton.MouseButton1Click:Connect(function()
    EspNameEnabled = not EspNameEnabled
    EspNameButton.Text = EspNameEnabled and "ESP Nome: LIGADO" or "ESP Nome: DESLIGADO"
    EspNameButton.TextColor3 = EspNameEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
end)

boxEvent = EspBoxButton.MouseButton1Click:Connect(function()
    boxEnabled = not boxEnabled
    EspBoxEnabled = boxEnabled
    EspBoxButton.Text = EspBoxEnabled and "ESP Caixa: LIGADO" or "ESP Caixa: DESLIGADO"
    EspBoxButton.TextColor3 = EspBoxEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
end)

-- =========================================================
-- CRIAÇÃO DA ABA 3: CRÉDITOS (TEXTO TOTALMENTE EM VERMELHO)
-- =========================================================
local CreditsContent = Instance.new("Frame")
CreditsContent.Name = "CreditsContent"
CreditsContent.Parent = ContentContainer
CreditsContent.BackgroundTransparency = 1
CreditsContent.Size = UDim2.new(1, 0, 1, 0)
CreditsContent.Visible = false

local CreditsLabel = Instance.new("TextLabel")
CreditsLabel.Name = "CreditsLabel"
CreditsLabel.Parent = CreditsContent
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Position = UDim2.new(0, 0, 0, 5)
CreditsLabel.Size = UDim2.new(1, 0, 1, -10)
CreditsLabel.Font = Enum.Font.SourceSansBold
CreditsLabel.Text = "👑 Criadores:\nSilvahxz18 & marquezsGSTZ\n\n🔥 Menu Hub Inteligente\n⚙️ Sistema Avançado V2\n\nObrigado por usar o script!"
CreditsLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
CreditsLabel.TextSize = 13
CreditsLabel.TextWrapped = true
CreditsLabel.TextYAlignment = Enum.TextYAlignment.Top

-- =========================================================
-- CONTROLE DE ATUALIZAÇÃO DO ESP (SISTEMA DINÂMICO)
-- =========================================================
RunService.Heartbeat:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            local char = p.Character
            local hiding = isPlayerHiding(p)

            -- ESP Nome
            local bbg = hrp:FindFirstChild("EspNameGui")
            if EspNameEnabled and hiding then
                if not bbg then
                    bbg = Instance.new("BillboardGui", hrp)
                    bbg.Name = "EspNameGui"
                    bbg.Size = UDim2.new(0, 100, 0, 30)
                    bbg.AlwaysOnTop = true
                    bbg.StudsOffset = Vector3.new(0, 3, 0)

                    local tl = Instance.new("TextLabel", bbg)
                    tl.Size = UDim2.new(1, 0, 1, 0)
                    tl.BackgroundTransparency = 1
                    tl.Text = p.DisplayName
                    tl.TextColor3 = Color3.fromRGB(255, 255, 0)
                    tl.Font = Enum.Font.SourceSansBold
                    tl.TextSize = 14
                end
            else
                if bbg then bbg:Destroy() end
            end

            -- ESP Caixa
            local box = hrp:FindFirstChild("EspBoxAdornment")
            if EspBoxEnabled and hiding then
                if not box then
                    box = Instance.new("BoxHandleAdornment", hrp)
                    box.Name = "EspBoxAdornment"
                    box.Size = char:GetExtentsSize() + Vector3.new(0.5, 0.5, 0.5)
                    box.AlwaysOnTop = true
                    box.ZIndex = 5
                    box.Color3 = Color3.fromRGB(0, 255, 255)
                    box.Transparency = 0.5
                    box.Adornee = char
                end
            else
                if box then box:Destroy() end
            end
        end
    end
end)

-- =========================================================
-- CONFIGURAÇÕES DE NAVEGAÇÃO LATERAL DAS ABAS
-- =========================================================
local HackTabBtn = Instance.new("TextButton", TabContainer)
HackTabBtn.Size = UDim2.new(1, 0, 0, 30)
HackTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
HackTabBtn.Font = Enum.Font.SourceSansBold
HackTabBtn.Text = "Hack"
HackTabBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
HackTabBtn.TextSize = 14
Instance.new("UICorner", HackTabBtn).CornerRadius = UDim.new(0, 6)

local EspTabBtn = Instance.new("TextButton", TabContainer)
EspTabBtn.Size = UDim2.new(1, 0, 0, 30)
EspTabBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
EspTabBtn.Font = Enum.Font.SourceSansBold
EspTabBtn.Text = "ESPs"
EspTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EspTabBtn.TextSize = 14
Instance.new("UICorner", EspTabBtn).CornerRadius = UDim.new(0, 6)

local CreditsTabBtn = Instance.new("TextButton", TabContainer)
CreditsTabBtn.Size = UDim2.new(1, 0, 0, 30)
CreditsTabBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
CreditsTabBtn.Font = Enum.Font.SourceSansBold
CreditsTabBtn.Text = "Créditos"
CreditsTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditsTabBtn.TextSize = 13
Instance.new("UICorner", CreditsTabBtn).CornerRadius = UDim.new(0, 6)

HackTabBtn.MouseButton1Click:Connect(function()
    HackContent.Visible = true; EspContent.Visible = false; CreditsContent.Visible = false
    HackTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); HackTabBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
    EspTabBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15); EspTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CreditsTabBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15); CreditsTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

EspTabBtn.MouseButton1Click:Connect(function()
    HackContent.Visible = false; EspContent.Visible = true; CreditsContent.Visible = false
    EspTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); EspTabBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
    HackTabBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15); HackTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CreditsTabBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15); CreditsTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

CreditsTabBtn.MouseButton1Click:Connect(function()
    HackContent.Visible = false; EspContent.Visible = false; CreditsContent.Visible = true
    CreditsTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); CreditsTabBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
    HackTabBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15); HackTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    EspTabBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15); EspTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

-- =========================================================
-- INTERFACE DE CONTROLE (FECHAR X / BOTÃO REDONDO ARRASTÁVEL)
-- =========================================================
local CloseButton = Instance.new("TextButton", MainFrame)
CloseButton.Name = "CloseButton"
CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.Position = UDim2.new(1, 5, 0, 10)
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextSize = 28
Instance.new("UIStroke", CloseButton).Color = Color3.fromRGB(0, 0, 255)
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 8)

local OpenToggleButton = Instance.new("ImageButton", SilvahxzMenuHub)
OpenToggleButton.Name = "OpenToggleButton"
OpenToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
OpenToggleButton.Position = UDim2.new(0.1, 0, 0.1, 0)
OpenToggleButton.Size = UDim2.new(0, 40, 0, 40)
OpenToggleButton.Image = "rbxassetid://95240563873925"
OpenToggleButton.ScaleType = Enum.ScaleType.Stretch
OpenToggleButton.Visible = false 
Instance.new("UICorner", OpenToggleButton).CornerRadius = UDim.new(
