-- =============================================================================
-- 🔥 Silvahxz18 MENU 🔥
-- =============================================================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local MarketPlaceService = game:GetService("MarketplaceService")
local LocalPlayer = Players.LocalPlayer

-- Pegar informações do Jogo Atual
local PlaceName = "Jogo Desconhecido"
pcall(function()
    local productInfo = MarketPlaceService:GetProductInfo(game.PlaceId)
    PlaceName = productInfo.Name
end)

-- Criação da Interface Principal
local SilvahxzGui = Instance.new("ScreenGui")
SilvahxzGui.Name = "Silvahxz18Menu"
SilvahxzGui.ResetOnSpawn = false
pcall(function() SilvahxzGui.Parent = CoreGui end)
if not SilvahxzGui.Parent then SilvahxzGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- =============================================================================
-- WIDGET DE CARREGAMENTO / LOGIN (40 SEGUNDOS)
-- =============================================================================
local LoginFrame = Instance.new("Frame")
LoginFrame.Size = UDim2.new(0, 220, 0, 75)
LoginFrame.Position = UDim2.new(1, -230, 1, -85) -- Canto inferior direito
LoginFrame.BackgroundColor3 = Color3.fromRGB(15, 11, 25)
LoginFrame.BackgroundTransparency = 0.2
LoginFrame.BorderSizePixel = 0
LoginFrame.Parent = SilvahxzGui

local LoginCorner = Instance.new("UICorner")
LoginCorner.CornerRadius = UDim.new(0, 8)
LoginCorner.Parent = LoginFrame

-- Borda RGB para o Carregamento
local LoginStroke = Instance.new("UIStroke")
LoginStroke.Thickness = 2
LoginStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
LoginStroke.Parent = LoginFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 35)
StatusLabel.Position = UDim2.new(0, 10, 0, 8)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Iniciando Silvahxz18..."
StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
StatusLabel.Font = Enum.Font.Code
StatusLabel.TextSize = 11
StatusLabel.TextWrapped = true
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = LoginFrame

-- Barrinha de Progresso (Fundo)
local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(1, -20, 0, 5)
BarBg.Position = UDim2.new(0, 10, 1, -15)
BarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
BarBg.BorderSizePixel = 0
BarBg.Parent = LoginFrame

local BarBgCorner = Instance.new("UICorner")
BarBgCorner.CornerRadius = UDim.new(0, 3)
BarBgCorner.Parent = BarBg

-- Barrinha de Progresso (Preenchimento)
local BarProg = Instance.new("Frame")
BarProg.Size = UDim2.new(0, 0, 1, 0)
BarProg.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
BarProg.BorderSizePixel = 0
BarProg.Parent = BarBg

local BarProgCorner = Instance.new("UICorner")
BarProgCorner.CornerRadius = UDim.new(0, 3)
BarProgCorner.Parent = BarProg

-- Sistema de Mensagens Dinâmicas (Totalizando 40 segundos)
local logs = {
    {time = 0, msg = "⚡ Conectando à rede Silvahxz18..."},
    {time = 5, msg = "🔍 Verificando credenciais do Delta..."},
    {time = 10, msg = "👤 Identificando Usuário: " .. LocalPlayer.Name},
    {time = 16, msg = "🛡️ Injetando scripts de segurança..."},
    {time = 22, msg = "📊 Carregando APIs de perfil do Roblox..."},
    {time = 28, msg = "⚙️ Configurando Anti-AFK no servidor..."},
    {time = 34, msg = "🎨 Renderizando design Neon Azul e Roxo..."},
    {time = 39, msg = "🚀 Pronto! Abrindo Silvahxz18 Menu..."}
}

-- Efeito RGB na Borda do Login
local rgbConnection
rgbConnection = RunService.RenderStepped:Connect(function()
    local hue = (tick() % 5) / 5
    local color = Color3.fromHSV(hue, 1, 1)
    LoginStroke.Color = color
end)

