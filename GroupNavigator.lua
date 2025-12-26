local ADDON, addon = ...
local config = addon.Config

local GamePadButtonList = addon.GamePadButtonList
local GamePadModifierList = addon.GamePadModifierList

local ActionList = {
   ["UNITNAVUP"] = true,
   ["UNITNAVDOWN"] = true,
   ["UNITNAVLEFT"] = true,
   ["UNITNAVRIGHT"] = true
}
config:ConfigListAdd("GamePadActions", "CATEGORY_UNIT_NAVIGATION", ActionList, "NONE")
config:ConfigListAdd("GamePadModifierActions", "CATEGORY_UNIT_NAVIGATION", ActionList, "NONE")

local GroupNavigatorMixin = {
   SoftTargetFrame = CrossHotbarAddon_GroupNavigator_SoftTarget,
   ActiveBindings = {}
}

function GroupNavigatorMixin:OnLoad()
   self:RegisterEvent("ADDON_LOADED")
   self:RegisterEvent("GROUP_JOINED")
   self:RegisterEvent("GROUP_LEFT")
   self:RegisterEvent("GROUP_ROSTER_UPDATE")
   self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
   self:RegisterEvent("UNIT_NAME_UPDATE")
   self:RegisterEvent("PLAYER_ROLES_ASSIGNED")
   self:RegisterEvent("PLAYER_ENTERING_WORLD")
   self:WrapOnClick()
   
   addon:AddApplyCallback(GenerateClosure(self.ApplyConfig, self))
end

function GroupNavigatorMixin:OnEvent(event, ...)
   if event == "ADDON_LOADED" then
      self:updateRoster()
      local value = GetCVarBool("ActionButtonUseKeyDown");
      self:RegisterForClicks("AnyUp", "AnyDown")
      self:UnregisterEvent("ADDON_LOADED")
   elseif event == "GROUP_JOINED" then
      self:updateRoster()
   elseif event == "GROUP_LEFT" then
      self:updateRoster()
      self.SoftTargetFrame:SetAlpha(0)      
      if not InCombatLockdown() then
         self.SoftTargetFrame:Hide()
      end
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
      local texCoords = { ["Raid-TargetFrame"] = { 0.00781250, 0.55468750, 0.28906250, 0.55468750 }}
      
      self.SoftTargetFrame.selectionHighlight:SetTexture("Interface\\RaidFrame\\Raid-FrameHighlights");
      self.SoftTargetFrame.selectionHighlight:SetTexCoord(unpack(texCoords["Raid-TargetFrame"]));
      self.SoftTargetFrame.selectionHighlight:SetVertexColor(0.2, 1.0, 0.6);
      self.SoftTargetFrame.selectionHighlight:SetAllPoints(self.SoftTargetFrame);
      
      self.SoftTargetFrame:SetAlpha(0)
      self.SoftTargetFrame:Hide()
      
      SecureHandlerSetFrameRef(self, "softtarget", self.SoftTargetFrame)
      if UnitInRaid("player") or UnitInParty("player") then
         self:updateRoster()
      end
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
end

function GroupNavigatorMixin:updateRoster() 
   if not InCombatLockdown() then 
      local raid_id = UnitInRaid("player")
      if raid_id then
         self:SetAttribute("player_id", "raid"..raid_id)
         self:SetAttribute("group_change", "true")
         self:AddUnitFrameRefs()
      elseif UnitInParty("player") then
         self:SetAttribute("player_id", "player")
         self:SetAttribute("group_change", "true")
         self:AddUnitFrameRefs()
      end
   end
end

