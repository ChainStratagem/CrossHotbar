local ADDON, addon = ...
local config = addon.Config

local GamePadButtonList = addon.GamePadButtonList
local GamePadModifierList = addon.GamePadModifierList

local DCLKList = {
   {"DISABLE", 0},
   {"ENABLE", 1},
   {"VISUAL", 2}
}
addon:ActionListAdd("HotbarDCLKTypes", "CATEGORY_HOTBAR_DCLK", DCLKList)
DCLKList = addon:ActionListToTable(DCLKList)

local ModifierList = {
   {"LEFTSHOULDER", true},
   {"RIGHTSHOULDER", true},
   {"LEFTHOTBAR", true},
   {"RIGHTHOTBAR", true},
   {"LEFTPADDLE", true},
   {"RIGHTPADDLE", true}
}
addon:ActionListAdd("GamePadModifiers", "CATEGORY_MODIFIERS", ModifierList, "NONE")
ModifierList = addon:ActionListToTable(ModifierList)

local ActionList = {
   {"JUMP", true},
   {"INTERACTTARGET", true},
   {"TOGGLEWORLDMAP", true},
   {"TOGGLEGAMEMENU", true},
   {"OPENALLBAGS", true},
   {"NAMEPLATES", true},
   {"FRIENDNAMEPLATES", true},
   {"ALLNAMEPLATES", true}
}
addon:ActionListAdd("GamePadActions", "CATEGORY_ACTIONS", ActionList, "NONE")
ActionList = addon:ActionListToTable(ActionList)

local ModifierActions = {
   {"SIT", [[ local down = ...
      if down then
         self:SetAttribute("macrotext1", "/sit")
      end
   ]]},
   {"LOOT", [[ local down = ...
      if down then
         self:SetAttribute("macrotext1", "/loot")
      end
   ]]},
   {"EXTRAACTIONBUTTON1", [[ local down = ...
      if down then
         self:SetAttribute("macrotext1", "/click ExtraActionButton1")
      end
   ]]},
   {"TOGGLESHEATH", [[local down = ...
      if down then
        local GamePadButtons = self:GetFrameRef('GamePadButtons')
        if GamePadButtons then
           GamePadButtons:CallMethod("ToggleSheath")
        end
      end
   ]]}
}

addon:ActionListAdd("GamePadActions", "CATEGORY_ACTIONS", ModifierActions, "NONE")
addon:ActionListAdd("GamePadModifierActions", "CATEGORY_ACTIONS", ModifierActions, "NONE")
addon:ActionListAdd("GamePadModifiers", "CATEGORY_ACTIONS", ModifierActions, "NONE")
ModifierActions = addon:ActionListToTable(ModifierActions)

local ExpandedModifierActions = {
   {"HOLDEXPANDED", [[local down = ...
      local GamePadButtons = self:GetFrameRef('GamePadButtons')
      if GamePadButtons ~= nil then
         local expanded = 0
         if down == true then expanded = 3 end
         local triggerstate = GamePadButtons:GetAttribute("triggerstate")
         local expandedstate = GamePadButtons:GetAttribute("expandedstate")
         if expandedstate == 0 or expandedstate == 3 then
            if triggerstate == 4 then
               GamePadButtons:SetAttribute("state-expanded", expanded)
            else
               GamePadButtons:SetAttribute("state-trigger", 4)
               GamePadButtons:SetAttribute("state-expanded", expanded)
               GamePadButtons:SetAttribute("state-trigger", triggerstate)
            end
         end
      end
   ]]},
   {"LEFTEXPANDED", [[local down = ...
      local GamePadButtons = self:GetFrameRef('GamePadButtons')
      if GamePadButtons ~= nil then
         local expanded = 0
         local triggerstate = GamePadButtons:GetAttribute("triggerstate")
         local expandedstate = GamePadButtons:GetAttribute("expandedstate")
         if expandedstate == 0 or expandedstate == 3 or expandedstate == 4 then
            if triggerstate == 4 or expandedstate == 4 then
               if down then
                  GamePadButtons:SetAttribute("state-trigger", 4)
                  GamePadButtons:SetAttribute("state-expanded", 4)
                  GamePadButtons:SetAttribute("state-trigger", 6)
               else
                  GamePadButtons:SetAttribute("state-expanded", 0)
                  GamePadButtons:SetAttribute("state-trigger", 4)
               end
            else
               if down == true then expanded = 3 end
               if (triggerstate == 6 or triggerstate == 3 or triggerstate == 2) then
                  GamePadButtons:SetAttribute("state-trigger", 4)
                  GamePadButtons:SetAttribute("state-expanded", expanded)
                  GamePadButtons:SetAttribute("state-trigger", triggerstate)
               end
            end
         end
      end
   ]]},
   {"RIGHTEXPANDED", [[local down = ...
      local GamePadButtons = self:GetFrameRef('GamePadButtons')
      if GamePadButtons ~= nil then
         local expanded = 0
         local triggerstate = GamePadButtons:GetAttribute("triggerstate")
         local expandedstate = GamePadButtons:GetAttribute("expandedstate")
         if expandedstate == 0 or expandedstate == 3 or expandedstate == 5 then
            if triggerstate == 4 or expandedstate == 5 then
               if down then
                  GamePadButtons:SetAttribute("state-trigger", 4)
                  GamePadButtons:SetAttribute("state-expanded", 5)
                  GamePadButtons:SetAttribute("state-trigger", 7)
               else
                  GamePadButtons:SetAttribute("state-expanded", 0)
                  GamePadButtons:SetAttribute("state-trigger", 4)
               end
            else
               if down == true then expanded = 3 end
               if (triggerstate == 7 or triggerstate == 5 or triggerstate == 1) then
                  GamePadButtons:SetAttribute("state-trigger", 4)
                  GamePadButtons:SetAttribute("state-expanded", expanded)
                  GamePadButtons:SetAttribute("state-trigger", triggerstate)
               end
            end
         end
      end
   ]]}
}

