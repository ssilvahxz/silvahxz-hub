local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- ========================================================================
-- CONFIGURAÇÃO DE EXIBIÇÃO DE PERFIL POR USERID
-- ========================================================================
local listaDePerfis = {
    [9354211139] = true, -- Coloque o UserId aqui como 'true' para o perfil APARECER
    [12345678] = true,
}

-- ========================================================================
-- CONFIGURAÇÃO DO STATUS VIP POR USERID
-- ========================================================================
local listaDeVips = {
    [9354211139] = "Possui VIP", 
    [12345678] = "Não Possui VIP",
}

-- ========================================================================
-- CONFIGURAÇÃO DE KEYS POR USERID
-- ========================================================================
local listaDeKeys = {
    [9354211139] = "123", 
    [12345678] = "KEY_EXEMPLO_2",
}

-- ========================================================================
-- MENSAGENS EXIBIDAS DURANTE O LOGIN
-- ========================================================================
local mensagensDeLogin = {
    "Estabelecendo conexão segura...",
    "Validando seu UserId com o servidor...",
    "Bypassando sistemas locais...",
    "Carregando tabelas de renderização...",
    "Sincronizando API LunarielLovely...",
    "Injetando módulos na memória...",
    "Limpando rastros de logs antigos...",
    "Otimizando threads de execução...",
    "Verificando integridade...",
    "Pronto! Inicializando ambiente..."
}

-- ========================================================================
-- CRIAÇÃO DA INTERFACE (UI)
-- ========================================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SistemaKey_Silvahxz_RGB_Perfil_Fixo"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Verifica se o jogador atual deve mostrar o perfil
local mostrarPerfil = listaDePerfis[player.UserId] or false

-- Janela Principal de Login (Aumentada a largura para acomodar o perfil se ativo)
local MainFrame = Instance.new("Frame")
MainFrame.Size = mostrarPerfil and UDim2.new(0, 420, 0, 200) or UDim2.new(0, 320, 0, 200)
MainFrame.Position = mostrarPerfil and UDim2.new(0.5, -210, 0.5, -100) or UDim2.new(0.5, -160, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.15
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- [1] FORÇANDO A BORDA RGB NO MAINFRAME
local MainUIStroke = Instance.new("UIStroke")
MainUIStroke.Thickness = 2.5
MainUIStroke.Color = Color3.fromRGB(255, 255, 255)
MainUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainUIStroke.Parent = MainFrame

local MainGradient = Instance.new("UIGradient")
MainGradient.Parent = MainUIStroke

-- Container dos Elementos da Direita
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = mostrarPerfil and UDim2.new(0, 300, 1, 0) or UDim2.new(1, 0, 1, 0)
ContentFrame.Position = mostrarPerfil and UDim2.new(0, 110, 0, 0) or UDim2.new(0, 0, 0, 0)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "SISTEMA DE VERIFICAÇÃO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = ContentFrame

-- INDICADOR DE STATUS VIP
local VipStatusLabel = Instance.new("TextLabel")
VipStatusLabel.Size = UDim2.new(1, 0, 0, 20)
VipStatusLabel.Position = UDim2.new(0, 0, 0, 35)
VipStatusLabel.BackgroundTransparency = 1
VipStatusLabel.Font = Enum.Font.GothamSemibold
VipStatusLabel.TextSize = 13
VipStatusLabel.Parent = ContentFrame

local statusAtual = listaDeVips[player.UserId] or "Não Possui VIP"
VipStatusLabel.Text = "Status: " .. statusAtual
VipStatusLabel.TextColor3 = (statusAtual == "Possui VIP") and Color3.fromRGB(0, 255, 130) or Color3.fromRGB(255, 80, 80)

-- Campo de Texto (Input da Key)
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0, 260, 0, 40)
TextBox.Position = UDim2.new(0.5, -130, 0.45, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "Insira sua Key aqui..."
TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 14
TextBox.Text = ""
TextBox.Parent = ContentFrame

local UICornerBox = Instance.new("UICorner")
UICornerBox.CornerRadius = UDim.new(0, 6)
UICornerBox.Parent = TextBox

local BoxUIStroke = Instance.new("UIStroke")
BoxUIStroke.Thickness = 1.5
BoxUIStroke.Color = Color3.fromRGB(255, 255, 255)
BoxUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
BoxUIStroke.Parent = TextBox

local BoxGradient = Instance.new("UIGradient")
BoxGradient.Parent = BoxUIStroke

-- Botão Verificar
local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0, 260, 0, 40)
VerifyBtn.Position = UDim2.new(0.5, -130, 0.72, 5)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.Text = "VERIFICAR"
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.TextSize = 14
VerifyBtn.Parent = ContentFrame

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(0, 6)
UICornerBtn.Parent = VerifyBtn

local BtnUIStroke = Instance.new("UIStroke")
BtnUIStroke.Thickness = 2
BtnUIStroke.Color = Color3.fromRGB(255, 255, 255)
BtnUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
BtnUIStroke.Parent = VerifyBtn

local BtnGradient = Instance.new("UIGradient")
BtnGradient.Parent = BtnUIStroke

