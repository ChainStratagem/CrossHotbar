local ADDON, addon = ...
local config = addon.Config

local GamePadModifierList = addon.GamePadModifierList

local ActionList = {
   ["HOTBARBTN1"] = true,
   ["HOTBARBTN2"] = true,
   ["HOTBARBTN3"] = true,
   ["HOTBARBTN4"] = true,
   ["HOTBARBTN5"] = true,
   ["HOTBARBTN6"] = true,
   ["HOTBARBTN7"] = true,
   ["HOTBARBTN8"] = true,
   ["HOTBARBTN9"] = true,
   ["HOTBARBTN10"] = true,
   ["HOTBARBTN11"] = true,
   ["HOTBARBTN12"] = true
}
config:ConfigListAdd("HotbarActions", "CATEGORY_HOTBAR_ACTIONS", ActionList, "NONE")

CrossHotbarMixin = {}

function CrossHotbarMixin:SetupCrosshotbar()
   self.LHotbar = { WXHBLHotbar1, WXHBLHotbar2, WXHBLHotbar3 }
   self.RHotbar = { WXHBRHotbar1, WXHBRHotbar2, WXHBRHotbar3 }
   self.MHotbar = { WXHBLRHotbar1, WXHBRLHotbar1 }
   
   SecureHandlerSetFrameRef(self, 'Hotbar1', WXHBLHotbar1)
   SecureHandlerSetFrameRef(self, 'Hotbar2', WXHBLHotbar2)
   SecureHandlerSetFrameRef(self, 'Hotbar3', WXHBLHotbar3)
   SecureHandlerSetFrameRef(self, 'Hotbar4', WXHBRHotbar1)
   SecureHandlerSetFrameRef(self, 'Hotbar5', WXHBRHotbar2)
   SecureHandlerSetFrameRef(self, 'Hotbar6', WXHBRHotbar3)
   SecureHandlerSetFrameRef(self, 'Hotbar7', WXHBLRHotbar1)
   SecureHandlerSetFrameRef(self, 'Hotbar8', WXHBRLHotbar1)

   self:SetAttribute('SetHotbarPlacement', [[
      for i = 1,8 do
         Hotbar = self:GetFrameRef('Hotbar'..i)
         if Hotbar then
            Hotbar:RunAttribute("SetHotbarPlacement")
         end
      end                  
   ]])
   SecureHandlerSetFrameRef(WXHBCrossHotbarMover, 'Crosshotbar', Crosshotbar)
   SecureHandlerWrapScript(WXHBCrossHotbarMover, "OnClick", WXHBCrossHotbarMover, [[
      local Crosshotbar = self:GetFrameRef('Crosshotbar')
      Crosshotbar:RunAttribute("SetHotbarPlacement")
      self:SetWidth(Crosshotbar:GetWidth())
   ]])
   
   SecureHandlerWrapScript(WXHBCrossHotbarMover, "OnEnter", WXHBCrossHotbarMover, [[
      self:SetFrameLevel(10)
   ]])
   SecureHandlerWrapScript(WXHBCrossHotbarMover, "OnLeave", WXHBCrossHotbarMover, [[
      self:SetFrameLevel(0)
      self:SetWidth(16)
   ]])
end

function CrossHotbarMixin:ApplyConfig()
   local bindings = {}
   local nbindings = #GamePadModifierList + 2
   for action,value in pairs(ActionList) do
      bindings[action] = {}
      for i = 1,nbindings do
         table.insert(bindings[action], {"", ""})
      end
   end

   for button, attributes in pairs(config.PadActions) do
      if ActionList[attributes.TRIGACTION] then
         bindings[attributes.TRIGACTION][1][1] = attributes.BIND
         bindings[attributes.TRIGACTION][1][2] = addon:GetButtonHotKey(button)
      end
   end

   for i,modifier in ipairs(GamePadModifierList) do
      for button, attributes in pairs(config.PadActions) do
         if ActionList[ attributes[modifier .. "TRIGACTION"] ] then
            bindings[ attributes[modifier .. "TRIGACTION"] ][1+i][1] = attributes.BIND
            bindings[ attributes[modifier .. "TRIGACTION"] ][1+i][2] = addon:GetButtonHotKey(button)
         end
      end
   end

   bindings["HOTBARBTN9"][nbindings] = bindings["HOTBARBTN1"][1]
   bindings["HOTBARBTN10"][nbindings] = bindings["HOTBARBTN2"][1]
   bindings["HOTBARBTN11"][nbindings] = bindings["HOTBARBTN3"][1]
   bindings["HOTBARBTN12"][nbindings] = bindings["HOTBARBTN4"][1]
   
   WXHBLHotbar1:AddOverrideKeyBindings(bindings)
   WXHBRHotbar1:AddOverrideKeyBindings(bindings)
   WXHBLRHotbar1:AddOverrideKeyBindings(bindings)
   WXHBRLHotbar1:AddOverrideKeyBindings(bindings)

   local hotbars = { self:GetChildren() }
   for k,hotbar in pairs(hotbars) do
      if hotbar.ApplyConfig then
         hotbar:ApplyConfig()
      end
   end
   
   self:UpdateCrosshotbar()
end

function CrossHotbarMixin:OnLoad()
   self:SetScale(0.90)
   self:AddTriggerHandler()
   self:AddShoulderHandler()
   self:AddPaddleHandler()
   self:AddExpandHandler()
   self:AddNextPageHandler()
   self:HideHudElements()
   addon.Crosshotbar = self
   addon.CreateGamePadButtons(self)
   addon.CreateGroupNavigator(self)

   self:RegisterEvent("PLAYER_ENTERING_WORLD")
   
   addon:AddInitCallback(GenerateClosure(self.SetupCrosshotbar, self))
   addon:AddApplyCallback(GenerateClosure(self.ApplyConfig, self))
