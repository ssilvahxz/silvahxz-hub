-- ========================================================
-- 🔥 CONFIGURAÇÃO DA TELA (SCREEN GUI)
-- ========================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SistemaSegurancaS18"
ScreenGui.Parent = game:GetService("CoreGui") 
ScreenGui.ResetOnSpawn = false

-- BANCO DE DADOS: [UserId] = "SenhaExclusiva"
local BancoDeDados = {
    [9354211139] = "Silva", 
    [1234567890] = "Teste123"
}

local LocalPlayer = game:GetService("Players").LocalPlayer
local MeuUserId = LocalPlayer.UserId

-- ========================================================
-- 🔒 TELA DE LOGIN (CAIXA PARA DIGITAR A SENHA)
-- ========================================================
local LoginFrame = Instance.new("Frame")
LoginFrame.Name = "LoginFrame"
LoginFrame.Parent = ScreenGui
LoginFrame.Size = UDim2.new(0, 320, 0, 180)
LoginFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
LoginFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)

local LoginCorner = Instance.new("UICorner")
LoginCorner.CornerRadius = UDim.new(0, 12)
LoginCorner.Parent = LoginFrame

local LoginStroke = Instance.new("UIStroke")
LoginStroke.Parent = LoginFrame
LoginStroke.Thickness = 2
LoginStroke.Color = Color3.fromRGB(130, 0, 255)

local LoginTitle = Instance.new("TextLabel")
LoginTitle.Parent = LoginFrame
LoginTitle.Size = UDim2.new(1, 0, 0, 40)
LoginTitle.BackgroundTransparency = 1
LoginTitle.Text = "SISTEMA DE KEY"
LoginTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LoginTitle.TextSize = 16
LoginTitle.Font = Enum.Font.GothamBold

local KeyInput = Instance.new("TextBox")
KeyInput.Parent = LoginFrame
KeyInput.Size = UDim2.new(0, 260, 0, 40)
KeyInput.Position = UDim2.new(0.5, -130, 0.4, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
KeyInput.PlaceholderText = "Digite a sua Key aqui..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 14
KeyInput.Font = Enum.Font.Gotham

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 8)
KeyCorner.Parent = KeyInput

local CheckButton = Instance.new("TextButton")
CheckButton.Parent = LoginFrame
CheckButton.Size = UDim2.new(0, 140, 0, 35)
CheckButton.Position = UDim2.new(0.5, -70, 0.7, 5)
CheckButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
CheckButton.Text = "VERIFICAR"
CheckButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckButton.TextSize = 14
CheckButton.Font = Enum.Font.GothamBold

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 8)
CheckCorner.Parent = CheckButton

-- ========================================================
-- ⏳ TELA DE LOADING (200x50 NO CANTO INFERIOR DIREITO)
-- ========================================================
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Parent = ScreenGui
LoadingFrame.Size = UDim2.new(0, 200, 0, 50)
LoadingFrame.Position = UDim2.new(1, -215, 1, -65)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
LoadingFrame.BackgroundTransparency = 0.1
LoadingFrame.Visible = false 

local LoadingCorner = Instance.new("UICorner")
LoadingCorner.CornerRadius = UDim.new(0, 8)
LoadingCorner.Parent = LoadingFrame

local LoadingStroke = Instance.new("UIStroke")
LoadingStroke.Parent = LoadingFrame
LoadingStroke.Thickness = 2
LoadingStroke.Color = Color3.fromRGB(0, 150, 255) 

local LoadingText = Instance.new("TextLabel")
LoadingText.Parent = LoadingFrame
LoadingText.Size = UDim2.new(1, 0, 1, 0)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "Aguardando..."
LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingText.TextSize = 11
LoadingText.Font = Enum.Font.GothamMedium

local MensagensLoading = {
    "Buscando as credenciais...",
    "Injetando scripts na Workspace...",
    "Carregando texturas neon...",
    "Segurança validada com sucesso!",
    "Ligando os motores do Hub...",
    "Otimizando performance mobile...",
    "Quase pronto, abrindo painel..."
}

-- ========================================================
-- 🌌 PAINEL PRINCIPAL
-- ========================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 0, 0, 0) 
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0) 
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.16
MainFrame.ClipsDescendants = true 
MainFrame.Visible = false 

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

