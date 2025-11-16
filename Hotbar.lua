local ADDON, addon = ...
local config = addon.Config

local HBARList = {
   ["LIBA"] = true,
   ["BLIZ"] = true,
}
config:ConfigListAdd("HotbarHBARTypes", HBARList)

local HKEYList = {
   ["_SHP"] = true,
   ["_LTR"] = true,
}
config:ConfigListAdd("HotbarHKEYTypes", HKEYList)

local WXHBList = {
   ["HIDE"] = true,
   ["FADE"] = true,
   ["SHOW"] = true
}
config:ConfigListAdd("HotbarWXHBTypes", WXHBList)

local DDAAList = {
   ["DADA"] = true,
   ["DDAA"] = true,
}
config:ConfigListAdd("HotbarDDAATypes", DDAAList)

local ButtonLayout = {
   ["DADA"] = {
      Padding = 0.0,
      LHotbar = {
         BtnPos = {{-1.0, 0.5}, {-1.0, -0.5}, {-2.0, 0}}, 
         BtnOff = {{-6.0, 2.0}, {-6.0, 2.0}, {-6.0, 2.0}},
         GrpPos = {{4.90, 0.0}, {1.1, 0.0}, {-0.25, 2.5}},
         GrpOff = {{-12.0, 0.0}, {10.0, 0.0}, {0.0, 0.0}},
         SclOff = {{-0.5, 0.5}, {1.5, 0.5}, {-0.5, 0.5}}
      },
      RHotbar = {
         BtnPos = {{-1.0, 0.5}, {-1.0, -0.5}, {-2.0, 0}}, 
         BtnOff = {{-6.0, 2.0}, {-6.0, 2.0}, {-6.0, 2.0}},
         GrpPos = {{11.9, 0.0}, {8.05, 0.0}, {12.90, 2.5}},
         GrpOff = {{-12.0, 0.0}, {10.0, 0.0}, {10.0, 0.0}},
         SclOff = {{-2.8, 0.5}, {-0.5, 0.5}, {-1.0, 1.0}}
      },
      RLHotbar = {
         BtnPos = {{-1.0, 0.5}, {-1.0, -0.5}, {-2.0, 0}}, 
         BtnOff = {{-6.0, 2.0}, {-6.0, 2.0}, {-6.0, 2.0}},
         GrpPos = {{8.05, 0.0}, {4.90, 0.0}, {12.90, 2.5}},
         GrpOff = {{10.0, 0.0}, {-12.0, 0.0}, {10.0, 0.0}},
         SclOff = {{-0.5, 0.5}, {-0.5, 0.5}, {-1.0, 1.0}}
      },
      LRHotbar = {
         BtnPos = {{-1.0, 0.5}, {-1.0, -0.5}, {-2.0, 0}}, 
         BtnOff = {{-6.0, 2.0}, {-6.0, 2.0}, {-6.0, 2.0}},
         GrpPos = {{8.05, 0.0}, {4.90, 0.0}, { -0.25, 2.5}},
         GrpOff = {{10.0, 0.0}, {-12.0, 0.0}, {0.0, 0.0}},
         SclOff = {{-0.5, 0.5}, {-0.5, 0.5}, {-0.5, 0.5}}
      }
   },
   ["DDAA"] = {
      Padding = 0.0,
      LHotbar = {
         BtnPos = {{-1.0, 0.5}, {-1.0, -0.5}, {-2.0, 0}}, 
         BtnOff = {{-6.0, 2.0}, {-6.0, 2.0}, {-6.0, 2.0}},
         GrpPos = {{8.05, 0.0}, {1.70, 0.0}, {-0.25, 2.5}},
         GrpOff = {{10.0, 0.0}, {-12.0, 0.0}, {0.0, 0.0}},
         SclOff = {{-0.5, 0.5}, {-0.5, 0.5}, {-0.5, 0.5}}
      },
      RHotbar = {
         BtnPos = {{-1.0, 0.5}, {-1.0, -0.5}, {-2.0, 0}}, 
         BtnOff = {{-6.0, 2.0}, {-6.0, 2.0}, {-6.0, 2.0}},
         GrpPos = {{11.30, 0.0}, {4.90, 0.0}, {12.90, 2.5}},
         GrpOff = {{10.0, 0.0}, {-12.0, 0.0}, {10.0, 0.0}},
         SclOff = {{-0.5, 0.5}, {-0.5, 0.5}, {-1.0, 1.0}}
      },
      RLHotbar = {
         BtnPos = {{-1.0, 0.5}, {-1.0, -0.5}, {-2.0, 0}}, 
         BtnOff = {{-6.0, 2.0}, {-6.0, 2.0}, {-6.0, 2.0}},
         GrpPos = {{8.05, 0.0}, {4.90, 0.0}, {12.90, 2.5}},
         GrpOff = {{10.0, 0.0}, {-12.0, 0.0}, {10.0, 0.0}},
         SclOff = {{-0.5, 0.5}, {-0.5, 0.5}, {-1.0, 1.0}}
      },
      LRHotbar = {
         BtnPos = {{-1.0, 0.5}, {-1.0, -0.5}, {-2.0, 0}}, 
         BtnOff = {{-6.0, 2.0}, {-6.0, 2.0}, {-6.0, 2.0}},
         GrpPos = {{8.05, 0.0}, {4.90, 0.0}, { -0.25, 2.5}},
         GrpOff = {{10.0, 0.0}, {-12.0, 0.0}, {0.0, 0.0}},
         SclOff = {{-0.5, 0.5}, {-0.5, 0.5}, {-0.5, 0.5}}
      }
   }
}

