local ADDON, addon = ...
local config = addon.Config

local HKEYList = {
   {"_SHP", true},
   {"_LTR", true},
}
addon:ActionListAdd("HotbarHKEYTypes", "CATEGORY_HOTBAR_KEY", HKEYList)
HKEYList = addon:ActionListToTable(HKEYList)

local WXHBList = {
   {"HIDE", true},
   {"FADE", true},
   {"SHOW", true}
}
addon:ActionListAdd("HotbarWXHBTypes", "CATEGORY_HOTBAR_WXHB", WXHBList)
WXHBList = addon:ActionListToTable(WXHBList)

local DDAAList = {
   {"DADA", true},
   {"DDAA", true},
}
addon:ActionListAdd("HotbarDDAATypes", "CATEGORY_HOTBAR_DDAA", DDAAList)
DDAAList = addon:ActionListToTable(DDAAList)

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
   LRHotbar = ButtonLayout["DADA"].LRHotbar,
   MasqueGroup = nil
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
end

function HotbarMixin:SetupHotbar()   
   self.AnchorButtons = {}
   self.Highlights = {}
   self:AddActionBar()
   self:AddBindingFunc()
   self:AddPageHandler()
   self:AddVisibilityHandler()
   self:AddModHandler()
   self:AddExpandHandler()
   
   local pageindex = self:GetAttribute("pageindex")
   local pageprefix = self:GetAttribute("pageprefix")
   
   UnregisterStateDriver(self, 'page')
   RegisterStateDriver(self, 'page', pageprefix .. pageindex)
end
      
function HotbarMixin:AddActionBar()
   self.Buttons = {}
   self.BtnPrefix = self:GetName() .. "Button"

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
      self.Buttons[i] = CreateFrame("CheckButton", self.BtnPrefix .. i, self, "ActionBarButtonTemplate")
      
      self.Buttons[i]:SetID(i)
      self.Buttons[i]:SetAttributeNoHandler("actions", i)
      self.Buttons[i]:SetAttribute("checkmouseovercast", true)
      -- Set attribute to tell Consoleport not to manage hotkey text.
      self.Buttons[i]:SetAttribute("ignoregamepadhotkey", true)
   end
   
   for i,button in ipairs(self.Buttons) do
      local index = self.Buttons[i]:GetID()
      SecureHandlerSetFrameRef(self, 'ActionButton'..index, button)
   end
   SecureHandlerSetFrameRef(self, 'ActionBar', self)
end

function HotbarMixin:AddOverrideKeyBindings(ConfigBindings)
   for i,button in ipairs(self.Buttons) do
      local index = button:GetID()
      for j, key in ipairs(ConfigBindings["HOTBARBTN"..index]) do
         button:SetAttribute('over_key'..j, key[1])
         button:SetAttribute('over_hotkey'..j, key[2])
      end
      button:SetAttribute("numbindings", #ConfigBindings["HOTBARBTN"..index])
      button.HotKey:SetText(RANGE_INDICATOR)
      button.HotKey:Show()
   end
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
   
   self:SetAttribute('actionpage', newstate)
   ]])
end