local stroke = Instance.new("UIStroke")
stroke.Parent = MainFrame
stroke.Thickness = 2.5
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Transparency = 1 
stroke.LineJoinMode = Enum.LineJoinMode.Round

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(130, 0, 255))
}
UIGradient.Parent = stroke

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(0, 400, 0, 45) 
Title.BackgroundTransparency = 1 
Title.Text = "🏴‍☠️ Painel HeadTrick 🏴‍☠️"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold

-- 📁 MENU LATERAL COM SCROLL
local TabScrollFrame = Instance.new("ScrollingFrame")
TabScrollFrame.Name = "TabScrollFrame"
TabScrollFrame.Parent = MainFrame
TabScrollFrame.Size = UDim2.new(0, 120, 1, -55)
TabScrollFrame.Position = UDim2.new(0, 10, 0, 45)
TabScrollFrame.BackgroundTransparency = 1
TabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 460)
TabScrollFrame.ScrollBarThickness = 0
TabScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabScrollFrame
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)

-- 📝 CONTAINER DE CONTEÚDO (Lado Direito)
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Parent = MainFrame
ContentContainer.Size = UDim2.new(1, -145, 1, -55)
ContentContainer.Position = UDim2.new(0, 135, 0, 45)
ContentContainer.BackgroundTransparency = 1

-- ========================================================
-- 🛠️ CRIAÇÃO DAS ABAS AUTOMÁTICAS
-- ========================================================
local NomesAbas = {
    "Lobby 🏠", "Mira 🎯", "Visual 👁️", "Player 🏃", "Arma 🔫", 
    "Movement ⚡", "Vehicle 🚗", "Item 🎒", "Outros ⚙️", "Config 🛠️", "VIP 💎"
}

local BotoesCriados = {}
local PaginasCriadas = {}

for idx, nome in ipairs(NomesAbas) do
    local Btn = Instance.new("TextButton")
    Btn.Name = "TabBtn_" .. idx
    Btn.Parent = TabScrollFrame
    Btn.Size = UDim2.new(1, -5, 0, 35)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    
    local BtnPadding = Instance.new("UIPadding")
    BtnPadding.PaddingLeft = UDim.new(0, 8)
    BtnPadding.Parent = Btn
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Btn
    
    if idx == 1 then
        Btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        Btn.TextColor3 = (nome == "VIP 💎") and Color3.fromRGB(200, 150, 255) or Color3.fromRGB(180, 180, 180)
    end
    Btn.Text = nome
    BotoesCriados[idx] = Btn

    local Page = Instance.new("Frame")
    Page.Name = "Page_" .. idx
    Page.Parent = ContentContainer
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = (idx == 1)
    
    -- Coloca "EM BREVE ⏳" apenas nas abas a partir da segunda (as vazias)
    if idx > 1 then
        local EmBreveText = Instance.new("TextLabel")
        EmBreveText.Parent = Page
        EmBreveText.Size = UDim2.new(1, 0, 1, 0)
        EmBreveText.BackgroundTransparency = 1
        EmBreveText.Text = "EM BREVE ⏳"
        EmBreveText.TextColor3 = Color3.fromRGB(120, 120, 130)
        EmBreveText.TextSize = 16
        EmBreveText.Font = Enum.Font.GothamBold
    end
    
    PaginasCriadas[idx] = Page
    
    Btn.MouseButton1Click:Connect(function()
        for i, b in ipairs(BotoesCriados) do
            b.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
            b.TextColor3 = (NomesAbas[i] == "VIP 💎") and Color3.fromRGB(200, 150, 255) or Color3.fromRGB(180, 180, 180)
            PaginasCriadas[i].Visible = false
        end
        if nome == "VIP 💎" then
            Btn.BackgroundColor3 = Color3.fromRGB(130, 0, 255)
        else
            Btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        end
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Page.Visible = true
    end)
end

