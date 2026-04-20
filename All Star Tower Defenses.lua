if not game:IsLoaded() then game.Loaded:Wait() end
if game.GameId ~= 1720936166 then return end
local benchmark_time = os.clock()

-- Helper Functions
local function Split(s, delimiter)
    local result = {}
    for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end
    return result
end

local function StringToCFrame(input)
    return CFrame.new(unpack(game:GetService("HttpService"):JSONDecode("[" ..input .."]")))
end

local function ShallowCopy(original)
    local copy = {}
    for key, value in pairs(original) do copy[key] = value end
    return copy
end

local function DeepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then v = DeepCopy(v) end
        copy[k] = v
    end
    return copy
end

local function TableLength(t)
    local n = 0

    for _ in pairs(t) do n = n + 1 end

    return n
end

local function TableConcat(t1, t2)
    for i = 1, #t2 do t1[#t1 + 1] = t2[i] end
    return t1
end

local function get_keys(t)
    local keys = {}
    for key, _ in pairs(t) do table.insert(keys, key) end
    return keys
end

local postfixes = {
    ["n"] = 10 ^ (-6),
    ["m"] = 10 ^ (-3),
    ["k"] = 10 ^ 3,
    ["M"] = 10 ^ 6,
    ["G"] = 10 ^ 9
}

local function convert(n)
    local postfix = n:sub(-1)
    if postfixes[postfix] then
        return tonumber(n:sub(1, -2)) * postfixes[postfix]
    elseif tonumber(n) then
        return tonumber(n)
    else
        error("invalid postfix")
    end
end

-- https://devforum.roblox.com/t/comparing-color-values/1017439/2
local function CompareColor3(base, toCompare)
    local base_colors = {base.R, base.G, base.B} -- table to hold the original color3s
    local comp_colors = {toCompare.R, toCompare.G, toCompare.B} -- table to 

    local verdict = {} -- table to hold whether other not each of them were the same

    for index, col in ipairs(comp_colors) do -- uses an "ipairs" loop instead of "pairs" loop because this is numerical
        if base_colors[index] == col then -- checks if the index of the base_colors table is the same
            table.insert(verdict, true) -- add 1 true value to the verdict table
        else
            table.insert(verdict, false) -- add 1 false value to the verdict table
        end
    end

    if table.find(verdict, false) then -- if one of them is false then it isn't the same
        return false -- returns false
    else
        return true -- returns true
    end
end


local Settings
local Macros = {}

benchmark_time = os.clock()

if not isfolder("CREATKING") then makefolder("CREATKING") end

if not isfolder("CREATKING\\ASTD") then makefolder("CREATKING\\ASTD") end

if not isfolder("CREATKING\\ASTD\\Settings") then
    makefolder("CREATKING\\ASTD\\Settings")
end



local InfiniteMapTable = {
    ["-1"] = "Regular [1]",
    ["-1.7"] = "Regular [2]",
    ["-1.1"] = "Category",
    ["-1.3"] = "Air",
    ["-1.8"] = "Solo",
    ["-1.9"] = "Random Unit",
    ["-1.5"] = "Double Path",
    ["-97"] = "Gauntlet",
    ["-98"] = "Training",
    ["-99"] = "Farm"
}

local AdventureMapTable = {
    ["-13"] = "String Raid",
    ["-1003"] = "Sijin Raid",
    ["-1004"] = "Spirit Raid",
    ["-1111"] = "Marine HQ",
    ["-1112"] = "Kai Planet",
    ["-1113"] = "Hell",
    ["-1114"] = "Machi Planet",
    ["-1117"] = "Candy Raid",
    ["-1118"] = "Demon Mark Raid",
    ["-1121"] = "Soul Raid",
    ["-1122"] = "Sun Raid",
    ["-1125"] = "Meteor Raid",
    ["-1127"] = "Berserker Raid",
    ["-1128"] = "Venom Raid",
    ["-1129"] = "Dueled Raid",
    ["-1132"] = "Hunt On Blacksmith",
    ["-1133"] = "Mythical Freedom",
    ["-1134"] = "Bizare Prison",
    ["-1136"] = "Six Eyes Raid",
    ["-1142"] = "TOP1",
    ["-1143"] = "TOP2",
    ["-1144"] = "TOP3",
    ["-1145"] = "TOP4",
    ["-1146"] = "TOP5",
    ["-1147"] = "TOP6",
    ["-1155"] = "Demon Raid M2",
    ["-1156"] = "Divine Raid",
    ["-1450"] = "Random Boss Rush",
    ["-1451"] = "Random Boss Rush 2",
    ["-1506"] = "Path Raid",
    ["-1550"] = "Enuma Raid",
    ["-1168"] = "Demon Memory Raid",
    ["-1167"] = "Ocean Memory Raid",
    ["-1166"] = "Earth Tournament Memory Raid",
    ["-1165"] = "Purple Planet Raid",
    ["-1164"] = "Darkness Raid",
    ["-1163"] = "Malevolent Raid",
    ["-1162"] = "Crystal Cavern Raid"
}

local function GetMapsFromTable(T)
    local maps = {}
    for _, v in pairs(T) do table.insert(maps, v) end
    return maps
end

local SettingsFile = "CREATKING\\ASTD\\Settings\\" ..game.Players.LocalPlayer.UserId .. ".json"
local Compkiller = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/CompKiller/refs/heads/main/src/source.luau"))();

local Notifier = Compkiller.newNotify();

local ConfigManager = Compkiller:ConfigManager({
	Directory = "Compkiller-UI",
	Config = "Example-Configs"
});
Compkiller:Loader("rbxassetid://120245531583106" , 1).yield();

local MainSettings = {
    Auto_Buff = true,
    Auto_Buff_Units = {
        ["Erwin"] = {
            ["Mode"] = "Box",
            ["Checks"] = {"attack"},
            ["Ability Type"] = "Normal",
            ["Time"] = 13
        },
        ["Merlin"] = {
            ["Mode"] = "Pair",
            ["Checks"] = {"range"},
            ["Ability Type"] = "Normal",
            ["Time"] = 30
        },
        ["Brook6"] = {
            ["Mode"] = "Box",
            ["Checks"] = {"attack", "range"},
            ["Ability Type"] = "Normal",
            ["Time"] = 13
        },
        ["Kisuke6"] = {
            ["Mode"] = "Pair",
            ["Checks"] = {"attack", "range"},
            ["Ability Type"] = "Multiple",
            ["Ability Name"] = "Buff Ability",
            ["Time"] = 13
        },
        ["Rayleigh"] = {
            ["Mode"] = "Box",
            ["Checks"] = {"attack"},
            ["Ability Type"] = "Normal",
            ["Time"] = 13
        },
        ["Six Eyes Gojo"] = {
            ["Mode"] = "Cycle",
            ["Checks"] = {},
            ["Ability Type"] = "Normal",
            ["Cycle Units"] = 7,
            ["Time"] = 10,
            ["Delay"] = 1
        },
        ["Merlin6"] = {
            ["Time"] = 13,
            ["Checks"] = {"attack", "range"},
            ["Mode"] = "Box",
            ["Ability Type"] = "Normal"
        },
        ["Gojo7"] = {
            ["Time"] = 9.5,
            ["Checks"] = {""},
            ["Mode"] = "Box",
            ["Delay"] = 0,
            ["Ability Type"] = "Normal"
        },
        ["Hoshino"] = {
            ["Time"] = 15,
            ["Checks"] = {""},
            ["Mode"] = "Spam",
            ["Delay"] = 0,
            ["Ability Type"] = "Normal"
        },
        ["Metal Cooler"] = {
            ["Time"] = 21,
            ["Checks"] = {""},
            ["Mode"] = "Spam",
            ["Delay"] = 0.5,
            ["Ability Type"] = "Normal"
        },
        ["Satorou Gojou"] = {
            ["Time"] = 10,
            ["Checks"] = {""},
            ["Mode"] = "Box",
            ["Delay"] = 0,
            ["Ability Type"] = "Normal"
        }
    },
    Auto_Vote_Extreme = false,
	Auto_Next_Story = false,
	Auto_Replay = false,
    Auto2x = false,
    Auto3x = false,
    Macro_Profile = "Default Profile",
    Macro_Record = false,
    Macro_Playback = false,
    Macro_Record_Time_Offset = 0,
    Macro_Money_Tracking = false,
    Macro_Playback_Time_Offset = 0,
    Macro_Magnitude = 1,
    Macro_Playback_Search_Attempts = 60,
    Macro_Playback_Search_Delay = 1,
    Macro_Summon = true,
    Macro_Sell = true,
    Macro_Upgrade = true,
    Macro_Ability = true,
    Macro_Auto_Ability = true,
    Macro_Priority = true,
    Macro_Skipwave = true,
    Macro_AutoSkipwave = true,
    Macro_SpeedChange = true,
    Macro_Ability_Blacklist = {
        "Erwin", "Merlin", "Brook6", "Kisuke6", "Rayleigh", "Merlin6", "Gojo7",
        "Hoshino", "Metal Cooler"
    },
    Macro_Timer_Version = "Version 2",
    Action_Queue_Remote_Fire_Delay = 0.25,
    Action_Queue_Remote_On_Fail = true,
    Action_Queue_Remote_On_Fail_Delay = 1,
    Action_Queue_Remote_On_Fail_Delay_Loop = 0.5,
    Auto_Join_Game = false,
    Auto_Join_Tower = false,
    Auto_Join_Delay = 5,
    Auto_Join_Mode = "Infinite",
    Auto_Join_Story_Level = 1,
    Auto_Join_Infinite_Level = "-1.7",
    Auto_Join_Trial_Level = 1,
    Auto_Join_Raid_Level = 1,
    Auto_Join_Challenge_Level = 1,
    Auto_Join_Bout_Level = 1,
    Auto_Join_Adventure_Level = "-1133",
    Auto_Evolve_Exp = true,
    Auto_Skip_Gui = true,
    Webhook_Url = "",
    Webhook_Discord_Id = "",
    Webhook_User_Name = true,
    Webhook_Color = "FF8700",
    Webhook_Ping_User = false,
    Webhook_End_Game = false,
    Webhook_Exp_Evolved = false,
    Anti_AFK = true,
    Disable_3D_Rendering = false,
    Auto_Execute = false,
    Auto_Battle = false,
    Auto_Battle_Gems = 2700,
    FPS_Boost = false,
    Auto_Upgrade = false,
    Auto_Upgrade_Money = 100,
    Auto_Upgrade_Wave_Stop = 100,
    Auto_Upgrade_Sell = false,
    Auto_Upgrade_Wave = 0,
    Auto_Upgrade_Wave_Sell = 100,
    anonymous_mode = true,
    anonymous_mode_name = "Anonymous"
}

if not pcall(function() readfile(SettingsFile) end) then
    writefile(SettingsFile,game:GetService("HttpService"):JSONEncode(MainSettings))
end

if not pcall(function()
    Settings = game:GetService("HttpService"):JSONDecode(readfile(SettingsFile))
end) then
    writefile(SettingsFile,game:GetService("HttpService"):JSONEncode(MainSettings))
    Settings = MainSettings
end

local IndividualMacroMainSettings = {
    ["Macro"] = {},
    ["Units"] = {},
    ["Map"] = {},
    ["Settings"] = {}
}

local MacroMainSettings = {
    ["Default Profile"] = DeepCopy(IndividualMacroMainSettings)
}

local folder_name = "CREATKING\\ASTD\\" .. game.Players.LocalPlayer.UserId

if not isfolder(folder_name) then makefolder(folder_name) end

if #listfiles(folder_name) == 0 then
    writefile(folder_name .. "\\" .. "Default Profile.json",game:GetService("HttpService"):JSONEncode(MacroMainSettings))
end

for _, file in pairs(listfiles(folder_name)) do
    if not pcall(function()
        local json_content = game:GetService("HttpService"):JSONDecode(readfile(file))
        for k, v in pairs(json_content) do
            if Macros[k] ~= nil then
                delfile(file)
            else
                Macros[k] = v
            end
        end
    end) then print("Error reading file: " .. file) end
end

if TableLength(Macros) == 0 then
    writefile(folder_name .. "\\" .. "Default Profile.json",game:GetService("HttpService"):JSONEncode(MacroMainSettings))
    Macros["Default Profile"] = DeepCopy(IndividualMacroMainSettings)
end

local MacroProfileList = {}

