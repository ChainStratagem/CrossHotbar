local ADDON, addon = ...
local config = addon.Config

local GamePadModifierList = addon.GamePadModifierList

local ActionList = {
   {"HOTBARBTN1", true},
   {"HOTBARBTN2", true},
   {"HOTBARBTN3", true},
   {"HOTBARBTN4", true},
   {"HOTBARBTN5", true},
   {"HOTBARBTN6", true},
   {"HOTBARBTN7", true},
   {"HOTBARBTN8", true},
   {"HOTBARBTN9", true},
   {"HOTBARBTN10", true},
   {"HOTBARBTN11", true},
   {"HOTBARBTN12", true}
}

addon:ActionListAdd("HotbarActions", "CATEGORY_HOTBAR_ACTIONS", ActionList, "NONE")
ActionList = addon:ActionListToTable(ActionList)

local ActionBarHideList = {
   {"HIDEMAIN", true},
   {"HIDEALL", true},
   {"NOHIDE", true}
}

addon:ActionListAdd("ActionBarHides", "CATEGORY_ACTIONBAR_HIDES", ActionBarHideList)
ActionBarHideList = addon:ActionListToTable(ActionBarHideList)

local VehicleHideList = {
   {"HIDEALL", true},
   {"NOHIDE", true}
}

addon:ActionListAdd("VehicleBarHides", "CATEGORY_VEHICLEBAR_HIDES", VehicleHideList)
VehicleHideList = addon:ActionListToTable(VehicleHideList)

CrossHotbarMixin = {
}

function CrossHotbarMixin:SetupCrosshotbar()

   self:HideActionBars(config.Interface.ActionBarHide)
   self:HideVehicleElements(config.Interface.VehicleBarHide)
   
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

   SecureHandlerSetFrameRef(WXHBCrossHotbarMover, 'Crosshotbar', Crosshotbar)
   SecureHandlerWrapScript(WXHBCrossHotbarMover, "OnClick", WXHBCrossHotbarMover, [[
      local Crosshotbar = self:GetFrameRef('Crosshotbar')
      self:SetWidth(Crosshotbar:GetWidth())
   ]])
   
   SecureHandlerWrapScript(WXHBCrossHotbarMover, "OnEnter", WXHBCrossHotbarMover, [[
      self:SetFrameLevel(10)
   ]])
   SecureHandlerWrapScript(WXHBCrossHotbarMover, "OnLeave", WXHBCrossHotbarMover, [[
      self:SetFrameLevel(0)
      self:SetWidth(16)
   ]])

   for k,hotbar in pairs(self.LHotbar) do
      hotbar:SetupHotbar()
   end
   for k,hotbar in pairs(self.RHotbar) do
      hotbar:SetupHotbar()
   end
   for k,hotbar in pairs(self.MHotbar) do
      hotbar:SetupHotbar()
   end
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

   for k,hotbar in pairs(self.LHotbar) do
      hotbar:ApplyConfig()
   end
   for k,hotbar in pairs(self.RHotbar) do
      hotbar:ApplyConfig()
   end
   for k,hotbar in pairs(self.MHotbar) do
      hotbar:ApplyConfig()
   end 
   
   self:UpdateCrosshotbar()
end

function CrossHotbarMixin:OnLoad()
   self:SetScale(0.90)
   self:AddTriggerHandler()
   self:AddShoulderHandler()
   self:AddPaddleHandler()
   self:AddExpandHandler()
   self:AddPageHandler()
   addon.Crosshotbar = self
   addon.CreateGamePadButtons(self)
   addon.CreateGroupNavigator(self)

   self:RegisterEvent("PLAYER_ENTERING_WORLD")
   self:RegisterEvent("PLAYER_REGEN_DISABLED")
   self:RegisterEvent("PLAYER_LOGOUT")
   self:RegisterEvent("ACTIONBAR_SHOWGRID")
   self:RegisterEvent("ACTIONBAR_HIDEGRID")
   
   addon:AddInitCallback(GenerateClosure(self.SetupCrosshotbar, self))
   addon:AddApplyCallback(GenerateClosure(self.ApplyConfig, self))

   self.PageStatusFrame = CreateFrame("Frame", nil, nil, self, "SecureFrameTemplate")
   self.PageStatusFrame:SetPoint("BOTTOM", self, "BOTTOM", 0 , 0)
   self.PageStatusFrame.frameText = self.PageStatusFrame:CreateFontString(nil, "BACKGROUND", "GameFontNormalSmall")
   self.PageStatusFrame.frameText:SetPoint("TOPLEFT")
   self.PageStatusFrame.frameText:SetFontObject(GameFontNormalSmall)
   self.PageStatusFrame.frameText:SetTextColor(1.0, 1.0, 0.8, 1.0)
   self:UpdatePageStatus()
   self.PageStatusFrame:SetSize(self.PageStatusFrame.frameText:GetWidth(), self.PageStatusFrame.frameText:GetHeight())
   self.PageStatusFrame:Hide()