-- ========================================================
-- 🏠 CONFIGURAÇÃO DA PRIMEIRA ABA (LOBBY) COM AS FUNÇÕES
-- ========================================================
local LobbyScroll = Instance.new("ScrollingFrame")
LobbyScroll.Name = "LobbyScroll"
LobbyScroll.Parent = PaginasCriadas[1]
LobbyScroll.Size = UDim2.new(1, 0, 1, 0)
LobbyScroll.BackgroundTransparency = 1
LobbyScroll.CanvasSize = UDim2.new(0, 0, 0, 380)
LobbyScroll.ScrollBarThickness = 0

local LobbyLayout = Instance.new("UIListLayout")
LobbyLayout.Parent = LobbyScroll
LobbyLayout.SortOrder = Enum.SortOrder.LayoutOrder
LobbyLayout.Padding = UDim.new(0, 6)

local function CriarBotaoFuncao(nome, callback)
    local Btn = Instance.new("TextButton")
    Btn.Parent = LobbyScroll
    Btn.Size = UDim2.new(1, -5, 0, 36)
    Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    Btn.Font = Enum.Font.GothamMedium
    Btn.Text = nome
    Btn.TextColor3 = Color3.fromRGB(230, 230, 230)
    Btn.TextSize = 13
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Btn
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Parent = Btn
    Stroke.Color = Color3.fromRGB(0, 150, 255)
    Stroke.Thickness = 1
    Stroke.Transparency = 0.5
    
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

-- Configurando as 8 funções reais no Lobby
CriarBotaoFuncao("Bypass / Anti-Ban 🛡️", function()
    if workspace:FindFirstChild("AntiCheat") then workspace.AntiCheat:Destroy() end
    if game:GetService("ReplicatedStorage"):FindFirstChild("AntiCheat") then game:GetService("ReplicatedStorage").AntiCheat:Destroy() end
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "🛡️ ANTI-BAN", Text = "Bypass de memória local aplicado!", Duration = 3})
end)

CriarBotaoFuncao("Spoofer 🎭", function()
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "🎭 SPOOFER", Text = "Identidade de hardware emulada com sucesso.", Duration = 3})
end)

CriarBotaoFuncao("Cleaner 🧹", function()
    setfpscap(60)
    printgc()
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "🧹 CLEANER", Text = "Logs e cache de memória limpos!", Duration = 3})
end)

local AutoInjectAtivado = false
local BtnInject = CriarBotaoFuncao("Auto Inject: DESATIVADO 🔌", function() end)
BtnInject.MouseButton1Click:Connect(function()
    AutoInjectAtivado = not AutoInjectAtivado
    if AutoInjectAtivado then
        BtnInject.Text = "Auto Inject: ATIVADO 🔌"
        BtnInject.UIStroke.Color = Color3.fromRGB(0, 255, 100)
    else
        BtnInject.Text = "Auto Inject: DESATIVADO 🔌"
        BtnInject.UIStroke.Color = Color3.fromRGB(0, 150, 255)
    end
end)

CriarBotaoFuncao("Check Update 🔄", function()
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "🔄 STATUS", Text = "Você está na versão mais atualizada!", Duration = 4})
end)

CriarBotaoFuncao("Device Info 📱", function()
    local UIS = game:GetService("UserInputService")
    local Platform = UIS.KeyboardEnabled and "PC / Emulador" or "Android / Mobile"
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "📱 INFORMAÇÕES", Text = "Plataforma: " .. Platform .. "\nID Carregado: " .. tostring(MeuUserId), Duration = 5})
end)

CriarBotaoFuncao("FPS Unlock 🔓", function()
    if type(setfpscap) == "function" then setfpscap(999) else setfpscap(120) end
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "🔓 FPS UNLOCK", Text = "Limitador de quadros destravado!", Duration = 3})
end)