for i, _ in pairs(Macros) do table.insert(MacroProfileList, i) end
if Macros[Settings.Macro_Profile] == nil then
    Settings.Macro_Profile = MacroProfileList[#MacroProfileList]
end

function Save()
    writefile(SettingsFile, game:GetService("HttpService"):JSONEncode(Settings))
    for profile_name, macro_table in pairs(Macros) do
        local save_data = {}
        save_data[profile_name] = macro_table
        writefile(folder_name .. "\\" .. profile_name .. ".json",game:GetService("HttpService"):JSONEncode(save_data))
    end
end

for k, v in pairs(MainSettings) do
    if Settings[k] == nil then Settings[k] = v end
end


Save()
print("[CREATKING] Filesystem Loaded: " .. os.clock() - benchmark_time)
benchmark_time = os.clock()

-- Game Helper Variables
local Player = game.Players.LocalPlayer
local GUI = Player.PlayerGui

-- Game Helper Functions
local function get_world()
    local worlds = {
        ["14657361824"] = -2, -- team event
        ["5552815761"] = -1, -- time chamber
        ["11574204578"] = 0,
        ["4996049426"] = 1,
        ["7785334488"] = 2
        -- ["11886211138"] = 3
    }
    return worlds[tostring(game.PlaceId)]
end

local function get_game_speed()
    return game:GetService("ReplicatedStorage").SpeedUP.Value
end

local function Delay(time, condition)
    local timeElapsed = 0
    local updates = 0.1 -- 100 ms checks

    while timeElapsed < time do
        if not condition then break end
        timeElapsed = timeElapsed + (updates * get_game_speed())
        task.wait(updates)
    end
end

local function get_units()
    local units = {}
    local T = game:GetService("Workspace").Unit:GetChildren()

    for k, v in pairs(T) do
        if v:FindFirstChild("Owner") ~= nil and tostring(v.Owner.Value) ==
            Player.Name then table.insert(units, v) end
    end

    return units
end

local CachedStats, OrbsV2Client, DataFolderClient

if get_world() ~= -1 and get_world() ~= -2 then
    CachedStats = require(Player.Backpack:WaitForChild("Framework"):WaitForChild("CachedStats"))
    OrbsV2Client = require(game:GetService("ReplicatedStorage"):WaitForChild("Framework"):WaitForChild("OrbsV2Client"))
    DataFolderClient = require(game.ReplicatedStorage.Framework.DataFolderClient)
end

local function get_all_storage_items()
    local items = {}
    if get_world() ~= -1 and get_world() ~= -2 then
        local storageItems = game:GetService("ReplicatedStorage").StorageItems
        for _, item in pairs(storageItems:GetChildren()) do
            if item.Name ~= "Disc" then -- no package link smh
                table.insert(items, item.Name)
            end
        end
    end
    return items
end

local function get_all_units()
    local units = {}

    if get_world() ~= -1 and get_world() ~= -2 then
        for k, v in pairs(game:GetService("ReplicatedStorage").Unit:GetChildren()) do
            if v.Name ~= "PackageLink" then
                table.insert(units, v.Name)
            end
        end
    end

    return units
end

local function get_stat(unit_name) return CachedStats.getstat(unit_name) end

local function get_unit_from_gui(unit_name)
    local UnitGUI = GUI:FindFirstChild("HUD"):FindFirstChild("BottomFrame"):FindFirstChild("Unit")
    for _, v in pairs(UnitGUI:GetChildren()) do
        if v.ClassName == "Frame" then
            local u = v:FindFirstChild("Unit")
            if u.Value == unit_name then return v end
        end
    end

    return nil
end

local function get_summon_cost(unit_name)
    local cost = get_stat(unit_name)["Cost"]
    local discount = 0
    local unit = get_unit_from_gui(unit_name)

    if unit == nil then
        local orb = OrbsV2Client.GetAssignedOrbForUnit(unit_name)

        if orb ~= nil then
            local orb_stats = CachedStats.getOrbStat(orb)

            if orb_stats ~= nil then
                if orb_stats["InitialCost"] ~= nil then
                    discount = orb_stats["InitialCost"]
                end
                if orb_stats["InitialPercentageCost"] ~= nil then
                    cost = cost * orb_stats["InitialPercentageCost"]
                end
            end
        end

        return cost - discount
    else
        local image_label = unit:FindFirstChild("ImageLabel")

        if image_label ~= nil then
            local text_label = image_label:FindFirstChild("TextLabel")

            if text_label ~= nil then cost = convert(text_label.Text) end
        end

        return cost
    end
end

local function get_upgrade_cost(unit_name, level)
    local unit = get_stat(unit_name)
    if unit ~= nil then
        local upgrades = unit["Upgrade"]

        if upgrades[level] == nil then
            return 0
        else
            local cost = upgrades[level]["Cost"]
            local unit = get_unit_from_gui(unit_name)

            if unit ~= nil then
                local id = unit:FindFirstChild("ID")

                if id ~= nil then
                    local orb = OrbsV2Client.GetAssignedOrbForUnit(id.Value)
                    if orb ~= nil then
                        local orb_stats = CachedStats.getOrbStat(orb)

                        if orb_stats ~= nil then
                            if orb_stats["InitialPercentageCost"] ~= nil then
                                cost = cost * orb_stats["InitialPercentageCost"]
                            end
                        end
                    end
                end
            end

            return cost
        end
    else
        return 0 -- cannot find unit with get_stat
    end
end

local function get_max_upgrade_level(unit_name)
    return #get_stat(unit_name)["Upgrade"]
end

local function get_money() return Player:FindFirstChild("Money").Value end

local function get_wave()
    local WaveValue = game:GetService("ReplicatedStorage"):FindFirstChild("WaveValue")
    local wave = 0
    if WaveValue ~= nil then wave = WaveValue.Value end
    return wave
end

local function get_gems()
    if DataFolderClient ~= nil then
        return DataFolderClient.Get("Gems")
    else
        return nil
    end
end

local function get_gold()
    if DataFolderClient ~= nil then
        return DataFolderClient.Get("Gold")
    else
        return nil
    end
end

local function get_stardust()
    if DataFolderClient ~= nil then
        return DataFolderClient.Get("StardustStone")
    else
        return nil
    end
end

local function get_level()
    if DataFolderClient ~= nil then
        return DataFolderClient.Get("Level")
    else
        return nil
    end
end

local function get_battle_pass_tier()
    local bp_tier = "nil"

    pcall(function()
        bp_tier = GUI.TowerPassRewards.Main.Page.Main.Top.CurrentTierBox.Tier.Text
    end)

    return bp_tier
end

local function is_lobby()
    if get_world() ~= -1 and get_world() ~= -2 then
        return game.ReplicatedStorage:FindFirstChild("Lobby").Value
    else
        return nil
    end
end

local function get_number_missions()
    if get_world() ~= -1 and get_world() ~= -2 then
        return #game.ReplicatedStorage.Remotes.Server:InvokeServer("Mission")
    else
        return 204
    end
end

local function get_game_status()
    local status = GUI.HUD:WaitForChild("MissionEnd"):WaitForChild("BG")
                       :WaitForChild("Status"):WaitForChild("Status")

    return status.Text
end

local function get_world_teleporter()
    if 1 == get_world() then
        return game:GetService("Workspace").Queue["W2 PERM"].World2.Script115
    elseif 2 == get_world() then
        return game:GetService("Workspace").Script115
    end
end

local function CheckAttackBuff(Units)
    pcall(function()
        for _, v in pairs(Units) do
            local buffs = v:FindFirstChild("Head"):FindFirstChild("EffectBBGUI")
            if buffs ~= nil then
                local attack_buff = buffs:FindFirstChild("Frame"):FindFirstChild("AttackImage")
                if not attack_buff.Visible then return false end
            else
                return false
            end
        end

        return true
    end)
end

local function CheckRangeBuff(Units)
    for _, v in pairs(Units) do
        local buffs = v:FindFirstChild("Head"):FindFirstChild("EffectBBGUI")
        if buffs ~= nil then
            local range_buff = buffs:FindFirstChild("Frame"):FindFirstChild("RangeImage")

            if not range_buff.Visible then return false end
        else
            return false
        end
    end

    return true
end

local function CheckStun(unit)
    local buffs = unit:FindFirstChild("Head"):FindFirstChild("EffectBBGUI")
    if buffs ~= nil then
        local stun = buffs:FindFirstChild("Frame"):FindFirstChild("StunImage")

        if not stun.Visible then return false end
    else
        return false
    end

    return true
end

local function HideSummonGUI()
    while GUI:WaitForChild("HUD"):FindFirstChild("SUMMONGUI") ~= nil do
        local vim = game:GetService('VirtualInputManager')
        vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        task.wait()
        vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        task.wait(0.25)
    end
end

 



local TimeOffset = 0


-- local time_total = 0
-- local dt = task.wait(waithow()) -- dt คือเวลาที่รอจริงในรอบนั้น
-- local speed = tonumber(game:GetService("ReplicatedStorage").SpeedUP.Value) or 1
-- time_total = time_total + (dt * speed) -- บวกเวลาที่คูณ Speed เข้าไป
-- local time_start = 0
-- local start_clock = os.clock() -- เก็บเวลาเริ่มต้นของระบบ (ความละเอียดสูง)
-- local is_counting = true

-- local function waithow()
--     local speed = tonumber(game:GetService("ReplicatedStorage").SpeedUP.Value) or 1
--     return 1 / speed
-- end

-- coroutine.resume(coroutine.create(function()
--     if is_lobby() then return end
--     if game:GetService("ReplicatedStorage").Map.Value == "Gauntlet" then return end
    
--     while is_counting do
--         local current_wave = tonumber(get_wave()) or 0
        
--         if current_wave > 0 then
--             is_counting = false
--             local time_start = os.clock() - start_clock
--             print(string.format("สรุปเวลาที่ใช้จนถึง Wave 1: %.2f วินาที", time_start))
--             break 
--         end
--         task.wait(waithow()) 
--     end
-- end))

-- local function ElapsedTime()
--     local wave = get_wave()

--     if wave > 0 then
--         if Settings.Macro_Timer_Version == "Version 1" then
--             return getrenv()["time"]() + TimeOffset
--         elseif Settings.Macro_Timer_Version == "Version 2" then
--             return (getrenv()["time"]() - time_start) + TimeOffset
--         end
--     end

--     return 0
-- end


local time_start = 0 -- จะถูกใช้เก็บค่า getrenv()["time"] ณ จุดเริ่มต้น Wave 1
local is_counting = true
local function waithow()
    local speed = tonumber(game:GetService("ReplicatedStorage").SpeedUP.Value) or 1
    return 1 / speed
end

coroutine.resume(coroutine.create(function()
    if is_lobby() then return end
    if game:GetService("ReplicatedStorage").Map.Value == "Gauntlet" then return end
    
    while is_counting do
        local current_wave = tonumber(get_wave()) or 0
        
        -- เมื่อเริ่ม Wave 1 (หรือมากกว่า 0)
        if current_wave > 0 then
            time_start = getrenv()["time"]() 
            
            is_counting = false -- หยุดการตรวจสอบ
            print("ระบบเริ่มนับเวลาที่ Wave 1 แล้ว (Reset to 0)")
            break 
        end
        
        task.wait(waithow()) 
    end
end))

local function ElapsedTime()
    local wave = tonumber(get_wave()) or 0

    if wave > 0 then
        if Settings.Macro_Timer_Version == "Version 1" then
            return getrenv()["time"]() + TimeOffset
        elseif Settings.Macro_Timer_Version == "Version 2" then
            return (getrenv()["time"]() - StartTime) + TimeOffset
        end
    end

    return 0
end

local function CalculateTimeOffset()
    task.spawn(function()
        repeat task.wait() until get_game_speed() ~= nil and get_wave() > 0

        StartTime = getrenv()["time"]()

        while true do
            if get_game_speed() > 1 then
                TimeOffset = TimeOffset + ((get_game_speed() - 1) * 0.015)
            end
            task.wait(0.015)
            -- print("Macro Calculated Time:", ElapsedTime())
            -- print("Macro Calculated Time w/o Offset:", ElapsedTime() - TimeOffset)
        end
    end)
end



-- https://www.lua.org/pil/11.4.html
Queue = {}
function Queue.new() return {first = 0, last = -1} end
function Queue.pushleft(list, value)
    local first = list.first - 1
    list.first = first
    list[first] = value
end
function Queue.pushright(list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
end
function Queue.popleft(list)
    local first = list.first
    if first > list.last then error("list is empty") end
    local value = list[first]
    list[first] = nil -- to allow garbage collection
    list.first = first + 1
    return value
end
function Queue.popright(list)
    local last = list.last
    if list.first > last then error("list is empty") end
    local value = list[last]
    list[last] = nil -- to allow garbage collection
    list.last = last - 1
    return value
end
function Queue.length(list) return (list.last - list.first) + 1 end

-- Action Queue
local Action_Queue = Queue.new()
local Upgrade_Counter = 0

local function ActionQueueHelper()
    while task.wait() do
        if Queue.length(Action_Queue) > 0 then
            print("Actions in queue:", Queue.length(Action_Queue))
            local current = Queue.popleft(Action_Queue)
            local remote_method = current["Method"]
            local remote_args = current["Args"]
            print("Current Action", remote_method)
            for k, v in pairs(remote_args) do print(k, v) end
            if tostring(remote_method) == "Input" then
                game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(remote_args))
            end
            if tostring(remote_method) == "Server" then
                game:GetService("ReplicatedStorage").Remotes.Server:InvokeServer(unpack(remote_args))
            end
            task.wait(Settings.Action_Queue_Remote_Fire_Delay)
            if remote_args[1] == "Upgrade" then
                Upgrade_Counter = Upgrade_Counter - 1
            end
        end
    end
end

local function StartActionQueue()
    local success, error_message = pcall(ActionQueueHelper)

    -- Rerun code if something breaks in the action queue.
    while not success do
        print("Error with action queue found: " .. error_message)
        success, error_message = pcall(ActionQueueHelper)
        task.wait()
    end
end

-- Action Queue Functions
local function AddToQueue(remote_method, remote_args)
    Queue.pushright(Action_Queue,{["Method"] = remote_method, ["Args"] = remote_args})
end

local function SummonUnit(rotation, cframe, unit_name)
    local status, err = pcall(function()
        local function CheckUnitExist(unit)
            local owner = unit:FindFirstChild("Owner")
            local hrp = unit:FindFirstChild("HumanoidRootPart")

            if owner ~= nil and hrp ~= nil then
                local magnitude =
                    (cframe.Position - hrp.CFrame.Position).magnitude

                if tostring(owner.Value) == Player.Name and unit.Name ==
                    unit_name and magnitude <= Settings.Macro_Magnitude then
                    return true
                end
            end

            return false
        end

        if type(cframe) == "string" then cframe = StringToCFrame(cframe) end

        if Settings.Macro_Money_Tracking then
            repeat task.wait() until get_money() >= get_summon_cost(unit_name)
        end

        local summoned = false
        local connection = game:GetService("Workspace").Unit.ChildAdded:Connect(function(unit)
			if CheckUnitExist(unit) then summoned = true end
		end)

        AddToQueue(game:GetService("ReplicatedStorage").Remotes.Input, {
            [1] = "Summon",
            [2] = {
                ["Rotation"] = rotation,
                ["cframe"] = cframe,
                ["Unit"] = unit_name
            }
        })

        if Settings.Action_Queue_Remote_On_Fail then
            task.spawn(function()
                task.wait(Settings.Action_Queue_Remote_On_Fail_Delay)
                while not summoned do
                    if Queue.length(Action_Queue) == 0 then
                        for _, unit in pairs(game:GetService("Workspace").Unit:GetChildren()) do
                            if CheckUnitExist(unit, cframe) then
                                summoned = true
                                break
                            end
                        end
                        if not summoned then
                            AddToQueue(
                                game:GetService("ReplicatedStorage").Remotes
                                    .Input, {
                                    [1] = "Summon",
                                    [2] = {
                                        ["Rotation"] = rotation,
                                        ["cframe"] = cframe,
                                        ["Unit"] = unit_name
                                    }
                                })
                        end
                    end
                    task.wait(Settings.Action_Queue_Remote_On_Fail_Delay_Loop)
                end
                connection:Disconnect()
            end)
        else
            connection:Disconnect()
        end
    end)

    if not status then print("Error on Summon Unit: " .. err) end
end

local function UpgradeUnit(unit, upgrade_level)
    local status, err = pcall(function()
        local unit_upgrade_level = unit:FindFirstChild("UpgradeTag")
        local unit_max_upgrade_level = get_max_upgrade_level(unit.Name)

        local function UnitIsUpgraded()
            if unit_upgrade_level.Value >= upgrade_level or
                unit_upgrade_level.Value >= unit_max_upgrade_level then
                return true
            else
                return false
            end
        end

        -- repeat task.wait() until Upgrade_Counter == 0

        -- if Settings.Macro_Money_Tracking then
        local total_upgrade_cost = 0
        local total_upgrade_levels = upgrade_level - unit_upgrade_level.Value

        for i = unit_upgrade_level.Value + 1, upgrade_level do
            total_upgrade_cost = total_upgrade_cost + get_upgrade_cost(unit.Name, i)
        end

        repeat task.wait()
            print(string.format("Macro money tracking, current money %s. Upgrade cost %s.",get_money(), total_upgrade_cost))
            if UnitIsUpgraded() then return end
        until get_money() >= total_upgrade_cost
        -- end

        local upgraded = false

        local connection = unit_upgrade_level:GetPropertyChangedSignal("Value"):Connect(function()
			if UnitIsUpgraded() then upgraded = true end
		end)

        for i = unit_upgrade_level.Value + 1, upgrade_level do
            -- Upgrade_Counter = Upgrade_Counter + 1
            game:GetService("ReplicatedStorage").Remotes.Server:InvokeServer("Upgrade", unit)
            -- AddToQueue(game:GetService("ReplicatedStorage").Remotes.Server, {[1] = "Upgrade", [2] = unit})
        end

        task.spawn(function()
            task.wait(1)
            while not upgraded do
                if Queue.length(Action_Queue) == 0 then
                    if UnitIsUpgraded() then break end
                    if not upgraded then
                        -- Upgrade_Counter = Upgrade_Counter + 1
                        game:GetService("ReplicatedStorage").Remotes.Server:InvokeServer("Upgrade", unit)
                    end
                end
                task.wait(1)
            end
            connection:Disconnect()
        end)

        --[[if Settings.Action_Queue_Remote_On_Fail then
            task.spawn(function()
                task.wait(Settings.Action_Queue_Remote_On_Fail_Delay)
                while not upgraded do
                    if Queue.length(Action_Queue) == 0 then
                        if UnitIsUpgraded() then break end
                        if not upgraded then
                            Upgrade_Counter = Upgrade_Counter + 1
                            AddToQueue(
                                game:GetService("ReplicatedStorage").Remotes
                                    .Server, {[1] = "Upgrade", [2] = unit})
                        end
                    end
                    task.wait(Settings.Action_Queue_Remote_On_Fail_Delay_Loop)
                end
                connection:Disconnect()
            end)
        else
            connection:Disconnect()
        end]] --
    end)

    if not status then print("Error on Upgrade Unit: " .. err) end
end

local function UseAbilityUnit(unit, ability_string)
    task.spawn(function()
        local status, err = pcall(function()
            local special_move = unit:FindFirstChild("SpecialMove")
            local special_move_enabled = special_move:FindFirstChild("Special_Enabled2")

            repeat task.wait() until not CheckStun(unit) and not special_move_enabled.Value

            local ability_used = false
            local connection = special_move_enabled:GetPropertyChangedSignal("Value"):Connect(function()
				ability_used = true
			end)

            AddToQueue(game:GetService("ReplicatedStorage").Remotes.Input, {
                [1] = "UseSpecialMove",
                [2] = unit,
                [3] = ability_string
            })

            if Settings.Action_Queue_Remote_On_Fail then
                task.spawn(function()
                    task.wait(Settings.Action_Queue_Remote_On_Fail_Delay)
                    while not ability_used do
                        if Queue.length(Action_Queue) == 0 then
                            if special_move_enabled.Value then
                                break
                            end
                            if not ability_used then
                                AddToQueue(
                                    game:GetService("ReplicatedStorage").Remotes.Input, {
                                        [1] = "UseSpecialMove",
                                        [2] = unit,
                                        [3] = ability_string
                                    }
								)
                            end
                        end
                        task.wait(
                            Settings.Action_Queue_Remote_On_Fail_Delay_Loop)
                    end
                    connection:Disconnect()
                end)
            else
                connection:Disconnect()
            end
        end)

        if not status then print("Error on Use Unit Ability: " .. err) end
    end)
end

local function UseMultipleAbilitiesGUI(ability_name)
    task.spawn(function()
        local gui = GUI:WaitForChild("MultipleAbilities")
        for k, v in pairs(gui:WaitForChild("Frame"):GetChildren()) do
            if v.Name == "ImageButton" then
                local text = v:WaitForChild("TextLabel")
                if text.Text == ability_name then
                    firesignal(v.Activated)
                    break
                end
            end
        end
    end)
end

local function UseKilluaWishesGUI(ability_name)
    task.spawn(function()
        local gui = GUI:WaitForChild("KilluaWishes")
        local Options = gui:WaitForChild("TextBackground"):WaitForChild("OptionsContainer")
        for k, v in pairs(Options:GetChildren()) do
            if v.Name == "Option" then
                if v.Text == ability_name then
                    print("Attempting to activate!")
                    for k, v in pairs(getconnections(v)) do
                        print(k, v)
                    end
                    -- TODO: Fix firesignal MouseButton1Click
                    pcall(function()
                        firesignal(v.MouseButton1Click)
                    end)
                    gui:Destroy()
                    break
                end
            end
        end
    end)
end

local function UseMultipleAbilitiesUnit(unit, ability_string, ability_name)
    -- TODO: Add check to make sure that unit is leveled for ability
    UseAbilityUnit(unit, ability_string)
    UseMultipleAbilitiesGUI(ability_name)
end

local function ActivateAutoAbilityUnit(unit, ability_string, toggled)
    AddToQueue(game:GetService("ReplicatedStorage").Remotes.Input,{[1] = "AutoToggle", [2] = unit, [3] = toggled})
    UseAbilityUnit(unit, ability_string)
end

local function ChangePriorityUnit(unit)
    AddToQueue(game:GetService("ReplicatedStorage").Remotes.Input,{[1] = "ChangePriority", [2] = unit})
end

local function SellUnit(unit)
    AddToQueue(game:GetService("ReplicatedStorage").Remotes.Input,{[1] = "Sell", [2] = unit})
end

local function SkipWave(wave)
    task.spawn(function()
        -- TODO: Use FindFirstChild etc
        repeat task.wait() until GUI.HUD.NextWaveVote.Visible

        -- TODO: Add remote refiring
        while get_wave() == wave and GUI.HUD.NextWaveVote.Visible do
            AddToQueue(game:GetService("ReplicatedStorage").Remotes.Input,{[1] = "VoteWaveConfirm"})
            task.wait(1)
        end
    end)
end

local function AutoSkipWaveToggle(wave, status)
    task.spawn(function()
        repeat task.wait() until get_wave() >= wave

        local CategoryName = GUI:WaitForChild("HUD"):WaitForChild("Setting"):WaitForChild("Page"):WaitForChild("Main"):WaitForChild("Scroll"):WaitForChild("SettingV2"):WaitForChild("AutoSkip"):WaitForChild("Options"):WaitForChild("Toggle"):WaitForChild("CategoryName")

        if CategoryName.Text ~= status then
            AddToQueue(game:GetService("ReplicatedStorage").Remotes.Input,{[1] = "AutoSkipWaves_CHANGE"})
        end
    end)
end

local record_connections = {}

-- TODO: pcall this
local function GetUnitIndex(unit)
    if Macros[Settings.Macro_Profile]["Units"][unit.Name] == nil then
        Macros[Settings.Macro_Profile]["Units"][unit.Name] = {}
    end

    local index = nil
    local exists = false

    for i, v in ipairs(Macros[Settings.Macro_Profile]["Units"][unit.Name]) do
        local hrp = unit:WaitForChild("HumanoidRootPart", 1)

        if hrp ~= nil then
            local magnitude = (StringToCFrame(v["Position"]).Position -hrp.CFrame.Position).magnitude
            if magnitude <= Settings.Macro_Magnitude then
                exists = true
                index = i
                break
            end
        end
    end

    if index == nil then
        -- TODO: Find new rotation variable if needed.
        local rotation = 0

        --[[if getrenv()["_G"] ~= nil then
            rotation = getrenv()["_G"].RotateUnitPlacementValue
        end

        if rotation == nil then rotation = 0 end]] --

        table.insert(Macros[Settings.Macro_Profile]["Units"][unit.Name], {
            ["Rotation"] = rotation,
            ["Position"] = tostring(unit.HumanoidRootPart.CFrame)
        })
        index = #Macros[Settings.Macro_Profile]["Units"][unit.Name]
    end

    return index
end

-- TODO: pcall this
local function GetUnitByTargetInfo(Target)
    local unit_name = Target["Name"]
    local index = Target["Index"]

    local unit_info = Macros[Settings.Macro_Profile]["Units"][unit_name][index]
    local rotation = unit_info["Rotation"] -- only used for summons
    local cframe = StringToCFrame(unit_info["Position"]) -- used for identifying unit

    local unit = nil

    for _, v in pairs(game:GetService("Workspace").Unit:GetChildren()) do
        local hrp = v:WaitForChild("HumanoidRootPart", 1)

        if hrp ~= nil then
            local magnitude = (cframe.Position - hrp.CFrame.Position).magnitude

            if magnitude <= Settings.Macro_Magnitude then
                unit = v
                break
            end
        end
    end

    return unit, cframe, rotation
end

local function MacroRecordElapsedTime()
    return ElapsedTime() + Settings.Macro_Record_Time_Offset
end

local CurrentStep = nil

local function InsertToMacro(action)
    table.insert(Macros[Settings.Macro_Profile]["Macro"], action)
    Save()
    if CurrentStep ~= nil then
        CurrentStep = CurrentStep + 1
    else
        CurrentStep = 1
    end
end

local function HookUpgrade(unit, index)
    local upgrade_level = unit:WaitForChild("UpgradeTag", 60)

    if upgrade_level ~= nil then
        return upgrade_level:GetPropertyChangedSignal("Value"):Connect(function()
			if Settings.Macro_Record and Settings.Macro_Upgrade then
				InsertToMacro({
					["Time"] = MacroRecordElapsedTime(),
					["Target"] = {["Name"] = unit.Name, ["Index"] = index},
					["Remote"] = {[1] = "Upgrade", [2] = "Target"},
					["Parameter"] = {["Level"] = upgrade_level.Value}
				})
			end
		end)
    else
        return nil
    end
end

local function HookAbility(unit, index)
    local special_move = unit:WaitForChild("SpecialMove", 15)

    if special_move ~= nil then
        local ability_2 = special_move:WaitForChild("Special_Enabled2", 15)

        if ability_2 == nil then return nil end

        local ability_1 = special_move:WaitForChild("Special_Enabled", 1)
        local ability_string = ""

        if ability_1 ~= nil then
            local special_enabled_string = ability_1:WaitForChild("Special_Enabled_String", 1)
            if special_enabled_string ~= nil then
                ability_string = special_enabled_string.Value
            end
        end

        return ability_2.ChildAdded:Connect(function(c)
            local status, err = pcall(function()
                if special_move:GetAttribute("Auto") then return end

                if Settings.Macro_Record and Settings.Macro_Ability and
                    table.find(Settings.Macro_Ability_Blacklist, unit.Name) ==
                    nil then
                    if c.Name == "SpecialStart" then
                        InsertToMacro({
                            ["Time"] = MacroRecordElapsedTime(),
                            ["Target"] = {
                                ["Name"] = unit.Name,
                                ["Index"] = index
                            },
                            ["Remote"] = {
                                [1] = "UseSpecialMove",
                                [2] = "Target",
                                [3] = ability_string
                            }
                        })
                    end
                end
            end)

            if not status then
                print("Error on use ability hook: " .. err)
            end
        end)
    end

    return nil
end

local function HookAutoAbility(unit, index)
    local special_move = unit:WaitForChild("SpecialMove", 15)

    if special_move ~= nil then
        local special_enabled = special_move:WaitForChild("Special_Enabled", 1)
        local ability_string = ""

        if special_enabled ~= nil then
            local special_enabled_string =
                special_enabled:WaitForChild("Special_Enabled_String", 1)

            if special_enabled_string ~= nil then
                ability_string = special_enabled_string.Value
            end
        end

        return special_move:GetAttributeChangedSignal("Auto"):Connect(function()
            if Settings.Macro_Record and Settings.Macro_Auto_Ability then
                InsertToMacro({
                    ["Time"] = MacroRecordElapsedTime(),
                    ["Target"] = {["Name"] = unit.Name, ["Index"] = index},
                    ["Remote"] = {
                        [1] = "AutoToggle",
                        [2] = "Target",
                        [3] = special_move:GetAttribute("Auto")
                    },
                    ["Parameter"] = {["Ability String"] = ability_string}
                })
            end
        end)
    end

    return nil
end

--[[local function HookPriority(unit, index)
    local priority = unit:WaitForChild("PriorityAttack", 60)

    if priority ~= nil then
        return priority:GetPropertyChangedSignal("Value"):Connect(function()
            if Settings.Macro_Record and Settings.Macro_Priority then
                InsertToMacro({
                    ["Time"] = MacroRecordElapsedTime(),
                    ["Target"] = {["Name"] = unit.Name, ["Index"] = index},
                    ["Remote"] = {[1] = "ChangePriority", [2] = "Target"},
                    ["Parameter"] = {["Priority"] = priority.Value}
                })
            end
        end)
    end

    return nil
end]] --

local function HookNextWave()
    local HUD = GUI:WaitForChild("HUD", 15)

    if HUD ~= nil then
        local next_wave_gui = HUD:WaitForChild("NextWaveVote", 15)

        if next_wave_gui == nil then return nil end

        local yes_button = next_wave_gui:WaitForChild("YesButton", 15)

        if yes_button ~= nil then
            return yes_button.MouseButton1Click:Connect(function()
                if Settings.Macro_Record and Settings.Macro_Skipwave then
                    InsertToMacro({
                        ["Time"] = MacroRecordElapsedTime(),
                        ["Remote"] = {[1] = "VoteWaveConfirm"},
                        ["Parameter"] = {["Wave"] = get_wave()}
                    })
                end
            end)
        end
    end

    return nil
end

local function HookAutoSkipWave()
    local Toggle = GUI:WaitForChild("HUD"):WaitForChild("Setting"):WaitForChild("Page"):WaitForChild("Main"):WaitForChild("Scroll"):WaitForChild("SettingV2"):WaitForChild("AutoSkip"):WaitForChild("Options"):WaitForChild("Toggle")
    local CategoryName = Toggle:WaitForChild("CategoryName")
    local Button = Toggle:WaitForChild("TextButton")

    if Button ~= nil then
        return Button.MouseButton1Click:Connect(function()
            if Settings.Macro_Record and Settings.Macro_AutoSkipwave then
                InsertToMacro({
                    ["Time"] = MacroRecordElapsedTime(),
                    ["Remote"] = {[1] = "AutoSkipWaves_CHANGE"},
                    ["Parameter"] = {
                        ["Wave"] = get_wave(),
                        ["Status"] = CategoryName.Text
                    }
                })
            end
        end)
    else
        return nil
    end
end

local function HookMultipleAbilitiesGUI()
    local function Hook(c)
        if c.Name == "MultipleAbilities" then
            local Frame = c:WaitForChild("Frame")

            repeat task.wait() until #Frame:GetChildren() > 1

            for k, v in pairs(Frame:GetChildren()) do
                if v.Name == "ImageButton" then
                    local connection = v.MouseButton1Click:Connect(function()
                        local text = v:WaitForChild("TextLabel")
                        if Settings.Macro_Record and Settings.Macro_Ability then
                            InsertToMacro({
                                ["Time"] = MacroRecordElapsedTime(),
                                ["Remote"] = {[1] = "MultipleAbilities"},
                                ["Parameter"] = {["Ability Name"] = text.Text}
                            })
                        end
                    end)
                end
            end
        end
        if c.Name == "KilluaWishes" then
            local Options = c:WaitForChild("TextBackground"):WaitForChild("OptionsContainer")
            for k, v in pairs(Options:GetChildren()) do
                if v.Name == "Option" then
                    local connection = v.MouseButton1Click:Connect(function()
                        if Settings.Macro_Record and Settings.Macro_Ability then
                            InsertToMacro({
                                ["Time"] = MacroRecordElapsedTime(),
                                ["Remote"] = {[1] = "KilluaWishes"},
                                ["Parameter"] = {["Ability Name"] = v.Text}
                            })
                        end
                    end)
                end
            end
        end
    end

    for _, v in pairs(GUI:GetChildren()) do
        Hook(v) -- ensures all previous multiple abilities guis are found
    end

    return GUI.ChildAdded:Connect(function(c) Hook(c) end)
end

local function HookSpeedChanges()
    return  game:GetService("ReplicatedStorage"):WaitForChild("SpeedUP").Changed:Connect(function(v)
		if Settings.Macro_Record and Settings.Macro_SpeedChange then
			InsertToMacro({
				["Time"] = MacroRecordElapsedTime(),
				["Remote"] = {[1] = "SpeedChange"},
				["Parameter"] = {["Speed"] = v}
			})
		end
	end)
end

local function AddHooks(unit, index)
    -- TODO: Print error message if one of the hooks are nil.
    table.insert(record_connections, HookUpgrade(unit, index))
    table.insert(record_connections, HookAbility(unit, index))
    table.insert(record_connections, HookAutoAbility(unit, index))
    -- table.insert(record_connections, HookPriority(unit, index))
end

-- Temporary fix for priority recording
local game_metatable = getrawmetatable(game)
local namecall_original = game_metatable.__namecall

setreadonly(game_metatable, false)

game_metatable.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local script = getcallingscript()

    local Args = {...}

    if Settings.Macro_Record and Settings.Macro_Priority then
        if Args ~= nil and #Args > 1 and
            (method == "FireServer" or method == "InvokeServer") then
            if Args[1] == "ChangePriority" then
                task.spawn(function()
                    InsertToMacro({
                        ["Time"] = MacroRecordElapsedTime(),
                        ["Target"] = {
                            ["Name"] = Args[2].Name,
                            ["Index"] = GetUnitIndex(Args[2])
                        },
                        ["Remote"] = {[1] = "ChangePriority", [2] = "Target"}
                        -- ["Parameter"] = {["Priority"] = nil}
                    })
                end)
            end
        end
    end

    return namecall_original(self, ...)
end)