end

function CrossHotbarMixin:OnEvent(event, ...)
   if ( event == "PLAYER_ENTERING_WORLD" ) then
      self:UpdateCrosshotbar()
   end
end

function CrossHotbarMixin:AddTriggerHandler()
   self:SetAttribute('_onstate-trigger', [[
      self:SetAttribute("triggerstate", newstate)

      local expanded = self:GetAttribute("expanded")

      local hotbar_expanded = 0
      if expanded == 3 then
         if (newstate == 6 or newstate == 3 or newstate == 1) then hotbar_expanded = 1 end
         if (newstate == 7 or newstate == 5 or newstate == 2) then hotbar_expanded = 2 end
      else
         if not ((expanded == 1 and (newstate == 6 or newstate == 3)) or
                (expanded == 2 and (newstate == 7 or newstate == 5))) then
            expanded = 0
            self:SetAttribute("expanded", 0)
         end
         hotbar_expanded = expanded
      end

      local state = 0
      if newstate == 6 or newstate == 2 then state = 1 end
      if newstate == 7 or newstate == 1 then state = 2 end
      if newstate == 3 then state = 3 end
      if newstate == 5 then state = 4 end

      for i=1,8 do
         local hotbar = self:GetFrameRef('Hotbar'..i)
         hotbar:SetAttribute("state-hotbar-expanded", hotbar_expanded)
         hotbar:SetAttribute("state-hotbar-visibility", state)
      end
  ]])
end

function CrossHotbarMixin:AddShoulderHandler()
   self:SetAttribute('_onstate-shoulder', [[
      local index = 0
      if newstate == 6 or newstate == 3 or newstate == 2 then
         index = 1
      end
      if newstate == 7 or newstate == 5 or newstate == 1 then
         index = 2
      end
      for i=1,8 do
         local hotbar = self:GetFrameRef('Hotbar'..i)
         hotbar:SetAttribute("state-hotbar-modifier", index)
      end
   ]])
end

function CrossHotbarMixin:AddPaddleHandler()
   self:SetAttribute('_onstate-paddle', [[
      local index = 0
      if newstate == 6 or newstate == 3 or newstate == 2 then
         index = 3
      end
      if newstate == 7 or newstate == 5 or newstate == 1 then
         index = 4
      end
      for i=1,8 do
         local hotbar = self:GetFrameRef('Hotbar'..i)
         hotbar:SetAttribute("state-hotbar-modifier", index)
      end
   ]])
end

function CrossHotbarMixin:AddExpandHandler()
   self:SetAttribute('_onstate-expanded', [[
      local expanded = self:GetAttribute("expanded")
      self:SetAttribute("expanded", newstate)
  ]])
   self:SetAttribute('update-expanded', [[
      local expanded = self:GetAttribute("expanded")
      for i=1,8 do
         local hotbar = self:GetFrameRef('Hotbar'..i)
         hotbar:SetAttribute("state-hotbar-expanded", expanded)
      end
  ]])
end

function CrossHotbarMixin:AddNextPageHandler()
   self:SetAttribute('_onstate-nextpage', [[
      for i=1,8 do
         local hotbar = self:GetFrameRef('Hotbar'..i)
         hotbar:SetAttribute("state-hotbar-nextpage", newstate)
      end
  ]])
end

function CrossHotbarMixin:UpdateCrosshotbar()
   local point = "CENTER"
   local relativeTo = self:GetParent()
   local relativePoint = "CENTER"
   local xOfs = 0
   local yOfs = 0  
   
   local w, h = self:GetSize()
   local s = self:GetScale()
   
   self:ClearAllPoints()
   self:SetPoint("BOTTOMLEFT", relativeTo, relativePoint, xOfs*s-w*0.5, yOfs*s-h*0.5)
   
   local hotbars = { self:GetChildren() }
   for k,hotbar in pairs(hotbars) do
      if hotbar.UpdateHotbar then
         hotbar:UpdateHotbar()
      end
   end     
end

function CrossHotbarMixin:HideHudElements()
   OverrideActionBar:Hide()
   OverrideActionBar:SetParent(addon.UIHider)
   
   hooksecurefunc(MainMenuBarVehicleLeaveButton, "Update", self.MainMenuBarVehicleLeaveButton_Update)
   
   -- remove EditMode hooks
   MainMenuBarVehicleLeaveButton.ClearAllPoints = nil
   MainMenuBarVehicleLeaveButton.SetPoint = nil
   MainMenuBarVehicleLeaveButton.SetScale = nil

   MainMenuBarVehicleLeaveButton:SetParent(self)
   MainMenuBarVehicleLeaveButton:SetScript("OnShow", nil)
   MainMenuBarVehicleLeaveButton:SetScript("OnHide", nil)
end

local function ShouldVehicleButtonBeShown()
   if not CanExitVehicle then
      return UnitOnTaxi("player")
   else
      return CanExitVehicle()
   end
end

function CrossHotbarMixin:MainMenuBarVehicleLeaveButton_Update()
   if ShouldVehicleButtonBeShown() then
      MainMenuBarVehicleLeaveButton:Show()
      MainMenuBarVehicleLeaveButton:Enable()
   else
      MainMenuBarVehicleLeaveButton:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]], "ADD")
      MainMenuBarVehicleLeaveButton:UnlockHighlight()
      MainMenuBarVehicleLeaveButton:Hide()
   end
end
