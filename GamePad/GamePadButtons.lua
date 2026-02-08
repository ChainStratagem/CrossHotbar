local ADDON, addon = ...
local config = addon.Config

local SetButtonPairState = [[
   local button, down, pairname  = ...

   local type = 0
   if button == "LeftButton" then type = 2 end
   if button == "RightButton" then type = 3 end

   local GamePad = self:GetFrameRef('GamePad')

   if GamePad ~= nil and type ~= 0 then

      if pairname == "trigger" then
         local expandedstate = GamePad:GetAttribute("expandedstate")
         if expandedstate == 4 and type == 2 then return end
         if expandedstate == 5 and type == 3 then return end
      end

      local state = GamePad:GetAttribute(pairname.."state")

      local a = 0
      if state == 6 or state == 3 then a = 2 end
      if state == 7 or state == 5 then a = 3 end
      local b = a - state + 4

      if a == 0 then
         a = b
         b = 0
      end

      local found = true
      if down and a == 0 then
         a = type
      elseif down and b == 0 then
         b = type
      elseif not down and a == type then
         a = 0
      elseif not down and b == type then
         b = 0
      else
         found = false
      end

      if found then
         state = a - b + 4
         GamePad:SetAttribute("state-"..pairname, state)
      else
        -- print("Error " .. state .. " " .. a .. " " .. b .. " " .. type)
      end
   end
]]

local SetButtonExpanded = [[
   local button = ...

   local type = 0
   if button == "LeftButton" then type = 2 end
   if button == "RightButton" then type = 3 end

   local GamePad = self:GetFrameRef('GamePad')
   if GamePad ~= nil and type ~= 0 then
      local dclktype = GamePad:GetAttribute("wxhbdclk")
      local state = GamePad:GetAttribute("triggerstate")

      local expandedstate = GamePad:GetAttribute("expandedstate")
      if expandedstate == 4 and type == 2 then return end
      if expandedstate == 5 and type == 3 then return end

      if dclktype > 0 and state ~= 3 and state ~= 5 then
         GamePad:SetAttribute("state-trigger", 4)
         if button == "LeftButton" then
            GamePad:SetAttribute("state-expanded", 1)
         end
         if button == "RightButton" then
            GamePad:SetAttribute("state-expanded", 2)
         end
         if dclktype == 2 then
            local Crosshotbar = self:GetFrameRef('Crosshotbar')
            if Crosshotbar ~= nil then
               Crosshotbar:RunAttribute("update-expanded")
            end
         end
      else
         local a = 0
         if state == 6 or state == 3 then a = 2 end
         if state == 7 or state == 5 then a = 3 end
         local b = a - state + 4

         if a == 0 then
            a = b
            b = 0
         end

         local found = true
         if  a == type then
            a = 0
         elseif b == type then
            b = 0
         else
            found = false
         end

         local newstate = 4
         if found then
            newstate = a - b + 4
         end
         GamePad:SetAttribute("state-trigger", newstate)
      end
   end
]]

addon.GamePadButtonsMixin = {
   LeftTriggerButton = nil,
   RightTriggerButton = nil,
   LeftShoulderButton = nil,
   RightShoulderButton = nil,
   LeftPaddleButton = nil,
   RightPaddleButton = nil
}

local GamePadButtonsMixin = addon.GamePadButtonsMixin

function GamePadButtonsMixin:CreatePairButton(ButtonName)
   local Button = CreateFrame("Button", ADDON .. ButtonName .. "ButtonFrame",
                                         self, "SecureActionButtonTemplate" )
   Button:SetFrameStrata("BACKGROUND")
   Button:SetPoint("TOP", self, "LEFT", 0, 0)
   Button:RegisterForClicks("AnyDown", "AnyUp")
   Button:Hide()
   
   SecureHandlerSetFrameRef(Button, 'GamePad', addon.GamePad)
   SecureHandlerSetFrameRef(Button, 'Crosshotbar', addon.Crosshotbar)
   SecureHandlerSetFrameRef(Button, 'GroupNavigator', addon.GroupNavigator)
   
   SecureHandlerSetFrameRef(self, ButtonName, Button)
   return Button
end

function GamePadButtonsMixin:CreateLeftTriggerButton()
   self.LeftTriggerButton = self:CreatePairButton("LeftTrigger")
   self.LeftTriggerButton:SetAttribute("SetButtonPairState", SetButtonPairState)
   self.LeftTriggerButton:SetAttribute("SetButtonExpanded", SetButtonExpanded)
   SecureHandlerWrapScript(self.LeftTriggerButton, "OnClick", self.LeftTriggerButton,
                           [[self:RunAttribute("SetButtonPairState", "LeftButton", down, "trigger")]])
   SecureHandlerWrapScript(self.LeftTriggerButton, "OnDoubleClick", self.LeftTriggerButton,
                           [[self:RunAttribute("SetButtonExpanded", "LeftButton")]])
end

