local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- ========================================================================
-- CONFIGURAÇÃO DE KEYS POR USERID
-- ========================================================================
local listaDeKeys = {
    [9354211139] = "123", -- Sua key atual para testes
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
ScreenGui.Name = "SistemaKey_Silvahxz_RGB_Fix"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Janela Principal de Login (Centralizada)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 180)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
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

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "SISTEMA DE VERIFICAÇÃO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

-- Campo de Texto (Input da Key)
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0, 260, 0, 40)
TextBox.Position = UDim2.new(0.5, -130, 0.4, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "Insira sua Key aqui..."
TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 14
TextBox.Text = ""
TextBox.Parent = MainFrame

local UICornerBox = Instance.new("UICorner")
UICornerBox.CornerRadius = UDim.new(0, 6)
UICornerBox.Parent = TextBox

-- [2] FORÇANDO A BORDA RGB NO INPUT
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
VerifyBtn.Position = UDim2.new(0.5, -130, 0.7, 5)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.Text = "VERIFICAR"
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.TextSize = 14
VerifyBtn.Parent = MainFrame

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(0, 6)
UICornerBtn.Parent = VerifyBtn

-- [3] FORÇANDO A BORDA RGB NO BOTÃO
local BtnUIStroke = Instance.new("UIStroke")
BtnUIStroke.Thickness = 2
BtnUIStroke.Color = Color3.fromRGB(255, 255, 255)
BtnUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
BtnUIStroke.Parent = VerifyBtn

local BtnGradient = Instance.new("UIGradient")
BtnGradient.Parent = BtnUIStroke

-- Indicador de Login (Canto Inferior Direito)
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

-- [4] FORÇANDO A BORDA RGB NO LOGIN
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

-- Barra de progresso RGB no login
local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 0, 0, 3)
ProgressBar.Position = UDim2.new(0, 0, 1, -3)
ProgressBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = LoginFrame

local ProgressGradient = Instance.new("UIGradient")
ProgressGradient.Parent = ProgressBar

-- ========================================================================
-- ANIMAÇÃO RGB FORÇADA (ATUALIZAÇÃO DE COR COMPATÍVEL COM DELTA)
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
        
        -- Atualização direta
        MainGradient.Color = sequence
        BoxGradient.Color = sequence
        BtnGradient.Color = sequence
        LoginGradient.Color = sequence
        ProgressGradient.Color = sequence
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
