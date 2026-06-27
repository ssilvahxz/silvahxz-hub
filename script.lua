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

    -- [[ SISTEMA DE ROLAGEM DE ABAS LADO ESQUERDO ]]
    local TabSelectorFrame = Instance.new("ScrollingFrame")
    TabSelectorFrame.Name = "TabSelectorFrame"
    TabSelectorFrame.Size = UDim2.new(0, 70, 1, -45)
    TabSelectorFrame.Position = UDim2.new(0, 5, 0, 40)
    TabSelectorFrame.BackgroundTransparency = 1
    TabSelectorFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabSelectorFrame.ScrollBarThickness = 2
    TabSelectorFrame.ScrollBarImageColor3 = Color3.fromRGB(130, 50, 250)
    TabSelectorFrame.Parent = MainPanel

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabListLayout.Parent = TabSelectorFrame

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -85, 1, -45)
    ContentContainer.Position = UDim2.new(0, 80, 0, 40)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainPanel

    local Divisoria = Instance.new("Frame")
    Divisoria.Size = UDim2.new(0, 1, 1, -45)
    Divisoria.Position = UDim2.new(0, 76, 0, 40)
    Divisoria.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Divisoria.BorderSizePixel = 0
    Divisoria.Parent = MainPanel

    local abasCriadas = {}
    local function CriarAbaEmoji(nomeAba, emoji)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 45, 0, 45)
        TabButton.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
        TabButton.Text = emoji
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 20
        TabButton.Font = Enum.Font.GothamBold
        TabButton.Parent = TabSelectorFrame

        local TabBtnCorner = Instance.new("UICorner")
        TabBtnCorner.CornerRadius = UDim.new(0, 8)
        TabBtnCorner.Parent = TabButton

        local TabBtnStroke = Instance.new("UIStroke")
        TabBtnStroke.Thickness = 1
        TabBtnStroke.Color = Color3.fromRGB(45, 45, 55)
        TabBtnStroke.Parent = TabButton

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
                aba.Button.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
                aba.Stroke.Color = Color3.fromRGB(45, 45, 55)
            end
            PageFrame.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            TabBtnStroke.Color = Color3.fromRGB(0, 255, 255)
        end)

        table.insert(abasCriadas, {Button = TabButton, Page = PageFrame, Stroke = TabBtnStroke})
        TabSelectorFrame.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y)
        
        if #abasCriadas == 1 then
            PageFrame.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            TabBtnStroke.Color = Color3.fromRGB(0, 255, 255)
        end

        return PageFrame, PageLayout
    end

    -- [[ CRIAÇÃO DAS ABAS COM EMOJI ]]
    local PageMira, LayoutMira = CriarAbaEmoji("MiraTab", "🎯")
    local PageVisuais, LayoutVisuais = CriarAbaEmoji("VisuaisTab", "👁️")

    -- ====================================================================
    -- [[ ESTRUTURAS DO CHEAT DE MIRA (🎯) ]]
    -- ====================================================================
    local Camera = workspace.CurrentCamera
    local RunService = game:GetService("RunService")
    
    local Checats = {
        Aimbot = false, Aimlock = false, Headtrick = false, AutoCapa = false, MagicBullet = false,
        AimFOV = false, FOVCircle = false, SmoothAim = false, AimPrediction = false,
        AimTarget = "Head", DragHead = false, AutoFire = false, Triggerbot = false, AimAssist = false,
        
        -- Configurações da Aba de Visuais (👁️)
        Wallhack = false, EnemyESP = false, BoxESP = false, LineESP = false, SkeletonESP = false,
        NameESP = false, DistanceESP = false, HealthESP = false, LootESP = false, VehicleESP = false,
        Warning360 = false, RadarHack = false, MiniMapESP = false
    }
    local FOV_Raio = 100
    local Smooth_Valor = 0.1

    local DesenhoFOV = Instance.new("Frame")
    DesenhoFOV.Size = UDim2.new(0, FOV_Raio * 2, 0, FOV_Raio * 2)
    DesenhoFOV.BackgroundTransparency = 1
    DesenhoFOV.Visible = false
    DesenhoFOV.Parent = ScreenGui
    
    local FOVStroke = Instance.new("UIStroke")
    FOVStroke.Thickness = 1
    FOVStroke.Color = Color3.fromRGB(255, 0, 0)
    FOVStroke.Parent = DesenhoFOV
    
    local FOVCorner = Instance.new("UICorner")
    FOVCorner.CornerRadius = UDim.new(1, 0)
    FOVCorner.Parent = DesenhoFOV

    local function CriarCheatToggle(nomeExibicao, configChave, pagina)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1, -6, 0, 30)
        Btn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
        Btn.Text = nomeExibicao .. " : OFF"
        Btn.TextColor3 = Cores.Erro
        Btn.Font = Enum.Font.GothamBold
        Btn.TextSize = 10
        Btn.Parent = pagina

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 4)
        Corner.Parent = Btn

        Btn.MouseButton1Click:Connect(function()
            Checats[configChave] = not Checats[configChave]
            if Checats[configChave] then
                Btn.Text = nomeExibicao .. " : ON"
                Btn.TextColor3 = Cores.Sucesso
                Btn.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
            else
                Btn.Text = nomeExibicao .. " : OFF"
                Btn.TextColor3 = Cores.Erro
                Btn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
            end
            if configChave == "FOVCircle" then DesenhoFOV.Visible = Checats.FOVCircle end
        end)
    end

    -- Injetando Botões na Aba da Mira
    CriarCheatToggle("AIMBOT MASTER", "Aimbot", PageMira)
    CriarCheatToggle("AIMLOCK HARD", "Aimlock", PageMira)
    CriarCheatToggle("HEADTRICK 100%", "Headtrick", PageMira)
    CriarCheatToggle("AUTO CAPA AUTOMATICO", "AutoCapa", PageMira)
    CriarCheatToggle("MAGIC BULLET (PROJETIL)", "MagicBullet", PageMira)
    CriarCheatToggle("USAR AIM FOV LOCK", "AimFOV", PageMira)
    CriarCheatToggle("EXIBIR FOV CIRCLE", "FOVCircle", PageMira)
    CriarCheatToggle("SMOOTH AIM (SUAVE)", "SmoothAim", PageMira)
    CriarCheatToggle("AIM PREDICTION (ALVO)", "AimPrediction", PageMira)
    CriarCheatToggle("MIRAR NO PESCOCO (NECK)", "AimNeck", PageMira)
    CriarCheatToggle("MIRAR NA CABECA (HEAD)", "AimHead", PageMira)
    CriarCheatToggle("DRAG HEAD (PUXADA)", "DragHead", PageMira)
    CriarCheatToggle("AUTO FIRE (TIRO AUTOMATICO)", "AutoFire", PageMira)
    CriarCheatToggle("TRIGGERBOT INSTANTANEO", "Triggerbot", PageMira)
    CriarCheatToggle("AIM ASSIST (ASSISTENCIA)", "AimAssist", PageMira)

    -- [[ INJEÇÃO DE TODAS AS 13 FUNÇÕES NA ABA DE VISUAIS (👁️) ]]
    CriarCheatToggle("WALLHACK (CHAMS)", "Wallhack", PageVisuais)
    CriarCheatToggle("ENEMY ESP (TRACK)", "EnemyESP", PageVisuais)
    CriarCheatToggle("BOX ESP (CAIXA)", "BoxESP", PageVisuais)
    CriarCheatToggle("LINE ESP (LINHAS)", "LineESP", PageVisuais)
    CriarCheatToggle("SKELETON ESP", "SkeletonESP", PageVisuais)
    CriarCheatToggle("NAME ESP (NOME)", "NameESP", PageVisuais)
    CriarCheatToggle("DISTANCE ESP (METROS)", "DistanceESP", PageVisuais)
    CriarCheatToggle("HEALTH ESP (VIDA)", "HealthESP", PageVisuais)
    CriarCheatToggle("LOOT ESP (ITEMS)", "LootESP", PageVisuais)
    CriarCheatToggle("VEHICLE ESP (CARROS)", "VehicleESP", PageVisuais)
    CriarCheatToggle("ALERTA 360° APURADO", "Warning360", PageVisuais)
    CriarCheatToggle("RADAR HACK CENTRAL", "RadarHack", PageVisuais)
    CriarCheatToggle("MINI MAP ESP PLANO", "MiniMapESP", PageVisuais)

    -- UI Extra para Warning 360 e Radar Hack instalados na tela principal
    local Alerta360Label = Instance.new("TextLabel")
    Alerta360Label.Size = UDim2.new(0, 200, 0, 25)
    Alerta360Label.Position = UDim2.new(0.5, -100, 0.2, 0)
    Alerta360Label.BackgroundTransparency = 1
    Alerta360Label.Text = "⚠️ INIMIGO PROXIMO!"
    Alerta360Label.TextColor3 = Color3.fromRGB(255, 50, 50)
    Alerta360Label.Font = Enum.Font.GothamBold
    Alerta360Label.TextSize = 14
    Alerta360Label.Visible = false
    Alerta360Label.Parent = ScreenGui

    local RadarFrame = Instance.new("Frame")
    RadarFrame.Size = UDim2.new(0, 80, 0, 80)
    RadarFrame.Position = UDim2.new(0, 10, 1, -170)
    RadarFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    RadarFrame.BackgroundTransparency = 0.3
    RadarFrame.Visible = false
    RadarFrame.Parent = ScreenGui
    local RadarCorner = Instance.new("UICorner") RadarCorner.CornerRadius = UDim.new(1,0) RadarCorner.Parent = RadarFrame
    local RadarStroke = Instance.new("UIStroke") RadarStroke.Color = Color3.fromRGB(0,255,255) RadarStroke.Parent = RadarFrame

    -- [[ ENGENHARIA DE MATEMÁTICA BALÍSTICA E RENDER LOOP ]]
    local function ObterInimigoMaisProximo()
        local AlvoFinal = nil
        local MenorDistanciaPista = math.huge
        local CentroTela = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                local Hrp = player.Character.HumanoidRootPart
                local PosicaoTela, NaTela = Camera:WorldToViewportPoint(Hrp.Position)
                
                if NaTela or not Checats.AimFOV then
                    local DistanciaPixel = (Vector2.new(PosicaoTela.X, PosicaoTela.Y) - CentroTela).Magnitude
                    if not Checats.AimFOV or DistanciaPixel <= FOV_Raio then
                        if DistanciaPixel < MenorDistanciaPista then
                            MenorDistanciaPista = DistanciaPixel
                            AlvoFinal = player.Character
                        end
                    end
                end
            end
        end
        return AlvoFinal
    end

    -- Sistema de Renderização do ESP Otimizado para Evitar Mem Leak
    local CacheESP = {}
    local function GerarEstruturaESP(player)
        if CacheESP[player] then return end
        local Estrutura = {}

        local BbGui = Instance.new("BillboardGui")
        BbGui.AlwaysOnTop = true
        BbGui.Size = UDim2.new(0, 150, 0, 50)
        BbGui.StudsOffset = Vector3.new(0, 3, 0)
        
        local InfoText = Instance.new("TextLabel")
        InfoText.Size = UDim2.new(1, 0, 1, 0)
        InfoText.BackgroundTransparency = 1
        InfoText.TextColor3 = Color3.fromRGB(255, 255, 255)
        InfoText.Font = Enum.Font.GothamBold
        InfoText.TextSize = 9
        InfoText.Text = ""
        InfoText.Parent = BbGui
        Estrutura.TextLabel = InfoText
        Estrutura.Billboard = BbGui

        local Highlight = Instance.new("Highlight")
        Highlight.FillColor = Color3.fromRGB(130, 50, 250)
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        Highlight.FillTransparency = 0.5
        Highlight.OutlineTransparency = 0
        Estrutura.Chams = Highlight

        local Line = Instance.new("Frame")
        Line.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        Line.BorderSizePixel = 0
        Line.AnchorPoint = Vector2.new(0.5, 0.5)
        Line.Visible = false
        Line.Parent = ScreenGui
        Estrutura.SnapLine = Line

        local Box = Instance.new("Frame")
        Box.BackgroundTransparency = 1
        Box.Visible = false
        Box.Parent = ScreenGui
        local BoxStroke = Instance.new("UIStroke") BoxStroke.Color = Color3.fromRGB(255, 255, 0) BoxStroke.Thickness = 1 BoxStroke.Parent = Box
        Estrutura.BoxFrame = Box

        local PontoRadar = Instance.new("Frame")
        PontoRadar.Size = UDim2.new(0, 4, 0, 4)
        PontoRadar.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        PontoRadar.Visible = false
        PontoRadar.Parent = RadarFrame
        local PrCorner = Instance.new("UICorner") PrCorner.CornerRadius = UDim.new(1,0) PrCorner.Parent = PontoRadar
        Estrutura.RadarBlip = PontoRadar

        CacheESP[player] = Estrutura
    end

    Players.PlayerRemoving:Connect(function(player)
        if CacheESP[player] then
            pcall(function()
                CacheESP[player].Billboard:Destroy()
                CacheESP[player].Chams:Destroy()
                CacheESP[player].SnapLine:Destroy()
                CacheESP[player].BoxFrame:Destroy()
                CacheESP[player].RadarBlip:Destroy()
            end)
            CacheESP[player] = nil
        end
    end)

    -- Monitoramento e atualização contínua do motor matemático de combate e Visuais
    RunService.RenderStepped:Connect(function()
        if Checats.FOVCircle then
            DesenhoFOV.Position = UDim2.new(0, (Camera.ViewportSize.X / 2) - FOV_Raio, 0, (Camera.ViewportSize.Y / 2) - FOV_Raio)
        end

        local Alvo = ObterInimigoMaisProximo()
        if Alvo then
            local MembroFocal = "Head"
            if Checats.AimNeck then MembroFocal = "UpperTorso" or "Torso" end
            if Checats.AimHead or Checats.Headtrick or Checats.AutoCapa then MembroFocal = "Head" end

            local ParteAlvo = Alvo:FindFirstChild(MembroFocal)
            if ParteAlvo then
                local PosicaoFinalMundo = ParteAlvo.Position

                if Checats.AimPrediction and Alvo:FindFirstChild("HumanoidRootPart") then
                    PosicaoFinalMundo = PosicaoFinalMundo + (Alvo.HumanoidRootPart.Velocity * 0.165)
                end

         
