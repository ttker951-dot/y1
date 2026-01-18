local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

local Whitelist = {
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
    [操你妈] = true,
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
