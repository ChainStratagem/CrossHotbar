local ADDON, addon = ...
local config = addon.Config

local GamePadButtonList = addon.GamePadButtonList
local GamePadModifierList = addon.GamePadModifierList

local ActionList = {
   {"UNITNAVUP", true},
   {"UNITNAVDOWN", true},
   {"UNITNAVLEFT", true},
   {"UNITNAVRIGHT", true}
}

addon:ActionListAdd("GamePadActions", "CATEGORY_UNIT_NAVIGATION", ActionList, "NONE")
addon:ActionListAdd("GamePadModifierActions", "CATEGORY_UNIT_NAVIGATION", ActionList, "NONE")
ActionList = addon:ActionListToTable(ActionList)

local PartyOrientationList = {
   {"VERTICAL", true},
   {"HORIZONTAL", true}
}

addon:ActionListAdd("PartyOrientation", "CATEGORY_UNIT_PARTYORIENTATION", PartyOrientationList)
PartyOrientationList = addon:ActionListToTable(PartyOrientationList)

local RaidOrientationList = {
   {"VERTICAL", true},
   {"HORIZONTAL", true}
}

addon:ActionListAdd("RaidOrientation", "CATEGORY_UNIT_RAIDORIENTATION", RaidOrientationList)
RaidOrientationList = addon:ActionListToTable(RaidOrientationList)

local GroupNavigatorMixin = {
   SoftTargetFrame = nil,
   ActiveBindings = {},
   PartyIsVertical = true,
   RaidIsVertical = true
}

function GroupNavigatorMixin:OnLoad()
   self:RegisterForClicks("AnyUp", "AnyDown")
   self:RegisterEvent("ADDON_LOADED")
   self:RegisterEvent("GROUP_JOINED")
   self:RegisterEvent("GROUP_LEFT")
   self:RegisterEvent("GROUP_ROSTER_UPDATE")
   self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
   self:RegisterEvent("UNIT_NAME_UPDATE")
   self:RegisterEvent("PLAYER_ROLES_ASSIGNED")
   self:RegisterEvent("PLAYER_ENTERING_WORLD")
   self:RegisterEvent("PLAYER_TARGET_CHANGED")
   self:WrapOnClick()
   
   addon:AddApplyCallback(GenerateClosure(self.ApplyConfig, self))
end

function GroupNavigatorMixin:OnEvent(event, ...)
   if event == "ADDON_LOADED" then
      self:updateRoster()
      --self:UnregisterEvent("ADDON_LOADED")
   elseif event == "GROUP_JOINED" then
      self:updateRoster()
   elseif event == "GROUP_LEFT" then
      self:updateRoster()
      self.SoftTargetFrame:Hide()
   elseif event == "GROUP_ROSTER_UPDATE" then
      self:updateRoster()
   elseif event == "ZONE_CHANGED_NEW_AREA" then
      self:updateRoster()
   elseif event == "UNIT_NAME_UPDATE" then
      self:updateRoster()
   elseif event == "PLAYER_ROLES_ASSIGNED" then
      self:updateRoster()                        
   elseif event == "PLAYER_ENTERING_WORLD" then
      self:updateRoster()
      if ChatFrame1EditBox then
         ChatFrame1EditBox:SetAltArrowKeyMode(false)
      end
      self.SoftTargetFrame:Hide()      
      self:updateRoster()
   elseif event == "PLAYER_TARGET_CHANGED" then
      local active = false
      if UnitInRaid("player") or UnitInParty("player") then
         if UnitInRaid("target") or UnitInParty("target") then
            if GetUnitName("target") == GetUnitName(self:GetAttribute("unit")) then
               active = true
            end
         end
      end
      self:SetSoftTargetActive(active)
   end
end