function StartMacroRecord()
    if Macros[Settings.Macro_Profile]["Macro"] == nil then
        Macros[Settings.Macro_Profile]["Macro"] = {}
    end

    if Macros[Settings.Macro_Profile]["Settings"] == nil then
        Macros[Settings.Macro_Profile]["Settings"] = {}
    end

    if Macros[Settings.Macro_Profile]["Map"] == nil then
        Macros[Settings.Macro_Profile]["Map"] = {}
    end

    if Macros[Settings.Macro_Profile]["Units"] == nil then
        Macros[Settings.Macro_Profile]["Units"] = {}
    end

    if is_lobby() then return end

    


    local Units = game:GetService("Workspace"):WaitForChild("Unit")
    for _, unit in pairs(get_units()) do AddHooks(unit, GetUnitIndex(unit)) end
    print("Hooked Units In Workspace...")

    task.spawn(function()
        table.insert(record_connections, Units.ChildAdded:Connect(function(unit)
            local owner = unit:WaitForChild("Owner")

            if tostring(owner.Value) == Player.Name then
                local index = GetUnitIndex(unit)

                if Settings.Macro_Record and Settings.Macro_Summon then
                    InsertToMacro({
                        ["Time"] = MacroRecordElapsedTime(),
                        ["Target"] = {["Name"] = unit.Name, ["Index"] = index},
                        ["Remote"] = {[1] = "Summon", [2] = "Target"}
                    })
                end

                AddHooks(unit, index)
            end
        end))
        print("Hooked Unit Summoning...")
    end)

    task.spawn(function()
        table.insert(record_connections,Units.ChildRemoved:Connect(function(unit)
            if Settings.Macro_Record and Settings.Macro_Sell then
                local owner = unit:WaitForChild("Owner")

                if tostring(owner.Value) == Player.Name then
                    local index = GetUnitIndex(unit)

                    InsertToMacro({
                        ["Time"] = MacroRecordElapsedTime(),
                        ["Target"] = {["Name"] = unit.Name, ["Index"] = index},
                        ["Remote"] = {[1] = "Sell", [2] = "Target"}
                    })

                    Save()
                end
            end
        end))
        print("Hooked Units Selling...")
    end)

    task.spawn(function()
        table.insert(record_connections, HookNextWave())
        print("Hooked Next Wave...")
    end)

    task.spawn(function()
        table.insert(record_connections, HookMultipleAbilitiesGUI())
        print("Hooked Multiple Abilities GUI...")
    end)

    task.spawn(function()
        table.insert(record_connections, HookAutoSkipWave())
        print("Hooked Auto Skip Wave...")
    end)

    task.spawn(function()
        table.insert(record_connections, HookSpeedChanges())
        print("Hooked Speed Changes...")
    end)

    Notifier.new({
        Title = "Macro Recording",
        Content = "Started Macro Recording...",
        Duration = 6.5,
        Icon = "rbxassetid://120245531583106"
    })