addon:ActionListAdd("GamePadActions", "CATEGORY_HOTBAR_EXPANDED", ExpandedModifierActions, "NONE")
addon:ActionListAdd("GamePadModifierActions", "CATEGORY_HOTBAR_EXPANDED", {{"HOLDEXPANDED",true}}, "NONE")
addon:ActionListAdd("GamePadModifiers", "CATEGORY_HOTBAR_EXPANDED", ExpandedModifierActions, "NONE")
ExpandedModifierActions = addon:ActionListToTable(ExpandedModifierActions)

local MacroModifierActions = {
   {"MACRO CH_MACRO_1", [[ local down = ...
      if down then
         self:SetAttribute("macro", "CH_MACRO_1")
      end
   ]]},
   {"MACRO CH_MACRO_2", [[ local down = ...
      if down then
         self:SetAttribute("macro", "CH_MACRO_2")
      end
   ]]},
   {"MACRO CH_MACRO_3", [[ local down = ...
      if down then
         self:SetAttribute("macro", "CH_MACRO_3")
      end
   ]]},
   {"MACRO CH_MACRO_4", [[ local down = ...
      if down then
         self:SetAttribute("macro", "CH_MACRO_4")
      end
   ]]}
}

addon:ActionListAdd("GamePadActions", "CATEGORY_MACRO", MacroModifierActions, "NONE")
addon:ActionListAdd("GamePadModifierActions", "CATEGORY_MACRO", MacroModifierActions, "NONE")
addon:ActionListAdd("GamePadModifiers", "CATEGORY_MACRO", MacroModifierActions, "NONE")
MacroModifierActions = addon:ActionListToTable(MacroModifierActions)

local TargetModifierActions = {
   {"FOCUSTARGET", [[ local down = ...
      if down then
         self:SetAttribute("macrotext1", "/focus")
      end
   ]]},
   {"TARGETFOCUS", [[ local down = ...
      if down then
         self:SetAttribute("macrotext1", "/target focus")
      end
   ]]},
   {"ASSISTTARGET", [[ local down = ...
      if down then
         self:SetAttribute("macrotext1", "/assist")
      end
   ]]},
   {"TARGETLASTHOSTILE", [[ local down = ...
      if down then
         self:SetAttribute("macrotext1", "/targetlastenemy")
      end
   ]]},
   {"TARGETLASTTARGET", [[local down = ...
      if down then
         self:SetAttribute("macrotext1", "/targetlasttarget")
      end
   ]]},
   {"TARGETNEARESTFRIEND", [[local down = ...
      if down then
         self:SetAttribute("macrotext1", "/targetfriend")
      end
   ]]},
   {"TARGETPREVIOUSFRIEND", [[local down = ...
      if down then
         self:SetAttribute("macrotext1", "/targetfriend 1")
      end
   ]]},
   {"TARGETNEARESTENEMY", [[local down = ...
      if down then
         self:SetAttribute("macrotext1", "/targetenemy")
      end
   ]]},
   {"TARGETPREVIOUSENEMY", [[local down = ...
      if down then
         self:SetAttribute("macrotext1", "/targetenemy 1")
      end
   ]]},
   {"TARGETSELF", [[local down = ...
      if down then
         self:SetAttribute("macrotext1", "/target player")
      end
   ]]},
   {"TARGETPARTYMEMBER1", [[local down = ...
      if down then
         self:SetAttribute("macrotext1", "/target party1")
      end
   ]]},
   {"TARGETPARTYMEMBER2", [[local down = ...
      if down then
         self:SetAttribute("macrotext1", "/target party2")
      end
   ]]},
   {"TARGETPARTYMEMBER3", [[local down = ...
      if down then
         self:SetAttribute("macrotext1", "/target party3")
      end
   ]]},
   {"TARGETPARTYMEMBER4", [[local down = ...
      if down then
         self:SetAttribute("macrotext1", "/target party4")
      end
   ]]},
   {"CLEARTARGETING", [[local down = ...
      if down then
         self:SetAttribute("macrotext1", "/cleartarget\n/stopspelltarget\n")
      end
   ]]}
}

addon:ActionListAdd("GamePadActions", "CATEGORY_TARGETING", TargetModifierActions, "NONE")
addon:ActionListAdd("GamePadModifierActions", "CATEGORY_TARGETING", TargetModifierActions, "NONE")
addon:ActionListAdd("GamePadModifiers", "CATEGORY_TARGETING", TargetModifierActions, "NONE")
TargetModifierActions = addon:ActionListToTable(TargetModifierActions)