end

function CrossHotbarMixin:UpdatePageStatus()
   local activeset = self:GetAttribute("activeset")
   if activeset then
      self.PageStatusFrame.frameText:SetText("SET " .. activeset)
   end
end

function CrossHotbarMixin:OnEvent(event, ...)
   if ( event == "PLAYER_ENTERING_WORLD" ) then
      local isInitialLogin, isReloadingUi = ...
      self:UpdateCrosshotbar()
      
      local activeset = self:GetAttribute("activeset")
      
      if isInitialLogin or isReloadingUi then 
         local configset = addon:GetConfigDBValue("ActiveSet")
         if configset and configset >= 1 and configset <= 6  then
            activeset = configset
         end
      end

      self:SetAttribute("state-page", activeset)
      self.PageStatusFrame:Show()
   elseif ( event == "PLAYER_REGEN_DISABLED" ) then
         self:ShowGrid(false)
   elseif ( event == "ACTIONBAR_SHOWGRID" ) then
      if not InCombatLockdown() then 
         self:ShowGrid(true)
      end
   elseif ( event == "ACTIONBAR_HIDEGRID" ) then
      if not InCombatLockdown() then 
         self:ShowGrid(false)
      end
   elseif ( event == "PLAYER_LOGOUT" ) then
      local activeset = self:GetAttribute("activeset")
      addon:SetConfigDBValue("ActiveSet", activeset)
   end
end