end

function StopMacroRecord()
    for _, v in pairs(record_connections) do v:Disconnect() end
    record_connections = {}
    Notifier.new({
        Title = "Macro Recording",
        Content = "Stopped Macro Recording...",
        Duration = 6.5,
        Icon = "rbxassetid://120245531583106"
    })
end

function StartMacroPlayback()
    if is_lobby() then return end

    table.sort(Macros[Settings.Macro_Profile]["Macro"],function(a, b) return a["Time"] < b["Time"] end)

    CurrentStep, _ = next(Macros[Settings.Macro_Profile]["Macro"], CurrentStep)

    while CurrentStep do
        local Current = Macros[Settings.Macro_Profile]["Macro"][CurrentStep]

        repeat task.wait() until ElapsedTime() + Settings.Macro_Playback_Time_Offset >= Current["Time"] or not Settings.Macro_Playback

        if not Settings.Macro_Playback then break end

        local Remote = Current["Remote"]

        if Current["Target"] == nil then
            if Remote[1] == "VoteWaveConfirm" then
                SkipWave(Current["Parameter"]["Wave"])
            elseif Remote[1] == "AutoSkipWaves_CHANGE" then
                AutoSkipWaveToggle(Current["Parameter"]["Wave"],Current["Parameter"]["Status"])
            elseif Remote[1] == "MultipleAbilities" then
                UseMultipleAbilitiesGUI(Current["Parameter"]["Ability Name"])
            elseif Remote[1] == "KilluaWishes" then
                UseKilluaWishesGUI(Current["Parameter"]["Ability Name"])
            elseif Remote[1] == "SpeedChange" then
                ChangeSpeed(Current["Parameter"]["Speed"])
            else
                print(string.format("Macro error! Invalid target found for remote %s at step %s",Remote[1], CurrentStep))
            end
        else
            local unit, position, rotation =GetUnitByTargetInfo(Current["Target"])

            if unit == nil and position and rotation then
                if Remote[1] == "Summon" and Settings.Macro_Summon then
                    SummonUnit(rotation, position, Current["Target"]["Name"])
                else
                    local attempts = 0
                    repeat task.wait(Settings.Macro_Playback_Search_Delay)
                        unit, position, rotation = GetUnitByTargetInfo(Current["Target"])
                        print(string.format("Macro is attempting to find the unit for %s. Increase magnitude if this continues to occur or check if unit is being summoned.",Remote[1]))
                        attempts = attempts + 1
                    until unit ~= nil or attempts >=
                        Settings.Macro_Playback_Search_Attempts or
                        not Settings.Macro_Playback

                    if attempts >= Settings.Macro_Playback_Search_Attempts then
                        print(string.format("Macro skipped step %s for action %s, target %s, time %s. Please check if unit is being summoned correctly, or if it is a issue with macro playback.",CurrentStep, Remote[1],Current["Target"]["Name"], Current["Time"]))
                    end
                end
            end

            if unit ~= nil then
                if Remote[1] == "Upgrade" and Settings.Macro_Upgrade then
                    UpgradeUnit(unit, Current["Parameter"]["Level"])
                elseif Remote[1] == "UseSpecialMove" and Settings.Macro_Ability and
                    table.find(Settings.Macro_Ability_Blacklist, unit.Name) ==
                    nil then
                    UseAbilityUnit(unit, Remote[3])
                elseif Remote[1] == "AutoToggle" and Settings.Macro_Auto_Ability then
                    ActivateAutoAbilityUnit(unit,Current["Parameter"]["Ability String"],Remote[3])
                elseif Remote[1] == "ChangePriority" and Settings.Macro_Priority then
                    ChangePriorityUnit(unit)
                elseif Remote[1] == "Sell" and Settings.Macro_Sell then
                    SellUnit(unit)
                elseif Remote[1] == "Summon" then
                    print("Macro attempting to summon a unit that already exists!")
                else
                    print("Macro error! Remote %s is not a valid for ASTD.")
                end
            elseif unit ~= nil and Remote[1] ~= "Summon" then
                print(string.format("Macro error! Cannot find unit for remote %s at step %s",Remote[1], CurrentStep))
            end
        end

        CurrentStep, _ = next(Macros[Settings.Macro_Profile]["Macro"],CurrentStep)
        task.wait()
    end
end

function StopMacroPlayback() if is_lobby() then return end end

function AutoVoteExtreme()
    repeat task.wait() until GUI.HUD.ModeVoteFrame.Visible
    repeat
        game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack({
            [1] = "VoteGameMode",
            [2] = "Extreme"
        }))
        task.wait(1)
    until not GUI.HUD.ModeVoteFrame.Visible
end

function AutoBattle()
    repeat task.wait() until GUI.HUD.FastForward.Autoplay.Visible
    if get_gems() < Settings.Auto_Battle_Gems then
        Settings.Auto_Battle = false
        Notifier.new({
            Title = "You have no gems to run Auto Battle!",
            Content = "Auto battle paused until you have more gems!",
            Duration = 6.5,
            Icon = "rbxassetid://120245531583106",
        })
        return
    end

    if not CompareColor3(GUI.HUD.FastForward.Autoplay.BackgroundColor3,Color3.fromRGB(10, 230, 0)) then
        local args = {
            [1] = "BuyAutoBattle"
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Input"):FireServer(unpack(args))
    end

  
    repeat task.wait() 
    until GUI.Notification:WaitForChild("Message").Visible or CompareColor3(GUI.HUD.FastForward.Autoplay.BackgroundColor3,Color3.fromRGB(10, 230, 0))

    if not CompareColor3(GUI.HUD.FastForward.Autoplay.BackgroundColor3,Color3.fromRGB(10, 230, 0)) then
        local args = {
            [1] = "BuyAutoBattle"
        }

        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Input"):FireServer(unpack(args))
    end
end

local function ManualUpgrade() -- added for pc
    if GUI.HUD.UpgradeV2.Actions.Upgrade.Visible then
        firesignal(GUI.HUD.UpgradeV2.Actions.Upgrade.MouseButton1Click)
    end
end

local function ManualSell() -- added for pc
    if GUI.HUD.UpgradeV2.Actions.Sell.Visible then
        firesignal(GUI.HUD.UpgradeV2.Actions.Sell.MouseButton1Click)
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.E then
        ManualUpgrade()
    elseif input.KeyCode == Enum.KeyCode.Q then
        ManualSell()
    end
end)

function ChangeSpeed(speed)
    task.spawn(function()
        while get_game_speed() ~= tonumber(speed) do
            local args = {[1] = "SpeedChange", [2] = true}
            if get_game_speed() < tonumber(speed) then
                game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(args))
            elseif get_game_speed() > tonumber(speed) then
                args[2] = false
                game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(args))
            end
            task.wait(1)
        end
    end)
end

-- function AutoChangeSpeed()
--     repeat task.wait(1) until get_game_speed() ~= nil

--     while Settings.Auto2x or Settings.Auto3x do
--         local args = {[1] = "SpeedChange", [2] = true}
--         if (Settings.Auto3x and get_game_speed() < 3) or (Settings.Auto2x and get_game_speed() < 2) then
--             if Settings.Auto3x and get_game_speed() < 3 and game:GetService("MarketplaceService"):UserOwnsGamePassAsync(game.Players.LocalPlayer.UserId, 12828275) == true then
--                 game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(args))
--             elseif game:GetService("MarketplaceService"):UserOwnsGamePassAsync(game.Players.LocalPlayer.UserId, 12828275) == false and (Settings.Auto3x and get_game_speed() < 2) then
--                 game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(args))
--             end
--         elseif (Settings.Auto2x and get_game_speed() > 2) then
--             args[2] = false
--             game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack(args))
--         end

--         task.wait(1)
--     end
-- end

-- function AutoChangeSpeed()
--     if not game.Players.LocalPlayer.PlayerGui.HUD.FastForward.Visible or tostring(game.Players.LocalPlayer.PlayerGui.HUD.FastForward.TextLabel.Text) == ("2X" or "3X") then
--     else
--         if Settings.Auto2x and tostring(game.Players.LocalPlayer.PlayerGui.HUD.FastForward.TextLabel.Text) ~= "2X" then
--             repeat
--                 if tostring(game.Players.LocalPlayer.PlayerGui.HUD.FastForward.TextLabel.Text) ~= "2X" then
--                     game:GetService("ReplicatedStorage").Remotes.Input:FireServer('SpeedChange',true)
--                     task.wait(1)
--                 end
--             until tostring(game.Players.LocalPlayer.PlayerGui.HUD.FastForward.TextLabel.Text) == "2X" or not Settings.Auto2x
--         elseif Settings.Auto3x and tostring(game.Players.LocalPlayer.PlayerGui.HUD.FastForward.TextLabel.Text) ~= "3X" then
--             if not game:GetService("MarketplaceService"):UserOwnsGamePassAsync(game.Players.LocalPlayer.UserId, 12828275) then
--             else
--                 repeat 
--                     if tostring(game.Players.LocalPlayer.PlayerGui.HUD.FastForward.TextLabel.Text) ~= "3X" and game:GetService("MarketplaceService"):UserOwnsGamePassAsync(game.Players.LocalPlayer.UserId, 12828275) then
--                         game:GetService("ReplicatedStorage").Remotes.Input:FireServer('SpeedChange',false)
--                         task.wait(1)
--                     end
--                 until tostring(game.Players.LocalPlayer.PlayerGui.HUD.FastForward.TextLabel.Text) == "1X" or not Settings.Auto3x
--                 or not game:GetService("MarketplaceService"):UserOwnsGamePassAsync(game.Players.LocalPlayer.UserId, 12828275)
--             end
--         end
--     end
-- end


-- function AutoChangeSpeed()
--     local HUD = game.Players.LocalPlayer.PlayerGui:WaitForChild("HUD", 5)
--     local speedText = tostring(HUD.FastForward.TextLabel.Text)
--     local remote = game:GetService("ReplicatedStorage").Remotes.Input
--     local has3xPass = game:GetService("MarketplaceService"):UserOwnsGamePassAsync(game.Players.LocalPlayer.UserId, 12828275)
--     while Settings.Auto3x or Settings.Auto2x do
--         if Settings.Auto3x and has3xPass then
--             if speedText ~= "3X" then
--                 repeat
--                     remote:FireServer('SpeedChange', false) -- ปกติ 3X มักจะเป็น Argument เฉพาะ ตรวจสอบอีกทีนะครับ
--                     task.wait(1)
--                     speedText = tostring(HUD.FastForward.TextLabel.Text)
--                 until speedText == "3X" or not Settings.Auto3x
--             end
--         elseif Settings.Auto2x then
--             if speedText ~= "2X" and speedText ~= "3X" then -- ถ้าเป็น 3X อยู่แล้วไม่ต้องถอยลงมา 2X
--                 repeat
--                     remote:FireServer('SpeedChange', true)
--                     task.wait(1)
--                     speedText = tostring(HUD.FastForward.TextLabel.Text)
--                 until speedText == "2X" or speedText == "3X" or not Settings.Auto2x
--             end
--         elseif Settings.Auto2x and speedText == "3X" then
--             repeat
--                     remote:FireServer('SpeedChange', false)
--                     task.wait(1)
--                     speedText = tostring(HUD.FastForward.TextLabel.Text)
--             until speedText == "2X" or not Settings.Auto2x
--         end
--         task.wait(1)
--     end
-- end


function AutoChangeSpeed()
    local HUD = game.Players.LocalPlayer.PlayerGui:WaitForChild("HUD", 5)
    if not HUD then return end
    
    local remote = game:GetService("ReplicatedStorage").Remotes.Input
    local checkDelay = 3 
    local clickDelay = 1 

    while Settings.Auto3x or Settings.Auto2x do
        local speedText = tostring(HUD.FastForward.TextLabel.Text)
        local has3xPass = game:GetService("MarketplaceService"):UserOwnsGamePassAsync(game.Players.LocalPlayer.UserId, 12828275)

        if Settings.Auto3x and has3xPass then
            if speedText ~= "3X" then
                repeat
                    remote:FireServer('SpeedChange', false)
                    task.wait(clickDelay) -- รอระว่างคลิก
                    speedText = tostring(HUD.FastForward.TextLabel.Text)
                until speedText == "3X" or not Settings.Auto3x
            end
            
        elseif Settings.Auto2x then
            -- ถ้าเปิด Auto2x แต่ปัจจุบันเป็น 3X และต้องการลดระดับลงมา
            if speedText == "3X" then
                repeat
                    remote:FireServer('SpeedChange', false)
                    task.wait(clickDelay)
                    speedText = tostring(HUD.FastForward.TextLabel.Text)
                until speedText == "2X" or not Settings.Auto2x
            -- ถ้าปัจจุบันไม่ใช่ 2X และไม่ใช่ 3X ให้กดเพิ่มสปีด
            elseif speedText ~= "2X" then
                repeat
                    remote:FireServer('SpeedChange', true)
                    task.wait(clickDelay)
                    speedText = tostring(HUD.FastForward.TextLabel.Text)
                until speedText == "2X" or speedText == "3X" or not Settings.Auto2x
            end
        end
        
        task.wait(checkDelay) -- พักรอบใหญ่ก่อนกลับไปเช็คเงื่อนไขใหม่
    end
