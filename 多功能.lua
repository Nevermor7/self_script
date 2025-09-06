-- 初始化全局变量
-- 需要注意监听函数入参的arg和按键函数的arg数字对应的鼠标按键不一样
setSeed = true -- 记录是否需要初始化随机种子。true为需要，flase为不需要。默认为需要
pressedWaitTimeMin = 35 -- 按下鼠标之后等待时间下限
pressedWaitTimeMax = 50 -- 按下鼠标之后等待时间上限
releasedWaitTimeMin = 15 -- 松开鼠标之后等待时间下限
releasedWaitTimeMax = 25 -- 松开鼠标之后等待时间上限
mouseShot = true -- 是否鼠标左键开火，若为否则游戏内改建，默认键盘开火
shotKey = "E" -- 键盘开火键，默认字母P
reloadKey = "R" -- 换弹键，默认字母R
switchGunKey = "Q" -- 切枪键，默认字母Q
backButton = 4  -- 炼狱功能键，默认鼠标后退侧键
forwardButton = 5  -- 身法功能键，默认鼠标前进侧键
prepareCount = 7  -- 炼狱开火预热需要的开火次数
count = -prepareCount   -- 开火计数
magazineNum = 320  -- 单个弹夹子弹数
EnablePrimaryMouseButtonEvents(true) -- 启用鼠标左键监测事件

-- 鼠标事件监听入口
function OnEvent(event, arg) 
    if (event == "MOUSE_BUTTON_PRESSED") then 
        -- 开关开启时需要进行初始化一次随机种子。
        if (setSeed) then 
            -- 初始化随机种子（注意：罗技lua不支持os.time()，这里自定义了一个generateRandomSeed()方法生成随机种子）
            math.randomseed(generateRandomSeed())
            setSeed = false
        end
        -- 鼠标中键：切换鼠标开火和键盘开火
        if (arg == 3) then 
            mouseShot = not mouseShot
        end
        -- 鼠标右键
        if (arg == 2) then 
            -- 1.按住lshift或lalt+点击右键执行一次瞬狙带切枪
            if IsModifierPressed("lshift") or IsModifierPressed("lalt") then 
                flash_sniper()
            end
        end
        -- 后退侧键
        if (arg == backButton) then 
            -- 1.按住lalt+按住后退侧键执行快速刺刀直到打开大写锁
            if IsModifierPressed("lalt") then 
                repeat
                    flash_bayonet()
                until not IsMouseButtonPressed(backButton)
            elseif IsModifierPressed("lshift") then 
                -- 2.按住lshift+点击后退侧键执行有间隔的连点方法直到打开大写锁
                repeat
                    shotWithSleep()
                    -- count = count + 1
                    -- if (count > magazineNum) then 
                    --     flash_reload()
                    --     count = -prepareCount
                    -- end
                until IsKeyLockOn("capslock")
            else 
                -- 3.按住了后退侧键执行有间隔的连点方法直到松开
                repeat
                    shotWithSleep()
                until not IsMouseButtonPressed(backButton)
            end
        end
        -- 前进侧键
        if (arg == forwardButton) then 
            if IsModifierPressed("lshift") then 
                -- 1.按住lshift+点击前进侧键执行光速按w直到松开
                repeat
                    flash_w()
                until not IsMouseButtonPressed(forwardButton)
            elseif IsModifierPressed("lctrl") then 
                -- 2.按住lctrl+点击前进侧键执行光速空格直到松开
                repeat
                    ghost_jump()
                until not IsMouseButtonPressed(forwardButton)
            else 
                -- 3.按住前进侧键执行光速闪蹲直到松开
                repeat 
                    flash_squat()
                until not IsMouseButtonPressed(forwardButton)
            end
        end
    end
end

-- 瞬狙
function flash_sniper() 
    PressMouseButton(3)
    Sleep(generateRandomInterval(pressedWaitTimeMin, pressedWaitTimeMax))
    ReleaseMouseButton(3)
    Sleep(generateRandomInterval(releasedWaitTimeMin, releasedWaitTimeMax))
    pressButtonOrKey()
    Sleep(generateRandomInterval(pressedWaitTimeMin, pressedWaitTimeMax))
    releaseButtonOrKey()
    Sleep(generateRandomInterval(releasedWaitTimeMin, releasedWaitTimeMax))
    PressKey(switchGunKey)
    Sleep(generateRandomInterval(pressedWaitTimeMin, pressedWaitTimeMax))
    ReleaseKey(switchGunKey)
    Sleep(generateRandomInterval(releasedWaitTimeMin, releasedWaitTimeMax))
    PressKey(switchGunKey)
    Sleep(generateRandomInterval(pressedWaitTimeMin, pressedWaitTimeMax))
    ReleaseKey(switchGunKey)
