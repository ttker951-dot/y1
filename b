local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

-- 白名单配置（已替换 sjqgduf6 的 UserId 为 4868138524，其他玩家需补充真实 UserId）
local TCWhitelist = {
    [4795570573] = true,
    [7051976887] = true,
    [4244796585] = true,
    [5284037699] = true,
    [4534027484] = true,
    [3646293521] = true,
    [10236222759] = true,
    [7268512194] = true,
    [4573641831] = true,
    [6217060028] = true,
    [7341156705] = true,
    [7669881846] = true,
    [4762238870] = true,
    [468306851] = true,
    [2481302326] = true,
    [4465522613] = true,
    [5763975610] = true,
    [10294363973] = true,
    [5200829396] = true,
    [3151188350] = true,
    [7490620102] = true,
    [4050128380] = true,
    [3168391241] = true,
    [7243632960] = true,
    [7868369306] = true,
    [3688239821] = true,
    [6217060028] = true,
    [3286387088] = true,
    [10126292762] = true,
    [4678913012] = true,
    [3532344669] = true,
    [4058885167] = true,
    [5455760265] = true,
    [8984885689] = true,
    [2670929305] = true,
    [4323975492] = true,
    [4652062067] = true,
    [4300030644] = true,
    [6232144829] = true,
    [1576822356] = true,
    [3960035850] = true,
    [5701540628] = true,
    [3237525249] = true,
    [2982479197] = true,
    [3269550863] = true,
    [4415347345] = true,
    [4151735980] = true,
    [3012567309] = true,
    [4825173814] = true,
    [7601136710] = true,
    [10151467189] = true,
    [4544452936] = true,
    [5386779059] = true,
    [5514406404] = true,
    [8333444648] = true,
    [2991800312] = true,
    [1611701218] = true,
    [4193005778] = true,
    [2607973233] = true,
    [3864472242] = true,
    [3806118293] = true,
    [4583375760] = true,
    [4572097845] = true,
    [12333] = true,
    [12333] = true,
    [12333] = true,
    [12333] = true,
    [12333] = true,
    [12333] = true,
    [12333] = true,
    [12333] = true,
    [12333] = true,
    [12333] = true,
    [12333] = true,
    [12333] = true,
    [12333] = true,
    [12333] = true,
    [12333] = true,
    [12333] = true,
}

-- 白名单检测函数（已改为 UserId 校验）
---@param player Player 要检测的玩家对象
---@return boolean 是否在白名单中
local function IsPlayerWhitelisted(player)
    if not typeof(player) == "Instance" or not player:IsA("Player") then
        warn("IsPlayerWhitelisted: 传入的参数不是有效的玩家对象")
        return false
    end
    -- 核心：仅通过不可篡改的 UserId 校验
    return TCWhitelist[player.UserId] or false
end

-- 等待本地玩家加载完成
local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players.PlayerAdded:Wait()
    LocalPlayer = Players.LocalPlayer
end

-- 核心逻辑执行
local isWhitelisted = IsPlayerWhitelisted(LocalPlayer)

if isWhitelisted then
    -- 发送认证通过通知（显示 UserId 方便核对）
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "白名单认证通过",
            Text = string.format("玩家: %s（UserId: %d），已通过校验，正在加载脚本...", LocalPlayer.Name, LocalPlayer.UserId),
            Duration = 7,
        })
    end)
    
    -- 加载远程脚本（强制 HTTPS 防篡改）
    local success, err = pcall(function()
        local scriptUrl = "加载操你妈脚本"
        local remoteScript = game:HttpGet(scriptUrl, true)
        loadstring(remoteScript)()
    end)
    
    if not success then
        warn(string.format("脚本加载失败: %s", err))
        LocalPlayer:Kick("脚本加载失败，请联系作者重试（错误："..err.."）")
    end
else
    -- 非白名单玩家踢出（显示其 UserId 方便核对）
    task.wait(0.5)
    LocalPlayer:Kick(string.format("未在白名单！你的UserId: %d，请联系作者添加", LocalPlayer.UserId))
end