local CameraModifierActions = {
   {"ZOOMIN", [[local down = ...
      local GamePadButtons = self:GetFrameRef('GamePadButtons')
      if GamePadButtons then
         GamePadButtons:CallMethod("ZoomIn", down)
      end
   ]]},
   {"ZOOMOUT", [[local down = ...
      local GamePadButtons = self:GetFrameRef('GamePadButtons')
      if GamePadButtons then
         GamePadButtons:CallMethod("ZoomOut", down)
      end
   ]]},
   {"CAMERALOOKON", [[local down = ...
      if down then
        local GamePadButtons = self:GetFrameRef('GamePadButtons')
        if GamePadButtons then
           GamePadButtons:CallMethod("SetCameraLook", false)
        end
      end
   ]]},
   {"CAMERALOOKOFF", [[local down = ...
      if down then
        local GamePadButtons = self:GetFrameRef('GamePadButtons')
        if GamePadButtons then
           GamePadButtons:CallMethod("SetCameraLook", true)
        end
      end
   ]]},
   {"CAMERALOOKTOGGLE", [[local down = ...
      if down then
         local GamePadButtons = self:GetFrameRef('GamePadButtons')
         if GamePadButtons then
            GamePadButtons:CallMethod("ToggleCameraLook")
         end
      end
   ]]},
   {"CAMERALOOKHOLD", [[local down = ...
      local GamePadButtons = self:GetFrameRef('GamePadButtons')
      if GamePadButtons then
         GamePadButtons:CallMethod("HoldCameraLook", down)
      end
   ]]},
   {"GAMEPADMOUSE", [[ local down = ...
      if down then
        local GamePadButtons = self:GetFrameRef('GamePadButtons')
        if GamePadButtons then
           GamePadButtons:CallMethod("SetGamePadMouse", nil)
        end
      end
   ]]}
}

addon:ActionListAdd("GamePadActions", "CATEGORY_CAMERA", CameraModifierActions, "NONE")
addon:ActionListAdd("GamePadModifierActions", "CATEGORY_CAMERA", CameraModifierActions, "NONE")
addon:ActionListAdd("GamePadModifiers", "CATEGORY_CAMERA", CameraModifierActions, "NONE")
CameraModifierActions = addon:ActionListToTable(CameraModifierActions)

local PageModifierActions = {
   {"NEXTPAGE", [[local down = ...
      if down then
         local GamePadButtons = self:GetFrameRef('GamePadButtons')
         if GamePadButtons then
            GamePadButtons:CallMethod("GPPlaySound", 1115)
         end
         local Crosshotbar = self:GetFrameRef('Crosshotbar')
         local newset = abs(Crosshotbar:GetAttribute("activeset") + 1)%6
         if newset == 0 then newset = 6 end
         Crosshotbar:SetAttribute("state-page", newset)
      end
   ]]},
   {"PREVPAGE", [[local down = ...
      if down then
         local GamePadButtons = self:GetFrameRef('GamePadButtons')
         if GamePadButtons then
            GamePadButtons:CallMethod("GPPlaySound", 1115)
         end
         local Crosshotbar = self:GetFrameRef('Crosshotbar')
         local newset = abs(Crosshotbar:GetAttribute("activeset") + 5)%6
         if newset == 0 then newset = 6 end
         Crosshotbar:SetAttribute("state-page", newset)
      end
   ]]},
   {"PAGEONE", [[local down = ...
      if down then
         local GamePadButtons = self:GetFrameRef('GamePadButtons')
         if GamePadButtons then
            GamePadButtons:CallMethod("GPPlaySound", 1115)
         end
         local Crosshotbar = self:GetFrameRef('Crosshotbar')
         local newset = 1
         Crosshotbar:SetAttribute("state-page", newset)
      end
   ]]},
   {"PAGETWO", [[local down = ...
      if down then
         local GamePadButtons = self:GetFrameRef('GamePadButtons')
         if GamePadButtons then
            GamePadButtons:CallMethod("GPPlaySound", 1115)
         end
         local Crosshotbar = self:GetFrameRef('Crosshotbar')
         local newset = 2
         Crosshotbar:SetAttribute("state-page", newset)
      end
   ]]},
   {"PAGETHREE", [[local down = ...
      if down then
         local GamePadButtons = self:GetFrameRef('GamePadButtons')
         if GamePadButtons then
            GamePadButtons:CallMethod("GPPlaySound", 1115)
         end
         local Crosshotbar = self:GetFrameRef('Crosshotbar')
         local newset = 3
         Crosshotbar:SetAttribute("state-page", newset)
      end
   ]]},
   {"PAGEFOUR", [[local down = ...
      if down then
         local GamePadButtons = self:GetFrameRef('GamePadButtons')
         if GamePadButtons then
            GamePadButtons:CallMethod("GPPlaySound", 1115)
         end
         local Crosshotbar = self:GetFrameRef('Crosshotbar')
         local newset = 4
         Crosshotbar:SetAttribute("state-page", newset)
      end
   ]]},
   {"PAGEFIVE", [[local down = ...
      if down then
         local GamePadButtons = self:GetFrameRef('GamePadButtons')
         if GamePadButtons then
            GamePadButtons:CallMethod("GPPlaySound", 1115)
         end
         local Crosshotbar = self:GetFrameRef('Crosshotbar')
         local newset = 5
         Crosshotbar:SetAttribute("state-page", newset)
      end
   ]]},
   {"PAGESIX", [[local down = ...
      if down then
         local GamePadButtons = self:GetFrameRef('GamePadButtons')
         if GamePadButtons then
            GamePadButtons:CallMethod("GPPlaySound", 1115)
         end
         local Crosshotbar = self:GetFrameRef('Crosshotbar')
         local newset = 6
         Crosshotbar:SetAttribute("state-page", newset)
      end
   ]]}
}

addon:ActionListAdd("GamePadActions", "CATEGORY_PAGING", PageModifierActions, "NONE")
addon:ActionListAdd("GamePadModifierActions", "CATEGORY_PAGING", PageModifierActions, "NONE")
addon:ActionListAdd("GamePadModifiers", "CATEGORY_PAGING", PageModifierActions, "NONE")
PageModifierActions = addon:ActionListToTable(PageModifierActions)

for key, value in pairs(ExpandedModifierActions) do ModifierActions[key] = value  end
for key, value in pairs(MacroModifierActions) do ModifierActions[key] = value  end
for key, value in pairs(TargetModifierActions) do ModifierActions[key] = value  end
for key, value in pairs(CameraModifierActions) do ModifierActions[key] = value  end
for key, value in pairs(PageModifierActions) do ModifierActions[key] = value  end