HotbarMixin = {
   Padding = ButtonLayout["DADA"].Padding,
   LHotbar = ButtonLayout["DADA"].LHotbar,
   RHotbar = ButtonLayout["DADA"].RHotbar,
   RLHotbar = ButtonLayout["DADA"].RLHotbar,
   LRHotbar = ButtonLayout["DADA"].LRHotbar
}

function HotbarMixin:SetHotbarLayout(layouttype)
   self.Padding = ButtonLayout[layouttype].Padding
   self.LHotbar = ButtonLayout[layouttype].LHotbar
   self.RHotbar = ButtonLayout[layouttype].RHotbar
   self.RLHotbar = ButtonLayout[layouttype].RLHotbar
   self.LRHotbar = ButtonLayout[layouttype].LRHotbar
end

function HotbarMixin:OnLoad()
   self:RegisterEvent("PLAYER_ENTERING_WORLD")
   addon:AddInitCallback(GenerateClosure(self.SetupHotbar, self))
   addon:AddApplyCallback(GenerateClosure(self.ApplyConfig, self))
end

function HotbarMixin:SetupHotbar()

   -- Workaround for MainMenuBar in Midnight
   if self.BarName == "MainMenuBar" then
      if _G[self.BarName] == nil then
         self.BarName = "MainActionBar"
         self.BtnPrefix = "ActionBarButton"
      end
   end
   
   self.AnchorButtons = {}
   self.Highlights = {}
   self:AddActionBar()
   self:AddBindingFunc()
   self:AddPlacemantFunc()
   self:AddPageHandler()
   self:AddVisibilityHandler()
   self:AddModHandler()
   self:AddExpandHandler()
   self:AddNextPageHandler()
   
   local pageindex = self:GetAttribute("pageindex")
   local pageprefix = self:GetAttribute("pageprefix")
   
   UnregisterStateDriver(self.ActionBar,'visibility')
   UnregisterStateDriver(self,'page')
   RegisterStateDriver(self, 'page', pageprefix .. pageindex)

   self.BtnLock = true
   self.BarLock = true
   self.BarLockPoint = {self:GetPoint(1)}
end

function HotbarMixin:SetPointHook(actionbor, ...)
   local point, relativeFrame, relativePoint, ofsx, ofsy = ...
   if self and self.BarLockPoint ~= nil then
      if self.BarLock == false then 
         self.BarLockPoint = {self.ActionBar:GetPoint(1)}
      else
         local p = self.BarLockPoint
         self.BarLockPoint = nil
         if not InCombatLockdown() then 
           self.ActionBar:ClearAllPoints()          
           self.ActionBar:SetPoint(unpack(p))
         end
         self.BarLockPoint = p
         p = nil
      end
   end