end

-- 炼狱快速换弹
function flash_reload() 
    PressKey(reloadKey)
    Sleep(generateRandomInterval(20, 30))
    ReleaseKey(reloadKey)
    Sleep(generateRandomInterval(2100, 2200))
    PressMouseButton(3)
    Sleep(generateRandomInterval(25, 40))
    ReleaseMouseButton(3)
    Sleep(generateRandomInterval(25, 40))
    pressButtonOrKey()
    Sleep(generateRandomInterval(25, 40))
    releaseButtonOrKey()
end

-- 有间隔地开火方法
function shotWithSleep() 
    pressButtonOrKey()
    Sleep(generateRandomInterval(pressedWaitTimeMin, pressedWaitTimeMax))
    releaseButtonOrKey()
    Sleep(generateRandomInterval(releasedWaitTimeMin, releasedWaitTimeMax))
end

-- 炼狱快速刺刀
function flash_bayonet() 
    PressMouseButton(3)
    Sleep(generateRandomInterval(25, 40))
    ReleaseMouseButton(3)
    Sleep(generateRandomInterval(235, 250))
    pressButtonOrKey()
    Sleep(generateRandomInterval(25, 40))
    releaseButtonOrKey()
    Sleep(generateRandomInterval(10, 20))
end

-- 快速按w，碎步
function flash_w()                                                                      
    PressKey("w")
    Sleep(generateRandomInterval(15, 25))
    ReleaseKey("w")
    Sleep(generateRandomInterval(15, 25))
end

-- 快速按空格，按下蹲键触发自动鬼跳
function ghost_jump() 
    PressKey("spacebar")
    Sleep(generateRandomInterval(15, 25))
    ReleaseKey("spacebar")
    Sleep(generateRandomInterval(15, 25))
end

-- 跳蹲蹲
function jump_squat_squat() 
    PressKey("spacebar")
    Sleep(generateRandomInterval(164, 172))
    ReleaseKey("spacebar")
    Sleep(generateRandomInterval(30, 40))
    PressKey("lctrl")                                                                                                                                                                                                                        
    Sleep(generateRandomInterval(10, 20))
    ReleaseKey("lctrl")
    Sleep(generateRandomInterval(10, 20))
    PressKey("lctrl")
    Sleep(generateRandomInterval(100, 200))
    ReleaseKey("lctrl")
end

-- 无限闪蹲
function flash_squat() 
    PressKey("lctrl")
    Sleep(generateRandomInterval(15, 25))
    ReleaseKey("lctrl")
    Sleep(generateRandomInterval(15, 25))
end

-- 按下开火键
function pressButtonOrKey() 
    if (mouseShot) then 
        PressMouseButton(1)
    else 
        PressKey(shotKey)
    end
end

-- 松开开火键
function releaseButtonOrKey() 
    if (mouseShot) then 
        ReleaseMouseButton(1)
    else 
        ReleaseKey(shotKey)
    end
end

-- 按住开火键直到打开大写锁
function keepShot() 
    pressButtonOrKey()
    repeat
        Sleep(200)
    until IsKeyLockOn("capslock")
    releaseButtonOrKey()
end

-- 生成均值为mean，方差为stdDev的正态分布随机数函数（使用Box-Muller变换）
function generateNormalRandom(mean, stdDev) 
    -- 生成两个均匀分布的随机数（0到1之间）
    local u = math.random()
    local v = math.random()
    -- 使用Box-Muller变换转换成正态分布随机数
    local z = math.sqrt(-2.0 * math.log(u)) * math.cos(2.0 * math.pi * v)
    -- 使用均值和标准差进行线性变换
    return math.floor(mean + z * stdDev + 0.5)
end

-- 生成指定范围内满足正态分布的随机数(95.00%概率不超过n，且不小于m)
function generateRandomInterval(m, n) 
    local mean = (m + n) / 2
    local sigma = (n - m) / (2 * 1.645)  -- 1.645 0.9500 1.2815 0.9000
    local generatedRandom = generateNormalRandom(mean, sigma)
    while (generatedRandom < m) do
        generatedRandom = math.random(m, n)
    end
    return generatedRandom
end

-- 通过math.randomseed()函数获取当前系统时间时间戳，GetRunningTime()函数获取脚本运行时间。两个值相加，以最大化避免多人使用该宏时使用相同的随机种子
function generateRandomSeed() 
    return tostring(math.randomseed() + GetRunningTime()):reverse() -- GetRunningTime()：获取当前脚本的运行时间
end