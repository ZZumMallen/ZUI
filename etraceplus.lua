local function LogEvent(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" or event == "COMBAT_LOG_EVENT" then
        self:LogEvent_Original(event, CombatLogGetCurrentEventInfo())
    elseif event == "COMBAT_TEXT_UPDATE" then
        self:LogEvent_Original(event, (...), GetCurrentCombatTextEventInfo())
    else
        self:LogEvent_Original(event, ...)
    end
end

local function OnEventTraceLoaded()
    EventTrace.LogEvent_Original = EventTrace.LogEvent
    EventTrace.LogEvent = LogEvent
end

if EventTrace then
    OnEventTraceLoaded()
else
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("ADDON_LOADED")
    frame:SetScript("OnEvent", function(self, event, ...)
        if event == "ADDON_LOADED" and (...) == "Blizzard_EventTrace" then
            OnEventTraceLoaded()
            self:UnregisterAllEvents()
        end
    end)
end