end

local WebHookLog = {}

local InitialStats = { Gems = 0, Gold = 0, Stardust = 0 }

local currentGems = get_gems()
local currentGold = get_gold()
local currentStardust = get_stardust()
local currentLevel = get_level()

warn("gems : "..currentGems.." gold : "..currentGold.." stardust : "..currentStardust)

function SendWebhook()
    -- repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui.HUD.MissionEnd.BG.Status.Status.Text ~= ""
    local player = game.Players.LocalPlayer
    local currentWave = get_wave() or "N/A"
    
    InitialStats.Gems = get_gems()
    InitialStats.Gold = get_gold()
    InitialStats.Stardust = get_stardust()

    local gainedGems =  (InitialStats.Gems ) - currentGems
    local gainedGold = (InitialStats.Gold ) - currentGold 
    local gainedStardust = (InitialStats.Stardust) - currentStardust
    warn("gain gems : "..gainedGems.." gain gold : "..gainedGold.." gain stardust : "..gainedStardust)
    local bpTier = "N/A"
    pcall(function()
        bpTier = GUI.TowerPassRewards.Main.Page.Main.Top.CurrentTierBox.Tier.Text
    end)
    local Status = game:GetService("Players").LocalPlayer.PlayerGui.HUD.MissionEnd.BG.Status.Status.Text
    local GameStatus,embedColor
    if Status == "Success!" then
        GameStatus = "```diff\n+ "..Status.."\n```"
        embedColor = 0x2ecc71
    elseif Status == "Failed!" then
        GameStatus = "```diff\n- "..Status.."\n```"
        embedColor = 0xe74c3c
    end
    
    local elapsed = ElapsedTime and ElapsedTime() or 0
    local realTimeFormat = string.format("%02d นาที %02d วินาที", math.floor(elapsed/60), math.floor(elapsed%60))
    -- local embedColor = tonumber(Settings.Webhook_Color, 16) or 0x00C4A0



    local embedData = {
        username = "✧ CREATKING HUB",
        avatar_url = "https://i.imgur.com/SpideyBotAvatar.png",  -- เปลี่ยนได้
        
        embeds = {{
            title = "🌟 CREATKING HUB | FARM STATUS 🌟",
            description = "**สรุปผลฟาร์มแบบเรียลไทม์**\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
            color = embedColor,
            
            author = {
                name = player.Name .. " • Elite Farmer",
                icon_url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
            },
            
            thumbnail = {
                url = "https://cdn.discordapp.com/attachments/1475544343824699577/1482813493953560586/FB_IMG_1732378005236.jpg?ex=69b8512e&is=69b6ffae&hm=84e58e906bcce23ae33995fd2a0455921c4adc521a8c17a780520e8fa07eced6"
            },
            
            fields = {
                {
                    name = "👤 PLAYER",
                    value = "```yaml\n" .. player.Name .. "\n```",
                    inline = true
                },
                {
                    name = "🗺️ WAVE",
                    value = "```yaml\n" .. tostring(currentWave) .. "\n```",
                    inline = true
                },
                {
                    name = "⏱️ TIME",
                    value = "```yaml\n" .. realTimeFormat .. "\n```",
                    inline = true
                },
                
                {
                    name = "📈 PROGRESS",
                    value = "```yaml\nLevel : " .. tostring(currentLevel) .. "\nBP Tier : " .. bpTier .. "\n```",
                    inline = false
                },

                {
                    name = "🏆 STATUS",
                    value = GameStatus,
                    inline = false
                },
                
                {
                    name = "💎 CURRENT BALANCE",
                    value = "```diff\nGems     " .. tostring(currentGems) .. "\nGold     " .. tostring(currentGold) .. "\nStardust " .. tostring(currentStardust) .. "\n```",
                    inline = true
                },
                {
                    name = "🎁 REWARDS GAINED",
                    value = "```diff\n+ Gems     " .. tostring(gainedGems) .. "\n+ Gold     " .. tostring(gainedGold) .. "\n+ Stardust " .. tostring(gainedStardust) .. "\n```",
                    inline = true
                },
                
                {
                    name = "⚙️ MACRO SETTINGS",
                    value = "```yaml\nMacro Time : " .. realTimeFormat .. "\nProfile    : "..Settings.Macro_Profile .. "\n```",
                    inline = false
                }
            },
            
            footer = {
                text = "CREATKING HUB • Version 0.2 • " .. os.date("%d/%m/%Y %H:%M:%S"),
                icon_url = "https://i.imgur.com/SpideyBotAvatar.png"
            },
            
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }

    local AllRequest = http_request or request or HttpPost or syn.request
    
    AllRequest({
        Url = Settings.Webhook_Url,
        Method = 'POST',
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode(embedData)
    })
    print("gainedGems : " .. gainedGems)
    print("✅ ส่ง Farm Status ไป Discord สำเร็จ! (หรูหราเวอร์ชัน)")
end



function SendWebhook_TEST()

    -- 🔹 ใส่ค่าทดสอบตรงนี้เลย
    local playerName = "OxigenZ"
    local userId = 123456789

    local currentWave = "35"
    local currentLevel = "120"

    local currentGems = "12,500"
    local currentGold = "850,000"
    local currentStardust = "320"

    local gainedGems = "+1,200"
    local gainedGold = "+50,000"
    local gainedStardust = "+25"

    local bpTier = "Tier 45"
    local macroProfile = "Overnight Farm"

    local realTimeFormat = "12:34"
    local GameStatus = "🟢 SUCCESS"
    local embedColor = 0x2ecc71

    -- 🔥 EMBED
    local embedData = {
        username = "CREATKING HUB",
        avatar_url = "https://i.imgur.com/SpideyBotAvatar.png",

        embeds = {{
            title = "🌟 FARM RESULT (TEST MODE)",
            description = "━━━━━━━━━━━━━━━━━━\n🧪 **Webhook Test Preview**\n━━━━━━━━━━━━━━━━━━",
            color = embedColor,

            author = {
                name = playerName,
                icon_url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"
            },

            fields = {
                {
                    name = "🎮 Player",
                    value = playerName,
                    inline = true
                },
                {
                    name = "🌊 Wave",
                    value = currentWave,
                    inline = true
                },
                {
                    name = "⏱ Time",
                    value = realTimeFormat,
                    inline = true
                },

                {
                    name = "📈 Progress",
                    value = "Level: ".. currentLevel .. "\nBP Tier: ".. bpTier,
                    inline = false
                },

                {
                    name = "🏆 Result",
                    value = GameStatus,
                    inline = false
                },

                {
                    name = "💰 Balance",
                    value = string.format(
                        "💎 %s\n🪙 %s\n✨ %s",
                        currentGems, currentGold, currentStardust
                    ),
                    inline = true
                },

                {
                    name = "📦 Gained",
                    value = string.format(
                        "%s 💎\n%s 🪙\n%s ✨",
                        gainedGems, gainedGold, gainedStardust
                    ),
                    inline = true
                },

                {
                    name = "⚙️ Macro",
                    value = "Profile: ".. macroProfile .. "\nDuration: ".. realTimeFormat,
                    inline = false
                }
            },

            footer = {
                text = "CREATKING HUB • TEST • " .. os.date("%d/%m/%Y %H:%M")
            },

            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }

    -- 🔹 ส่ง webhook
    local req = http_request or request or HttpPost or syn.request

    req({
        Url = Settings.Webhook_Url,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode(embedData)
    })

    print("🧪 TEST WEBHOOK SENT!")
end


function OnGameEnd()
    if not is_lobby() then
        local end_gui = GUI.HUD:WaitForChild("MissionEnd")
        repeat task.wait() until end_gui.Visible and end_gui.BG.Status.Status.Text ~= ""
        if Settings.Webhook_End_Game then 
            SendWebhook() 
        end
    end
end


function FpsBoost()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Jeikaru/Roblox/main/FpsBoost"))()
end

local linkport = ""
local linkport2 = ""

local function extractFileName(url)
    local nameWithParams = url:match("^.+/(.+)$")
    return nameWithParams:match("^[^?]+")
end

local function importMacro(url)
    local fileName = extractFileName(url)
    local savePath = folder_name .. "\\" .. fileName

    local success, response = pcall(function() return game:HttpGet(url) end)

    if success then
        writefile(savePath, response)

        local jsonData
        success, jsonData = pcall(function()
            return game:GetService("HttpService"):JSONDecode(response)
        end)

        if success then
            Notifier.new({
                Title = "Macro Imported!",
                Content = "Macro Import Success!",
                Duration = 4,
                Icon = "rbxassetid://120245531583106"
            })
        else
            warn("Error parsing JSON: " .. jsonData)
        end
    else
        warn("Error downloading JSON: " .. response)
    end
end

local function importSettings(url)
    local fileName = extractFileName(url)
    local tempSavePath = "CREATKING\\ASTD\\Settings\\" .. fileName
    local success, response = pcall(function() return game:HttpGet(url) end)

    if success then
        writefile(tempSavePath, response)

        local success, jsonData = pcall(function()
            return game:GetService("HttpService"):JSONDecode(response)
        end)

        writefile(SettingsFile, response)
        delfile(tempSavePath) -- Delete the Settings.json file after userid.json is created

        if success then
            Notifier.new({
                Title = "Settings Imported!",
                Content = "Settings Imported Rejoin to See the changes!",
                Duration = 4,
                Icon = "rbxassetid://120245531583106"
            })
        else
            warn("Error parsing JSON: " .. jsonData)
        end
    else
        warn("Error downloading JSON: " .. response)
    end
end

function AutoReplay()
    local end_gui = GUI.HUD:WaitForChild("MissionEnd")

    repeat task.wait() until end_gui.Visible

    local replay_button = end_gui:WaitForChild("BG"):WaitForChild("Actions"):WaitForChild("Replay")
    local next_button = end_gui:WaitForChild("BG"):WaitForChild("Actions"):WaitForChild("Next")

    while Settings.Auto_Replay do
        if Settings.Auto_Next_Story and next_button.Visible then break end

        if replay_button.Visible then firesignal(replay_button.Activated) end
        task.wait(1)
    end
end

function AutoNextStory()
    local end_gui = GUI.HUD:WaitForChild("MissionEnd")

    repeat task.wait() until end_gui.Visible

    local next_button = end_gui:WaitForChild("BG"):WaitForChild("Actions"):WaitForChild("Next")

    while Settings.Auto_Next_Story do
        if next_button.Visible then firesignal(next_button.Activated) end
        task.wait(1)
    end
end

function AutoUpgrade()
    while true do
        while get_money() >= Settings.Auto_Upgrade_Money and get_wave() >= Settings.Auto_Upgrade_Wave and Settings.Auto_Upgrade and get_wave() < Settings.Auto_Upgrade_Wave_Stop do

            local units = get_units()
            local any_upgraded = false

            for _, unit in ipairs(units) do
                local unit_name = unit.Name
                if get_current_upgrade_level(unit) <
                    get_max_upgrade_level(unit_name) then
                    local args = {[1] = "Upgrade", [2] = unit}
                    game:GetService("ReplicatedStorage").Remotes.Server:InvokeServer(unpack(args))
                    any_upgraded = true
                    wait(0.1)
                end
            end
            wait(1)
        end

        if get_wave() >= Settings.Auto_Upgrade_Wave_Stop then
            warn("Auto-upgrade stopped at wave", Settings.Auto_Upgrade_Wave_Stop)
            Settings.Auto_Upgrade = false
            break
        end

        wait(1)
    end
end

function AutoSell()
    local Wave = get_wave()

    local function units()
        local unitNames = {}
        for _, child in ipairs(workspace:GetChildren()) do
            if child.Name == "Unit" then
                local childNames = {}
                for _, unitChild in ipairs(child:GetChildren()) do
                    table.insert(childNames, unitChild.Name)
                end
                unitNames["unit"] = childNames
            end
        end
        return unitNames
    end

    local function SellUnit(unit)
        task.spawn(function()
            local has_sold = false
            local attempts = 0

            workspace.Unit.ChildRemoved:Connect(function(x)
                if unit == x then has_sold = true end
            end)
            repeat
                if not has_sold then
                    local args = {[1] = "Sell", [2] = unit}

                    game:GetService("ReplicatedStorage").Remotes.Input:FireServer(
                        unpack(args))
                    has_sold = true
                end
                attempts = attempts + 1
                task.wait(0.6)
            until has_sold or attempts >= 3
        end)
    end

    if get_wave() >= Settings.Auto_Upgrade_Wave_Sell then
        while Settings.Auto_Upgrade.Auto_Upgrade_Sell do
            local unitList = units()["unit"]
            if unitList then
                for _, unitName in ipairs(unitList) do
                    local unit = workspace.Unit[unitName]
                    if unit then
                        SellUnit(unit)
                        task.wait(0.6)
                    end
                end
            else
                break
            end
            task.wait(1)
        end
    end
end

local function AutoBuffHelper(Units, unit, checks, ability_type, ability_name)
    for _, check in pairs(checks) do
        if check == "attack" then
            repeat task.wait() until not CheckAttackBuff(Units)
        elseif check == "range" then
            repeat task.wait() until not CheckRangeBuff(Units)
        end
    end

    if ability_type == "Multiple" then
        UseMultipleAbilitiesUnit(unit, "", ability_name)
    else
        UseAbilityUnit(unit, "")
    end
end

function AutoBuff()
    for k, v in pairs(Settings.Auto_Buff_Units) do
        task.spawn(function()
            while Settings.Auto_Buff do
                local Units = {}

                for _, unit in pairs(get_units()) do
                    if unit.Name == k and unit:WaitForChild("SpecialMove").Value ~=
                        "" then table.insert(Units, unit) end
                end

                local checks = v["Checks"]
                local ability_type = v["Ability Type"]
                local ability_name = nil
                local time = v["Time"]

                if ability_type == "Multiple" then
                    ability_name = v["Ability Name"]
                end

                if v["Mode"] == "Box" then
                    local Units2 = {}

                    if #Units > 4 and #Units < 8 then
                        repeat
                            task.wait(1)
                            table.remove(Units, #Units)
                        until #Units == 4
                    end

                    if #Units == 8 then
                        for i = 1, 4 do
                            table.insert(Units2, Units[1])
                            table.remove(Units, 1)
                        end
                    end

                    if #Units == 4 or #Units2 == 4 then
                        for i = 1, 4 do
                            if not Settings.Auto_Buff or
                                Settings.Auto_Buff_Units[k] == nil then
                                break
                            end
                            if #Units == 4 then
                                AutoBuffHelper(Units, Units[i], checks,ability_type, ability_name)
                            end
                            if #Units2 == 4 then
                                AutoBuffHelper(Units2, Units2[i], checks,ability_type, ability_name)
                            end
                            Delay(time, Settings.Auto_Buff and Settings.Auto_Buff_Units[k] ~= nil)
                        end
                    end
                elseif v["Mode"] == "Pair" then
                    if #Units >= 2 then
                        for i, v in pairs(Units) do
                            if i % 2 ~= 0 then
                                AutoBuffHelper(Units, Units[i], checks,ability_type, ability_name)
                            end
                        end

                        Delay(time, Settings.Auto_Buff and Settings.Auto_Buff_Units[k] ~= nil)

                        for i, v in pairs(Units) do
                            if i % 2 == 0 then
                                AutoBuffHelper(Units, Units[i], checks,ability_type, ability_name)
                            end
                        end

                        Delay(time, Settings.Auto_Buff and Settings.Auto_Buff_Units[k] ~= nil)
                    end
                elseif v["Mode"] == "Spam" then
                    for i, unit in pairs(Units) do
                        AutoBuffHelper(Units, Units[i], checks, ability_type,ability_name)
                    end
                    Delay(time, Settings.Auto_Buff and Settings.Auto_Buff_Units[k] ~= nil)

                elseif v["Mode"] == "Cycle" then
                    local cycle_units = 8

                    if v["Cycle Units"] ~= nil then
                        cycle_units = v["Cycle Units"]
                    end

                    if #Units >= cycle_units then
                        for i, v in pairs(Units) do
                            if Settings.Auto_Buff and
                                Settings.Auto_Buff_Units[k] ~= nil and #Units >=
                                cycle_units then
                                AutoBuffHelper(Units, Units[i], checks,ability_type, ability_name)
                            else
                                break
                            end
                            Delay(time,Settings.Auto_Buff and Settings.Auto_Buff_Units[k] ~= nil and #Units >= cycle_units)
                        end
                    end
                end

                if v["Delay"] ~= nil then
                    Delay(v["Delay"], Settings.Auto_Buff)
                end

                task.wait()
            end
        end)
    end
end



function AutoTower()
    local player = game:GetService("Players").LocalPlayer
    local towerteleporter = workspace.Queue.InteractionsV2:FindFirstChild("Script633")

    local function UseTeleporter(teleporter)
        if teleporter ~= nil then
            firetouchinterest(player.Character.HumanoidRootPart, teleporter, 0)
            task.wait()
            firetouchinterest(player.Character.HumanoidRootPart, teleporter, 1)
            task.wait(1)
        end
    end

    local function pressKey(keyCode)
        game:GetService("VirtualInputManager"):SendKeyEvent(true, keyCode,false, game)
        task.wait(0.1)
        game:GetService("VirtualInputManager"):SendKeyEvent(false, keyCode,false, game)
    end

    UseTeleporter(towerteleporter)

    if player.PlayerGui.HUD.TowerLevelSelector.StoryModeChooser.StoryModeChooser
        .Visible then
        pressKey(Enum.KeyCode.BackSlash)
        task.wait(0.5)
        pressKey(Enum.KeyCode.Right)
        task.wait(0.5)
        pressKey(Enum.KeyCode.Return)
        task.wait(0.5)
        pressKey(Enum.KeyCode.BackSlash)

        game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack({
            [1] = towerteleporter.Name .. "Start"
        }))
    end
end

function AutoJoinGame()
    local function UseTeleporter(teleporter)
        if teleporter ~= nil then
            firetouchinterest(Player.Character.HumanoidRootPart, teleporter, 0)
            task.wait()
            firetouchinterest(Player.Character.HumanoidRootPart, teleporter, 1)
            task.wait(1)
        end
    end

    local function QuickStartTeleporter(teleporter)
        task.wait(1)
        Player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").SpawnLocation.CFrame
        task.wait(1)
        if teleporter ~= nil then
            game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack({[1] = teleporter.Name .. "Start"}))
        end
    end

    if Settings.Auto_Evolve_Exp then
        repeat task.wait() until not isEvolvingEXP or not Settings.Auto_Evolve_Exp
    end

    if not Settings.Auto_Join_Game then return end

    task.wait(Settings.Auto_Join_Delay)

    local args = {}
    local teleporter = nil

    -- TODO: Add server hopper on teleport failed.
    if get_world() == 1 then
        -- TODO: Teleport to teleporter location if no teleporters loaded.
        local function FindTeleporter(Teleporters)
            local Found = false

            while not Found do
                for _, v in pairs(Teleporters) do
                    if v.ClassName == "Part" and
                        v.SurfaceGui.Frame.TextLabel.Text == "Empty" then
                        Found = true
                        return v
                    end
                end

                task.wait()
            end

            return nil
        end
        local function GetStoryTeleporters()
            local Teleporters = {}
            local TeleporterNames = {
                "Script170", "Script158", "Script395", "Script408", "Script523",
                "Script539", "Script573", "Script600", "Script624", "Script958"
            }

            for _, v in pairs(game:GetService("Workspace").Queue.InteractionsV2:GetChildren()) do
                if table.find(TeleporterNames, v.Name) ~= nil then
                    table.insert(Teleporters, v)
                end
            end

            return Teleporters
        end
        local function GetInfiniteTeleporters()
            local Teleporters = {}
            local TeleporterNames = {
                "Script209", "Script222", "Script381", "Script405", "Script448",
                "Script58", "Script647", "Script716"
            }

            for _, v in pairs(game:GetService("Workspace").Queue.InteractionsV2:GetChildren()) do
                if table.find(TeleporterNames, v.Name) ~= nil then
                    table.insert(Teleporters, v)
                end
            end

            return Teleporters
        end
        local function SetStoryMap(teleporter)
            if teleporter ~= nil then
                game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack({
					[1] = teleporter.Name .. "Level",
					[2] = tostring(Settings.Auto_Join_Story_Level),
					[3] = false
				}))
            end
        end
        local function SetInfiniteMap(teleporter)
            if teleporter ~= nil then
                game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack({
					[1] = teleporter.Name .. "Level",
					[2] = Settings.Auto_Join_Infinite_Level,
					[3] = false
				}))
            end
        end
        local function TeleportToWorld2()
            UseTeleporter(get_world_teleporter())
        end
        if Settings.Auto_Join_Mode == "Story" then
            if Settings.Auto_Join_Story_Level > 120 then
                TeleportToWorld2()
                return
            end
            teleporter = FindTeleporter(GetStoryTeleporters())
            UseTeleporter(teleporter)
            SetStoryMap(teleporter)
        elseif Settings.Auto_Join_Mode == "Infinite" then
            if InfiniteMapTable[Settings.Auto_Join_Infinite_Level] == "Gauntlet" or
                InfiniteMapTable[Settings.Auto_Join_Infinite_Level] == "Training" then
                TeleportToWorld2()
                return
            end
            teleporter = FindTeleporter(GetInfiniteTeleporters())
            UseTeleporter(teleporter)
            SetInfiniteMap(teleporter)
        elseif Settings.Auto_Join_Mode == "Adventure" then
            TeleportToWorld2()
            return
        elseif Settings.Auto_Join_Mode == "Time Chamber" then
            UseTeleporter(game:GetService("Workspace").Queue.Interactions.Script548)
        elseif Settings.Auto_Join_Mode == "Team Event" then
            for _, v in pairs(game:GetService("Workspace").Queue:GetChildren()) do
                if v.Name == "Model" and v:FindFirstChild("PortalPart") ~= nil then
                    UseTeleporter(v:FindFirstChild("PortalPart"))
                    break
                end
            end
        elseif Settings.Auto_Join_Mode == "Bakugan Event" then
            UseTeleporter(game:GetService("Workspace").Queue.BakuganEventArea.Script412)
        end
        QuickStartTeleporter(teleporter)
    elseif get_world() == 2 then
        local function FindTeleporter(Teleporters, Mode)
            local Found = false

            while not Found do
                for _, v in pairs(Teleporters) do
                    if (Mode == nil or v.Name == Mode) and v.ClassName == "Part" and
                        v.SurfaceGui.Frame.TextLabel.Text == "Empty" then
                        Found = true
                        return v
                    end
                end

                task.wait()
            end

            return nil
        end
        local function SetStoryMap(teleporter)
            if teleporter ~= nil then
                game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack({
					[1] = "StoryModeLevel",
					[2] = tostring(Settings.Auto_Join_Story_Level),
					[3] = true
				}))
            end
        end
        local function SetInfiniteMap(teleporter)
            if teleporter ~= nil then
                game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack({
					[1] = "InfiniteModeLevel",
					[2] = Settings.Auto_Join_Infinite_Level,
					[3] = false
				}))
            end
        end
        local function SetAdventureMap(teleporter)
            if teleporter ~= nil then
                game:GetService("ReplicatedStorage").Remotes.Input:FireServer(unpack({
					[1] = "AdventureModeLevel",
					[2] = Settings.Auto_Join_Adventure_Level,
					[3] = false
				}))
            end
        end
        local function TeleportToWorld1()
            UseTeleporter(get_world_teleporter())
        end
        local teleporter = nil
        if Settings.Auto_Join_Mode == "Story" then
            if Settings.Auto_Join_Story_Level < 121 then
                TeleportToWorld1()
                return
            end
            repeat task.wait() until #game:GetService("Workspace").Joinables:GetChildren() > 0
            teleporter = FindTeleporter(game:GetService("Workspace").Joinables:GetChildren(),"StoryMode")
            UseTeleporter(teleporter)
            SetStoryMap(teleporter)
        elseif Settings.Auto_Join_Mode == "Infinite" then
            if InfiniteMapTable[Settings.Auto_Join_Infinite_Level] == "Farm" then
                TeleportToWorld1()
                return
            end
            repeat task.wait() until #game:GetService("Workspace").Joinables:GetChildren() > 0
            teleporter = FindTeleporter(game:GetService("Workspace").Joinables:GetChildren(),"InfiniteMode")
            UseTeleporter(teleporter)
            SetInfiniteMap(teleporter)
        elseif Settings.Auto_Join_Mode == "Adventure" then
            repeat task.wait() until #game:GetService("Workspace").Joinables:GetChildren() > 0
            teleporter = FindTeleporter(game:GetService("Workspace").Joinables:GetChildren(),"AdventureMode")
            UseTeleporter(teleporter)
            SetAdventureMap(teleporter)
        elseif Settings.Auto_Join_Mode == "Time Chamber" then
            TeleportToWorld1()
            return
        elseif Settings.Auto_Join_Mode == "Team Event" then
            TeleportToWorld1()
            return
        elseif Settings.Auto_Join_Mode == "Bakugan Event" then
            TeleportToWorld1()
            return
        end
        QuickStartTeleporter(teleporter)
        --[[elseif get_world() == -2 then -- team event map (reaper's base)
        for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
            if v.Name == "Model" and v:FindFirstChild("Meshes/senkaimon2 (1)") ~=
                nil then
                Player.Character.HumanoidRootPart.CFrame = v:FindFirstChild(
                                                               "Meshes/senkaimon2 (1)").CFrame
                break
            end
        end]] --
    end
end

function AutoSkipGUI()
    local SummonGUI = GUI:WaitForChild("Summon")

    while Settings.Auto_Skip_Gui do
        local status, err = pcall(function()
            -- TODO: Stop when other things are opened.
            if SummonGUI:FindFirstChild('Skip').Visible then
                game:GetService('VirtualUser'):ClickButton1(Vector2.new( workspace.CurrentCamera.ViewportSize.X / 2,workspace.CurrentCamera.ViewportSize.Y / 2))
            end
        end)

        if not status then print("Error on Auto Skip GUI: " .. err) end

        task.wait()
    end
end

local function AnonMode()
    local player = game.Players.LocalPlayer
    local userId = "p_" .. tostring(player.UserId)

    local success, err = pcall(function()
        local playerName = game:GetService("CoreGui").PlayerList.PlayerListMaster.OffsetFrame.PlayerScrollList.SizeOffsetFrame.ScrollingFrameContainer.ScrollingFrameClippingFrame.ScollingFrame.OffsetUndoFrame[userId].ChildrenFrame.NameFrame.BGFrame.OverlayFrame.PlayerName.PlayerName
        playerName.Text = Settings.anonymous_mode_name
    end)

    if not success then warn("Failed to change name in leaderboard: " .. err) end

    if not success then warn("Failed to change name in leaderboard: " .. err) end

    local nameLabel = game:GetService("Workspace").Camera:WaitForChild(Player.Name).Head:WaitForChild("NameLevelBBGUI"):WaitForChild("NameFrame"):WaitForChild("TextLabel")
    nameLabel.Text = Settings.anonymous_mode_name
end

-- TODO: Change all task.spawns to coroutines for easier management on re-executes and prevent double execution of the same function.
if get_world() ~= -1 and get_world() ~= -2 then
    repeat task.wait() until not GUI:WaitForChild("LoadingScreen").Frame.Visible

    if not is_lobby() then
        CalculateTimeOffset()
        task.spawn(StartActionQueue)
        if Settings.Auto_Buff then task.spawn(AutoBuff) end
        if Settings.Auto_Vote_Extreme then task.spawn(AutoVoteExtreme) end
        if Settings.Auto2x or Settings.Auto3x then
            task.spawn(AutoChangeSpeed)
        end
        if Settings.Auto_Battle then task.spawn(AutoBattle) end
        if Settings.Auto_Replay then task.spawn(AutoReplay) end
        if Settings.Auto_Next_Story then task.spawn(AutoNextStory) end
        if Settings.Macro_Record then task.spawn(StartMacroRecord) end
        if Settings.Macro_Playback then task.spawn(StartMacroPlayback) end
        if Settings.Auto_Upgrade then task.spawn(AutoUpgrade) end
        if Settings.Auto_Upgrade_Sell then task.spawn(AutoSell) end
        task.spawn(OnGameEnd)
    else
        task.wait(1)
        if Settings.Auto_Join_Game then task.spawn(AutoJoinGame) end
        if Settings.Auto_Join_Tower then task.spawn(AutoTower) end
    end

    if Settings.Auto_Skip_Gui then task.spawn(AutoSkipGUI) end
    if Settings.FPSBoost then task.spawn(FpsBoost) end
    if Settings.anonymous_mode then task.spawn(AnonMode) end
end

if get_world() == -2 and Settings.Auto_Join_Game then task.spawn(AutoJoinGame) end

-- Tasks that run regardless if its in lobby or in game.
task.spawn(function()
    if Settings.Disable_3D_Rendering then
        game:GetService("RunService"):Set3dRenderingEnabled(not Settings.Disable_3D_Rendering)
    end
    if Settings.Anti_AFK then
        for _, v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
            v:Disable()
        end
    end
end)

print("[CREATKING] Functions Loaded: " .. os.clock() - benchmark_time)
benchmark_time = os.clock()



-- Creating Window --
local Window = Compkiller.new({
	Name = "COMPKILLER",
	Keybind = "LeftAlt",
	Logo = "rbxassetid://120245531583106",
	-- Scale = Compkiller.Scale.Window, -- Leave blank if you want automatic scale [PC, Mobile].
	TextSize = 30,
});

local Watermark = Window:Watermark();

Watermark:AddText({
	Icon = "user",
	Text = "4lpaca",
});

Watermark:AddText({
	Icon = "clock",
	Text = Compkiller:GetDate(),
});

local Time = Watermark:AddText({
	Icon = "timer",
	Text = "TIME",
});

task.spawn(function()
	while true do task.wait()
		Time:SetText(Compkiller:GetTimeNow());
	end
end)

Watermark:AddText({
	Icon = "server",
	Text = Compkiller.Version,
});

Window:DrawCategory({
	Name = "Main"
});


local Maintab = Window:DrawTab({
	Name = "Main Tabs",
	Icon = "home",
	EnableScrolling = true
});

local ingamesection = Maintab:DrawSection({
	Name = "Ingame Section",
	Position = 'left'	
});

local UnitList = get_all_units()

local AutoBuffToggle = ingamesection:AddToggle({
	Name = "Auto Unit Buff",
	Default = Settings.Auto_Buff,
	Callback = function(v)
		Settings.Auto_Buff = v 
		Save()
		if not is_lobby() and v then
			task.spawn(AutoBuff)
		end
	end,
});

local AutoUpgradeToggle = ingamesection:AddToggle({
	Name = "Auto Upgrade",
	Default = Settings.Auto_Upgrade,
	Callback = function(v)
		Settings.Auto_Upgrade = v 
		Save()
		if not is_lobby() and v then
			task.spawn(AutoUpgrade)
		end
	end,
});



local AutoSellToggle = ingamesection:AddToggle({
	Name = "Auto Sell",
	Default = Settings.Auto_Upgrade_Sell,
	Callback = function(v)
		Settings.Auto_Upgrade_Sell = v 
		Save()
		if not is_lobby() and v then
			task.spawn(AutoSell)
		end
	end,
});


local GUIScriptsSection = Maintab:DrawSection({
	Name = "Gui Script",
	Position = "left"
})

local AutoVoteExtremeToggle = GUIScriptsSection:AddToggle({
	Name = "Auto Vote Extream Mode",
	Default = Settings.Auto_Vote_Extreme,
	Callback = function(v)
		Settings.Auto_Vote_Extreme = v 
		Save()
		if not is_lobby() and v then
			task.spawn(AutoVoteExtreme)
		end
	end,
});


local Auto2XToggle = GUIScriptsSection:AddToggle({
	Name = "Auto 2x Speed",
	Default = Settings.Auto2x,
	Callback = function(v)
		Settings.Auto2x = v 
		Save()
		if not is_lobby() and v then
			task.spawn(AutoChangeSpeed)
		end
	end,
});


local Auto3XToggle = GUIScriptsSection:AddToggle({
	Name = "Auto 3x Speed",
	Default = Settings.Auto3x,
	Callback = function(v)
		Settings.Auto3x = v 
		Save()
		if not is_lobby() and v then
			task.spawn(AutoChangeSpeed)
		end
	end,
});


local endgame = Maintab:DrawSection({
	Name = "End Game",
	Position = "left"
})

local AutoReplayToggle = endgame:AddToggle({
	Name = "Auto Replay",
	Default = Settings.Auto_Replay,
	Callback = function(v)
		Settings.Auto_Replay = v 
		Save()
		if not is_lobby() and v then
			task.spawn(AutoReplay)
		end
	end,
});

local AutoNextStoryToggle = endgame:AddToggle({
	Name = "Auto Next Story",
	Default = Settings.Auto_Next_Story,
	Callback = function(v)
		Settings.Auto_Next_Story = v 
		Save()
		if not is_lobby() and v then
			task.spawn(AutoNextStory)
		end
	end,
});

local AutoBattleToggle = endgame:AddToggle({
	Name = "Auto Battle [20 Gems]",
	Default = Settings.Auto_Battle,
	Callback = function(v)
		Settings.Auto_Battle = v 
		Save()
		if not is_lobby() and v then
			task.spawn(AutoNextStory)
		end
	end,
});


local Marcrosec = Maintab:DrawSection({
	Name = "Macros",
	Position = "right"
})

local MacroProfileDropdown = Marcrosec:AddDropdown({
	Name = "Select Profile",
	Default = Settings.Macro_Profile,
	Values = MacroProfileList,
	Callback = function(v)
		Settings.Macro_Profile = v 
		if Macros[Settings.Macro_Profile] == nil then
			Macros[Settings.Macro_Profile] = {}
		end
		Save()
	end
})

local MacroProfileInfo = Marcrosec:AddParagraph({
	Title = "Current Profile Info",
    Content = string.format("Waiting for information...\n")
})   

task.spawn(function()
	while MacroProfileInfo ~= nil do
		if Macros[Settings.Macro_Profile]["Macro"] ~= nil and
			Macros[Settings.Macro_Profile]["Units"] ~= nil then
			MacroProfileInfo:SetContent(string.format("Total Steps: %s\nUnits: %s",tostring(#Macros[Settings.Macro_Profile]["Macro"]),table.concat(get_keys(Macros[Settings.Macro_Profile]["Units"]),",\n")))
		end
		task.wait()
	end
end)

local Controlsec = Maintab:DrawSection({
	Name = "Controls",
	Position = "right"
})

local RecordMacroToggle = Controlsec:AddToggle({
	Name = "Record Macro",
	Default = Settings.Macro_Record,
	Callback = function(v)
		Settings.Macro_Record = v 
		Save()
		if not is_lobby() then
			if v then
				task.spawn(StartMacroRecord)
			else
				task.spawn(StopMacroRecord)
			end
		end
	end,
})

local missionEndUI = game:GetService("Players").LocalPlayer.PlayerGui.HUD.MissionEnd

local stopConnection
stopConnection = missionEndUI:GetPropertyChangedSignal("Visible"):Connect(function()
    if missionEndUI.Visible and Settings.Macro_Record then
        RecordMacroToggle:SetValue(false)
        Settings.Macro_Record = false
        Notifier.new({
            Title = "Macro Recording",
            Content = "Stopped Macro Recording...",
            Duration = 6.5,
            Icon = "rbxassetid://120245531583106"
        })
        Save()
        for _, v in pairs(record_connections) do v:Disconnect() end
        record_connections = {}
        print("Macro stopped automatically.  dwdwwwwwwwwwwwwwwwwwwwwwwwwwwwwwddddddddddddddddddddddd")
        stopConnection:Disconnect()
    end
end)

local PlaybackMacroToggle = Controlsec:AddToggle({
	Name = "Playback Macro",
	Default = Settings.Macro_Playback,
	Callback = function(v)
		Settings.Macro_Playback = v 
		Save()
		if not is_lobby() then
			if v then
				Notifier.new({
					Title = "Macro Playback",
					Content = "Starting Macro Playback...",
					Duration = 6.5,
					Icon = "rbxassetid://120245531583106"
				})
				task.spawn(StartMacroPlayback)
			else
				Notifier.new({
					Title = "Macro Playback",
					Content = "Stoped Macro Playback...",
					Duration = 6.5,
					Icon = "rbxassetid://120245531583106"
				})
				task.spawn(StopMacroPlayback)
			end
		end
	end,
})


local MacroStatus = Controlsec:AddParagraph({
	Title = "Current Profile Info",
    Content = "Waiting for status...\n\n\n\n\n\n"
})  


task.spawn(function()
	while MacroStatus ~= nil do
		if CurrentStep ~= nil then
			local MacroCurrentStep = Macros[Settings.Macro_Profile]["Macro"][CurrentStep]

			if MacroCurrentStep ~= nil then
				local Target = nil
				local TargetName = nil
				local TargetIndex = nil
				local Time = MacroCurrentStep["Time"]
				local Remote = nil
				local Parameters = nil

				if MacroCurrentStep["Target"] ~= nil then
					Target = MacroCurrentStep["Target"]

					if Target ~= nil then
						TargetName = Target["Name"]
						TargetIndex = Target["Index"]
					end
				end

				if MacroCurrentStep["Remote"] ~= nil then
					Remote = MacroCurrentStep["Remote"][1]
				end

				if MacroCurrentStep["Parameter"] ~= nil then
					Parameters = ""
					for k, v in pairs(MacroCurrentStep["Parameter"]) do
						Parameters = Parameters .. tostring(k) .. ": " ..tostring(v) .. "; "
					end
				end

				MacroStatus:SetContent(string.format(
						"Current Step: %s\nTarget: %s[%s]\nTime: %s\nGame Elapsed Time: %s\nAction: %s\nParameters: %s",
						tostring(CurrentStep), tostring(TargetName),
						tostring(TargetIndex), tostring(Time),
						tostring(ElapsedTime()), tostring(Remote),
						tostring(Parameters))
				)
			else
				MacroStatus:SetContent(string.format("Error at step %s!\nGame Elapsed Time: %s",tostring(CurrentStep), tostring(ElapsedTime())))
			end
		else
			MacroStatus:SetContent(string.format("Idle...\nGame Elapsed Time: %s",tostring(ElapsedTime())))
		end

		task.wait()
	end
end)



Controlsec:AddButton({
	Name = "Previous Macro Step",
	Callback = function()
		if CurrentStep ~= nil and CurrentStep > 0 then
			CurrentStep = CurrentStep - 1
		else
			CurrentStep = 1
		end
	end,
})

Controlsec:AddButton({
	Name = "Next Macro Step",
	Callback = function()
		if (CurrentStep == nil or CurrentStep < 0) and
			#Macros[Settings.Macro_Profile]["Macro"] > 0 then
			CurrentStep = 1
		elseif CurrentStep ~= nil and CurrentStep > 0 and CurrentStep <
			#Macros[Settings.Macro_Profile]["Macro"] then
			CurrentStep = CurrentStep + 1
		end
	end,
})

Controlsec:AddButton({
	Name = "Reset Macro Step",
	Callback = function()
		if CurrentStep ~= nil then CurrentStep = nil end
	end,
})

local filesec = Maintab:DrawSection({
	Name = "Profile Management",
	Position = "right"
})

filesec:AddTextBox({
	Name = "New macro profile name",
	Placeholder = "New Pro file name",
	Default = "",
	Callback = function(text) 
		ProfileNameInput = text 
	end
})


filesec:AddButton({
	Name = "Create new macro profile",
	Callback = function()
		local profile_name = ProfileNameInput
		if string.match(profile_name, '[^%w%s]') ~= nil then
			Notifier.new({
				Title = "Macro",
				Content = string.format(
					"%s contains illegal characters!", profile_name),
				Duration = 6.5,
				Icon = "rbxassetid://120245531583106"
			})
		elseif Macros[profile_name] ~= nil then
			Notifier.new({
				Title = "Macro",
				Content = string.format("Macro %s already exists!",profile_name),
				Duration = 6.5,
				Icon = "rbxassetid://120245531583106"
			})
		else
			Macros[profile_name] = DeepCopy(IndividualMacroMainSettings)
			Settings.Macro_Profile = profile_name
			Save()
			table.insert(MacroProfileList, profile_name)
			MacroProfileDropdown:SetValues(MacroProfileList)
			MacroProfileDropdown:SetValue(Settings.Macro_Profile)
			Notifier.new({
				Title = "Macro",
				Content = string.format("Created macro %s!",profile_name),
				Duration = 6.5,
				Icon = "rbxassetid://120245531583106"
			})
		end
	end,
})

filesec:AddButton({
	Name = "Delete selected profile",
	Callback = function()
    	if #MacroProfileList == 1 then
			Notifier.new({
				Title = "Macro",
				Content = "Cannot remove last macro in list!",
				Duration = 6.5,
				Icon = "rbxassetid://120245531583106"
			})
			return
		else
			local removed_profile_name = Settings.Macro_Profile
			delfile(folder_name .. "\\" ..Settings.Macro_Profile ..".json")
			Macros[Settings.Macro_Profile] = nil
			table.remove(MacroProfileList,table.find(MacroProfileList,removed_profile_name))
			for _, v in pairs(MacroProfileList) do
				if v ~= nil then
					Settings.Macro_Profile = v
					break
				end
			end
			Save()
			MacroProfileDropdown:SetValues(MacroProfileList,Settings.Macro_Profile)
			MacroProfileDropdown:SetValue(Settings.Macro_Profile)
			Notifier.new({
				Title = "Macro",
				Content = string.format(
					"Successfully removed macro profile %s!",
					removed_profile_name),
				Duration = 6.5,
				Icon = "rbxassetid://120245531583106"
			})
		end
	end,
})

filesec:AddButton({
	Name = "Clear all macro data on selected profile",
	Callback = function()
		Macros[Settings.Macro_Profile] = DeepCopy(IndividualMacroDefaultSettings)
		CurrentStep = nil
		Save()
		Notifier.new({
			Title = "Macro",
			Content = "Selected profile has been cleared.",
			Duration = 6.5,
			Icon = "rbxassetid://120245531583106"
		})
	end,
})


local reccf = Maintab:DrawSection({
	Name = "Recording Options",
	Position = 'left'	
});

reccf:AddSlider({
	Name = "Time Offset",
	Min = -10,
	Max = 10,
	Default = Settings.Macro_Record_Time_Offset,
	Round = 0,
	Callback = function(value)
		Settings.Macro_Record_Time_Offset = value
		Save()
	end
});

local pbsc = Maintab:DrawSection({
	Name = "Playbackg Options",
	Position = 'left'	
});

pbsc:AddToggle({
	Name = "Money Tracking",
	Default = Settings.Macro_Money_Tracking,
	Callback = function(value)
		Settings.Macro_Money_Tracking = value
		Save()
	end
});


pbsc:AddSlider({
	Name = "Time Offset",
	Min = -10,
	Max = 10,
	Default = Settings.Macro_Playback_Time_Offset,
	Round = 0,
	Callback = function(value)
		Settings.Macro_Playback_Time_Offset = value
		Save()
	end
});

pbsc:AddSlider({
	Name = "Magnitude",
	Min = 0,
	Max = 5,
	Default = Settings.Macro_Magnitude,
	Round = 0,
	Callback = function(value)
		Settings.Macro_Magnitude = value
		Save()
	end
});

pbsc:AddSlider({
	Name = "Attempts before action skip",
	Min = 0,
	Max = 120,
	Default = Settings.Macro_Playback_Search_Attempts,
	Round = 0,
	Callback = function(value)
		Settings.Macro_Playback_Search_Attempts = value
		Save()
	end
});


pbsc:AddSlider({
	Name = "Action skip search delay",
	Min = 0,
	Max = 1,
	Default = Settings.Macro_Playback_Search_Delay,
	Round = 2,
	Callback = function(value)
		Settings.Macro_Playback_Search_Delay = value
		Save()
	end
});

local mcot = Maintab:DrawSection({
	Name = "Macro Options",
	Position = 'right'	
});


mcot:AddDropdown({
	Name = "Elapsed Time Mode",
	Default = Settings.Macro_Timer_Version,
	Values = {"Version 2", "Version 1"},
 	Callback = function(Option)
		Settings.Macro_Timer_Version = Option
		Save()
	end
})

mcot:AddToggle({
	Name = "Summon Unit",
	Default = Settings.Macro_Summon,
	Callback = function(value)
		Settings.Macro_Summon = value
		Save()
	end
});


mcot:AddToggle({
	Name = "Sell Unit",
	Default = Settings.Macro_Sell,
	Callback = function(value)
		Settings.Macro_Sell = value
		Save()
	end
});

mcot:AddToggle({
	Name = "Upgrade Unit",
	Default = Settings.Macro_Upgrade,
	Callback = function(value)
		Settings.Macro_Upgrade = value
		Save()
	end
});

mcot:AddToggle({
	Name = "Change Unit Priority",
	Default = Settings.Macro_Priority,
	Callback = function(value)
		Settings.Macro_Priority = value
		Save()
	end
});

mcot:AddToggle({
	Name = "Unit Ability",
	Default = Settings.Macro_Ability,
	Callback = function(value)
		Settings.Macro_Ability = value
		Save()
	end
});

mcot:AddToggle({
	Name = "Unit Auto Ability",
	Default = Settings.Macro_Auto_Ability,
	Callback = function(value)
		Settings.Macro_Auto_Ability = value
		Save()
	end
});
mcot:AddToggle({
	Name = "Skip Wave",
	Default = Settings.Macro_Skipwave,
	Callback = function(value)
		Settings.Macro_Skipwave = value
		Save()
	end
});
mcot:AddToggle({
	Name = "Auto Skip Wave",
	Default = Settings.Macro_AutoSkipwave,
	Callback = function(value)
		Settings.Macro_AutoSkipwave = value
		Save()
	end
});

mcot:AddToggle({
	Name = "Speed Change",
	Default = Settings.Macro_SpeedChange,
	Callback = function(value)
		Settings.Macro_SpeedChange = value
		Save()
	end
});


local advtab = Window:DrawTab({
	Icon = "crosshair",
	Name = "Advance",
	EnableScrolling = true
});


local adSection = advtab:DrawSection({
	Name = "Auto Unit Bufing",
	Position = 'left'	
});

local AutoBuffSelectedUnitInformation = adSection:AddParagraph({
	Title = "Selected Unit Information",
	Content = "Waiting for selected unit...\n"
})

local function AutoBuffDropdownCallback(value)
	if AutoBuffSelectedUnitInformation ~= nil and
		Settings.Auto_Buff_Units[value] ~= nil then
		local content = ""

		for k, v in pairs(Settings.Auto_Buff_Units[value]) do
			if type(v) == "table" then
				content = content .. string.format("%s: %s\n", tostring(k), table.concat(v, ", "))
			else
				content = content .. string.format("%s: %s\n", tostring(k), tostring(v))
			end
		end
		AutoBuffSelectedUnitInformation:SetContent(content)
	end
end

do 
	local AutoBuffUnitList = get_keys(Settings.Auto_Buff_Units)
 	local AutoBuffDropdown
	if #AutoBuffUnitList > 0 then
		AutoBuffDropdown = adSection:AddDropdown({
			Name = "Units",
			Values = AutoBuffUnitList,
			Default = AutoBuffUnitList[#AutoBuffUnitList],
			Callback = AutoBuffDropdownCallback
		})
	else
		AutoBuffDropdown = adSection:AddDropdown({
			Name = "Units",
			Values = {"None"},
			Default = "None",
			Callback = AutoBuffDropdownCallback
		})
	end
end


local AutoBuffModeDropdown = adSection:AddDropdown({
	Name = "Buffing Mode",
	Values = {"Box", "Pair", "Cycle"},
	Default = "Box",
	Callback = function(Option) end
})

local AutoBuffChecks = adSection:AddDropdown({
	Name = "Auto Buff Checks",
	Values = {"Attack Buff", "Range Buff", "Multiple Abilities"},
	Multi = true,
	Default = {"Attack Buff", "Range Buff"},
	Callback = function(Option) end
})

local AutoBuffMultipleAbilitiesNameInput
adSection:AddTextBox({
	Name = "Multiple Abilities: Ability Name",
	Placeholder = "		",
	Default = "Buff Ability",
	Callback = function(text)
		AutoBuffMultipleAbilitiesNameInput = text
	end
})

local AutoBuffAbilityTime = 15
adSection:AddTextBox({
	Name = "Ability Time",
	Placeholder = "		",
	Default = "15",
	Callback = function(text)
		AutoBuffAbilityTime = tonumber(text)
	end
})
local CycleUnits = 8
adSection:AddSlider({
	Name = "CycleUnits",
	Min = 1,
	Max = 8,
	Default = CycleUnits,
	Round = 0,
	Callback = function(value) CycleUnits = value end
});

local AutoBuffDelay = 0

adSection:AddSlider({
	Name = "Post Loop Delay",
	Min = 0,
	Max = 60,
	Default = AutoBuffDelay,
	Round = 0,
	Callback = function(value) AutoBuffDelay = value end
});


local ActionQueueSection = advtab:DrawSection({
	Name = "Action Queue Settings",
	Position = 'right'	
});

ActionQueueSection:AddParagraph({
	Title = "Action Queue",
	Content = "The action queue is used for all ingame functions in the script that calls remotes. This queue ensures that the action that is being called is executed successfully as the game has bugs where it doesn't call certain remotes due to lag or insufficient resources (cash/cooldown times)."
})


ActionQueueSection:AddSlider({
	Name = "Remote Action Delay",
	Min = 0,
	Max = 1,
	Default = Settings.Action_Queue_Remote_Fire_Delay,
	Round = 2,
	Callback = function(value)
		Settings.Action_Queue_Remote_Fire_Delay = value
		Save()
	end
});

local RemoteRefiringSection = advtab:DrawSection({
	Name = "Remote Refiring",
	Position = 'right'	
});

RemoteRefiringSection:AddParagraph({
	Title = "What is remote refiring?",
	Content = "Remote refiring makes the script call the remote repeatedly until the unit successfully summons, upgrades, or uses their ability. The following parameter allows you to adjust how remote refiring works."
})

RemoteRefiringSection:AddToggle({
	Name = "Refire Remote",
	Default = Settings.Action_Queue_Remote_On_Fail,
	Callback = function(value)
		Settings.Action_Queue_Remote_On_Fail = value
		Save()
	end
});

RemoteRefiringSection:AddSlider({
	Name = "Pre Loop Delay",
	Min = 0,
	Max = 1,
	Default = Settings.Action_Queue_Remote_On_Fail_Delay,
	Round = 2,
	Callback = function(value)
		Settings.Action_Queue_Remote_On_Fail_Delay = value
		Save()
	end
});



RemoteRefiringSection:AddSlider({
	Name = "Loop Delay",
	Min = 0,
	Max = 1,
	Default = Settings.Action_Queue_Remote_On_Fail_Delay_Loop,
	Round = 2,
	Callback = function(value)
		Settings.Action_Queue_Remote_On_Fail_Delay_Loop = value
		Save()
	end
});



local AutomationSection = advtab:DrawSection({
	Name = "Automation",
	Position = 'left'	
});


AutomationSection:AddTextBox({
	Name = "Auto Battle Gems",
	Placeholder = "		",
	Default = Settings.Auto_Battle_Gems,
	Callback = function(text)
		Settings.Auto_Battle_Gems = text
		Save()
	end
})


AutomationSection:AddTextBox({
	Name = "Auto Upgrade Money",
	Placeholder = "		",
	Default = Settings.Auto_Upgrade_Money,
	Callback = function(text)
		Settings.Auto_Upgrade_Money = text
		Save()
	end
})

AutomationSection:AddTextBox({
	Name = "Auto Upgrade Wave",
	Placeholder = "		",
	Default = Settings.Auto_Upgrade_Wave,
	Callback = function(text)
		Settings.Auto_Upgrade_Wave = text
		Save()
	end
})

AutomationSection:AddTextBox({
	Name = "Stop Auto Upgrade At Wave",
	Placeholder = "		",
	Default = Settings.Auto_Upgrade_Wave_Stop,
	Callback = function(text)
		Settings.Auto_Upgrade_Wave_Stop = text
		Save()
	end
})

AutomationSection:AddTextBox({
	Name = "Auto Sell At Wave",
	Placeholder = "		",
	Default = Settings.Auto_Upgrade_Wave_Sell,
	Callback = function(text)
		Settings.Auto_Upgrade_Wave_Sell = text
		Save()
	end
})



local Lobbytqab = Window:DrawTab({
	Name = "Lobby Tab",
	Icon = "flag",
	EnableScrolling = true
});

local lobbysc = Lobbytqab:DrawSection({
	Name = "Lobby Script",
	Position = 'left'	
});


lobbysc:AddToggle({
	Name = "Auto Join Game",
	Default = Settings.Auto_Join_Game,
	Callback = function(value)
		Settings.Auto_Join_Game = value
		Save()

		if value and is_lobby() then
			task.spawn(AutoJoinGame)
		end
	end
});

lobbysc:AddToggle({
	Name = "Auto Join Tower",
	Default = Settings.Auto_Join_Tower,
	Callback = function(value)
		Settings.Auto_Join_Tower = value
		Save()

		if value and is_lobby() then
			task.spawn(AutoTower)
		end
	end
});


lobbysc:AddToggle({
	Name = "Auto Evolve EXP",
	Default = Settings.Auto_Evolve_Exp,
	Callback = function(value)
		Settings.Auto_Evolve_Exp = value
		Save()

		if value and is_lobby() then
			task.spawn(AutoEvolveEXP)
		end
	end
});


lobbysc:AddToggle({
	Name = "Auto Click Popup",
	Default = Settings.Auto_Skip_Gui,
	Callback = function(value)
		Settings.Auto_Skip_Gui = value
		Save()

		if value then
			task.spawn(AutoSkipGUI)
		end
	end
});



local atjsc = Lobbytqab:DrawSection({
	Name = "Auto Join Settings",
	Position = 'right'	
});


atjsc:AddSlider({
	Name = "Auto Join Delay",
	Min = 0,
	Max = 60,
	Default = Settings.Auto_Join_Delay,
	Round = 0,
	Callback = function(value)
		Settings.Auto_Join_Delay = value
		Save()
	end
});


atjsc:AddDropdown({
	Name = "Mode",
	Default = Settings.Auto_Join_Mode,
	Flag = "Single_Dropdown",
	Values = {
		"Story",
		"Infinite",
		"Adventure",
		"Time Chamber",
		"Team Event",
		"Bakugan Event"
	},
	Callback = function(value)
		Settings.Auto_Join_Mode = value
		Save()
	end
})


atjsc:AddSlider({
	Name = "Story Level",
	Min = 0,
	Max = get_number_missions(),
	Default = Settings.Auto_Join_Story_Level,
	Round = 0,
	Callback = function(value)
		Settings.Auto_Join_Story_Level = value
		Save()
	end
});

if InfiniteMapTable[Settings.Auto_Join_Infinite_Level] == nil then
	Settings.Auto_Join_Infinite_Level = "-1"
	Save()
end


atjsc:AddDropdown({
	Name = "Infinite Map Selection",
	Default = Settings.Auto_Join_Infinite_Level,
	Values = GetMapsFromTable(InfiniteMapTable),
	Callback = function(option)
		for k, v in pairs(InfiniteMapTable) do
			if v == option then
				Settings.Auto_Join_Infinite_Level = k
				Save()
				break
			end
		end
	end
})
if AdventureMapTable[Settings.Auto_Join_Adventure_Level] == nil then
	Settings.Auto_Join_Adventure_Level = "-1133"
	Save()
end


atjsc:AddDropdown({
	Name = "Adventure Map Selection",
	Default = Settings.Auto_Join_Adventure_Level,
	Values = GetMapsFromTable(AdventureMapTable),
	Callback = function(option)
		for k, v in pairs(AdventureMapTable) do
			if v == option then
				Settings.Auto_Join_Adventure_Level = k
				Save()
				break
			end
		end
	end
})

local wht = Window:DrawTab({
	Name = "Webhook Tab",
	Icon = "bell",
	EnableScrolling = true
});


local whsc = wht:DrawSection({
	Name = "WebHook",
	Position = 'left'	
});

whsc:AddTextBox({
	Name = "URL",
	Placeholder = "here",
	Default = Settings.Webhook_Url,
	Callback = function(text)
		Settings.Webhook_Url = text
		Save()
	end
})

whsc:AddTextBox({
	Name = "Discord ID",
	Placeholder = "here",
	Default = Settings.Webhook_Discord_Id,
	Callback = function(text)
		Settings.Webhook_Discord_Id = text
		Save()
	end
})

whsc:AddToggle({
	Name = "Ping User",
	Default = Settings.Webhook_Ping_User,
	Callback = function(value)
		Settings.Webhook_Ping_User = value
		Save()
	end
});


whsc:AddButton({
	Name = "Test Webhook",
	Callback = function()
		SendWebhook_TEST()
	end
})


whsc:AddColorPicker({
	Name = "Webhook color",
	Default = Color3.fromHex(Settings.Webhook_Color),
	Callback = function(value)
		Settings.Webhook_Color = value:ToHex()
		Save()
	end,
})

whsc:AddToggle({
	Name = "Send webhook on game end",
	Default = Settings.Webhook_End_Game,
	Callback = function(value)
		Settings.Webhook_End_Game = value
		Save()
	end
});

whsc:AddToggle({
	Name = "Send webhook after exp evolve",
	Default = Settings.Webhook_Exp_Evolved,
	Callback = function(value)
		Settings.Webhook_Exp_Evolved = value
		Save()
	end
});



Window:DrawCategory({
	Name = "Misc"
});

local SettingTab = Window:DrawTab({
	Icon = "settings-3",
	Name = "Settings",
	Type = "Single",
	EnableScrolling = true
});

local ThemeTab = Window:DrawTab({
	Icon = "paintbrush",
	Name = "Themes",
	Type = "Single"
});

local Settings = SettingTab:DrawSection({
	Name = "UI Settings",
});

Settings:AddToggle({
	Name = "Alway Show Frame",
	Default = false,
	Callback = function(v)
		Window.AlwayShowTab = v;
	end,
});

Settings:AddColorPicker({
	Name = "Highlight",
	Default = Compkiller.Colors.Highlight,
	Callback = function(v)
		Compkiller.Colors.Highlight = v;
		Compkiller:RefreshCurrentColor();
	end,
});

Settings:AddColorPicker({
	Name = "Toggle Color",
	Default = Compkiller.Colors.Toggle,
	Callback = function(v)
		Compkiller.Colors.Toggle = v;
		
		Compkiller:RefreshCurrentColor(v);
	end,
});

Settings:AddColorPicker({
	Name = "Drop Color",
	Default = Compkiller.Colors.DropColor,
	Callback = function(v)
		Compkiller.Colors.DropColor = v;

		Compkiller:RefreshCurrentColor(v);
	end,
});

Settings:AddColorPicker({
	Name = "Risky",
	Default = Compkiller.Colors.Risky,
	Callback = function(v)
		Compkiller.Colors.Risky = v;

		Compkiller:RefreshCurrentColor(v);
	end,
});

Settings:AddColorPicker({
	Name = "Mouse Enter",
	Default = Compkiller.Colors.MouseEnter,
	Callback = function(v)
		Compkiller.Colors.MouseEnter = v;

		Compkiller:RefreshCurrentColor(v);
	end,
});

Settings:AddColorPicker({
	Name = "Block Color",
	Default = Compkiller.Colors.BlockColor,
	Callback = function(v)
		Compkiller.Colors.BlockColor = v;

		Compkiller:RefreshCurrentColor(v);
	end,
});

Settings:AddColorPicker({
	Name = "Background Color",
	Default = Compkiller.Colors.BGDBColor,
	Callback = function(v)
		Compkiller.Colors.BGDBColor = v;

		Compkiller:RefreshCurrentColor(v);
	end,
});

Settings:AddColorPicker({
	Name = "Block Background Color",
	Default = Compkiller.Colors.BlockBackground,
	Callback = function(v)
		Compkiller.Colors.BlockBackground = v;

		Compkiller:RefreshCurrentColor(v);
	end,
});

Settings:AddColorPicker({
	Name = "Stroke Color",
	Default = Compkiller.Colors.StrokeColor,
	Callback = function(v)
		Compkiller.Colors.StrokeColor = v;

		Compkiller:RefreshCurrentColor(v);
	end,
});

Settings:AddColorPicker({
	Name = "High Stroke Color",
	Default = Compkiller.Colors.HighStrokeColor,
	Callback = function(v)
		Compkiller.Colors.HighStrokeColor = v;

		Compkiller:RefreshCurrentColor(v);
	end,
});

Settings:AddColorPicker({
	Name = "Switch Color",
	Default = Compkiller.Colors.SwitchColor,
	Callback = function(v)
		Compkiller.Colors.SwitchColor = v;

		Compkiller:RefreshCurrentColor(v);
	end,
});

Settings:AddColorPicker({
	Name = "Line Color",
	Default = Compkiller.Colors.LineColor,
	Callback = function(v)
		Compkiller.Colors.LineColor = v;

		Compkiller:RefreshCurrentColor(v);
	end,
});

Settings:AddButton({
	Name = "Get Theme",
	Callback = function()
		print(Compkiller:GetTheme())
		
		Notifier.new({
			Title = "Notification",
			Content = "Copied Them Color to your clipboard",
			Duration = 5,
			Icon = "rbxassetid://120245531583106"
		});
	end,
});

ThemeTab:DrawSection({
	Name = "UI Themes"
}):AddDropdown({
	Name = "Select Theme",
	Default = "Default",
	Values = {
		"Default",
		"Dark Green",
		"Dark Blue",
		"Purple Rose",
		"Skeet"
	},
	Callback = function(v)
		Compkiller:SetTheme(v)
	end,
})

-- Creating Config Tab --
local ConfigUI = Window:DrawConfig({
	Name = "Config",
	Icon = "folder",
	Config = ConfigManager
});

ConfigUI:Init()