function GroupNavigatorMixin:AddStateHandlers()
   self:SetAttribute("modstate", 0)
   self:SetAttribute("modname", "")
   
   self:SetAttribute("SetActionBindings", [[
      local prefix = ...
      if prefix == "" or prefix == "TRIG" then
         self:ClearBindings()
      end
      local binding = self:GetAttribute(prefix .. "UNITNAVUP")
      if binding and binding ~= "" then self:SetBindingClick(true, binding, self:GetName(), "Button4") end
      binding = self:GetAttribute(prefix .. "UNITNAVDOWN")                  
      if binding and binding ~= "" then self:SetBindingClick(true, binding, self:GetName(), "Button5") end
      binding = self:GetAttribute(prefix .. "UNITNAVLEFT")                  
      if binding and binding ~= "" then self:SetBindingClick(true, binding, self:GetName(), "LeftButton") end
      binding = self:GetAttribute(prefix .. "UNITNAVRIGHT")
      if binding and binding ~= "" then self:SetBindingClick(true, binding, self:GetName(), "RightButton") end
    ]])
end

function GroupNavigatorMixin:ClearConfig()
   for action in pairs(ActionList) do
      self:SetAttribute(action, "")
      for i,modifier in ipairs(GamePadModifierList) do
         self:SetAttribute(modifier .. action, "")
      end
   end
end

function GroupNavigatorMixin:ApplyConfig()
   self:ClearConfig()
   self.ActiveBindings = {}
   for button, attributes in pairs(config.PadActions) do
      if ActionList[ attributes.ACTION ] then
         self:SetAttribute(attributes.ACTION, attributes.BIND)
      end
      
      for i,modifier in ipairs(GamePadModifierList) do
         if ActionList[ attributes[modifier .. "ACTION"] ] then
            self:SetAttribute(modifier .. attributes[modifier .. "ACTION"], attributes.BIND)
            self:SetAttribute(modifier .. "TRIG" .. attributes[modifier .. "ACTION"], attributes.BIND)
         end
      end
   end
   self:Execute([[ self:ClearBindings(); self:RunAttribute("SetActionBindings", "") ]])

   self.SoftTargetFrame.activeHighlight:SetVertexColor(unpack(config.Interface.UnitTargetActiveColor));
   self.SoftTargetFrame.activeHighlight.isEnabled = config.Interface.UnitTargetActiveEnable
   self.SoftTargetFrame.inactiveHighlight:SetVertexColor(unpack(config.Interface.UnitTargetInActiveColor));
   self.SoftTargetFrame.inactiveHighlight.isEnabled = config.Interface.UnitTargetInActiveEnable

   local padding = config.Interface.UnitTargetPadding
   self.SoftTargetFrame.activeHighlight:SetPoint("TOPLEFT", self.SoftTargetFrame, "TOPLEFT", -1*padding, padding)
   self.SoftTargetFrame.activeHighlight:SetPoint("BOTTOMRIGHT", self.SoftTargetFrame, "BOTTOMRIGHT", padding, -1*padding)
   self.SoftTargetFrame.inactiveHighlight:SetPoint("TOPLEFT", self.SoftTargetFrame, "TOPLEFT", -1*padding, padding)
   self.SoftTargetFrame.inactiveHighlight:SetPoint("BOTTOMRIGHT", self.SoftTargetFrame, "BOTTOMRIGHT", padding, -1*padding)

   self.PartyIsVertical = (config.Interface.UnitPartyOrientation == "VERTICAL")
   self.RaidIsVertical = (config.Interface.UnitRaidOrientation == "VERTICAL")

   if UnitInRaid("player") then 
      self:SetAttribute("group_vertical", self.RaidIsVertical)
   elseif UnitInParty("player") then
      self:SetAttribute("group_vertical", self.PartyIsVertical)
   end
end

function GroupNavigatorMixin:updateRoster() 
   if not InCombatLockdown() then 
      local raid_id = UnitInRaid("player")
      if raid_id then
         self:SetAttribute("player_id", "raid"..raid_id)
         self:SetAttribute("group_change", true)
         self:AddUnitFrameRefs()
      elseif UnitInParty("player") then
         self:SetAttribute("player_id", "player")
         self:SetAttribute("group_change", true)
         self:AddUnitFrameRefs()
      end
   end
end