function GroupNavigatorMixin:AddUnitFrameRefs()

   if not InCombatLockdown() then 
      local inparty = true
      local groupType = CompactRaidGroupTypeEnum.Party;
      if UnitInRaid("player") then 
         inparty = false
         groupType = CompactRaidGroupTypeEnum.Raid;
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
            self:WrapOnClick()
         end
      end
      
      if hasUnits == false then
         if inparty == false then
            for i = 1,8 do
               for j = 1,5 do
                  local frame = _G["CompactRaidGroup"..i.."Member"..j]
                  if frame and frame:IsVisible() then 
                     local frame_unit = frame:GetAttribute("unit")
                     if frame_unit then
                        hasUnits = true
                        SecureHandlerSetFrameRef(self, i .. "_" .. j, frame)
                     end
                  end               
                  local frame = _G["CellRaidFrameHeader"..i.."UnitButton"..j]
                  if frame and frame:IsVisible() then
                     local frame_unit = frame:GetAttribute("unit")
                     if frame_unit then
                        hasUnits = true
                        SecureHandlerSetFrameRef(self, i .. "_" .. j, frame)
                     end
                  end
                  local frame = _G["Grid2LayoutHeader"..i.."UnitButton"..j]
                  if frame and frame:IsVisible() then
                     local frame_unit = frame:GetAttribute("unit")
                     if frame_unit then
                        hasUnits = true
                        SecureHandlerSetFrameRef(self, i .. "_" .. j, frame)
                     end
                  end
                  local frame = _G["ElvUF_Raid1Group"..i.."UnitButton"..j]
                  if frame and frame:IsVisible() then
                     local frame_unit = frame:GetAttribute("unit")
                     if frame_unit then
                        hasUnits = true
                        SecureHandlerSetFrameRef(self, i .. "_" .. j, frame)
                     end
                  end
                  local frame = _G["ElvUF_Raid2Group"..i.."UnitButton"..j]
                  if frame and frame:IsVisible() then
                     local frame_unit = frame:GetAttribute("unit")
                     if frame_unit then
                        hasUnits = true
                        SecureHandlerSetFrameRef(self, i .. "_" .. j, frame)
                     end
                  end
                  local frame = _G["ElvUF_Raid3Group"..i.."UnitButton"..j]
                  if frame and frame:IsVisible() then
                     local frame_unit = frame:GetAttribute("unit")
                     if frame_unit then
                        hasUnits = true
                        SecureHandlerSetFrameRef(self, i .. "_" .. j, frame)
                     end
                  end
               end
            end
            self:SetAttribute("max_group", 8)
            self:SetAttribute("max_unit", 5)
            self:WrapOnClick()
         else
            for j = 1,5 do
               local frame = _G["PartyFrame"]
               if frame and frame:IsVisible() then
                  local memberFrame = frame["MemberFrame" .. j]
                  if memberFrame and memberFrame:IsVisible() then
                     local frame_unit = memberFrame:GetAttribute("unit")
                     if frame_unit then
                        hasUnits = true
                        SecureHandlerSetFrameRef(self, "1_" .. j, memberFrame)
                     end
                  end
               end
               local frame = _G["CompactPartyFrameMember"..j]
               if frame and frame:IsVisible() then
                  local frame_unit = frame:GetAttribute("unit")
                  if frame_unit then
                     hasUnits = true
                     SecureHandlerSetFrameRef(self, "1_" .. j, frame)
                  end
               end
               local frame = _G["CellPartyFrameHeaderUnitButton"..j]
               if frame and frame:IsVisible() then
                  local frame_unit = frame:GetAttribute("unit")
                  if frame_unit then
                     hasUnits = true
                     SecureHandlerSetFrameRef(self, "1_" .. j, frame)
                  end
               end
               local frame = _G["Grid2LayoutHeader1UnitButton"..j]
               if frame and frame:IsVisible() then
                  local frame_unit = frame:GetAttribute("unit")
                  if frame_unit then
                     hasUnits = true
                     SecureHandlerSetFrameRef(self, "1_" .. j, frame)
                  end
               end
               local frame = _G["ElvUF_PartyGroup1UnitButton"..j]
               if frame and frame:IsVisible() then
                  local frame_unit = frame:GetAttribute("unit")
                  if frame_unit then
                     hasUnits = true
                     SecureHandlerSetFrameRef(self, "1_" .. j, frame)
                  end
               end              
            end            
            self:SetAttribute("max_group", 1)
            self:SetAttribute("max_unit", 5)
            self:WrapOnClick()
         end
      end
      
      if hasUnits then
         self.SoftTargetFrame:Show()
         SecureHandlerSetFrameRef(self, "softtarget", self.SoftTargetFrame)
      else
         self.SoftTargetFrame:Hide()
      end
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
      -- print("Re-Calc Units")

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
                  -- print("hidden")
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
            local softtarget = self:GetFrameRef("softtarget")
            local frame = group_units[lastgroup][lastunit]

            if softtarget then
               if frame and frame:IsVisible() then
                  if softtarget:GetParent() == frame then
                     unitfound = true
                  end
               end
            end
            
            if unitfound then
               if UnitPlayerOrPetInRaid("target") or
                  UnitPlayerOrPetInParty("target") then
    
                  if button == "Button4" then
                     lastunit = (lastunit + num_units - 1) % num_units
                  elseif button == "Button5" then
                     lastunit = (lastunit + 1) % num_units
                  elseif button == "LeftButton" then
                     lastgroup = (lastgroup + num_groups - 1) % num_groups
                  elseif button == "RightButton" then
                     lastgroup = (lastgroup + 1) % num_groups
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

                  -- print(lastgroup, lastunit)
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
               if softtarget then
                  softtarget:SetParent(frame)
                  softtarget:ClearAllPoints()
                  softtarget:SetPoint("CENTER", frame, "CENTER")
                  local frameWidth = frame:GetWidth();
                  local frameHeight = frame:GetHeight();
                  softtarget:SetWidth(frameWidth+6)
                  softtarget:SetHeight(frameHeight+6)
                  softtarget:SetAlpha(0.75)
               end
            elseif softtarget then
               softtarget:SetAlpha(0)
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
   local GroupNavigator = CreateFrame("Button", ADDON .. "GroupNavigator", parent,
                                      "SecureActionButtonTemplate, SecureHandlerStateTemplate")

   Mixin(GroupNavigator, GroupNavigatorMixin)

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
   GroupNavigator:SetAttribute("group_change", "true")
   GroupNavigator:SetAttribute("max_group", 1)
   GroupNavigator:SetAttribute("max_unit", 5)

   GroupNavigator:AddStateHandlers()

   GroupNavigator:HookScript("OnEvent", GroupNavigator.OnEvent)
   GroupNavigator:OnLoad()

   addon.GroupNavigator = GroupNavigator
end

addon.CreateGroupNavigator = CreateGroupNavigator