function GamePadButtonsMixin:CreateRightTriggerButton()
   self.RightTriggerButton = self:CreatePairButton("RightTrigger")
   self.RightTriggerButton:SetAttribute("SetButtonPairState", SetButtonPairState)
   self.RightTriggerButton:SetAttribute("SetButtonExpanded", SetButtonExpanded)
   SecureHandlerWrapScript(self.RightTriggerButton, "OnClick", self.RightTriggerButton,
                           [[self:RunAttribute("SetButtonPairState", "RightButton", down, "trigger")]])
   SecureHandlerWrapScript(self.RightTriggerButton, "OnDoubleClick", self.RightTriggerButton,
                           [[self:RunAttribute("SetButtonExpanded", "RightButton")]])
end

function GamePadButtonsMixin:CreateLeftShoulderButton()
   self.LeftShoulderButton = self:CreatePairButton("LeftShoulder")
   self.LeftShoulderButton:SetAttribute("SetButtonPairState", SetButtonPairState)
   SecureHandlerWrapScript(self.LeftShoulderButton, "OnClick", self.LeftShoulderButton,
                           [[self:RunAttribute("SetButtonPairState", "LeftButton", down, "shoulder")]])
end

function GamePadButtonsMixin:CreateRightShoulderButton()
   self.RightShoulderButton = self:CreatePairButton("RightShoulder")
   self.RightShoulderButton:SetAttribute("SetButtonPairState", SetButtonPairState)
   SecureHandlerWrapScript(self.RightShoulderButton, "OnClick", self.RightShoulderButton,
                           [[self:RunAttribute("SetButtonPairState", "RightButton", down, "shoulder")]])
end

function GamePadButtonsMixin:CreateLeftPaddleButton()
   self.LeftPaddleButton = self:CreatePairButton("LeftPaddle")
   self.LeftPaddleButton:SetAttribute("SetButtonPairState", SetButtonPairState)
   SecureHandlerWrapScript(self.LeftPaddleButton, "OnClick", self.LeftPaddleButton,
                           [[self:RunAttribute("SetButtonPairState", "LeftButton", down, "paddle")]])
end

function GamePadButtonsMixin:CreateRightPaddleButton()
   self.RightPaddleButton = self:CreatePairButton("RightPaddle")
   self.RightPaddleButton:SetAttribute("SetButtonPairState", SetButtonPairState)
   SecureHandlerWrapScript(self.RightPaddleButton, "OnClick", self.RightPaddleButton,
                           [[self:RunAttribute("SetButtonPairState", "RightButton", down, "paddle")]])
end

function GamePadButtonsMixin:CreateModifierButton(Name)
   self[Name.."Button"] = CreateFrame("Button", ADDON .. Name .. "ButtonFrame",
                                      self, "SecureActionButtonTemplate, SecureHandlerStateTemplate" )
   self[Name.."Button"]:SetFrameStrata("BACKGROUND")
   self[Name.."Button"]:SetPoint("TOP", self, "LEFT", 0, 0)
   self[Name.."Button"]:RegisterForClicks("AnyDown", "AnyUp")
   self[Name.."Button"]:Hide()
   
   SecureHandlerSetFrameRef(self[Name.."Button"], 'GamePad', addon.GamePad)
   SecureHandlerSetFrameRef(self[Name.."Button"], 'Crosshotbar', addon.Crosshotbar)
   SecureHandlerSetFrameRef(self[Name.."Button"], 'GroupNavigator', addon.GroupNavigator)
   
   self[Name.."Button"]:SetAttribute("*type1", "macro")
   self[Name.."Button"]:SetAttribute("macrotext1", "")
   self[Name.."Button"]:SetAttribute("modstate", 0)
   self[Name.."Button"]:SetAttribute("modname", "")
   self[Name.."Button"]:SetAttribute("trigstate", 4)
   self[Name.."Button"]:SetAttribute("SetActionBindings", [[
      local modname = ...
      if modname == "" then
         self:ClearBindings()
         self:SetAttribute("macrotext1", "")
      end
      local binding = self:GetAttribute(modname .. "BINDING")
      if binding ~= nil and binding ~= "" then
         local action = self:GetAttribute(modname .. "ACTION")
         self:SetAttribute("ACTIVE", action) 
         self:SetBindingClick(true, binding, self:GetName(), "LeftButton")
      end
   ]])
   SecureHandlerWrapScript(self[Name.."Button"], "OnClick", self[Name.."Button"], [[
      if self:GetAttribute("ACTIVE")  then
         local action = self:GetAttribute("ACTIVE")
         --print(action)
         self:RunAttribute("ACTIVE", down)
      end
   ]])
end