function GroupNavigatorMixin:AddUnitFrameRefs()
   if not InCombatLockdown() then
      self.units =  {}
      local inparty = true
      if UnitInRaid("player") then 
         inparty = false
         self:SetAttribute("group_vertical", self.RaidIsVertical)
      else
         self:SetAttribute("group_vertical", self.PartyIsVertical)
      end

      local hasUnits = false
      
      if CompactRaidFrameContainer.groupMode == "flush" then
         --local orientation = CompactRaidFrameContainer.flowOrientation
         local maxPerLine = CompactRaidFrameContainer.flowMaxPerLine
         local i = 1
         local j = 1
         local max_i = 0
         local max_j = 0
         for _,frame in pairs(CompactRaidFrameContainer.flowFrames) do
            if frame and frame.IsVisible and frame:IsVisible() then 
               if frame.unit then
                  hasUnits = true
                  if max_i < i then max_i = i end
                  if max_j < j then max_j = j end
                  self.units[i .. "_" .. j] = frame
                  SecureHandlerSetFrameRef(self, i .. "_" .. j, frame)
                  j = j + 1
                  if j > (maxPerLine) then
                     i = i + 1
                     j = 1
                  end
               end
            end
         end         
         if hasUnits == true then
            self:SetAttribute("max_group", max_i)
            self:SetAttribute("max_unit", max_j)
            self.SoftTargetFrame:Show()
         end
      end
      
      if hasUnits == false then
         if inparty == false then
            for i = 1,8 do
               for j = 1,5 do
                  
                  local framePrefixes = {
                     {"CompactRaidGroup", "Member"},
                     {"CellRaidFrameHeader", "UnitButton"},
                     {"Grid2LayoutHeader", "UnitButton"},
                     {"ElvUF_Raid1Group", "UnitButton"},
                     {"ElvUF_Raid2Group", "UnitButton"},
                     {"ElvUF_Raid3Group", "UnitButton"}
                  }
                  
                  for _,prefix in ipairs(framePrefixes) do
                     local frame = _G[prefix[1] .. i .. prefix[2] ..j]
                     if frame and frame:IsVisible() then 
                        local frame_unit = frame:GetAttribute("unit")
                        if frame_unit then
                           hasUnits = true
                        self.units[i .. "_" .. j] = frame
                        SecureHandlerSetFrameRef(self, i .. "_" .. j, frame)
                        end
                     end
                  end
               end
            end
            if hasUnits then
               self:SetAttribute("max_group", 8)
               self:SetAttribute("max_unit", 5)
               self.SoftTargetFrame:Show()
            end
         else
            for j = 1,5 do
               local frame = _G["PartyFrame"]
               if frame and frame:IsVisible() then
                  local memberFrame = frame["MemberFrame" .. j]
                  if memberFrame and memberFrame:IsVisible() then
                     local frame_unit = memberFrame:GetAttribute("unit")
                     if frame_unit then
                        hasUnits = true
                        self.units["1_" .. j] = memberFrame
                        SecureHandlerSetFrameRef(self, "1_" .. j, memberFrame)
                     end
                  end
               end
               
               local framePrefixes = {
                  "CompactPartyFrameMember",
                  "CellPartyFrameHeaderUnitButton",
                  "Grid2LayoutHeader1UnitButton",
                  "ElvUF_PartyGroup1UnitButton"
               }
            
               for _,prefix in ipairs(framePrefixes) do
                  local frame = _G[prefix .. j]
                  if frame and frame:IsVisible() then
                     local frame_unit = frame:GetAttribute("unit")
                     if frame_unit then
                        hasUnits = true
                        self.units["1_" .. j] = frame
                        SecureHandlerSetFrameRef(self, "1_" .. j, frame)
                     end
                  end
               end
            end
            if hasUnits then
               self:SetAttribute("max_group", 1)
               self:SetAttribute("max_unit", 5)
               self.SoftTargetFrame:Show()
            end
         end
      end
   end
end

function GroupNavigatorMixin:SetSoftTargetActive(active)
   if active then
      self.SoftTargetFrame.activeHighlight:SetShown(self.SoftTargetFrame.activeHighlight.isEnabled)
      self.SoftTargetFrame.inactiveHighlight:Hide()
   else
      self.SoftTargetFrame.activeHighlight:Hide()
      self.SoftTargetFrame.inactiveHighlight:SetShown(self.SoftTargetFrame.inactiveHighlight.isEnabled)
   end
end

function GroupNavigatorMixin:UpdateSoftTarget(frameName)
   local frame = self.units[frameName]
   if frame then
      self.SoftTargetFrame:SetAllPoints(frame)
   end
