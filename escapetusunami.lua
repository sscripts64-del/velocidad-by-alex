-- MTX VELOCIDAD | ESTILO COLONIA HUB | FIX VELOCIDAD
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local VELOCIDAD_NORMAL = 16
local velocidadActual = VELOCIDAD_NORMAL

-- FUNCION HUMANOID SEGURA
local function getHumanoid()
	local char = player.Character or player.CharacterAdded:Wait()
	return char:WaitForChild("Humanoid")
end

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player.PlayerGui
ScreenGui.ResetOnSpawn = false

-- BOTÓN FLOTANTE REDONDO
local OpenButton = Instance.new("TextButton")
OpenButton.Parent = ScreenGui
OpenButton.Size = UDim2.new(0, 60, 0, 60)
OpenButton.Position = UDim2.new(0, 20, 0.5, -30)
OpenButton.Text = "MTX"
OpenButton.BackgroundColor3 = Color3.fromRGB(20,20,20)
OpenButton.BackgroundTransparency = 0.15
OpenButton.TextColor3 = Color3.fromRGB(255,255,255)
OpenButton.BorderSizePixel = 0
OpenButton.Font = Enum.Font.GothamBold
OpenButton.TextSize = 18

local BtnCorner = Instance.new("UICorner", OpenButton)
BtnCorner.CornerRadius = UDim.new(1,0)

local BtnStroke = Instance.new("UIStroke", OpenButton)
BtnStroke.Color = Color3.fromRGB(255,0,0)
BtnStroke.Thickness = 1.5

-- FRAME MENU
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 340, 0, 240)
Frame.Position = UDim2.new(0.5, -170, 0.5, -120)
Frame.BackgroundColor3 = Color3.fromRGB(18,18,18)
Frame.BackgroundTransparency = 0.12
Frame.Visible = false
Frame.BorderSizePixel = 0

local FrameCorner = Instance.new("UICorner", Frame)
FrameCorner.CornerRadius = UDim.new(0,18)

local FrameStroke = Instance.new("UIStroke", Frame)
FrameStroke.Color = Color3.fromRGB(255,0,0)
FrameStroke.Thickness = 1.5

-- CREDITOS
local Credit = Instance.new("TextLabel")
Credit.Parent = Frame
Credit.Size = UDim2.new(1,0,0,28)
Credit.Text = "Script by Alex"
Credit.TextColor3 = Color3.fromRGB(255,60,60)
Credit.BackgroundTransparency = 1
Credit.Font = Enum.Font.GothamBold
Credit.TextSize = 16

-- TITULO
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Position = UDim2.new(0,0,0,30)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "MTX Velocidad"
Title.TextColor3 = Color3.fromRGB(230,230,230)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

-- TEXTBOX
local SpeedBox = Instance.new("TextBox")
SpeedBox.Parent = Frame
SpeedBox.Size = UDim2.new(0.8,0,0,38)
SpeedBox.Position = UDim2.new(0.1,0,0.38,0)
SpeedBox.PlaceholderText = "Pon la velocidad (ej: 50)"
SpeedBox.Text = ""
SpeedBox.Font = Enum.Font.Gotham
SpeedBox.TextSize = 16
SpeedBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
SpeedBox.BackgroundTransparency = 0.1
SpeedBox.TextColor3 = Color3.fromRGB(255,255,255)
SpeedBox.BorderSizePixel = 0

local BoxCorner = Instance.new("UICorner", SpeedBox)
BoxCorner.CornerRadius = UDim.new(0,12)

-- BOTÓN APLICAR
local ApplyButton = Instance.new("TextButton")
ApplyButton.Parent = Frame
ApplyButton.Size = UDim2.new(0.8,0,0,36)
ApplyButton.Position = UDim2.new(0.1,0,0.6,0)
ApplyButton.Text = "Aplicar velocidad"
ApplyButton.Font = Enum.Font.GothamBold
ApplyButton.TextSize = 16
ApplyButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
ApplyButton.TextColor3 = Color3.fromRGB(255,255,255)
ApplyButton.BorderSizePixel = 0

local ApplyCorner = Instance.new("UICorner", ApplyButton)
ApplyCorner.CornerRadius = UDim.new(0,12)

-- BOTÓN NORMAL
local NormalButton = Instance.new("TextButton")
NormalButton.Parent = Frame
NormalButton.Size = UDim2.new(0.8,0,0,36)
NormalButton.Position = UDim2.new(0.1,0,0.77,0)
NormalButton.Text = "Velocidad normal"
NormalButton.Font = Enum.Font.GothamBold
NormalButton.TextSize = 15
NormalButton.BackgroundColor3 = Color3.fromRGB(80,0,0)
NormalButton.TextColor3 = Color3.fromRGB(255,255,255)
NormalButton.BorderSizePixel = 0

local NormalCorner = Instance.new("UICorner", NormalButton)
NormalCorner.CornerRadius = UDim.new(0,12)

-- ABRIR / CERRAR
OpenButton.MouseButton1Click:Connect(function()
	Frame.Visible = not Frame.Visible
end)

-- APLICAR VELOCIDAD (ANTI RESET)
ApplyButton.MouseButton1Click:Connect(function()
	local speed = tonumber(SpeedBox.Text)
	if speed and speed > 0 then
		velocidadActual = speed
		local hum = getHumanoid()
		hum.WalkSpeed = speed

		task.spawn(function()
			while velocidadActual ~= VELOCIDAD_NORMAL do
				if hum and hum.Parent then
					hum.WalkSpeed = velocidadActual
				end
				task.wait(0.15)
			end
		end)
	end
end)

-- VOLVER A NORMAL
NormalButton.MouseButton1Click:Connect(function()
	velocidadActual = VELOCIDAD_NORMAL
	local hum = getHumanoid()
	hum.WalkSpeed = VELOCIDAD_NORMAL
end)

-- REAPLICAR AL MORIR
player.CharacterAdded:Connect(function()
	if velocidadActual ~= VELOCIDAD_NORMAL then
		task.wait(0.2)
		local hum = getHumanoid()
		hum.WalkSpeed = velocidadActual
	end
end)