function HotbarMixin:AddVisibilityHandler()
   self:SetAttribute('_onstate-hotbar-visibility', [[
      local actionbar = self:GetFrameRef('ActionBar')
      local shownstate = self:GetAttribute("shownstate")
      local laststate = self:GetAttribute("currentstate")

      self:SetAttribute("currentstate", newstate)

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
   if ((newstate == 1 and self.Type == "LHotbar") or
         (newstate == 2 and self.Type == "RHotbar")) then
      for i, button in ipairs(self.Buttons) do
         if  button:GetID() >= 9 then 
            button:SetAlpha(1.0)
         else
            button:SetAlpha(self.ExpandedAlpha2)
            button.icon:SetDesaturated(self.DesatExpanded)
         end
      end
   else
      for i, button in ipairs(self.Buttons) do
         if  button:GetID() >= 9 then 
            button:SetAlpha(self.ExpandedAlpha1)
         else
         button:SetAlpha(1.0)
         button.icon:SetDesaturated(false)
         end
      end
   end
end

function HotbarMixin:UpdateHotbar()
   local parent_scaling = self:GetParent():GetScale()
   local bar = self[self.Type]
   if bar then
      local mxw = 0
      local mxh = 0
      
      local buttons = self.Buttons
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
      
      local CHBar = {{0, 0}, {0, 0}, { 0, 0}}
      
      for i=1,3 do
         CHBar[i][1] = (bar.GrpPos[i][1]*mxw + bar.BtnOff[i][1]*self.Padding + bar.GrpOff[i][1] + 
                        (1.0 - self.Scaling)*bar.SclOff[i][1]*mxw)/self.Scaling
         CHBar[i][2] = (bar.GrpPos[i][2]*mxh + bar.BtnOff[i][2]*self.Padding + bar.GrpOff[i][2] +
                        (1.0 - self.Scaling)*bar.SclOff[i][2]*mxh+mxh)/self.Scaling
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
   end
end

function HotbarMixin:getGroupAnchors()
   local bar = self[self.Type]
   if bar then
      return  self.AnchorButtons
   end
end

function HotbarMixin:UpdateVisibility()
   self:UpdateGridLayout()
   self:UpdateHotbar()
end

function HotbarMixin:UpdateHotkeys()   
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
            button.HotKey:SetText(key)
            button:SetAlpha(1.0)
            button.icon:SetDesaturated(false)
            if i < 5 then
               highlights[1] = true 
            elseif i < 9 then
               highlights[2] = true
            elseif i < 13 then
               highlights[3] = true
            end
         else
            button.HotKey:SetText(RANGE_INDICATOR)            
            if  button:GetID() >= 9 then 
               button:SetAlpha(self.ExpandedAlpha1)
            else
               if expanded ~= 0 then
                  button:SetAlpha(self.ExpandedAlpha2)
                  button.icon:SetDesaturated(self.DesatExpanded)
               else
                  button:SetAlpha(1.0)
                  button.icon:SetDesaturated(false)
               end
            end
         end
      else
         button.HotKey:SetText(RANGE_INDICATOR)            
         if button:GetID() >= 9 then 
            button:SetAlpha(self.ExpandedAlpha1)
         else
            button:SetAlpha(1.0)
            button.icon:SetDesaturated(false)
         end
      end
      button.HotKey:Show()
      if self.MasqueGroup then
         self.MasqueGroup:ReSkin(button)
      end
   end
   for i,highlight in ipairs(self.Highlights) do
      if highlights[i] then
         highlight:SetAlpha(1.0)
      else
         highlight:SetAlpha(0.0)
      end
   end
end

function HotbarMixin:ShowGrid(enable)
   if enable then
      self.ExpandedAlpha1 = 1.0
      self.ExpandedAlpha2 = 0.5
      self:UpdateHotkeys()
   else
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
      self:UpdateHotkeys()
   end
end

function HotbarMixin:SetupMasque()
   local Masque, MSQ_Version = LibStub('Masque', true)
   if Masque then
      self.MasqueGroup = Masque:Group(ADDON, self.Type)      
      if self.MasqueGroup then
         local buttons = self.Buttons
         for i, button in ipairs(buttons) do
            if button ~= nil and button:GetName() ~= nil then
               self.MasqueGroup:AddButton(button, null, "Action")
            end
         end
      end
   end
end

function HotbarMixin:OnEvent(event, ...)
   if event == "PLAYER_ENTERING_WORLD" then
      local isInitialLogin, isReloadingUi = ...
      self:UpdateHotbar()
      if isInitialLogin or isReloadingUi then
         self:SetupMasque()
      end
   end
end

function HotbarMixin:ApplyConfig()
   self.ExpandedAlpha1 = 0.5 
   self.DesatExpanded2 = 0.5

   local pageprefix = config.Hotbar[string.gsub(self.Type, 'Hotbar', 'PagePrefix')]
   local pageindex = config.Hotbar[string.gsub(self.Type, 'Hotbar', 'PageIndex')]
   self:SetAttribute('pageprefix', pageprefix)
   self:SetAttribute('pageindex', pageindex)

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
