local part = Instance.new("Part")
part.Parent = workspace
part.Anchored = true -- Неподвижная часть
part.Size = Vector3.new(0.2, 0.2, 300)
part.Transparency = 0.75
part.Name = "Bullet"
part.Material = Enum.Material.Neon
part.BrickColor = BrickColor.new("Really red")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local head = character:FindFirstChild("Head")

if not head then
    warn("Не удалось найти Head. Используем HumanoidRootPart.")
    head = humanoidRootPart
end

-- Получаем направление взгляда
local function getLookVector()
    local lookVector = humanoidRootPart.CFrame.lookVector
    return lookVector
end

-- Инициализация
local direction = getLookVector()

-- **Ключевой момент:** Смещение вперёд на 150 при создании
part.Position = head.Position + direction * 150
part.CFrame = CFrame.new(part.Position, part.Position + direction * 1) -- Начинаем с нулевой точки перед взглядом

-- **Изменяем CanCollide и добавляем CustomPhysicalProperties**
part.CanCollide = false -- Отключаем столкновения 

-- Добавляем таймер для удаления части
local timer = game:GetService("RunService").Heartbeat:Connect(function(dt)
    local timeElapsed = 0
    
    while timeElapsed < 5 do -- Удаление после 5 секунд
        timeElapsed += dt
        wait()
    end
    
    part:Destroy()
    timer:Disconnect()
end)