local GamePadButtonsMixin = {
   GamePadEnabled = true,
   MouseLookEnabled = true,
   GamePadLookEnabled = true,
   GamePadLookHold = false,
   SpellTargetConfirmButton = "PAD1",
   SpellTargetCancelButton = "PAD3",
   GamePadLeftClick = "PADLTRIGGER",
   GamePadRightClick = "PADRTRIGGER",
   GamePadLeftClickCache = "PADLTRIGGER",
   GamePadRightClickCache = "PADRTRIGGER",
   GamePadAutoDisableSticks = 0,
   GamePadAutoDisableJump = 0,
   GamePadAutoEnable = 0,
   GamePadMouseMode = false,
   GamePadCursorEnabled = false,
   SpellTargetingStarted = false,   
   SpellTargetingUpdate = false,
   LeftTriggerButton = nil,
   RightTriggerButton = nil,
   LeftShoulderButton = nil,
   RightShoulderButton = nil,
   LeftPaddleButton = nil,
   RightPaddleButton = nil,
   MouseLookState = false,
   EnableSounds = false
}

function GamePadButtonsMixin:SetMouseLook(enable)
   self.MouseLookState = enable
   if enable then
      MouselookStart()
   else
      MouselookStop()
   end
end
   
function GamePadButtonsMixin:CanAutoSetGamePadCursorControl(enable)
   if self.GamePadAutoEnable == 1 and
      not self.GamePadMouseMode then
      return CanAutoSetGamePadCursorControl(enable)
   else
      if enable == self.GamePadCursorEnabled then
         return false
      else
         return true
      end
   end
end

function GamePadButtonsMixin:SetGamePadCursorControl(enable)
   self.GamePadCursorEnabled = enable
   if enable then
      if self.GamePadMouseMode then
         self.MouseStatusFrame.pointtex:Hide()
         self.MouseStatusFrame.mousetex:Show()
      else
         self.MouseStatusFrame.pointtex:Show()
         self.MouseStatusFrame.mousetex:Hide()
      end
      self.MouseStatusFrame:Show()
   else
      if not self.GamePadMouseMode then
         self.MouseStatusFrame.pointtex:Hide()
         self.MouseStatusFrame.mousetex:Hide()
         self.MouseStatusFrame:Hide()
      end
   end
end

function GamePadButtonsMixin:GPPlaySound(soundid)
   if self.EnableSounds then
      PlaySound(soundid)
   end
end

function GamePadButtonsMixin:ToggleSheath()
   ToggleSheath()
end

function GamePadButtonsMixin:ZoomIn(down)
   if down then
      MoveViewInStart(1.0, 0, true);
   else
      CameraZoomIn(1.0)
   end
end

function GamePadButtonsMixin:ZoomOut(down)
   if down then
      MoveViewOutStart(1.0, 0, true);
   else
      CameraZoomOut(1.0)
   end
end

function GamePadButtonsMixin:ToggleCameraLook()
   self:HoldCameraLook(not self.GamePadLookHold)
end

function GamePadButtonsMixin:HoldCameraLook(isheld)
   if self.MouseLookEnabled then
      if IsMouselooking() then
         self:SetMouseLook(false)
      else
         self:SetMouseLook(true)
      end
   end
   if self.GamePadLookEnabled then
      if isheld then self.GamePadLookHold = isheld end      
      if not SpellIsTargeting() and not self.GamePadMouseMode then   
         if isheld then   
            self.GamePadLeftClickCache = GetCVar('GamePadCursorLeftClick')
            self.GamePadRightClickCache = GetCVar('GamePadCursorRightClick')
            SetCVar('GamePadCursorLeftClick', 'NONE');
            SetCVar('GamePadCursorRightClick', 'NONE');
         else
            SetCVar('GamePadCursorLeftClick', self.GamePadLeftClickCache)
            SetCVar('GamePadCursorRightClick', self.GamePadRightClickCache) 
         end
      end
      if self:CanAutoSetGamePadCursorControl(true) then
         SetGamePadCursorControl(true)
      elseif self:CanAutoSetGamePadCursorControl(false) then
         SetGamePadCursorControl(false)
      end
      if not isheld then self.GamePadLookHold = isheld end
   end
end

function GamePadButtonsMixin:SetCameraLook(enable)
   if self.MouseLookEnabled then
     if enable then
         self:SetMouseLook(false)
      else
         self:SetMouseLook(true)
      end
   end
   if self.GamePadLookEnabled then
      if self:CanAutoSetGamePadCursorControl(enable) then
         SetGamePadCursorControl(enable)
      end
   end
end

function GamePadButtonsMixin:SetGamePadMouse(enable)
   if not SpellIsTargeting() and not self.GamePadLookHold then
      if enable == nil then
         enable = not self.GamePadMouseMode
      end
      if self.MouseLookEnabled then
         if enable then
            self:SetMouseLook(false)
         else
            self:SetMouseLook(true)
         end
      end
      if self.GamePadLookEnabled then
         if enable then
            SetCVar('GamePadCursorAutoEnable', 0)
            SetCVar('GamePadCursorAutoDisableSticks', 0)
            SetCVar('GamePadCursorAutoDisableJump', 0)
            SetCVar('GamePadCursorLeftClick', self.GamePadLeftClick);
            SetCVar('GamePadCursorRightClick', self.GamePadRightClick);
            self.GamePadMouseMode = true
            SetGamePadCursorControl(true)
            self:GPPlaySound(100)
         else
            SetCVar('GamePadCursorAutoEnable', self.GamePadAutoEnable)
            SetCVar('GamePadCursorAutoDisableSticks', self.GamePadAutoDisableSticks)
            SetCVar('GamePadCursorAutoDisableJump', self.GamePadAutoDisableJump)
            SetCVar('GamePadCursorLeftClick', 'NONE');
            SetCVar('GamePadCursorRightClick', 'NONE');      
            self.GamePadMouseMode = false
            SetGamePadCursorControl(false)
            self:GPPlaySound(100)
         end
      end
   end