function CrossHotbarMixin:AddTriggerHandler()
   self:SetAttribute('_onstate-trigger', [[
      self:SetAttribute("triggerstate", newstate)
      local expanded = self:GetAttribute("expanded")

      local state = 0
      if newstate == 6 or newstate == 2 then state = 1 end
      if newstate == 7 or newstate == 1 then state = 2 end
      if newstate == 3 then state = 3 end
      if newstate == 5 then state = 4 end

      for i=1,8 do
         local hotbar = self:GetFrameRef('Hotbar'..i)
         hotbar:SetAttribute("state-hotbar-expanded", expanded)
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

function CrossHotbarMixin:AddPageHandler()
   self:SetAttribute('_onstate-page', [[
      self:SetAttribute("activeset", newstate)

      local pageindex = 1

      if newstate == 3 then pageindex = 3 end
      if newstate == 4 then pageindex = 5 end
      if newstate == 5 then pageindex = 7 end
      if newstate == 6 then pageindex = 9 end

      for i=1,8 do
         local hotbar = self:GetFrameRef('Hotbar'..i)

         local pageprefix = ""
         if newstate == 1 or i > 6 then
            pageindex = hotbar:GetAttribute("pageindex")
            pageprefix = hotbar:GetAttribute("pageprefix")
            RegisterStateDriver(hotbar, 'page', pageprefix .. pageindex)
         else
            if i <= 3 then
               RegisterStateDriver(hotbar, 'page', pageprefix .. (pageindex + 1))
            else 
               RegisterStateDriver(hotbar, 'page', pageprefix .. pageindex)
            end
         end
      end

      self:CallMethod("UpdatePageStatus")
  ]])
end

function CrossHotbarMixin:ShowGrid(enable)
   if enable then
      self:SetFrameStrata("HIGH")
   else
      self:SetFrameStrata("MEDIUM")
   end
   for k,hotbar in pairs(self.LHotbar) do            
      hotbar:ShowGrid(enable)
   end
   for k,hotbar in pairs(self.RHotbar) do        
      hotbar:ShowGrid(enable)
   end
   for k,hotbar in pairs(self.MHotbar) do        
      hotbar:ShowGrid(enable)
   end                                    
end

function CrossHotbarMixin:UpdateCrosshotbar()
   for k,hotbar in pairs(self.LHotbar) do
      hotbar:UpdateHotbar()
   end
   for k,hotbar in pairs(self.RHotbar) do
      hotbar:UpdateHotbar()
   end
   for k,hotbar in pairs(self.MHotbar) do
      hotbar:UpdateHotbar()
   end
end

function CrossHotbarMixin:HideActionBar(actionbar)
   if actionbar then
      if actionbar.EndCaps then
         actionbar.EndCaps.LeftEndCap:SetShown(false)
         actionbar.EndCaps.RightEndCap:SetShown(false)
      end
      if actionbar.BorderArt then
         actionbar.BorderArt:SetTexture(nil)
      end
      if actionbar.Background then
         actionbar.Background:SetShown(false)
      end
      if actionbar.ActionBarPageNumber then
         actionbar.ActionBarPageNumber:SetShown(false)
         actionbar.ActionBarPageNumber.Text:SetShown(false)
      end
      
      if actionbar.system then
         actionbar["isShownExternal"] = nil
         local c = 42
         repeat
            if actionbar[c]  == nil then
               actionbar[c]  = nil
            end
            c = c + 1
         until issecurevariable(actionbar, "isShownExternal")
      end
      if actionbar.HideBase then
         actionbar:HideBase()
      else
         actionbar:Hide()
      end
      actionbar:ClearAllPoints()
      actionbar:SetParent(addon.UIHider)
      
      actionbar:UnregisterEvent("PLAYER_REGEN_ENABLED")
      actionbar:UnregisterEvent("PLAYER_REGEN_DISABLED")
      actionbar:UnregisterEvent("ACTIONBAR_SHOWGRID")
      actionbar:UnregisterEvent("ACTIONBAR_HIDEGRID")
      
      local containers = { actionbar:GetChildren() }
      for i,container in ipairs(containers) do
         local buttons = { container:GetChildren() }
         for j,button in ipairs(buttons) do
            button:Hide()
            button:UnregisterAllEvents()
            button:SetAttribute("statehidden", true)
         end
      end
   end
end

function CrossHotbarMixin:HideActionBars(hide)
   if hide == "HIDEALL" or
      hide == "HIDEMAIN" then
      local mainbarnames = {
         "MainMenuBar",
         "MainActionBar"
      }
      
      for _,barname in ipairs(mainbarnames) do
         self:HideActionBar(_G[barname])
      end
   end

   if hide == "HIDEALL" then
      local multibarnames = {
         "MultiBarLeft",
         "MultiBar5",
         "MultiBarBottomLeft",
         "MultiBarRight",
         "MultiBar6",
         "MultiBarBottomRight",
         "MultiBar7"
      }
      
      for _,barname in ipairs(multibarnames) do
         self:HideActionBar(_G[barname])
      end
   end
end

function CrossHotbarMixin:HideVehicleElements(hide)
   if "HIDEALL" == hide then
      OverrideActionBar:Hide()
      OverrideActionBar:SetParent(addon.UIHider)

      local function ShouldVehicleButtonBeShown()
         if not CanExitVehicle then
            return UnitOnTaxi("player")
         else
            return CanExitVehicle()
         end
      end

      function MainMenuBarVehicleLeaveButton_Update()
         if ShouldVehicleButtonBeShown() then
            MainMenuBarVehicleLeaveButton:Show()
            MainMenuBarVehicleLeaveButton:Enable()
         else
            MainMenuBarVehicleLeaveButton:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]], "ADD")
            MainMenuBarVehicleLeaveButton:UnlockHighlight()
            MainMenuBarVehicleLeaveButton:Hide()
         end
      end
      
      hooksecurefunc(MainMenuBarVehicleLeaveButton, "Update", MainMenuBarVehicleLeaveButton_Update)
      
      -- remove EditMode hooks
      MainMenuBarVehicleLeaveButton.ClearAllPoints = nil
      MainMenuBarVehicleLeaveButton.SetPoint = nil
      MainMenuBarVehicleLeaveButton.SetScale = nil
      
      MainMenuBarVehicleLeaveButton:SetParent(self)
      MainMenuBarVehicleLeaveButton:SetScript("OnShow", nil)
      MainMenuBarVehicleLeaveButton:SetScript("OnHide", nil)
   end
end

