local addonName, addon = ...

---@diagnostic disable:undefined-global, rediefinedl-local

KludgeDB = KludgeDB or {}

if KludgeDB.Scale == nil then
    KludgeDB.Scale = 0.75
end

local function Help()
    print("|cFFFF0000Ope|r Please enter a value between 0.5 and 2.")
    print("Standard UI scaling is 1 (100%)")
end

local function UpdateScale(input)
    local n = tonumber(input)
    if n > 2 then
        Help()
        return4
    end
    GameMenuFrame:SetScale(n)
    MinimapCluster:SetScale(n)
    KludgeDB.Scale = n
end

SLASH_KLG1 = "/klg"
SlashCmdList["KLG"] = function (j)
    local k = tonumber(j)
    if k == nil then
        Help()
    end
    if k > 0 then        
        return UpdateScale(k)
    end
end

local f = CreateFrame("FRAME")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == addonName then
        C_Timer.NewTimer(5, function (self)
            GameMenuFrame:SetScale(KludgeDB.Scale)
            MinimapCluster:SetScale(KludgeDB.Scale)
        end)

        EventRegistry:RegisterCallback("PlayerSpellsFrame.SpellBookFrame.Show", function()
            PlayerSpellsFrame:SetScale(KludgeDB.Scale)
            PlayerSpellsFrame:SetMovable(true);
            PlayerSpellsFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);
            PlayerSpellsFrame:RegisterForDrag("LeftButton");
            PlayerSpellsFrame:SetScript("OnDragStart", function(self) self:StartMoving() end);

        end)
        EventRegistry:RegisterCallback("PlayerSpellsFrame.TalentTab.Show", function()
            PlayerSpellsFrame:SetScale(KludgeDB.Scale)
        end)

    end
end)


