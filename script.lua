-- [[ CONFIGURAÇÃO DE CHAVES E USERIDS (BANCADA DE CONTROLE) ]]
local ChavesPermitidas = {
    ["Silva"] = 9354211139, -- Key "Silva" vinculada exatamente ao seu UserId
    ["drip_free_882"] = 87654321, 
    ["adm_silva_10"] = 5429183740,
}

-- [[ VERIFICAÇÃO EXCLUSIVA: APENAS ANDROID ]]
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local isAndroid = false
if UserInputService.TouchEnabled and not GuiService:IsTenFootInterface() then
    isAndroid = true
end

if not isAndroid then
    LocalPlayer:Kick("Drip Android: Este script foi feito exclusivamente para dispositivos Android.")
    return
end

-- [[ CONFIGURAÇÃO DA INTERFACE ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DripAndroid_Hub"
ScreenGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Cores = {
    Fundo = Color3.fromRGB(15, 15, 20),
    Texto = Color3.fromRGB(255, 255, 255),
    TextoEscuro = Color3.fromRGB(150, 150, 150),
    Erro = Color3.fromRGB(255, 50, 50),
    Sucesso = Color3.fromRGB(50, 255, 50)
}

-- Criando referências das bordas para o efeito RGB global
local ListaBordasRGB = {}

local function AplicarEstiloBorda(stroke)
    stroke.Thickness = 2
    table.insert(ListaBordasRGB, stroke)
end

-- [[ SISTEMA LOOP RGB NAS BORDAS ]]
task.spawn(function()
    while task.wait() do
        local hue = (tick() % 5) / 5
        local color = Color3.fromHSV(hue, 1, 1)
        for _, stroke in ipairs(ListaBordasRGB) do
            if stroke and stroke.Parent then
                stroke.Color = color
            end
        end
    end
end)

-- [[ 0. TELA DE KEY SYSTEM (APARECE PRIMEIRO) ]]
local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 280, 0, 150)
KeyFrame.Position = UDim2.new(0.5, -140, 0.5, -75)
KeyFrame.BackgroundColor3 = Cores.Fundo
KeyFrame.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 10)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
AplicarEstiloBorda(KeyStroke)
KeyStroke.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 35)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "SISTEMA DE VERIFICAÇÃO"
KeyTitle.TextColor3 = Cores.Texto
KeyTitle.TextSize = 14
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Parent = KeyFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0, 220, 0, 35)
KeyInput.Position = UDim2.new(0.5, -110, 0, 45)
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
KeyInput.Text = ""
KeyInput.PlaceholderText = "Insira sua Key de Acesso..."
KeyInput.TextColor3 = Cores.Texto
KeyInput.TextSize = 12
KeyInput.Font = Enum.Font.Gotham
KeyInput.Parent = KeyFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = KeyInput

local KeyButton = Instance.new("TextButton")
KeyButton.Size = UDim2.new(0, 120, 0, 30)
KeyButton.Position = UDim2.new(0.5, -60, 0, 95)
KeyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
KeyButton.Text = "VERIFICAR"
KeyButton.TextColor3 = Cores.Texto
KeyButton.TextSize = 12
KeyButton.Font = Enum.Font.GothamBold
KeyButton.Parent = KeyFrame

local ButtonKeyCorner = Instance.new("UICorner")
ButtonKeyCorner.CornerRadius = UDim.new(0, 6)
ButtonKeyCorner.Parent = KeyButton

-- Funções estruturais declaradas previamente para o fluxo
local IniciarEstruturaDoScript

-- Lógica de checagem corrigida e limpa (Key + UserId)
KeyButton.MouseButton1Click:Connect(function()
    -- string.gsub remove qualquer espaço ou quebra de linha acidental do teclado mobile
    local chaveDigitada = string.gsub(KeyInput.Text, "%s+", "")
    local meuUserId = LocalPlayer.UserId
    
    if ChavesPermitidas[chaveDigitada] ~= nil then
        if ChavesPermitidas[chaveDigitada] == meuUserId then
            KeyButton.Text = "ACESSO LIBERADO!"
            KeyButton.TextColor3 = Cores.Sucesso
            task.wait(1)
            KeyFrame:Destroy()
            IniciarEstruturaDoScript() -- Dispara o carregamento do painel
        else
            KeyButton.Text = "KEY COMPARTILHADA!"
            KeyButton.TextColor3 = Cores.Erro
            task.wait(1.5)
            KeyButton.Text = "VERIFICAR"
            KeyButton.TextColor3 = Cores.Texto
        end
    else
        KeyButton.Text = "KEY INVÁLIDA!"
        KeyButton.TextColor3 = Cores.Erro
        task.wait(1.5)
        KeyButton.Text = "VERIFICAR"
        KeyButton.TextColor3 = Cores.Texto
    end
end)