end

function HotbarMixin:SetAlphaHook(button, alpha)
   local lock = self.BtnLock     
   if lock == false then
      button.CHBAlpha = alpha
   elseif button.CHBAlpha ~= nil then
      local alpha_reset = button.CHBAlpha
      button.CHBAlpha = nil
      button:SetAlpha(alpha_reset)
      button.CHBAlpha = alpha_reset
   end
end

function HotbarMixin:HookDesatHook(icon, Saturation)
   local lock = self.BtnLock         
   if lock == false then
      icon.CHBDesat = Saturation
   elseif icon.CHBDesat ~= nil then
      local Saturation_reset = icon.CHBDesat
      icon.CHBDesat = nil
      icon:SetDesaturated(Saturation_reset)
      icon.CHBDesat = Saturation_reset
   end
end
      
function HotbarMixin:AddActionBar()
   if CrossHotbar_DB.HBARType == "LIBA" then
      self.Buttons = {}
      self.BtnPrefix = self:GetName() .. "Button"

      self.ActionBar = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")
      self.ActionBar:SetAttribute("_onstate-page", [[
         self:SetAttribute('actionpage', newstate)
         self:SetAttribute("state", newstate)     
         self:ChildUpdate("state", newstate)
      ]])
      
      self.ActionBar:SetAttribute('actionpage', 1)
      self.ActionBar:SetAttribute("state-page", "1")
      self.ActionBar:SetID(0)

      local customExitButton = {
         func = function(button)
            VehicleExit()
         end,
         texture = "Interface\\Vehicles\\UI-Vehicles-Button-Exit-Up",
         tooltip = LEAVE_VEHICLE,
      }
      
      local ActBTnConfig = {
         showGrid = true
      }
      
      for i = 1,12 do
         self.Buttons[i] = CreateFrame("CheckButton", self.BtnPrefix .. i, self.ActionBar, "ActionBarButtonTemplate")
         
         self.Buttons[i]:SetID(i)
         self.Buttons[i]:SetAttributeNoHandler("actions", i)
         self.Buttons[i]:SetAttribute("checkmouseovercast", true);
         -- Set attribute to tell Consoleport not to manage hotkey text.
         self.Buttons[i]:SetAttribute("ignoregamepadhotkey", true)
         hooksecurefunc(self.Buttons[i], "SetAlpha", GenerateClosure(self.SetAlphaHook, self))
         hooksecurefunc(self.Buttons[i].icon, "SetDesaturated", GenerateClosure(self.HookDesatHook, self))
      end

      if _G[self.BarName].EndCaps then
         _G[self.BarName].EndCaps.LeftEndCap:SetShown(false)
         _G[self.BarName].EndCaps.RightEndCap:SetShown(false)
      end
      if _G[self.BarName].BorderArt then
         _G[self.BarName].BorderArt:SetTexture(nil)
      end
      if _G[self.BarName].Background then
         _G[self.BarName].Background:SetShown(false)
      end
      if _G[self.BarName].ActionBarPageNumber then
         _G[self.BarName].ActionBarPageNumber:SetShown(false)
         _G[self.BarName].ActionBarPageNumber.Text:SetShown(false)
      end
      
      if _G[self.BarName].system then
         _G[self.BarName]["isShownExternal"] = nil
	local c = 42
	repeat
           if _G[self.BarName][c]  == nil then
              _G[self.BarName][c]  = nil
           end
           c = c + 1
	until issecurevariable(_G[self.BarName], "isShownExternal")
      end
      if _G[self.BarName].HideBase then
         _G[self.BarName]:HideBase()
      else
         _G[self.BarName]:Hide()
      end
      _G[self.BarName]:SetParent(addon.UIHider)
      
      _G[self.BarName]:UnregisterEvent("PLAYER_REGEN_ENABLED")
      _G[self.BarName]:UnregisterEvent("PLAYER_REGEN_DISABLED")
      _G[self.BarName]:UnregisterEvent("ACTIONBAR_SHOWGRID")
      _G[self.BarName]:UnregisterEvent("ACTIONBAR_HIDEGRID")
      
      local containers = { _G[self.BarName]:GetChildren() }
      for i,container in ipairs(containers) do
         local buttons = { container:GetChildren() }
         for j,button in ipairs(buttons) do
            button:Hide()
            button:UnregisterAllEvents()
            button:SetAttribute("statehidden", true)
         end
      end
   elseif CrossHotbar_DB.HBARType == "BLIZ" then
      self.Buttons = {}
      self.ActionBar = _G[self.BarName]
      local containers = { self.ActionBar:GetChildren() }
      for i,container in ipairs(containers) do
         local buttons = { container:GetChildren() }
         for j,button in ipairs(buttons) do
            -- Set attribute to tell Consoleport not to manage hotkey text.
            button:SetAttribute("ignoregamepadhotkey", true)
            if button ~= nil and button:GetName() ~= nil then
               local index = button:GetID();
               if string.find(button:GetName(), "Button") then -- self.BtnPrefix
                  self.Buttons[index] = button
                  hooksecurefunc(self.Buttons[index], "SetAlpha", GenerateClosure(self.SetAlphaHook, self))
                  hooksecurefunc(self.Buttons[index].icon, "SetDesaturated", GenerateClosure(self.HookDesatHook, self))
               end
            end
         end
      end
   end
   
   for i,button in ipairs(self.Buttons) do
      local index = self.Buttons[i]:GetID();
      SecureHandlerSetFrameRef(self, 'ActionButton'..index, button)
   end
   SecureHandlerSetFrameRef(self, 'ActionBar', self.ActionBar)