-- ========================================================================
-- NOVO MÉTODO COMPATÍVEL COM DELTA PARA FOTO DE PERFIL
-- ========================================================================
local ProfileGradient = nil
if mostrarPerfil then
    local ProfileFrame = Instance.new("ImageLabel")
    ProfileFrame.Size = UDim2.new(0, 80, 0, 80)
    ProfileFrame.Position = UDim2.new(0, 15, 0.5, -40)
    ProfileFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    
    -- Método rbxthumb: Muito mais rápido e nunca falha em executores mobile
    ProfileFrame.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(player.UserId) .. "&w=150&h=150"
    ProfileFrame.Parent = MainFrame
    
    local UICornerProfile = Instance.new("UICorner")
    UICornerProfile.CornerRadius = UDim.new(1, 0) -- Redondo perfeito
    UICornerProfile.Parent = ProfileFrame
    
    -- Borda RGB no Perfil
    local ProfileUIStroke = Instance.new("UIStroke")
    ProfileUIStroke.Thickness = 2
    ProfileUIStroke.Color = Color3.fromRGB(255, 255, 255)
    ProfileUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    ProfileUIStroke.Parent = ProfileFrame
    
    ProfileGradient = Instance.new("UIGradient")
    ProfileGradient.Parent = ProfileUIStroke
end

-- ========================================================================
-- INDICADOR DE LOGIN (CANTO INFERIOR DIREITO)
-- ========================================================================
local LoginFrame = Instance.new("Frame")
LoginFrame.Size = UDim2.new(0, 260, 0, 65)
LoginFrame.Position = UDim2.new(1, -280, 1, -85)
LoginFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
LoginFrame.BackgroundTransparency = 0.15
LoginFrame.Visible = false
LoginFrame.Parent = ScreenGui

local UICornerLogin = Instance.new("UICorner")
UICornerLogin.CornerRadius = UDim.new(0, 8)
UICornerLogin.Parent = LoginFrame

local LoginUIStroke = Instance.new("UIStroke")
LoginUIStroke.Thickness = 2
LoginUIStroke.Color = Color3.fromRGB(255, 255, 255)
LoginUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
LoginUIStroke.Parent = LoginFrame

local LoginGradient = Instance.new("UIGradient")
LoginGradient.Parent = LoginUIStroke

local LoginText = Instance.new("TextLabel")
LoginText.Size = UDim2.new(1, -20, 1, -10)
LoginText.Position = UDim2.new(0, 10, 0, 2)
LoginText.BackgroundTransparency = 1
LoginText.Text = "Pronto para conectar..."
LoginText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoginText.TextXAlignment = Enum.TextXAlignment.Left
LoginText.Font = Enum.Font.GothamSemibold
LoginText.TextSize = 12
LoginText.TextWrapped = true
LoginText.Parent = LoginFrame

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 0, 0, 3)
ProgressBar.Position = UDim2.new(0, 0, 1, -3)
ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = LoginFrame

local ProgressGradient = Instance.new("UIGradient")
ProgressGradient.Parent = ProgressBar

-- ========================================================================
-- ANIMAÇÃO RGB FORÇADA
-- ========================================================================
local function IniciarCicloRGB()
    local t = 0
    RunService.RenderStepped:Connect(function(dt)
        t = t + dt * 0.4
        local c1 = Color3.fromHSV(t % 1, 1, 1)
        local c2 = Color3.fromHSV((t + 0.33) % 1, 1, 1)
        local c3 = Color3.fromHSV((t + 0.66) % 1, 1, 1)
        
        local sequence = ColorSequence.new({
            ColorSequenceKeypoint.new(0, c1),
            ColorSequenceKeypoint.new(0.5, c2),
            ColorSequenceKeypoint.new(1, c3)
        })
        
        MainGradient.Color = sequence
        BoxGradient.Color = sequence
        BtnGradient.Color = sequence
        LoginGradient.Color = sequence
        ProgressGradient.Color = sequence
        if ProfileGradient then ProfileGradient.Color = sequence end
    end)
end

task.spawn(IniciarCicloRGB)

-- ========================================================================
-- LÓGICA DE VERIFICAÇÃO E CONTAGEM
-- ========================================================================
VerifyBtn.MouseButton1Click:Connect(function()
    local keyInserida = TextBox.Text
    local userIdAtual = player.UserId
    
    if listaDeKeys[userIdAtual] and listaDeKeys[userIdAtual] == keyInserida then
        MainFrame.Visible = false
        LoginFrame.Visible = true
        
        local tweenInfo = TweenInfo.new(60, Enum.EasingStyle.Linear)
        TweenService:Create(ProgressBar, tweenInfo, {Size = UDim2.new(1, 0, 0, 3)}):Play()
        
        for i = 60, 1, -1 do
            local indexMensagem = math.clamp(math.ceil((61 - i) / 6), 1, #mensagensDeLogin)
            local textoAtual = mensagensDeLogin[indexMensagem]
            
            LoginText.Text = textoAtual .. "\n[Tempo restante: " .. i .. "s]"
            task.wait(1)
        end
        
        LoginText.Text = "Iniciando Script..."
        task.wait(0.5)
        
        ScreenGui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LunarielLovely/Scripts/refs/heads/main/SpeedDraw"))()
    else
        VerifyBtn.Text = "KEY INVÁLIDA OU INCORRETA!"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
        task.wait(2)
        VerifyBtn.Text = "VERIFICAR"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    end
end)