function GamePadButtonsMixin:AddUpdateModifierName()
self:SetAttribute("UpdateModifierName", [[
   local type = ...
   local trig = ""
   local mod  = ""

   if type == "trigger" then
      type = self:GetAttribute("modtype")
   end

   local triggerstate = self:GetAttribute("triggerstate")
   if triggerstate ~= 0 and triggerstate ~= 4 then
      trig = "TRIG"
   end

   if type == "shoulder" then
      local shoulderstate = self:GetAttribute("shoulderstate")
      self:SetAttribute("modtype", type)
      if shoulderstate == 6 or shoulderstate == 3 or shoulderstate == 2 then
         mod = "SPADL"
      end
      if shoulderstate == 7 or shoulderstate == 5 or shoulderstate == 1 then
         mod = "SPADR"
      end
   end

   if type == "paddle"  then
      local paddlestate = self:GetAttribute("paddlestate")
      self:SetAttribute("modtype", type)
      if paddlestate == 6 or paddlestate == 3 or paddlestate == 2 then
         mod = "PPADL"
      end
      if paddlestate == 7 or paddlestate == 5 or paddlestate == 1 then
         mod = "PPADR"
      end
   end

   self:SetAttribute("modname", mod .. trig)
   -- print("[" .. mod .. trig .. "]")
]])
end

function GamePadButtonsMixin:AddTriggerHandler()
   self:SetAttribute("triggerstate", 4)
   self:SetAttribute("_onstate-trigger", [[
      self:SetAttribute("triggerstate", newstate)

      self:RunAttribute("UpdateModifierName", "trigger")
      local modname = self:GetAttribute("modname")

      local nbuttons = self:GetAttribute("NumModifierButtons")
      for i = 1,nbuttons do
         local button = self:GetFrameRef('ModifierButton'..i)
         if button ~= nil then
            button:RunAttribute("SetActionBindings", modname)
         end
      end
      
      local GroupNavigator = self:GetFrameRef('GroupNavigator')
      if GroupNavigator ~= nil then
         GroupNavigator:RunAttribute("SetActionBindings", modname)
      end
      
      local Crosshotbar = self:GetFrameRef('Crosshotbar')
      if Crosshotbar ~= nil then

         local hotbar_expanded = self:GetAttribute("expandedstate")

         if hotbar_expanded >= 3 then
            hotbar_expanded = 0
            if (newstate == 6 or newstate == 3 or newstate == 2) then hotbar_expanded = 1 end
            if (newstate == 7 or newstate == 5 or newstate == 1) then hotbar_expanded = 2 end
         else
            if not ((hotbar_expanded == 1 and (newstate == 6 or newstate == 3)) or
                    (hotbar_expanded == 2 and (newstate == 7 or newstate == 5))) then
               hotbar_expanded = 0
               self:SetAttribute("expandedstate", 0)
            end
         end

         Crosshotbar:SetAttribute("state-expanded", hotbar_expanded)
         Crosshotbar:SetAttribute("state-trigger", newstate)
      end
   ]])
end

function GamePadButtonsMixin:AddShoulderHandler()
   self:SetAttribute("shoulderstate", 4)
   self:SetAttribute("_onstate-shoulder", [[
      self:SetAttribute("shoulderstate", newstate)

      self:RunAttribute("UpdateModifierName", "shoulder")
      local modname = self:GetAttribute("modname")

      local nbuttons = self:GetAttribute("NumModifierButtons")
      for i = 1,nbuttons do
         local button = self:GetFrameRef('ModifierButton'..i)
         if button ~= nil then
            button:RunAttribute("SetActionBindings", modname)
         end
      end

      local GroupNavigator = self:GetFrameRef('GroupNavigator')
      if GroupNavigator ~= nil then
         GroupNavigator:RunAttribute("SetActionBindings", modname)
      end
      
      local Crosshotbar = self:GetFrameRef('Crosshotbar')
      if Crosshotbar ~= nil then
         Crosshotbar:SetAttribute("state-shoulder", newstate)
      end
   ]])
end

function GamePadButtonsMixin:AddPaddleHandler()
   self:SetAttribute("paddlestate", 4)
   self:SetAttribute("_onstate-paddle", [[
      self:SetAttribute("paddlestate", newstate)

      self:RunAttribute("UpdateModifierName", "paddle")
      local modname = self:GetAttribute("modname")

      local nbuttons = self:GetAttribute("NumModifierButtons")
      for i = 1,nbuttons do
         local button = self:GetFrameRef('ModifierButton'..i)
         if button ~= nil then
            button:RunAttribute("SetActionBindings", modname)
         end
      end
      
      local GroupNavigator = self:GetFrameRef('GroupNavigator')
      if GroupNavigator ~= nil then
         GroupNavigator:RunAttribute("SetActionBindings", modname)
      end
      
      local Crosshotbar = self:GetFrameRef('Crosshotbar')
      if Crosshotbar ~= nil then
         Crosshotbar:SetAttribute("state-paddle", newstate)
      end
   ]])
end

function GamePadButtonsMixin:AddExpandedHandler()
   self:SetAttribute("expandedstate", 0)
   self:SetAttribute("_onstate-expanded", [[
      self:SetAttribute("expandedstate", newstate)
      local Crosshotbar = self:GetFrameRef('Crosshotbar')
      if Crosshotbar ~= nil then
         Crosshotbar:SetAttribute("state-expanded", newstate)
      end
   ]])
end

function GamePadButtonsMixin:AddStateHandlers()
   self:AddUpdateModifierName()
   self:AddTriggerHandler()
   self:AddShoulderHandler()
   self:AddPaddleHandler()
   self:AddExpandedHandler()
end