-- [[ CONFIGURAÇÃO E ANIMAÇÕES DO PAINEL PRINCIPAL ]]
IniciarEstruturaDoScript = function()

    -- [[ 1. PAINEL PRINCIPAL (300x200) ]]
    local MainPanel = Instance.new("Frame")
    MainPanel.Name = "MainPanel"
    MainPanel.Size = UDim2.new(0, 300, 0, 200)
    MainPanel.Position = UDim2.new(0.5, -150, 0.5, -100)
    MainPanel.BackgroundColor3 = Cores.Fundo
    MainPanel.ClipsDescendants = true
    MainPanel.Visible = false
    MainPanel.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainPanel

    local MainStroke = Instance.new("UIStroke")
    AplicarEstiloBorda(MainStroke)
    MainStroke.Parent = MainPanel

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundTransparency = 1
    Title.Text = "DRIP ANDROID"
    Title.TextColor3 = Cores.Texto
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainPanel
        -- ====================================================================
    -- [[ INÍCIO DO BLOCO DE ABAS: COLA LOGO ABAIXO DE TITLE.PARENT ]]
    -- ====================================================================
    local TabSelectorFrame = Instance.new("ScrollingFrame")
    TabSelectorFrame.Name = "TabSelectorFrame"
    TabSelectorFrame.Size = UDim2.new(0, 90, 1, -45)
    TabSelectorFrame.Position = UDim2.new(0, 5, 0, 40)
    TabSelectorFrame.BackgroundTransparency = 1
    TabSelectorFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabSelectorFrame.ScrollBarThickness = 2
    TabSelectorFrame.ScrollBarImageColor3 = Color3.fromRGB(130, 50, 250)
    TabSelectorFrame.Parent = MainPanel

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Parent = TabSelectorFrame

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -105, 1, -45)
    ContentContainer.Position = UDim2.new(0, 100, 0, 40)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainPanel

    local Divisoria = Instance.new("Frame")
    Divisoria.Size = UDim2.new(0, 1, 1, -45)
    Divisoria.Position = UDim2.new(0, 96, 0, 40)
    Divisoria.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Divisoria.BorderSizePixel = 0
    Divisoria.Parent = MainPanel

    local abasCriadas = {}
    local function CriarAba(nomeAba)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, -4, 0, 30)
        TabButton.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
        TabButton.Text = string.upper(nomeAba)
        TabButton.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabButton.TextSize = 11
        TabButton.Font = Enum.Font.GothamBold
        TabButton.Parent = TabSelectorFrame

        local TabBtnCorner = Instance.new("UICorner")
        TabBtnCorner.CornerRadius = UDim.new(0, 4)
        TabBtnCorner.Parent = TabButton

        local PageFrame = Instance.new("ScrollingFrame")
        PageFrame.Name = nomeAba .. "Page"
        PageFrame.Size = UDim2.new(1, 0, 1, 0)
        PageFrame.BackgroundTransparency = 1
        PageFrame.Visible = false
        PageFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        PageFrame.ScrollBarThickness = 2
        PageFrame.Parent = ContentContainer

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Padding = UDim.new(0, 6)
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Parent = PageFrame

        TabButton.MouseButton1Click:Connect(function()
            for _, aba in ipairs(abasCriadas) do
                aba.Page.Visible = false
                aba.Button.TextColor3 = Color3.fromRGB(150, 150, 150)
                aba.Button.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
            end
            PageFrame.Visible = true
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        end)

        table.insert(abasCriadas, {Button = TabButton, Page = PageFrame})
        TabSelectorFrame.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y)
        
        if #abasCriadas == 1 then
            PageFrame.Visible = true
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        end

        return PageFrame, PageLayout
    end

    -- Criando as abas iniciais do menu
    local PageCombat, LayoutCombat = CriarAba("Combat")
    local PageVisuals, LayoutVisuals = CriarAba("Visuals")

    -- [[ BOTÃO MIRA PERSONALIZADA (DENTRO DA ABA COMBAT) ]]
    local CrosshairEnabled = false
    local CrosshairCenter = nil

    local ToggleCrosshairBtn = Instance.new("TextButton")
    ToggleCrosshairBtn.Size = UDim2.new(1, -5, 0, 32)
    ToggleCrosshairBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    ToggleCrosshairBtn.Text = "MIRA PERSONALIZADA: OFF"
    ToggleCrosshairBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
    ToggleCrosshairBtn.TextSize = 11
    ToggleCrosshairBtn.Font = Enum.Font.GothamBold
    ToggleCrosshairBtn.Parent = PageCombat

    local CrosshairCorner = Instance.new("UICorner")
    CrosshairCorner.CornerRadius = UDim.new(0, 5)
    CrosshairCorner.Parent = ToggleCrosshairBtn

    ToggleCrosshairBtn.MouseButton1Click:Connect(function()
        CrosshairEnabled = not CrosshairEnabled
        if CrosshairEnabled then
            ToggleCrosshairBtn.Text = "MIRA PERSONALIZADA: ON"
            ToggleCrosshairBtn.TextColor3 = Color3.fromRGB(50, 255, 50)
            if not CrosshairCenter then
                CrosshairCenter = Instance.new("ScreenGui")
                CrosshairCenter.Name = "DripCrosshair"
                CrosshairCenter.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")
                
                local LineH = Instance.new("Frame")
                LineH.Size = UDim2.new(0, 16, 0, 2)
                LineH.Position = UDim2.new(0.5, -8, 0.5, -1)
                LineH.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
                LineH.BorderSizePixel = 0
                LineH.Parent = CrosshairCenter
                
                local LineV = Instance.new("Frame")
                LineV.Size = UDim2.new(0, 2, 0, 16)
                LineV.Position = UDim2.new(0.5, -1, 0.5, -8)
                LineV.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
                LineV.BorderSizePixel = 0
                LineV.Parent = CrosshairCenter
            end
        else
            ToggleCrosshairBtn.Text = "MIRA PERSONALIZADA: OFF"
            ToggleCrosshairBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
            if CrosshairCenter then
                CrosshairCenter:Destroy()
                CrosshairCenter = nil
            end
        end
    end)
    PageCombat.CanvasSize = UDim2.new(0, 0, 0, LayoutCombat.AbsoluteContentSize.Y)
    -- ====================================================================
    -- [[ FIM DO BLOCO DE ABAS ]]
    -- ====================================================================

    -- [[ 2. BOTÃO ABRIR / FECHAR (ARRASTÁVEL) ]]
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Size = UDim2.new(0, 55, 0, 55)
    ToggleButton.Position = UDim2.new(0, 20, 0.5, -27)
    ToggleButton.BackgroundColor3 = Cores.Fundo
    ToggleButton.Text = "DRIP"
    ToggleButton.TextColor3 = Cores.Texto
    ToggleButton.TextSize = 12
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Visible = false
    ToggleButton.Parent = ScreenGui

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(1, 0)
    ButtonCorner.Parent = ToggleButton

    local ButtonStroke = Instance.new("UIStroke")
    AplicarEstiloBorda(ButtonStroke)
    ButtonStroke.Parent = ToggleButton

    -- [[ 3. ANIMAÇÃO DE INTRODUÇÃO (ESTILO RAYFIELD) ]]
    local IntroFrame = Instance.new("Frame")
    IntroFrame.Name = "IntroFrame"
    IntroFrame.Size = UDim2.new(0, 1, 0, 3)
    IntroFrame.Position = UDim2.new(0.5, 0, 0.5, -1)
    IntroFrame.BackgroundColor3 = Cores.Fundo
    IntroFrame.ClipsDescendants = true
    IntroFrame.Parent = ScreenGui

    local IntroCorner = Instance.new("UICorner")
    IntroCorner.CornerRadius = UDim.new(0, 8)
    IntroCorner.Parent = IntroFrame

    local IntroStroke = Instance.new("UIStroke")
    AplicarEstiloBorda(IntroStroke)
    IntroStroke.Parent = IntroFrame

    local IntroText = Instance.new("TextLabel")
    IntroText.Size = UDim2.new(1, 0, 1, 0)
    IntroText.BackgroundTransparency = 1
    IntroText.Text = "drip Android iniciando"
    IntroText.TextColor3 = Cores.Texto
    IntroText.TextSize = 18
    IntroText.Font = Enum.Font.GothamBold
    IntroText.TextTransparency = 1
    IntroText.Parent = IntroFrame

    -- [[ 4. SCRIPT DE LOGIN INFERIOR DIREITO ]]
    local LoginFrame = Instance.new("Frame")
    LoginFrame.Name = "LoginFrame"
    LoginFrame.Size = UDim2.new(0, 230, 0, 80)
    LoginFrame.Position = UDim2.new(1, -250, 1, -100)
    LoginFrame.BackgroundColor3 = Cores.Fundo
    LoginFrame.Visible = false
    LoginFrame.Parent = ScreenGui

    local LoginCorner = Instance.new("UICorner")
    LoginCorner.CornerRadius = UDim.new(0, 8)
    LoginCorner.Parent = LoginFrame

    local LoginStroke = Instance.new("UIStroke")
    AplicarEstiloBorda(LoginStroke)
    LoginStroke.Parent = LoginFrame

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(1, -20, 1, -20)
    StatusLabel.Position = UDim2.new(0, 10, 0, 10)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "Aguardando..."
    StatusLabel.TextColor3 = Cores.TextoEscuro
    StatusLabel.TextSize = 13
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextWrapped = true
    StatusLabel.Parent = LoginFrame

    -- [[ LÓGICA DE ARRASTAR O BOTÃO (MOBILE TOUCH) ]]
    local dragging, dragInput, dragStart, startPos
    ToggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = ToggleButton.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    ToggleButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragInput = input
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- [[ CONTROLE DE ABRIR / FECHAR ]]
    ToggleButton.MouseButton1Click:Connect(function()
        MainPanel.Visible = not MainPanel.Visible
        ToggleButton.Text = MainPanel.Visible and "X" or "DRIP"
    end)

    -- [[ EXECUÇÃO DAS ANIMAÇÕES ]]
    local TweenService = game:GetService("TweenService")

    task.spawn(function()
        TweenService:Create(IntroFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 280, 0, 3), Position = UDim2.new(0.5, -140, 0.5, -1)}):Play()
        task.wait(0.6)
        TweenService:Create(IntroFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 280, 0, 60), Position = UDim2.new(0.5, -140, 0.5, -30)}):Play()
        task.wait(0.3)
        TweenService:Create(IntroText, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
        task.wait(2.5)
        TweenService:Create(IntroText, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
        task.wait(0.3)
        TweenService:Create(IntroFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
        task.wait(0.6)
        IntroFrame:Destroy()

        LoginFrame.Visible = true
        
        local mensagens = {
            {tempo = 0, txt = "💧 [DRIP] Inicializando sistema Android..."},
            {tempo = 4, txt = "🛰️ [DRIP] Conectando servidores Delta..."},
            {tempo = 8, txt = "🔐 [DRIP] Ignorando chaves desnecessárias..."},
            {tempo = 12, txt = "📱 [DRIP] Otimizando memória RAM Mobile..."},
            {tempo = 17, txt = "🔥 [DRIP] Aplicando Bypass anti-cheat..."},
            {tempo = 22, txt = "⚡ [DRIP] Carregando interface limpa (300x200)..."},
            {tempo = 26, txt = "🧬 [DRIP] Modificando threads do motor Lua..."},
            {tempo = 30, txt = "✨ [DRIP] Sucesso! Menu liberado."}
        }

        for index, info in ipairs(mensagens) do
            if info.tempo > 0 then
                task.wait(info.tempo - mensagens[index - 1].tempo)
            end
            StatusLabel.Text = info.txt
        end
        
        task.wait(1)
        LoginFrame:Destroy()
        
        ToggleButton.Visible = true
        MainPanel.Visible = true
    end)
end