end

local SetButtonPairState = [[
   local button, down, pairname  = ...

   local type = 0
   if button == "LeftButton" then type = 2 end
   if button == "RightButton" then type = 3 end

   local GamePadButtons = self:GetFrameRef('GamePadButtons')

   if GamePadButtons ~= nil and type ~= 0 then

      if pairname == "trigger" then
         local expandedstate = GamePadButtons:GetAttribute("expandedstate")
         if expandedstate == 4 and type == 2 then return end
         if expandedstate == 5 and type == 3 then return end
      end

      local state = GamePadButtons:GetAttribute(pairname.."state")

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
         GamePadButtons:SetAttribute("state-"..pairname, state)
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

   local GamePadButtons = self:GetFrameRef('GamePadButtons')
   if GamePadButtons ~= nil and type ~= 0 then
      local dclktype = GamePadButtons:GetAttribute("wxhbdclk")
      local state = GamePadButtons:GetAttribute("triggerstate")

      local expandedstate = GamePadButtons:GetAttribute("expandedstate")
      if expandedstate == 4 and type == 2 then return end
      if expandedstate == 5 and type == 3 then return end

      if dclktype > 0 and state ~= 3 and state ~= 5 then
         GamePadButtons:SetAttribute("state-trigger", 4)
         if button == "LeftButton" then
            GamePadButtons:SetAttribute("state-expanded", 1)
         end
         if button == "RightButton" then
            GamePadButtons:SetAttribute("state-expanded", 2)
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
         GamePadButtons:SetAttribute("state-trigger", newstate)
      end
   end
]]

local UpdateModifierName = [[
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
]]

function GamePadButtonsMixin:CreatePairButton(ButtonName)
   local Button = CreateFrame("Button", ADDON .. ButtonName .. "ButtonFrame",
                                         self, "SecureActionButtonTemplate" )
   Button:SetFrameStrata("BACKGROUND")
   Button:SetPoint("TOP", self, "LEFT", 0, 0)
   Button:RegisterForClicks("AnyDown", "AnyUp")
   Button:Hide()
   Button:RegisterEvent("PLAYER_ENTERING_WORLD")
   local function OnEvent(self, event, ...)
      if event == 'PLAYER_ENTERING_WORLD' then
         SecureHandlerSetFrameRef(self, 'Crosshotbar', addon.Crosshotbar)
         SecureHandlerSetFrameRef(self, 'GamePadButtons', addon.GamePadButtons)
         SecureHandlerSetFrameRef(self, 'GroupNavigator', addon.GroupNavigator)
      end
   end
   Button:HookScript("OnEvent", OnEvent)
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
   self[Name.."Button"]:RegisterEvent("PLAYER_ENTERING_WORLD")
   local function OnEvent(self, event, ...)
      if event == 'PLAYER_ENTERING_WORLD' then
         SecureHandlerSetFrameRef(self, 'Crosshotbar', addon.Crosshotbar)
         SecureHandlerSetFrameRef(self, 'GamePadButtons', addon.GamePadButtons)
         SecureHandlerSetFrameRef(self, 'GroupNavigator', addon.GroupNavigator)
      end
   end
   self[Name.."Button"]:HookScript("OnEvent", OnEvent)
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

