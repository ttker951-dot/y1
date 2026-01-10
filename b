local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

-- 白名单配置（已替换 sjqgduf6 的 UserId 为 4868138524，其他玩家需补充真实 UserId）
local TCWhitelist = {
    [7051976887] = true,  --Mas_Yesa
    [4795570573] = true,  --fetter_hh
    [4534027484] = true,
    [3237525249] = true,
    [907094829] = true,
    [5285150391] = true,
    [2624394000] = true,
    [4678913012] = true,
    [5763975610] = true,
    [468306851] = true,
    [2481302326] = true,
    [4868138524] = true,
    [3151188350] = true,
    [4300030644] = true,
    [3265534645] = true,
    [1611701218] = true,
    [3168391241] = true,
    [4478163332] = true,
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
        local scriptUrl = "https://gist.githubusercontent.com/kismile36/94e217b70ec7121c71640c0c7db1fdb4/raw/464f85b2d3439e9144533ef3829803494bdf2730/%25E4%25BA%25BA%25E6%258C%25A4%25E4%25BA%25BA%25E5%258A%25A0%25E5%25AF%2586"
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
