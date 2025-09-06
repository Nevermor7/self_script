-- 初始化全局变量
setSeed = true
enableMouseButton = 4
pressedWaitTimeMin = 40
pressedWaitTimeMax = 60
releasedWaitTimeMin = 300
releasedWaitTimeMax = 500
mouseShot = true
shotKey = "P"
targetMouseButton = 1
EnablePrimaryMouseButtonEvents(true)

function OnEvent(event, arg) 
    if (event == "MOUSE_BUTTON_PRESSED") then
        if (IsModifierPressed("ralt") and IsModifierPressed("rctrl")) then
            if (arg == 2) then
                mouseShot = not mouseShot
            end
        end
        if (setSeed) then
            math.randomseed(generateRandomSeed())
            setSeed = false
        end
        if (arg == enableMouseButton) then 
            repeat
                shotWithSleep()
            until IsKeyLockOn("capslock")
        end
    end
end

function shotWithSleep() 
    pressButtonOrKey()
    Sleep(generateRandomInterval(pressedWaitTimeMin, pressedWaitTimeMax))
    releaseButtonOrKey()
    Sleep(generateRandomInterval(releasedWaitTimeMin, releasedWaitTimeMax))
end

function pressButtonOrKey() 
    if (mouseShot) then 
        PressMouseButton(targetMouseButton)
    else 
        PressKey(shotKey)
    end
end

function releaseButtonOrKey() 
    if (mouseShot) then 
        ReleaseMouseButton(targetMouseButton)
    else 
        ReleaseKey(shotKey)
    end
end

function generateNormalRandom(mean, stdDev) 
    local u = math.random()
    local v = math.random()
    local z = math.sqrt(-2.0 * math.log(u)) * math.cos(2.0 * math.pi * v)
    return math.floor(mean + z * stdDev + 0.5)
end

function generateRandomInterval(m, n) 
    local mean = (m + n) / 2
    local sigma = (n - m) / (2 * 1.645)  -- 1.645 0.9500 1.2815 0.9000
    local generatedRandom = generateNormalRandom(mean, sigma)
    while (generatedRandom < m) do
        generatedRandom = math.random(m, n)
    end
    return generatedRandom
end

function generateRandomSeed() 
    return tostring(math.randomseed() + GetRunningTime()):reverse()
end