function GamePadButtonsMixin:OnLoad()
   self:SetAttribute("modname", "")
   self:SetAttribute("modtype", "")
   self:SetAttribute("wxhbdclk", 0)
   self:SetAttribute("UpdateModifierName", UpdateModifierName)

   self:AddTriggerHandler()
   self:AddShoulderHandler()
   self:AddPaddleHandler()
   self:AddExpandedHandler()

   self:CreateLeftTriggerButton()
   self:CreateRightTriggerButton()
   self:CreateLeftShoulderButton()
   self:CreateRightShoulderButton()
   self:CreateLeftPaddleButton()
   self:CreateRightPaddleButton()

   for i,button in ipairs(GamePadButtonList) do
      self:CreateModifierButton(button)
      SecureHandlerSetFrameRef(self, "ModifierButton"..i, self[button.."Button"])
   end
   self:SetAttribute("NumModifierButtons", #GamePadButtonList)

   self:RegisterEvent("ADDON_LOADED")
   self:RegisterEvent("PLAYER_ENTERING_WORLD")
   self:RegisterEvent("CURSOR_CHANGED")
   self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED")

   addon:AddApplyCallback(GenerateClosure(self.ApplyConfig, self))
end

function GamePadButtonsMixin:OnEvent(event, ...)
   -- print(event)
   if event == 'PLAYER_ENTERING_WORLD' then
      --[[
      local isInitialLogin, isReloadingUi = ...
      if isInitialLogin or isReloadingUi then
      end
      --]]
   elseif event == 'CURSOR_CHANGED' then
   elseif event == 'CURRENT_SPELL_CAST_CHANGED' then
      if SpellIsTargeting() then
         if self.MouseLookEnabled then
            if IsMouselooking() then
               MouselookStop()
            end
         end
         self.SpellTargetingStarted = true
         if self.GamePadLookEnabled and not self.GamePadMouseMode then
            if config.GamePad.GPCenterCursor == 0 then
               SetCVar('GamePadCursorCentering', true)
            end
            if config.GamePad.GPCenterEmu == 0 then
               SetCVar('GamePadCursorCenteredEmulation', true)
            end
            if not self.GamePadLookHold then
               self.GamePadLeftClickCache = GetCVar('GamePadCursorLeftClick')
               self.GamePadRightClickCache = GetCVar('GamePadCursorRightClick')
            end
            SetCVar('GamePadCursorLeftClick', self.SpellTargetConfirmButton)
            SetCVar('GamePadCursorRightClick', self.SpellTargetCancelButton)
            if GetCVar('GamePadCursorForTargeting') == "1" then
               SetGamePadCursorControl(true)
            end
         end
      elseif self.SpellTargetingStarted then
         if self.GamePadLookEnabled and not self.GamePadMouseMode then                    
            local function togglecvar()
               -- We need to wait for the click to finish.
               -- 11.0.2 was interacting with the world
               -- while left mouse was down and errored
               -- on cvar changes.
               if not IsMouseButtonDown() then
                  if not self.GamePadLookHold then
                     SetCVar('GamePadCursorLeftClick', self.GamePadLeftClickCache)
                     SetCVar('GamePadCursorRightClick', self.GamePadRightClickCache)
                     if GetCVar('GamePadCursorForTargeting') == "1" then
                        SetGamePadCursorControl(false)
                     end
                  end
                  if config.GamePad.GPCenterCursor == 0 then
                     SetCVar('GamePadCursorCentering', false)
                  end
                  if config.GamePad.GPCenterEmu == 0 then
                     SetCVar('GamePadCursorCenteredEmulation', false)
                  end
               else
                  C_Timer.After(0.025, togglecvar)
               end
            end
            C_Timer.After(0.0, togglecvar)
         end
         self.SpellTargetingStarted = false
      end
   elseif event == 'ADDON_LOADED' then
      SecureHandlerSetFrameRef(self, 'Crosshotbar', addon.Crosshotbar)
      SecureHandlerSetFrameRef(self, 'GamePadButtons', addon.GamePadButtons)
      SecureHandlerSetFrameRef(self, 'GroupNavigator', addon.GroupNavigator)
      
      self.MouseStatusFrame = CreateFrame("Frame")
      self.MouseStatusFrame:SetPoint("CENTER", Crosshotbar, "TOP", 0 , 4)
      self.MouseStatusFrame.backgtex = self.MouseStatusFrame:CreateTexture(nil,"BACKGROUND")
      self.MouseStatusFrame.backgtex:SetAtlas("CircleMaskScalable", true)
      self.MouseStatusFrame.backgtex:SetVertexColor(0,0,0,1)
      self.MouseStatusFrame.backgtex:SetPoint("CENTER")
      self.MouseStatusFrame.backgtex:SetSize(32, 32)
      self.MouseStatusFrame.backgtex:Show()
      self.MouseStatusFrame.mousetex = self.MouseStatusFrame:CreateTexture()
      self.MouseStatusFrame.mousetex:SetAtlas("ClickCast-Icon-Mouse", true)
      self.MouseStatusFrame.mousetex:SetPoint("CENTER")
      self.MouseStatusFrame.mousetex:SetSize(32, 32)
      self.MouseStatusFrame.mousetex:Hide()
      self.MouseStatusFrame.pointtex = self.MouseStatusFrame:CreateTexture()
      self.MouseStatusFrame.pointtex:SetAtlas("Cursor_cast_32", true)
      self.MouseStatusFrame.pointtex:SetPoint("CENTER", 2, -2)
      self.MouseStatusFrame.pointtex:SetSize(24, 24)
      self.MouseStatusFrame.pointtex:SetAlpha(0.9)
      self.MouseStatusFrame.pointtex:Hide()
      self.MouseStatusFrame:SetSize(32, 32)
      self.MouseStatusFrame:Hide()
      SecureHandlerSetFrameRef(self, "MouseStatusFrame", self.MouseStatusFrame)

      self.MouseLookState = IsMouselooking();
      
      self.MouseOnUpdateFrame = CreateFrame("Frame", ADDON .. "OnUpdateFrame")
      
      function self.MouseOnUpdateFrame:onUpdate(...)
         if addon.GamePadButtons.MouseLookEnabled then
            if addon.GamePadButtons.MouseLookState then
               if IsMouselooking() ~= addon.GamePadButtons.MouseLookState then
                  addon.GamePadButtons:SetMouseLook(addon.GamePadButtons.MouseLookState)
               end
            end
         end
      end

      self.MouseOnUpdateFrame:SetScript("OnUpdate", self.MouseOnUpdateFrame.onUpdate)
      self.MouseOnUpdateFrame:Hide()
      
      local mouselookhandlerstate = false
      local gamepadlookhandlerstate = false
      local mousehandlerstart = function(self)
         if addon.GamePadButtons.MouseLookEnabled then
            if IsMouselooking() then
               addon.GamePadButtons:SetMouseLook(false)
               mouselookhandlerstate = true
            end
         end
         if addon.GamePadButtons.GamePadLookEnabled then
            addon.GamePadButtons:SetGamePadMouse(true)
            gamepadlookhandlerstate = true
         end
      end
      local mousehandlerstop = function(self)
         if addon.GamePadButtons.MouseLookEnabled then
            if mouselookhandlerstate then
               addon.GamePadButtons:SetMouseLook(true)
               mouselookhandlerstate = false
            end
         end
         if addon.GamePadButtons.GamePadLookEnabled then
            if gamepadlookhandlerstate then
               addon.GamePadButtons:SetGamePadMouse(false)
               gamepadlookhandlerstate = false
            end
         end
      end

      local cinemarichandler = function(self, button)
         CinematicFrameCloseDialogResumeButton:SetText(('%s %s'):format(GetBindingText('PAD2', 'KEY_ABBR'), NO))
         CinematicFrameCloseDialogConfirmButton:SetText(('%s %s'):format(GetBindingText('PAD1', 'KEY_ABBR'), YES))
         if self.closeDialog then
            if self.closeDialog:IsShown() then
               if button == config.PadActions.FACER.BIND then CinematicFrameCloseDialogResumeButton:Click() end
               if button == config.PadActions.FACED.BIND then CinematicFrameCloseDialogConfirmButton:Click() end
            else
               self.closeDialog:Show()
            end
         end
      end
      
      if addon.GamePadButtons.MouseLookEnabled or
         addon.GamePadButtons.GamePadLookEnabled then
         CinematicFrameCloseDialog:HookScript("OnShow", mousehandlerstart)
         CinematicFrameCloseDialog:HookScript("OnHide", mousehandlerstop)
      end
      
      if addon.GamePadButtons.GamePadEnabled then
         CinematicFrame:HookScript('OnGamePadButtonDown', cinemarichandler)
         CinematicFrame:HookScript('OnKeyDown', cinemarichandler)
      end
      
      local moviehandler = function(self, button)
         MovieFrame.CloseDialog.ResumeButton:SetText(('%s %s'):format(GetBindingText('PAD2', '_ABBR'), NO))
         MovieFrame.CloseDialog.ConfirmButton:SetText(('%s %s'):format(GetBindingText('PAD1', '_ABBR'), YES))
         if self.CloseDialog then
            if self.CloseDialog:IsShown() then
               if button == config.PadActions.FACER.BIND then self.CloseDialog.ResumeButton:Click() end
               if button == config.PadActions.FACED.BIND then self.CloseDialog.ConfirmButton:Click() end
            else
               self.CloseDialog:Show()
            end
         end
      end
      
      if addon.GamePadButtons.MouseLookEnabled or
         addon.GamePadButtons.GamePadLookEnabled then
         MovieFrame.CloseDialog:HookScript("OnShow", mousehandlerstart)
         MovieFrame.CloseDialog:HookScript("OnHide", mousehandlerstop)
      end
      
      if addon.GamePadButtons.GamePadEnabled then
         MovieFrame:HookScript('OnGamePadButtonDown', moviehandler)
         MovieFrame:HookScript('OnKeyDown', moviehandler)
      end

      if addon.GamePadButtons.GamePadEnabled then
         hooksecurefunc('SetGamePadCursorControl',  GenerateClosure(self.SetGamePadCursorControl, self))
      end
      
      self:UnregisterEvent("ADDON_LOADED")
   end
end

function GamePadButtonsMixin:SetupGamePad()
   self.EnableSounds = false
   self.MouseLookEnabled = config.GamePad.MouseLook
   self.GamePadLookEnabled = config.GamePad.GamePadLook
   self.GamePadEnabled = config.GamePad.CVSetup

   if self.GamePadEnabled then
      if self.MouseLookEnabled then
         SetCVar("cameraYawMoveSpeed", 40)
         SetCVar("cameraPitchMoveSpeed", 20)
         SetCVar("enableMouseSpeed", 0)
      end

      SetCVar('GamePadEnable', config.GamePad.GPEnable)
      SetCVar('GamePadEmulateShift', config.GamePad.GPShift)
      SetCVar('GamePadEmulateCtrl', config.GamePad.GPCtrl)
      SetCVar('GamePadEmulateAlt', config.GamePad.GPAlt)
      SetCVar('GamePadCursorLeftClick', config.GamePad.GPLeftClick)
      SetCVar('GamePadCursorRightClick', config.GamePad.GPRightClick)
      SetCVar('GamePadCursorForTargeting', config.GamePad.GPTargetCursor)
      SetCVar('GamePadCursorAutoEnable', config.GamePad.GPAutoCursor)
      SetCVar('GamePadCursorAutoDisableSticks', config.GamePad.GPAutoSticks)
      SetCVar('GamePadCursorAutoDisableJump', config.GamePad.GPAutoJump)
      SetCVar('GamePadCursorCentering', config.GamePad.GPCenterCursor)
      SetCVar('GamePadCursorCenteredEmulation', config.GamePad.GPCenterEmu)
      SetCVar('GamePadCameraYawSpeed', config.GamePad.GPYawSpeed)
      SetCVar('GamePadCameraPitchSpeed', config.GamePad.GPPitchSpeed)
      SetCVar('GamePadOverlapMouseMs', config.GamePad.GPOverlapMouse)
      SetCVar('GamePadSingleActiveID', config.GamePad.GPDeviceID)

   end

   self.GamePadLeftClick = GetCVar('GamePadCursorLeftClick')
   self.GamePadRightClick = GetCVar('GamePadCursorRightClick')
   self.GamePadAutoDisableSticks = GetCVar('GamePadCursorAutoDisableSticks')
   self.GamePadAutoDisableJump = GetCVar('GamePadCursorAutoDisableJump')
   self.GamePadAutoEnable = GetCVar('GamePadCursorAutoEnable')

   if self.MouseLookEnabled then      
      self.MouseLookState = IsMouselooking();
      self.MouseOnUpdateFrame:Show()
   end
   
   if self.GamePadLookEnabled then
      self:SetGamePadMouse(self.GamePadMouseMode)
   end
   self.EnableSounds = true
end

function GamePadButtonsMixin:ClearConfig()
   for button, attributes in pairs(config.PadActions) do
      self:SetAttribute(button, "")
   end

   ClearOverrideBindings(self)
   
   ClearOverrideBindings(self.LeftTriggerButton);
   ClearOverrideBindings(self.RightTriggerButton);
   ClearOverrideBindings(self.LeftShoulderButton);
   ClearOverrideBindings(self.RightShoulderButton);
   ClearOverrideBindings(self.LeftPaddleButton);
   ClearOverrideBindings(self.RightPaddleButton);

   for i,button in ipairs(GamePadButtonList) do
      if self[button.."Button"] ~= nil then
         ClearOverrideBindings(self[button.."Button"])
         self[button.."Button"]:SetAttribute("BINDING", "")
         self[button.."Button"]:SetAttribute("ACTION", "")
         self[button.."Button"]:SetAttribute("TRIGBINDING", "")
         self[button.."Button"]:SetAttribute("TRIGACTION", "")
         
         for i,modifier in ipairs(GamePadModifierList) do
            self[button.."Button"]:SetAttribute(modifier .. "BINDING", "")
            self[button.."Button"]:SetAttribute(modifier .. "ACTION", "")
            self[button.."Button"]:SetAttribute(modifier .. "TRIGBINDING", "")
            self[button.."Button"]:SetAttribute(modifier .. "TRIGACTION", "")
         end
      end
   end
end

function GamePadButtonsMixin:ApplyConfig()
   self:SetupGamePad()
   self:ClearConfig()
   for button, attributes in pairs(config.PadActions) do
      if button == "FACED" then
         self.SpellTargetConfirmButton = attributes.BIND
      end
      if button == "FACER" then
         self.SpellTargetCancelButton = attributes.BIND
      end
      if ActionList[attributes.ACTION] then
         SetOverrideBinding(self, true, attributes.BIND, attributes.ACTION)
      elseif ModifierList[attributes.ACTION] then
         if attributes.ACTION == "LEFTHOTBAR" then
            SetOverrideBindingClick(self.LeftTriggerButton, true, attributes.BIND,
                                    self.LeftTriggerButton:GetName(), "LeftButton")            
         end
         if attributes.ACTION == "RIGHTHOTBAR" then
            SetOverrideBindingClick(self.RightTriggerButton, true, attributes.BIND,
                                    self.RightTriggerButton:GetName(), "LeftButton")
         end
         if attributes.ACTION == "LEFTSHOULDER" then
            SetOverrideBindingClick(self.LeftShoulderButton, true, attributes.BIND,
                                    self.LeftShoulderButton:GetName(), "LeftButton")
         end
         if attributes.ACTION == "RIGHTSHOULDER" then
            SetOverrideBindingClick(self.RightShoulderButton, true, attributes.BIND,
                                    self.RightShoulderButton:GetName(), "LeftButton")
         end
         if attributes.ACTION == "LEFTPADDLE" then
            SetOverrideBindingClick(self.LeftPaddleButton, true, attributes.BIND,
                                    self.LeftPaddleButton:GetName(), "LeftButton")
         end
         if attributes.ACTION == "RIGHTPADDLE" then
            SetOverrideBindingClick(self.RightPaddleButton, true, attributes.BIND,
                                    self.RightPaddleButton:GetName(), "LeftButton")
         end
         
      elseif ModifierActions[ attributes["ACTION"] ] then
         if self[button.."Button"] ~= nil then
            self[button.."Button"]:SetAttribute("BINDING", attributes.BIND)
            self[button.."Button"]:SetAttribute("ACTION", ModifierActions[ attributes["ACTION" ] ])
         end
      end

      for i,modifier in ipairs(GamePadModifierList) do
         if ModifierActions[ attributes[modifier .. "ACTION"] ] then
            if self[button.."Button"] ~= nil then
               self[button.."Button"]:SetAttribute(modifier .. "BINDING", attributes.BIND)
               self[button.."Button"]:SetAttribute(modifier .. "ACTION", ModifierActions[ attributes[modifier .. "ACTION" ] ])
            end
         end
         if ModifierActions[ attributes[modifier .. "TRIGACTION"] ] then
            if self[button.."Button"] ~= nil then
               self[button.."Button"]:SetAttribute(modifier .. "TRIGBINDING", attributes.BIND)
               self[button.."Button"]:SetAttribute(modifier .. "TRIGACTION", ModifierActions[ attributes[modifier .. "TRIGACTION"] ])
            end
         end
      end
      
      if ModifierActions[attributes.TRIGACTION] then
         if self[button.."Button"] ~= nil then
            self[button.."Button"]:SetAttribute("TRIGBINDING", attributes.BIND)
            self[button.."Button"]:SetAttribute("TRIGACTION", ModifierActions[attributes.TRIGACTION])
         end
      end
      self:SetAttribute(button, attributes.BIND)
   end

   if DCLKList[config.Hotbar.DCLKType] ~= nil  then
      self:SetAttribute("wxhbdclk", DCLKList[config.Hotbar.DCLKType])
   end
   
   self:Execute([[
         local triggerstate = self:GetAttribute("triggerstate")
         self:SetAttribute("state-trigger", triggerstate)
   ]])

end

local CreateGamePadButtons = function(parent)
   local GamePadButtons = CreateFrame("Frame", ADDON .. "GamePadButtonsFrame",
                                      parent, "SecureHandlerStateTemplate" )
   Mixin(GamePadButtons, GamePadButtonsMixin)
   GamePadButtons:SetFrameStrata("BACKGROUND")
   GamePadButtons:SetPoint("TOP", parent:GetName(), "LEFT", 0, 0)
   GamePadButtons:HookScript("OnEvent", GamePadButtons.OnEvent)
   GamePadButtons:Hide()
   GamePadButtons:OnLoad()
   addon.GamePadButtons = GamePadButtons
end

addon.CreateGamePadButtons = CreateGamePadButtons