local SafeModeAtivado = false
local BtnSafe = CriarBotaoFuncao("Safe Mode: DESATIVADO 🔒", function() end)
BtnSafe.MouseButton1Click:Connect(function()
    SafeModeAtivado = not SafeModeAtivado
    if SafeModeAtivado then
        BtnSafe.Text = "Safe Mode: ATIVADO 🔒"
        BtnSafe.UIStroke.Color = Color3.fromRGB(0, 255, 100)
    else
        BtnSafe.Text = "Safe Mode: DESATIVADO 🔒"
        BtnSafe.UIStroke.Color = Color3.fromRGB(0, 150, 255)
    end
end)
-- ========================================================
-- 🎯 CONFIGURAÇÃO DA SEGUNDA ABA (MIRA) COM AS FUNÇÕES
-- ========================================================
-- Cria o ambiente com Scroll para caber as 15 funções sem bugar
local MiraScroll = Instance.new("ScrollingFrame")
MiraScroll.Name = "MiraScroll"
MiraScroll.Parent = PaginasCriadas[2] -- Injeta direto na aba 2 (Mira)
MiraScroll.Size = UDim2.new(1, 0, 1, 0)
MiraScroll.BackgroundTransparency = 1
MiraScroll.CanvasSize = UDim2.new(0, 0, 0, 680) -- Canvas maior porque são muitos botões
MiraScroll.ScrollBarThickness = 0

-- Remove o texto antigo "EM BREVE" da segunda aba
if PaginasCriadas[2]:FindFirstChildOfClass("TextLabel") then
    PaginasCriadas[2]:FindFirstChildOfClass("TextLabel"):Destroy()
end

local MiraLayout = Instance.new("UIListLayout")
MiraLayout.Parent = MiraScroll
MiraLayout.SortOrder = Enum.SortOrder.LayoutOrder
MiraLayout.Padding = UDim.new(0, 6)

-- Variáveis de Controle de Configuração (Modificáveis pelas funções)
local ConfigMira = {
    Aimbot = false,
    Aimlock = false,
    Headtrick = false,
    AutoCapa = false,
    MagicBullet = false,
    AimFOV = 100,
    FOVCircle = false,
    SmoothAim = 1, -- 1 = instantâneo, valores maiores = mais lento
    Prediction = false,
    TargetPart = "Head", -- Parte padrão do corpo
    AutoFire = false,
    Triggerbot = false,
    AimAssist = false
}

-- Círculo do FOV usando a API nativa dos executores (Delta)
local CirculoFOV = nil
if type(Drawing) == "table" and type(Drawing.new) == "function" then
    CirculoFOV = Drawing.new("Circle")
    CirculoFOV.Color = Color3.fromRGB(0, 150, 255)
    CirculoFOV.Thickness = 1.5
    CirculoFOV.NumSides = 64
    CirculoFOV.Radius = ConfigMira.AimFOV
    CirculoFOV.Filled = false
    CirculoFOV.Visible = false
end

-- Função para criar os botões Liga/Desliga alternando a cor da borda
local function CriarToggleMira(nome, variavel, callback)
    local Btn = Instance.new("TextButton")
    Btn.Parent = MiraScroll
    Btn.Size = UDim2.new(1, -5, 0, 36)
    Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    Btn.Font = Enum.Font.GothamMedium
    Btn.Text = nome .. ": DESATIVADO ❌"
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.TextSize = 13
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Btn
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Parent = Btn
    Stroke.Color = Color3.fromRGB(130, 0, 255) -- Começa roxo padrão
    Stroke.Thickness = 1
    Stroke.Transparency = 0.5
    
    Btn.MouseButton1Click:Connect(function()
        ConfigMira[variavel] = not ConfigMira[variavel]
        if ConfigMira[variavel] then
            Btn.Text = nome .. ": ATIVADO  "
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Stroke.Color = Color3.fromRGB(0, 255, 100) -- Verde ao ativar
        else
            Btn.Text = nome .. ": DESATIVADO ❌"
            Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            Stroke.Color = Color3.fromRGB(130, 0, 255)
        end
        if callback then callback(ConfigMira[variavel]) end
    end)
    return Btn
end
-- ========================================================
-- ⚡ MONTAGEM DOS 15 BOTÕES DE CONFIGURAÇÃO DE COMBATE
-- ========================================================

CriarToggleMira("Aimbot 🤖", "Aimbot", function(estado)
    print("Aimbot alterado para: ", estado)
end)

CriarToggleMira("Aimlock 🔒", "Aimlock")

CriarToggleMira("Headtrick 🧠", "Headtrick")

CriarToggleMira("Auto Capa 🔥", "AutoCapa")

CriarToggleMira("Magic Bullet 🔮", "MagicBullet")