end

function GroupNavigatorMixin:WrapOnClick()
   SecureHandlerUnwrapScript(self, "OnClick")
   SecureHandlerWrapScript(self, "OnClick", self,  [[

   if not down then return end

   if not lastunit then lastunit = 1 end
   if not lastgroup then lastgroup = 1 end

   local max_group = self:GetAttribute("max_group")
   local max_unit = self:GetAttribute("max_unit")
   local group_vertical = self:GetAttribute("group_vertical")

   local newunit = "player"
   local player_id = self:GetAttribute("player_id")
   local player_unit = 1
   local player_group = 1
   
   if not group_units then group_units = table.new() end
   if not hidden_units then hidden_units = table.new() end

   local num_units = 0
   local num_groups = #group_units
   local recalc = self:GetAttribute("group_change")

   for _,frame in pairs(hidden_units) do
      if frame and frame:IsVisible() then
         recalc = true;
      end
   end

   if recalc then
      group_units = table.new()
      hidden_units = table.new()

      for x = 1,max_group do
         local newgroup = true
         for y = 1,max_unit do
            local frame = self:GetFrameRef(x .. "_" .. y)
            if frame then
               if frame:IsVisible() then 
                  if newgroup then 
                     group_units[#group_units + 1] = table.new()
                     newgroup = false
                  end
                  table.insert(group_units[#group_units], frame)
                  if player_id == frame:GetAttribute("unit") then
                     player_unit = y
                     player_group = x
                  end
               else
                  table.insert(hidden_units, frame)
               end
            end
         end
      end

      num_groups = #group_units

      if num_groups > 0 then 
         if lastgroup > num_groups then
            lastgroup = num_groups
         end

         num_units = #(group_units[lastgroup])
         if num_units > 0 then
            if lastunit > num_units then
               lastunit = num_units
            end
         end
      end

      self:SetAttribute("group_change", false)
   end

   if num_groups > 0 then 
      num_units = #(group_units[lastgroup])
      if num_units > 0 then
         if PlayerInGroup() == "party" or PlayerInGroup() == "raid" then
            
            local unitfound = false
            local frame = group_units[lastgroup][lastunit]

            if frame and frame:IsVisible() then
               local target_frame = self:GetAttribute("target_frame")
               if target_frame == frame then
                  unitfound = true
               end
            end
            
            if unitfound then
               if UnitPlayerOrPetInRaid("target") or
                  UnitPlayerOrPetInParty("target") then

                  if group_vertical then
                     if button == "Button4" then
                        lastunit = (lastunit + num_units - 1) % num_units
                     elseif button == "Button5" then
                        lastunit = (lastunit + 1) % num_units
                     elseif button == "LeftButton" then
                        lastgroup = (lastgroup + num_groups - 1) % num_groups
                     elseif button == "RightButton" then
                        lastgroup = (lastgroup + 1) % num_groups
                     end
                  else
                     if button == "LeftButton" then
                        lastunit = (lastunit + num_units - 1) % num_units
                     elseif button == "RightButton" then
                        lastunit = (lastunit + 1) % num_units
                     elseif button == "Button4" then
                        lastgroup = (lastgroup + num_groups - 1) % num_groups
                     elseif button == "Button5" then
                        lastgroup = (lastgroup + 1) % num_groups
                     end
                  end
                  
                  if lastgroup == 0 then
                     lastgroup = num_groups
                  end
                  
                  num_units = #(group_units[lastgroup])
                  
                  if lastunit > num_units then
                     lastunit = num_units
                  elseif lastunit == 0 then
                     lastunit = num_units
                  end
               end
            else 
               lastgroup = player_group
               lastunit = player_unit
            end
            
            frame = nil
            if group_units[lastgroup] then 
               frame = group_units[lastgroup][lastunit]
            end

            if frame and frame:IsVisible() then
               newunit = frame:GetAttribute("unit")
               self:SetAttribute("unit", newunit)
               self:SetAttribute("target_frame", frame)
               self:CallMethod("UpdateSoftTarget", lastgroup .. "_" .. lastunit)
            else
               self:CallMethod("UpdateSoftTarget", nil)
               self:SetAttribute("group_change", true)
            end
            
         else
            self:SetAttribute("unit", newunit)
         end
      else
         self:SetAttribute("unit", newunit)
      end
   else
      self:SetAttribute("unit", newunit)
   end
   ]])
end

local CreateGroupNavigator = function(parent)

   local SoftTargetFrame = CreateFrame("Frame", ADDON .. "SoftTarget", UIParent)
   SoftTargetFrame:SetFrameStrata("MEDIUM")
   SoftTargetFrame:EnableMouse(false)
   SoftTargetFrame:SetFrameLevel(10)
   SoftTargetFrame:SetPoint("TOP", UIParent, "LEFT", 0, 0)
   
   SoftTargetFrame.activeHighlight = SoftTargetFrame:CreateTexture(nil, "OVERLAY")
   SoftTargetFrame.activeHighlight:SetTexture("Interface\\RaidFrame\\Raid-FrameHighlights");
   SoftTargetFrame.activeHighlight:SetTexCoord(0.00781250, 0.55468750, 0.28906250, 0.55468750 );
   SoftTargetFrame.activeHighlight:SetPoint("TOPLEFT", SoftTargetFrame, "TOPLEFT", -5, 5)
   SoftTargetFrame.activeHighlight:SetPoint("BOTTOMRIGHT", SoftTargetFrame, "BOTTOMRIGHT", 5, -5)
   SoftTargetFrame.activeHighlight:SetVertexColor(1.0, 1.0, 1.0);
   SoftTargetFrame.activeHighlight.isEnabled = true
   SoftTargetFrame.activeHighlight:Hide()
   
   SoftTargetFrame.inactiveHighlight = SoftTargetFrame:CreateTexture(nil, "OVERLAY")
   SoftTargetFrame.inactiveHighlight:SetTexture("Interface\\RaidFrame\\Raid-FrameHighlights");
   SoftTargetFrame.inactiveHighlight:SetTexCoord(0.00781250, 0.55468750, 0.28906250, 0.55468750 );
   SoftTargetFrame.inactiveHighlight:SetPoint("TOPLEFT", SoftTargetFrame, "TOPLEFT", -5, 5)
   SoftTargetFrame.inactiveHighlight:SetPoint("BOTTOMRIGHT", SoftTargetFrame, "BOTTOMRIGHT", 5, -5)
   SoftTargetFrame.inactiveHighlight:SetVertexColor(0.2, 1.0, 0.6);
   SoftTargetFrame.inactiveHighlight.isEnabled = true
   SoftTargetFrame.inactiveHighlight:Hide()
   SoftTargetFrame:Hide()
   
   local GroupNavigator = CreateFrame("Button", ADDON .. "GroupNavigator", parent,
                                      "SecureActionButtonTemplate, SecureHandlerStateTemplate")

   Mixin(GroupNavigator, GroupNavigatorMixin)

   GroupNavigator.SoftTargetFrame = SoftTargetFrame
   addon.SoftTargetFrame = SoftTargetFrame
   
   GroupNavigator:SetFrameStrata("BACKGROUND")
   GroupNavigator:SetPoint("TOP", parent:GetName(), "LEFT", 0, 0)
   GroupNavigator:Hide()

   GroupNavigator:SetAttribute("player_unit", "1")
   GroupNavigator:SetAttribute("player_group", "1")
   GroupNavigator:SetAttribute("*type1", "target")
   GroupNavigator:SetAttribute("*type2", "target")
   GroupNavigator:SetAttribute("*type3", "macro")
   GroupNavigator:SetAttribute("*type4", "target")
   GroupNavigator:SetAttribute("*type5", "target")
   GroupNavigator:SetAttribute("unit", "player")
   GroupNavigator:SetAttribute("group_change", true)
   GroupNavigator:SetAttribute("max_group", 1)
   GroupNavigator:SetAttribute("max_unit", 5)
   GroupNavigator:SetAttribute("group_vertical", true)

   GroupNavigator:AddStateHandlers()

   GroupNavigator:HookScript("OnEvent", GroupNavigator.OnEvent)
   GroupNavigator:OnLoad()

   addon.GroupNavigator = GroupNavigator
end

addon.CreateGroupNavigator = CreateGroupNavigator
