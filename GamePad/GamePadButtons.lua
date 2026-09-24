local ADDON, addon = ...
local config = addon.Config

local CalculatePairState = [[
   local down, state, button = ...

   local type = 0
   if button == "LeftButton" then type = 2 end
   if button == "RightButton" then type = 3 end

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
    end

    return found, state
]]

local SetButtonPairState = [[
   local button, down, pairname  = ...

   local GamePad = self:GetFrameRef('GamePad')

   if GamePad ~= nil and type ~= 0 then

      local state = GamePad:GetAttribute(pairname.."state")
      local found, newstate = self:RunAttribute('CalculatePairState', down, state, button);

      if found then
         GamePad:SetAttribute("state-"..pairname, newstate)
      else
        -- print("Error " .. state .. " " .. a .. " " .. b .. " " .. type)
      end
   end
]]

local SetButtonExpanded = [[
   local button = ...
   local GamePad = self:GetFrameRef('GamePad')

   if GamePad ~= nil then
      local dblclick = GamePad:GetAttribute("wxhbdclk")
      local state = GamePad:GetAttribute("triggerstate")

      if dblclick == 1 then
         if state == 4 then
            if button == "LeftButton" then
               GamePad:SetAttribute("state-expanded", 1)
            end
            if button == "RightButton" then
               GamePad:SetAttribute("state-expanded", 2)
            end
         end
      elseif dblclick == 2 then
         if state == 6 or state == 7 then
            GamePad:SetAttribute("state-trigger", 4)
            if button == "LeftButton" then
               GamePad:SetAttribute("state-expanded", 1)
            end
            if button == "RightButton" then
               GamePad:SetAttribute("state-expanded", 2)
            end

            local Crosshotbar = self:GetFrameRef('Crosshotbar')
            if Crosshotbar ~= nil then
               Crosshotbar:RunAttribute("update-expanded")
            end
         else
            local found, newstate = self:RunAttribute('CalculatePairState', false, state, button);
            if found then
               GamePad:SetAttribute("state-trigger", newstate)
            else
               GamePad:SetAttribute("state-trigger", 4)
            end
         end
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

function GamePadButtonsMixin:AddEventHandler(frame)
   frame:SetAttribute("event-ready", 0)
   frame:SetAttribute("event-ncount", 0)
   RegisterAttributeDriver(frame, "event-ready", 1)
   frame:Execute([[ ncount = 0 ]])
   frame:SetAttributeNoHandler("_onattributechanged", [[
        if name == "event-ready" then
           if value == 1 and ncount > 0 then
              ncount = ncount - 1
              if ncount > 0 then
                 self:SetAttribute("event-ready", 0)
              end
           end
        end
        if name == "event-ncount" then
           if value > 0 then
              ncount = value
              self:SetAttribute("event-ready", 0)
           else
              ncount = 0
              self:SetAttribute("event-ready", 1)
           end
        end
    ]])
end

function GamePadButtonsMixin:RemoveEventHandler(frame)
   frame:SetAttribute("event-ready", 0)
   frame:SetAttribute("event-ncount", 0)
   UnregisterAttributeDriver(frame, "event-ready")
   frame:SetAttributeNoHandler("_onattributechanged", nil)
end

function GamePadButtonsMixin:CreatePairButton(ButtonName)
   local Button = CreateFrame("Button", ADDON .. ButtonName .. "ButtonFrame",
                              self, "SecureActionButtonTemplate, SecureHandlerAttributeTemplate" )
   Button:SetFrameStrata("BACKGROUND")
   Button:SetPoint("TOP", self, "LEFT", 0, 0)
   Button:RegisterForClicks("AnyDown", "AnyUp")
   Button:SetAttribute("useOnKeyDown", true)
   Button:SetAttribute("CalculatePairState", CalculatePairState);
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
   self:AddEventHandler(self.LeftTriggerButton)
   SecureHandlerWrapScript(self.LeftTriggerButton, "OnClick", self.LeftTriggerButton, [[
      local GamePad = self:GetFrameRef('GamePad')
      if GamePad ~= nil then
         local expandedstate = GamePad:GetAttribute("expandedstate")
         local dblclick = GamePad:GetAttribute("wxhbdclk")

         if (down and dblclick == 1)  or (not down and dblclick == 2) then
            if expandedstate ~= 4 then
               GamePad:RunAttribute("SetActionButton", "LeftTrigger")
            end
        
            local ready = self:GetAttribute("event-ready")
            if ready == 0 then
               self:RunAttribute("SetButtonExpanded", "LeftButton")
            else 
               self:SetAttribute("event-ncount", 2)
            end
         end

         if expandedstate ~= 4 then
            self:RunAttribute("SetButtonPairState", "LeftButton", down, "trigger")
         end
     end
  ]])
end

function GamePadButtonsMixin:CreateRightTriggerButton()
   self.RightTriggerButton = self:CreatePairButton("RightTrigger")
   self.RightTriggerButton:SetAttribute("SetButtonPairState", SetButtonPairState)
   self.RightTriggerButton:SetAttribute("SetButtonExpanded", SetButtonExpanded)
   self:AddEventHandler(self.RightTriggerButton)
   SecureHandlerWrapScript(self.RightTriggerButton, "OnClick", self.RightTriggerButton, [[
      local GamePad = self:GetFrameRef('GamePad')
      if GamePad ~= nil then
         local expandedstate = GamePad:GetAttribute("expandedstate")
         local dblclick = GamePad:GetAttribute("wxhbdclk")
         if (down and dblclick == 1) or (not down and dblclick == 2) then
            if expandedstate ~= 5 then
               GamePad:RunAttribute("SetActionButton", "RightTrigger")
            end
            local ready = self:GetAttribute("event-ready")
            if ready == 0 then
               self:RunAttribute("SetButtonExpanded", "RightButton")
            else
               self:SetAttribute("event-ncount", 2)
            end
          end

         if expandedstate ~= 5 then
            self:RunAttribute("SetButtonPairState", "RightButton", down, "trigger")
         end
       end
   ]])
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
   self[Name.."Button"]:SetAttribute("useOnKeyDown", true)
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