-- Execução do Carregamento (40s exatos)
task.spawn(function()
    local tweenInfo = TweenInfo.new(40, Enum.EasingStyle.Linear)
    local barTween = TweenService:Create(BarProg, tweenInfo, {Size = UDim2.new(1, 0, 1, 0)})
    barTween:Play()

    for _, log in ipairs(logs) do
        StatusLabel.Text = log.msg
        task.wait(5)
    end
    
    rgbConnection:Disconnect()
    LoginFrame:Destroy()
    
    -- =============================================================================
    -- PAINEL PRINCIPAL PERSONALIZADO SILVAHXZ18 (SÓ ABRE DEPOIS DO LOGIN)
    -- =============================================================================
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 400, 0, 280)
    MainFrame.Position = UDim2.new(1, -420, 1, -300) -- Canto inferior direito (Fixo)
    MainFrame.BackgroundColor3 = Color3.fromRGB(13, 10, 22)
    MainFrame.BackgroundTransparency = 0.15 -- Efeito de transparência premium
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = true
    MainFrame.Parent = SilvahxzGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame

    -- Borda RGB Infinita para o Painel Principal
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Thickness = 2.5
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MainStroke.Parent = MainFrame
    
    RunService.RenderStepped:Connect(function()
        local hue = (tick() % 6) / 6
        MainStroke.Color = Color3.fromHSV(hue, 0.8, 1)
    end)

    -- Título Superior do Menu
    local MenuTitle = Instance.new("TextLabel")
    MenuTitle.Size = UDim2.new(1, 0, 0, 35)
    MenuTitle.BackgroundTransparency = 1
    MenuTitle.Text = "🔥 SILVAHXZ18 MENU 🔥"
    MenuTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    MenuTitle.Font = Enum.Font.GothamBold
    MenuTitle.TextSize = 16
    MenuTitle.Parent = MainFrame

    -- Container das Abas (Navegação Superior)
    local TabContainer = Instance.new("Frame")
    TabContainer.Size = UDim2.new(1, -20, 0, 30)
    TabContainer.Position = UDim2.new(0, 10, 0, 35)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = MainFrame

    local TabPerfilBtn = Instance.new("TextButton")
    TabPerfilBtn.Size = UDim2.new(0, 185, 1, 0)
    TabPerfilBtn.BackgroundColor3 = Color3.fromRGB(110, 0, 255) -- Roxo
    TabPerfilBtn.Text = "👤 Perfil"
    TabPerfilBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabPerfilBtn.Font = Enum.Font.GothamBold
    TabPerfilBtn.TextSize = 13
    TabPerfilBtn.Parent = TabContainer
    Instance.new("UICorner", TabPerfilBtn).CornerRadius = UDim.new(0, 6)

    local TabServidorBtn = Instance.new("TextButton")
    TabServidorBtn.Size = UDim2.new(0, 185, 1, 0)
    TabServidorBtn.Position = UDim2.new(1, -185, 0, 0)
    TabServidorBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
    TabServidorBtn.Text = "🌐 Servidor"
    TabServidorBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    TabServidorBtn.Font = Enum.Font.GothamBold
    TabServidorBtn.TextSize = 13
    TabServidorBtn.Parent = TabContainer
    Instance.new("UICorner", TabServidorBtn).CornerRadius = UDim.new(0, 6)

    -- Páginas de Conteúdo
    local ContentPage = Instance.new("Frame")
    ContentPage.Size = UDim2.new(1, -20, 1, -85)
    ContentPage.Position = UDim2.new(0, 10, 0, 75)
    ContentPage.BackgroundTransparency = 1
    ContentPage.Parent = MainFrame

    -- =============================================================================
    -- ABA 1: PERFIL (PRIMEIRA ABA)
    -- =============================================================================
    local PerfilPage = Instance.new("Frame")
    PerfilPage.Size = UDim2.new(1, 0, 1, 0)
    PerfilPage.BackgroundTransparency = 1
    PerfilPage.Visible = true
    PerfilPage.Parent = ContentPage

    -- Foto de Perfil Redonda
    local AvatarImg = Instance.new("ImageLabel")
    AvatarImg.Size = UDim2.new(0, 70, 0, 70)
    AvatarImg.Position = UDim2.new(0, 15, 0, 15)
    AvatarImg.BackgroundColor3 = Color3.fromRGB(30, 25, 50)
    AvatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
    AvatarImg.Parent = PerfilPage
    
    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(1, 0) -- Deixa redondo
    AvatarCorner.Parent = AvatarImg

    -- Informações de Texto do Usuário
    local UserInfo = Instance.new("TextLabel")
    UserInfo.Size = UDim2.new(1, -110, 1, -30)
    UserInfo.Position = UDim2.new(0, 100, 0, 15)
    UserInfo.BackgroundTransparency = 1
    UserInfo.Text = "<b>Nome:</b> " .. LocalPlayer.DisplayName .. "\n\n<b>User:</b> @" .. LocalPlayer.Name .. "\n\n<b>ID:</b> " .. LocalPlayer.UserId .. "\n\n<b>Jogando:</b> <font color='rgb(0,180,255)'>" .. PlaceName .. "</font>"
    UserInfo.TextColor3 = Color3.fromRGB(230, 230, 230)
    UserInfo.Font = Enum.Font.Gotham
    UserInfo.TextSize = 12
    UserInfo.RichText = true
    UserInfo.TextXAlignment = Enum.TextXAlignment.Left
    UserInfo.TextYAlignment = Enum.TextYAlignment.Top
    UserInfo.Parent = PerfilPage

    -- =============================================================================
    -- ABA 2: SERVIDOR (SEGUNDA ABA)
    -- =============================================================================
    local ServidorPage = Instance.new("Frame")
    ServidorPage.Size = UDim2.new(1, 0, 1, 0)
    ServidorPage.BackgroundTransparency = 1
    ServidorPage.Visible = false
    ServidorPage.Parent = ContentPage

    -- Estilização do Botão Toggle Anti-AFK
    local ToggleBg = Instance.new("TextButton")
    ToggleBg.Size = UDim2.new(1, -20, 0, 45)
    ToggleBg.Position = UDim2.new(0, 10, 0, 15)
    ToggleBg.BackgroundColor3 = Color3.fromRGB(22, 17, 35)
    ToggleBg.Text = "    Anti-AFK"
    ToggleBg.TextColor3 = Color3.fromRGB(240, 240, 240)
    ToggleBg.Font = Enum.Font.GothamBold
    ToggleBg.TextSize = 14
    ToggleBg.TextXAlignment = Enum.TextXAlignment.Left
    ToggleBg.Parent = ServidorPage
    Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(0, 8)

    local ToggleIndicator = Instance.new("Frame")
    ToggleIndicator.Size = UDim2.new(0, 50, 0, 24)
    ToggleIndicator.Position = UDim2.new(1, -65, 0.5, -12)
    ToggleIndicator.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleIndicator.Parent = ToggleBg
    Instance.new("UICorner", ToggleIndicator).CornerRadius = UDim.new(1, 0)

    local ToggleBall = Instance.new("Frame")
    ToggleBall.Size = UDim2.new(0, 18, 0, 18)
    ToggleBall.Position = UDim2.new(0, 4, 0.5, -9)
    ToggleBall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBall.Parent = ToggleIndicator
    Instance.new("UICorner", ToggleBall).CornerRadius = UDim.new(1, 0)

    -- Lógica de Notificação do Sistema
    local function MostrarMensagem(titulo, mensagem, cor)
        local Notification = Instance.new("Frame")
        Notification.Size = UDim2.new(0, 250, 0, 60)
        Notification.Position = UDim2.new(1, 20, 0, 20) -- Começa fora da tela
        Notification.BackgroundColor3 = Color3.fromRGB(15, 12, 28)
        Notification.Parent = SilvahxzGui
        Instance.new("UICorner", Notification).CornerRadius = UDim.new(0, 8)
        
        local Stroke = Instance.new("UIStroke")
        Stroke.Thickness = 1.5
        Stroke.Color = cor
        Stroke.Parent = Notification

        local Txt1 = Instance.new("TextLabel")
        Txt1.Size = UDim2.new(1, -20, 0, 25)
        Txt1.Position = UDim2.new(0, 10, 0, 5)
        Txt1.BackgroundTransparency = 1
        Txt1.Text = titulo
        Txt1.TextColor3 = cor
        Txt1.Font = Enum.Font.GothamBold
        Txt1.TextSize = 13
        Txt1.TextXAlignment = Enum.TextXAlignment.Left
        Txt1.Parent = Notification

        local Txt2 = Instance.new("TextLabel")
        Txt2.Size = UDim2.new(1, -20, 0, 25)
        Txt2.Position = UDim2.new(0, 10, 0, 25)
        Txt2.BackgroundTransparency = 1
        Txt2.Text = mensagem
        Txt2.TextColor3 = Color3.fromRGB(200, 200, 200)
        Txt2.Font = Enum.Font.Gotham
        Txt2.TextSize = 11
        Txt2.TextXAlignment = Enum.TextXAlignment.Left
        Txt2.Parent = Notification

        -- Animar entrada
        TweenService:Create(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Position = UDim2.new(1, -270, 0, 20)}):Play()
        task.wait(3.5)
        -- Animar saída e deletar
        local out = TweenService:Create(Notification, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Position = UDim2.new(1, 20, 0, 20)})
        out:Play()
        out.Completed:Connect(function() Notification:Destroy() end)
    end

    -- Mecânica de funcionamento do Anti-AFK
    local AntiAFKEnabled = false
    local VirtualUser = game:GetService("VirtualUser")

    LocalPlayer.Idled:Connect(function()
        if AntiAFKEnabled then
            VirtualUser:Button2Down(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
        end
    end)

    -- Ativação do Clique no Toggle do Anti-AFK
    ToggleBg.MouseButton1Click:Connect(function()
        AntiAFKEnabled = not AntiAFKEnabled
        if AntiAFKEnabled then
            TweenService:Create(ToggleIndicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 180, 255)}):Play() -- Azul Neon
            TweenService:Create(ToggleBall, TweenInfo.new(0.2), {Position = UDim2.new(1, -22, 0.5, -9)}):Play()
            task.spawn(function()
                MostrarMensagem("[SISTEMA]", "Anti-AFK Ativado com sucesso!", Color3.fromRGB(0, 180, 255))
            end)
        else
            TweenService:Create(ToggleIndicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
            TweenService:Create(ToggleBall, TweenInfo.new(0.2), {Position = UDim2.new(0, 4, 0.5, -9)}):Play()
            task.spawn(function()
                MostrarMensagem("[SISTEMA]", "Anti-AFK Desativado no painel.", Color3.fromRGB(255, 50, 50))
            end)
        end
    end)

    -- Alternância Gráfica entre as Abas
    TabPerfilBtn.MouseButton1Click:Connect(function()
        PerfilPage.Visible = true
        ServidorPage.Visible = false
        TabPerfilBtn.BackgroundColor3 = Color3.fromRGB(110, 0, 255)
        TabPerfilBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabServidorBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
        TabServidorBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    end)

    TabServidorBtn.MouseButton1Click:Connect(function()
        PerfilPage.Visible = false
        ServidorPage.Visible = true
        TabServidorBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 255) -- Azul Neon ao selecionar
        TabServidorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabPerfilBtn.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
        TabPerfilBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    end)

    -- =============================================================================
    -- BOTÃO TOGGLE (ABRIR / FECHAR MENU) - TOTALMENTE ARRASTÁVEL
    -- =============================================================================
    local OpenCloseBtn = Instance.new("TextButton")
    OpenCloseBtn.Size = UDim2.new(0, 55, 0, 55)
    OpenCloseBtn.Position = UDim2.new(0, 20, 0.4, 0) -- Começa no lado esquerdo da tela
    OpenCloseBtn.BackgroundColor3 = Color3.fromRGB(15, 11, 25)
    OpenCloseBtn.Text = "S18"
    OpenCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenCloseBtn.Font = Enum.Font.GothamBold
    OpenCloseBtn.TextSize = 14
    OpenCloseBtn.Parent = SilvahxzGui

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(1, 0) -- Totalmente redondo
    BtnCorner.Parent = OpenCloseBtn

    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Thickness = 2
    BtnStroke.Parent = OpenCloseBtn
    
    RunService.RenderStepped:Connect(function()
        local hue = (tick() % 4) / 4
        BtnStroke.Color = Color3.fromHSV(hue, 1, 1)
    end)

    -- Ação de Abrir e Fechar o Painel Principal
    OpenCloseBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- Script de Arrastar com suavidade dedicado APENAS ao botão de Abrir/Fechar
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        local targetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        TweenService:Create(OpenCloseBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPos}):Play()
    end

    OpenCloseBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = OpenCloseBtn.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)

    OpenCloseBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then update(input) end
    end)
end)