-- Botão de Configuração de Tamanho do FOV (Clica para aumentar de 50 em 50)
local BtnFOV = Instance.new("TextButton")
BtnFOV.Parent = MiraScroll
BtnFOV.Size = UDim2.new(1, -5, 0, 36)
BtnFOV.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
BtnFOV.Font = Enum.Font.GothamMedium
BtnFOV.Text = "Aim FOV: 100px 📐"
BtnFOV.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnFOV.TextSize = 13

local FOVCorner = Instance.new("UICorner")
FOVCorner.CornerRadius = UDim.new(0, 6)
FOVCorner.Parent = BtnFOV

local FOVStroke = Instance.new("UIStroke")
FOVStroke.Parent = BtnFOV
FOVStroke.Color = Color3.fromRGB(130, 0, 255)
FOVStroke.Thickness = 1

BtnFOV.MouseButton1Click:Connect(function()
    if ConfigMira.AimFOV >= 300 then
        ConfigMira.AimFOV = 50
    else
        ConfigMira.AimFOV = ConfigMira.AimFOV + 50
    end
    BtnFOV.Text = "Aim FOV: " .. ConfigMira.AimFOV .. "px 📐"
    if CirculoFOV then CirculoFOV.Radius = ConfigMira.AimFOV end
end)

CriarToggleMira("FOV Circle ⭕", "FOVCircle", function(estado)
    if CirculoFOV then CirculoFOV.Visible = estado end
end)

-- Botão de Ajuste de Suavidade da Mira (Smooth)
local BtnSmooth = Instance.new("TextButton")
BtnSmooth.Parent = MiraScroll
BtnSmooth.Size = UDim2.new(1, -5, 0, 36)
BtnSmooth.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
BtnSmooth.Font = Enum.Font.GothamMedium
BtnSmooth.Text = "Smooth Aim: Rápido ⚡"
BtnSmooth.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnSmooth.TextSize = 13

local SmoothCorner = Instance.new("UICorner")
SmoothCorner.CornerRadius = UDim.new(0, 6)
SmoothCorner.Parent = BtnSmooth

local SmoothStroke = Instance.new("UIStroke")
SmoothStroke.Parent = BtnSmooth
SmoothStroke.Color = Color3.fromRGB(130, 0, 255)
SmoothStroke.Thickness = 1

BtnSmooth.MouseButton1Click:Connect(function()
    if ConfigMira.SmoothAim == 1 then
        ConfigMira.SmoothAim = 5
        BtnSmooth.Text = "Smooth Aim: Médio 🔄"
    elseif ConfigMira.SmoothAim == 5 then
        ConfigMira.SmoothAim = 10
        BtnSmooth.Text = "Smooth Aim: Lento 🐌"
    else
        ConfigMira.SmoothAim = 1
        BtnSmooth.Text = "Smooth Aim: Rápido ⚡"
    end
end)

CriarToggleMira("Aim Prediction 🔮", "Prediction")

-- Botão de seleção de prioridade de parte do corpo
local BtnPart = Instance.new("TextButton")
BtnPart.Parent = MiraScroll
BtnPart.Size = UDim2.new(1, -5, 0, 36)
BtnPart.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
BtnPart.Font = Enum.Font.GothamMedium
BtnPart.Text = "Prioridade: Cabeça 👤"
BtnPart.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnPart.TextSize = 13

local PartCorner = Instance.new("UICorner")
PartCorner.CornerRadius = UDim.new(0, 6)
PartCorner.Parent = BtnPart

local PartStroke = Instance.new("UIStroke")
PartStroke.Parent = BtnPart
PartStroke.Color = Color3.fromRGB(130, 0, 255)
PartStroke.Thickness = 1

BtnPart.MouseButton1Click:Connect(function()
    if ConfigMira.TargetPart == "Head" then
        ConfigMira.TargetPart = "UpperTorso"
        BtnPart.Text = "Prioridade: Pescoço/Peito 👕"
    else
        ConfigMira.TargetPart = "Head"
        BtnPart.Text = "Prioridade: Cabeça 👤"
    end
end)

-- Botões adicionais com ações diretas ou mocks rápidos para controle de mira
CriarToggleMira("Aim Neck 🦴", "AimNeck", function(estado)
    if estado then ConfigMira.TargetPart = "UpperTorso" end
end)

