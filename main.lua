---@diagnostic disable:lowercase-global
local addonName, addon = ...

ZUIDB = {}
local T = ZUIDB

local defaults = {
    scale = 1,
    pt = "TOP",
    relTo = "UIParent",
    relPt = "TOP",
    pos = {
        x = 0,
        y = 0
    }
}


SLASH_KLG1 = "/klg"
SlashCmdList["KLG"] = function(input)
    local userInput = tonumber(input)
    if userInput then
        ZUIDB.scale = userInput
        ChangeFrameScaling()
    else
        Help()
    end
end

function AddMapOverlay()
    if WorldMapFrame then
        local relativeTo = T.relTo and _G[T.relTo] or UIParent

        WorldMapFrame:SetPoint(T.pt, relativeTo, T.relPt, T.pos.x , T.pos.y)
        WorldMapFrame:SetScale(T.scale);
        WorldMapFrame:SetMovable(true);
        WorldMapFrame:RegisterForDrag("LeftButton");
        WorldMapFrame:SetScript("OnDragStart", function(self) self:StartMoving() end);
        WorldMapFrame:SetScript("OnDragStop", function(self)
            self:StopMovingOrSizing()
            local point, relativeToFrame, relativePoint, offsetX, offsetY = self:GetPoint()
            T.pt = point
            T.relTo = relativeToFrame and relativeToFrame:GetName() or "UIParent"
            T.relPt = relativePoint
            T.pos.x = offsetX
            T.pos.y = offsetY
        end)
    end
end


function ChangeFrameScaling()
    PlayerSpellsFrame:SetScale(ZUIDB.scale)
    PlayerSpellsFrame:SetMovable(true);
    PlayerSpellsFrame:RegisterForDrag("LeftButton");
    PlayerSpellsFrame:SetScript("OnDragStart", function(self) self:StartMoving() end);
    PlayerSpellsFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);

    GameMenuFrame:SetScale(ZUIDB.scale);
    MinimapCluster:SetScale(ZUIDB.scale);
    TalkingHeadFrame:SetScale(ZUIDB.scale)
end

function Trunc(value)
    newVal = math.floor(value * 100) / 100
    return newVal
end

function InitMap()
    PlayerSpellsFrame:Show();
    PlayerSpellsFrame:SetScale(T.scale)
    PlayerSpellsFrame:Hide();
end

EventRegistry:RegisterCallback("PlayerSpellsFrame.SpellBookFrame.Show", function()
    PlayerSpellsFrame:ClearAllPoints();
    ChangeFrameScaling();
end)

EventRegistry:RegisterCallback("PlayerSpellsFrame.TalentTab.Show", function()
    PlayerSpellsFrame:ClearAllPoints();
    ChangeFrameScaling();
end)

EventRegistry:RegisterCallback("PlayerSpellsFrame.SpecFrame.Show", function()
    PlayerSpellsFrame:ClearAllPoints();
    ChangeFrameScaling();
end)

-- function Save()
--     ZUIDB.pt = T.pt
--     ZUIDB.relTo = T.relTo
--     ZUIDB.relPt = T.relPt
--     ZUIDB.pos.x = T.pos.x
--     ZUIDB.pos.y = T.pos.y
--     ZUIDB.scale = T.scale
-- end

-- local f = CreateFrame("FRAME")
-- f:RegisterEvent("ADDON_LOADED")
-- f:RegisterEvent("PLAYER_ENTERING_WORLD")
-- f:RegisterEvent("PLAYER_LEAVING_WORLD")
-- f:SetScript("OnEvent", function(self, event, arg1, ...)
--     if event == "ADDON_LOADED" and arg1 == addonName then
--     ZUIDB = ZUIDB or {}
--     T = ZUIDB

--     for k, v in pairs(defaults) do
--         if T[k] == nil then
--             T[k] = v
--         end
--     end
--     f:UnregisterEvent("ADDON_LOADED");
--     elseif event == "PLAYER_ENTERING_WORLD" then
--         InitMap();
--         ChangeFrameScaling();
--         f:UnregisterEvent("PLAYER_ENTERING_WORLD");
--     elseif event == "PLAYER_LEAVING_WORLD" then
--         Save()
--     end
-- end)