end

function HotbarMixin:AddOverrideKeyBindings(ConfigBindings)
   for i,button in ipairs(self.Buttons) do
      local index = button:GetID();
      for j, key in ipairs(ConfigBindings["HOTBARBTN"..index]) do
         button:SetAttribute('over_key'..j, key[1])
         button:SetAttribute('over_hotkey'..j, key[2])
      end
      button:SetAttribute("numbindings", #ConfigBindings["HOTBARBTN"..index])
      button.HotKey:SetText(RANGE_INDICATOR);
      button.HotKey:Show();
   end
end

function HotbarMixin:AddPlacemantFunc()
   self:SetAttribute('SetHotbarPlacement', [[
      actionbar = self:GetFrameRef('ActionBar')
      if actionbar then
         local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()
         local apoint, arelativeTo, arelativePoint, axOfs, ayOfs = actionbar:GetPoint()
         if arelativeTo ~= relativeTo then
            local left, bottom, w, h = self:GetRect()
            local s = self:GetScale()
            actionbar:SetScale(s)
            actionbar:ClearAllPoints()
            actionbar:SetPoint("BOTTOMLEFT", relativeTo, relativePoint, xOfs*s-w*0.5, yOfs*s-h*0.5)
         end
      end
   ]])
end

function HotbarMixin:AddBindingFunc()
   self:SetAttribute('SetHotbarBindings', [[
      local currentstate = self:GetAttribute("currentstate")
      local activestate = self:GetAttribute("activestate")
      local expanded = self:GetAttribute("expanded")
      local modifier = self:GetAttribute("modifier")
      if currentstate ~= 0 and currentstate == activestate then
         for i = 1, 12 do
            local b = self:GetFrameRef('ActionButton'..i)
            if b then 
               local nbindings = b:GetAttribute('numbindings')
               if expanded ~= 0 then modifier = nbindings end
               local key = b:GetAttribute('over_key' .. modifier)
               if key then
                  b:SetBindingClick(true, key, b:GetName(), "LeftButton")
               end
            end
         end
      end
      self:CallMethod("UpdateHotkeys")
   ]])
end

function HotbarMixin:AddPageHandler()
   self:SetAttribute("_onstate-page", [[
   if newstate == "possess" or newstate == "11" then
      if HasVehicleActionBar() then
         newstate = GetVehicleBarIndex()
      elseif HasOverrideActionBar() then
         newstate = GetOverrideBarIndex()
      elseif HasTempShapeshiftActionBar() then
         newstate = GetTempShapeshiftBarIndex()
      elseif HasBonusActionBar() then
         newstate = GetBonusBarIndex()
      else
         newstate = nil
      end
      if not newstate then
         print("Unknow page state")
         newstate = 12
      end
   end
   for i = 1, 12 do
      local button = self:GetFrameRef('ActionButton'..i)
      button:SetAttribute('actionpage', newstate)
   end
   
   local bar = self:GetFrameRef('ActionBar')
   bar:SetAttribute('state-page', newstate)
   bar:SetAttribute('actionpage', newstate)
   self:SetAttribute('actionpage', newstate)
   ]])
end

function HotbarMixin:AddVisibilityHandler()
   self:SetAttribute('_onstate-hotbar-visibility', [[
      local actionbar = self:GetFrameRef('ActionBar')
      local shownstate = self:GetAttribute("shownstate")
      local laststate = self:GetAttribute("currentstate")

      self:SetAttribute("currentstate", newstate)

      actionbar = self:GetFrameRef('ActionBar')
      self:RunAttribute("SetHotbarPlacement")

      if newstate == shownstate then
         RegisterStateDriver(actionbar, "visibility", "[petbattle]hide;show")
         self:RunAttribute("SetHotbarBindings")
      else
         if laststate == shownstate or laststate == 99 then
            for i = 1, 12 do
               local b = self:GetFrameRef('ActionButton'..i)
               if b then b:ClearBindings() end
            end
            RegisterStateDriver(actionbar, "visibility", "[petbattle]hide;hide")
         end
      end
   ]])
end

function HotbarMixin:AddModHandler()
   self:SetAttribute('_onstate-hotbar-modifier', [[
      self:SetAttribute("modifier", 1+newstate)
      self:RunAttribute("SetHotbarBindings")
   ]])
end

function HotbarMixin:AddExpandHandler()
   self:SetAttribute('_onstate-hotbar-expanded', [[
      local actionbar = self:GetFrameRef('ActionBar')
      local activestate = self:GetAttribute("activestate")

      local enable = 0
      if newstate ~= 0 and (activestate == 1 or activestate == 3) then enable = 1 end 
      if newstate ~= 0 and (activestate == 2 or activestate == 4) then enable = 1 end

      self:SetAttribute("expanded", enable)
      self:SetAttribute("expanded-state", newstate)

      if newstate ~= 0 and enable == 0 then
        self:CallMethod("UpdateExpanded", newstate)
      end
   ]])
end

function HotbarMixin:UpdateExpanded(newstate)
   self.BtnLock = false
   if ((newstate == 1 and self.Type == "LHotbar") or
         (newstate == 2 and self.Type == "RHotbar")) then
      for i, button in ipairs(self.Buttons) do
         if  button:GetID() >= 9 then 
            button:SetAlpha(self.ExpandedAlpha1)
         else
            button:SetAlpha(self.ExpandedAlpha2)
            button.icon:SetDesaturated(self.DesatExpanded);
         end
      end
   else
      for i, button in ipairs(self.Buttons) do
         if  button:GetID() >= 9 then 
            button:SetAlpha(self.ExpandedAlpha1)
         else
         button:SetAlpha(1.0)
         button.icon:SetDesaturated(false);
         end
      end
   end
   self.BtnLock = true
end

function HotbarMixin:AddNextPageHandler()
   self:SetAttribute('_onstate-hotbar-nextpage', [[
      local activestate = self:GetAttribute("activestate")
      if activestate < 3 then
         local pageindex = self:GetAttribute("pageindex")
         local pageprefix = self:GetAttribute("pageprefix")

         pageindex = (pageindex + newstate)%10

         if pageindex == 0 then
            pageindex = 10
         end

         RegisterStateDriver(self, 'page', pageprefix .. pageindex)
      end
   ]])
end

function HotbarMixin:UpdateHotbar()
   
   if self.ActionBar.ActionBarPageNumber then 
      self.ActionBar.ActionBarPageNumber:SetShown(false)
   end

   if self.ActionBar.UpdateEndCaps then
      self.ActionBar.hideBarArt = true
      self.ActionBar:UpdateEndCaps(self.ActionBar.hideBarArt)
      self.ActionBar.BorderArt:SetShown(not self.ActionBar.hideBarArt)

      for i, actionButton in pairs(self.ActionBar.actionButtons) do
         actionButton:UpdateButtonArt()
      end
      
      if self.ActionBar.UpdateDividers then
         self.ActionBar:UpdateDividers()
      end
   end
   
   local parent_scaling = self:GetParent():GetScale()
   local bar = self[self.Type]
   if bar then
      local mxw = 0
      local mxh = 0
      
      local buttons = { self.ActionBar:GetChildren() }
      for i, button in ipairs(buttons) do
         if button ~= nil and button:GetName() ~= nil then
            if string.find(button:GetName(), self.BtnPrefix) then
               local width = math.ceil(button:GetWidth()+0.5)
               width = width + width%2
               local height = math.ceil(button:GetHeight()+0.5)
               height = height + height%2
               if mxw < width then mxw = width end
               if mxh < height then mxh = height end
            end
         end
      end
      
      local mxw = mxw+self.Padding
      local mxh = mxh+self.Padding
      
      self:SetSize(mxw*parent_scaling*12-4, mxh*parent_scaling)
      self.ActionBar:SetSize(mxw*parent_scaling*12-4, mxh*parent_scaling)
      
      local CHBar = {{0, 0}, {0, 0}, { 0, 0}}
      
      for i=1,3 do
         CHBar[i][1] = (bar.GrpPos[i][1]*mxw + bar.BtnOff[i][1]*self.Padding + bar.GrpOff[i][1] + 
                        (1.0 - self.Scaling)*bar.SclOff[i][1]*mxw)/self.Scaling;
         CHBar[i][2] = (bar.GrpPos[i][2]*mxh + bar.BtnOff[i][2]*self.Padding + bar.GrpOff[i][2] +
                        (1.0 - self.Scaling)*bar.SclOff[i][2]*mxh)/self.Scaling;
      end
      
      local anchor = nil
      local anchorIdx = 0
      
      local idx = 0
      self.AnchorButtons = {}
      for i, button in ipairs(buttons) do
         if button ~= nil and button:GetName() ~= nil then
            if string.find(button:GetName(), self.BtnPrefix) then
               if idx%4 == 0 then
                  anchorIdx = idx
                  anchor = button
                  button:SetScale(self.Scaling*parent_scaling)
                  button:ClearAllPoints()
                  button:SetPoint("BOTTOMLEFT", CHBar[(idx+4)/4][1], CHBar[(idx+4)/4][2])
                  table.insert(self.AnchorButtons, button)
               else
                  bIdx = idx-anchorIdx
                  button:SetScale(self.Scaling*parent_scaling)
                  button:ClearAllPoints()
                  button:SetPoint("CENTER", anchor, "CENTER", bar.BtnPos[bIdx][1]*mxw, bar.BtnPos[bIdx][2]*mxh)
               end
               idx = idx+1
            end
         end
      end
      
      if self.hasHighlights then
         if #self.Highlights == 0 then
            for i,anchor in ipairs(self.AnchorButtons) do
               local highlight = CreateFrame("Frame", self:GetName() .. "Highlight" .. i, anchor, "SecureHandlerBaseTemplate")
               local tex = highlight:CreateTexture(nil, "BACKGROUND")
               tex:SetAllPoints()
               tex:SetAtlas("AftLevelup-WhiteIconGlow")
               tex:SetVertexColor(0.88, 0.78, 0.68, 0.58)
               highlight:SetSize(5.0*mxw,3.5*mxh)
               highlight:SetFrameStrata("LOW")
               highlight:SetPoint("CENTER", anchor, "CENTER", -1*mxw, 0)
               highlight:SetFrameLevel(0) 
               table.insert(self.Highlights, highlight)
            end
         else
            for i,anchor in ipairs(self.AnchorButtons) do
               local highlight = self.Highlights[i]
               highlight:SetSize(5.0*mxw,3.5*mxh)
               highlight:SetFrameStrata("LOW")
               highlight:SetPoint("CENTER", anchor, "CENTER", -1*mxw, 0)
               highlight:SetFrameLevel(0) 
            end
         end
      end
      
      local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint()  
      local w, h = self:GetSize()
      local s = self:GetScale()
      self.BarLock = false
      self.ActionBar:SetScale(s)
      self.ActionBar:ClearAllPoints()
      self.ActionBar:SetPoint("BOTTOMLEFT", relativeTo, relativePoint, xOfs*s-w*0.5, yOfs*s-h*0.5)
      self.BarLock = true
   end
end

function HotbarMixin:getGroupAnchors()
   local bar = self[self.Type]
   if bar then
      return  self.AnchorButtons
   end
end

function HotbarMixin:UpdateVisibility()
   self.ActionBar:UpdateGridLayout();
   self:UpdateHotbar();
end

function HotbarMixin:UpdateHotkeys()   
   self.BtnLock = false
   local currentstate = self:GetAttribute("currentstate")
   local activestate = self:GetAttribute("activestate")
   local expanded = self:GetAttribute("expanded")
   local modifier = self:GetAttribute("modifier")
      
   local highlights = {}
   highlights[1] = false
   highlights[2] = false
   highlights[3] = false
   for i, button in ipairs(self.Buttons) do
      if currentstate ~= 0 and
         currentstate == activestate then
         local nbindings = button:GetAttribute('numbindings')
         if expanded ~= 0 then modifier = nbindings end
         local key = button:GetAttribute('over_hotkey' .. modifier)
         if key and key ~= "" then
            button.HotKey:SetText(key);
            button:SetAlpha(1.0)
            button.icon:SetDesaturated(false);
            if i < 5 then
               highlights[1] = true 
            elseif i < 9 then
               highlights[2] = true
            elseif i < 13 then
               highlights[3] = true
            end
         else
            button.HotKey:SetText(RANGE_INDICATOR);            
            if  button:GetID() >= 9 then 
               button:SetAlpha(self.ExpandedAlpha1)
            else
               if expanded ~= 0 then
                  button:SetAlpha(self.ExpandedAlpha2)
                  button.icon:SetDesaturated(self.DesatExpanded);
               else
                  button:SetAlpha(1.0)
                  button.icon:SetDesaturated(false);
               end
            end
         end
      else
         button.HotKey:SetText(RANGE_INDICATOR);            
         if  button:GetID() >= 9 then 
            button:SetAlpha(self.ExpandedAlpha1)
         else
            button:SetAlpha(1.0)
            button.icon:SetDesaturated(false);
         end
      end
      button.HotKey:Show();
   end
   for i,highlight in ipairs(self.Highlights) do
      if highlights[i] then
         highlight:SetAlpha(1.0)
      else
         highlight:SetAlpha(0.0)
      end
   end
   self.BtnLock = true
end

function HotbarMixin:OnEvent(event, ...)
   if event == "PLAYER_ENTERING_WORLD" then
      self:UpdateHotbar();
   end
end

function HotbarMixin:ApplyConfig()
   self.ExpandedAlpha1 = 0.5 
   self.DesatExpanded2 = 0.5
   self.EnableExpanded = true

   local pageprefix = config.Hotbar[string.gsub(self.Type, 'Hotbar', 'PagePrefix')]
   local pageindex = config.Hotbar[string.gsub(self.Type, 'Hotbar', 'PageIndex')]
   self:SetAttribute('pageprefix', pageprefix)
   self:SetAttribute('pageindex', pageindex)
   RegisterStateDriver(self, 'page', pageprefix .. pageindex)
   
   self:AddModHandler()

   if config.Hotbar.WXHBType == "HIDE" then
      self.ExpandedAlpha1 = 0.0
   end

   if config.Hotbar.WXHBType == "FADE" then
      self.ExpandedAlpha1 = 0.5
   end

   if config.Hotbar.WXHBType == "SHOW" then
      self.ExpandedAlpha1 = 1.0
      self.ExpandedAlpha2 = 0.5
   end
   
   self:SetHotbarLayout(config.Hotbar.DDAAType)
   self:UpdateHotkeys()
end