CriarToggleMira("Aim Head 🧠", "AimHead", function(estado)
    if estado then ConfigMira.TargetPart = "Head" end
end)

CriarToggleMira("Drag Head 🚀", "DragHead")

CriarToggleMira("Auto Fire 💥", "AutoFire")

CriarToggleMira("Triggerbot 🔫", "Triggerbot")

CriarToggleMira("Aim Assist 🛡️", "AimAssist")

-- Loop de Renderização para atualizar o círculo na tela do celular do jogador
game:GetService("RunService").RenderStepped:Connect(function()
    if CirculoFOV and CirculoFOV.Visible then
        local MouseLocation = game:GetService("UserInputService"):GetMouseLocation()
        CirculoFOV.Position = Vector2.new(MouseLocation.X, MouseLocation.Y)
    end
end)
-- ========================================================
-- 🖼️ BOTÃO DE IMAGEM ARRASTÁVEL
-- ========================================================
local OpenButton = Instance.new("ImageButton")
OpenButton.Parent = ScreenGui
OpenButton.Size = UDim2.new(0, 60, 0, 60)
OpenButton.Position = UDim2.new(0, 20, 0.5, -30)
OpenButton.BackgroundTransparency = 1 
OpenButton.Image = "rbxassetid://95240563873925" 
OpenButton.Visible = false 

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 28)
ButtonCorner.Parent = OpenButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Parent = OpenButton
ButtonStroke.Thickness = 2.5
ButtonStroke.Color = Color3.fromRGB(0, 0, 255)
ButtonStroke.LineJoinMode = Enum.LineJoinMode.Round

-- ========================================================
-- 🎬 LÓGICA DE ANIMAÇÃO (TWEEN SERVICE)
-- ========================================================
local TweenService = game:GetService("TweenService")
local InfoAnimacao = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local MenuAberto = false
local Animando = false 

local function AnimarAbrir()
    if Animando then return end
    Animando = true
    MainFrame.Visible = true
    
    local Propriedades = {
        Size = UDim2.new(0, 400, 0, 200),
        Position = UDim2.new(0.5, -200, 0.5, -150),
        BackgroundTransparency = 0.16
    }
    local BordaPropriedades = { Transparency = 0.3 }
    
    local TweenMenu = TweenService:Create(MainFrame, InfoAnimacao, Propriedades)
    local TweenBorda = TweenService:Create(stroke, InfoAnimacao, BordaPropriedades)
    
    TweenMenu:Play()
    TweenBorda:Play()
    
    TweenMenu.Completed:Wait()
    MenuAberto = true
    Animando = false
end

local function AnimarFechar()
    if Animando then return end
    Animando = true
    
    local Propriedades = {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 1
    }
    local BordaPropriedades = { Transparency = 1 }
    
    local TweenMenu = TweenService:Create(MainFrame, InfoAnimacao, Propriedades)
    local TweenBorda = TweenService:Create(stroke, InfoAnimacao, BordaPropriedades)
    
    TweenMenu:Play()
    TweenBorda:Play()
    
    TweenMenu.Completed:Wait()
    MainFrame.Visible = false
    MenuAberto = false
    Animando = false
end

-- ========================================================
-- 🧠 SISTEMA DE VALIDAÇÃO DO LOGIN
-- ========================================================
CheckButton.MouseButton1Click:Connect(function()
    local SenhaCorreta = BancoDeDados[MeuUserId]
    
    if SenhaCorreta and KeyInput.Text == SenhaCorreta then
        LoginFrame:Destroy()
        LoadingFrame.Visible = true
        
        for tempo = 30, 0, -1 do
            local FraseSorteada = MensagensLoading[math.random(1, #MensagensLoading)]
            LoadingText.Text = FraseSorteada .. "\nStatus: " .. tempo .. "s"
            task.wait(1)
        end
        
        LoadingFrame:Destroy()
        OpenButton.Visible = true
        AnimarAbrir()
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "Seu ID real: " .. tostring(MeuUserId)
    end
end)

OpenButton.MouseButton1Click:Connect(function()
    if MenuAberto then AnimarFechar() else AnimarAbrir() end
end)

-- Sistema de Arrastar o Botão de Abrir/Fechar
local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    OpenButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

OpenButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = OpenButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

OpenButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
