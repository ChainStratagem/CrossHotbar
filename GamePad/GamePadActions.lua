local ADDON, addon = ...
local config = addon.Config

local Actions = {
   {"JUMP", true},
   {"INTERACTTARGET", true},
   {"TOGGLEWORLDMAP", true},
   {"TOGGLEGAMEMENU", true},
   {"OPENALLBAGS", true},
   {"NAMEPLATES", true},
   {"FRIENDNAMEPLATES", true},
   {"ALLNAMEPLATES", true}
}
addon:ActionListAdd("GamePadActions", "CATEGORY_ACTIONS", Actions, "NONE")

local Modifiers = {
   {"LEFTSHOULDER", true},
   {"RIGHTSHOULDER", true},
   {"LEFTHOTBAR", true},
   {"RIGHTHOTBAR", true},
   {"LEFTPADDLE", true},
   {"RIGHTPADDLE", true}
}
addon:ActionListAdd("GamePadModifiers", "CATEGORY_MODIFIERS", Modifiers, "NONE")

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
        local GamePad = self:GetFrameRef('GamePad')
        if GamePad then
           GamePad:CallMethod("ToggleSheath")
        end
      end
   ]]}
}

addon:ActionListAdd("GamePadActions", "CATEGORY_ACTIONS", ModifierActions, "NONE")
addon:ActionListAdd("GamePadModifierActions", "CATEGORY_ACTIONS", ModifierActions, "NONE")
addon:ActionListAdd("GamePadModifiers", "CATEGORY_ACTIONS", ModifierActions, "NONE")

local ExpandedModifierActions = {
   {"HOLDEXPANDED", [[local down = ...
      local GamePad = self:GetFrameRef('GamePad')
      if GamePad ~= nil then
         local expanded = 0
         if down == true then expanded = 3 end
         local triggerstate = GamePad:GetAttribute("triggerstate")
         local expandedstate = GamePad:GetAttribute("expandedstate")
         if expandedstate == 0 or expandedstate == 3 then
            if triggerstate == 4 then
               GamePad:SetAttribute("state-expanded", expanded)
            else
               GamePad:SetAttribute("state-trigger", 4)
               GamePad:SetAttribute("state-expanded", expanded)
               GamePad:SetAttribute("state-trigger", triggerstate)
            end
         end
      end
   ]]},
   {"LEFTEXPANDED", [[local down = ...
      local GamePad = self:GetFrameRef('GamePad')
      if GamePad ~= nil then
         local expanded = 0
         local triggerstate = GamePad:GetAttribute("triggerstate")
         local expandedstate = GamePad:GetAttribute("expandedstate")
         if expandedstate == 0 or expandedstate == 3 or expandedstate == 4 then
            if triggerstate == 4 or expandedstate == 4 then
               if down then
                  GamePad:SetAttribute("state-trigger", 4)
                  GamePad:SetAttribute("state-expanded", 4)
                  GamePad:SetAttribute("state-trigger", 6)
               else
                  GamePad:SetAttribute("state-expanded", 0)
                  GamePad:SetAttribute("state-trigger", 4)
               end
            else
               if down == true then expanded = 3 end
               if (triggerstate == 6 or triggerstate == 3 or triggerstate == 2) then
                  GamePad:SetAttribute("state-trigger", 4)
                  GamePad:SetAttribute("state-expanded", expanded)
                  GamePad:SetAttribute("state-trigger", triggerstate)
               end
            end
         end
      end
   ]]},
   {"RIGHTEXPANDED", [[local down = ...
      local GamePad = self:GetFrameRef('GamePad')
      if GamePad ~= nil then
         local expanded = 0
         local triggerstate = GamePad:GetAttribute("triggerstate")
         local expandedstate = GamePad:GetAttribute("expandedstate")
         if expandedstate == 0 or expandedstate == 3 or expandedstate == 5 then
            if triggerstate == 4 or expandedstate == 5 then
               if down then
                  GamePad:SetAttribute("state-trigger", 4)
                  GamePad:SetAttribute("state-expanded", 5)
                  GamePad:SetAttribute("state-trigger", 7)
               else
                  GamePad:SetAttribute("state-expanded", 0)
                  GamePad:SetAttribute("state-trigger", 4)
               end
            else
               if down == true then expanded = 3 end
               if (triggerstate == 7 or triggerstate == 5 or triggerstate == 1) then
                  GamePad:SetAttribute("state-trigger", 4)
                  GamePad:SetAttribute("state-expanded", expanded)
                  GamePad:SetAttribute("state-trigger", triggerstate)
               end
            end
         end
      end
   ]]}
}

addon:ActionListAdd("GamePadActions", "CATEGORY_HOTBAR_EXPANDED", ExpandedModifierActions, "NONE")
addon:ActionListAdd("GamePadModifierActions", "CATEGORY_HOTBAR_EXPANDED", {{"HOLDEXPANDED",true}}, "NONE")
addon:ActionListAdd("GamePadModifiers", "CATEGORY_HOTBAR_EXPANDED", ExpandedModifierActions, "NONE")

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

local CameraModifierActions = {
   {"ZOOMIN", [[local down = ...
      local GamePad = self:GetFrameRef('GamePad')
      if GamePad then
         GamePad:CallMethod("ZoomIn", down)
      end
   ]]},
   {"ZOOMOUT", [[local down = ...
      local GamePad = self:GetFrameRef('GamePad')
      if GamePad then
         GamePad:CallMethod("ZoomOut", down)
      end
   ]]},
   {"CAMERALOOKON", [[local down = ...
      if down then
        local GamePad = self:GetFrameRef('GamePad')
        if GamePad then
           GamePad:CallMethod("SetCameraLook", false)
        end
      end
   ]]},
   {"CAMERALOOKOFF", [[local down = ...
      if down then
        local GamePad = self:GetFrameRef('GamePad')
        if GamePad then
           GamePad:CallMethod("SetCameraLook", true)
        end
      end
   ]]},
   {"CAMERALOOKTOGGLE", [[local down = ...
      if down then
         local GamePad = self:GetFrameRef('GamePad')
         if GamePad then
            GamePad:CallMethod("ToggleCameraLook")
         end
      end
   ]]},
   {"CAMERALOOKHOLD", [[local down = ...
      local GamePad = self:GetFrameRef('GamePad')
      if GamePad then
         GamePad:CallMethod("HoldCameraLook", down)
      end
   ]]},
   {"GAMEPADMOUSE", [[ local down = ...
      if down then
        local GamePad = self:GetFrameRef('GamePad')
        if GamePad then
           GamePad:CallMethod("SetGamePadMouse", nil)
        end
      end
   ]]}
}

addon:ActionListAdd("GamePadActions", "CATEGORY_CAMERA", CameraModifierActions, "NONE")
addon:ActionListAdd("GamePadModifierActions", "CATEGORY_CAMERA", CameraModifierActions, "NONE")
addon:ActionListAdd("GamePadModifiers", "CATEGORY_CAMERA", CameraModifierActions, "NONE")

local PageModifierActions = {
   {"NEXTPAGE", [[local down = ...
      if down then
         local GamePad = self:GetFrameRef('GamePad')
         if GamePad then
            GamePad:CallMethod("GPPlaySound", 1115)
         end
         local Crosshotbar = self:GetFrameRef('Crosshotbar')
         local newset = abs(Crosshotbar:GetAttribute("activeset") + 1)%6
         if newset == 0 then newset = 6 end
         Crosshotbar:SetAttribute("state-page", newset)
      end
   ]]},
   {"PREVPAGE", [[local down = ...
      if down then
         local GamePad = self:GetFrameRef('GamePad')
         if GamePad then
            GamePad:CallMethod("GPPlaySound", 1115)
         end
         local Crosshotbar = self:GetFrameRef('Crosshotbar')
         local newset = abs(Crosshotbar:GetAttribute("activeset") + 5)%6
         if newset == 0 then newset = 6 end
         Crosshotbar:SetAttribute("state-page", newset)
      end
   ]]},
   {"PAGEONE", [[local down = ...
      if down then
         local GamePad = self:GetFrameRef('GamePad')
         if GamePad then
            GamePad:CallMethod("GPPlaySound", 1115)
         end
         local Crosshotbar = self:GetFrameRef('Crosshotbar')
         local newset = 1
         Crosshotbar:SetAttribute("state-page", newset)
      end
   ]]},
   {"PAGETWO", [[local down = ...
      if down then
         local GamePad = self:GetFrameRef('GamePad')
         if GamePad then
            GamePad:CallMethod("GPPlaySound", 1115)
         end
         local Crosshotbar = self:GetFrameRef('Crosshotbar')
         local newset = 2
         Crosshotbar:SetAttribute("state-page", newset)
      end
   ]]},
   {"PAGETHREE", [[local down = ...
      if down then
         local GamePad = self:GetFrameRef('GamePad')
         if GamePad then
            GamePad:CallMethod("GPPlaySound", 1115)
         end
         local Crosshotbar = self:GetFrameRef('Crosshotbar')
         local newset = 3
         Crosshotbar:SetAttribute("state-page", newset)
      end
   ]]},
   {"PAGEFOUR", [[local down = ...
      if down then
         local GamePad = self:GetFrameRef('GamePad')
         if GamePad then
            GamePad:CallMethod("GPPlaySound", 1115)
         end
         local Crosshotbar = self:GetFrameRef('Crosshotbar')
         local newset = 4
         Crosshotbar:SetAttribute("state-page", newset)
      end
   ]]},
   {"PAGEFIVE", [[local down = ...
      if down then
         local GamePad = self:GetFrameRef('GamePad')
         if GamePad then
            GamePad:CallMethod("GPPlaySound", 1115)
         end
         local Crosshotbar = self:GetFrameRef('Crosshotbar')
         local newset = 5
         Crosshotbar:SetAttribute("state-page", newset)
      end
   ]]},
   {"PAGESIX", [[local down = ...
      if down then
         local GamePad = self:GetFrameRef('GamePad')
         if GamePad then
            GamePad:CallMethod("GPPlaySound", 1115)
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

addon.GamePadActionsMixin = {
   Actions = nil,
   Modifiers = nil,
   ModifierActions = nil,
   EnableSounds = false
}

local GamePadActionsMixin = addon.GamePadActionsMixin

function GamePadActionsMixin:GPPlaySound(soundid)
   if self.EnableSounds then
      PlaySound(soundid)
   end
end

function GamePadActionsMixin:ToggleSheath()
   ToggleSheath()
end

function GamePadActionsMixin:ZoomIn(down)
   if down then
      MoveViewInStart(1.0, 0, true);
   else
      CameraZoomIn(1.0)
   end
end

function GamePadActionsMixin:ZoomOut(down)
   if down then
      MoveViewOutStart(1.0, 0, true);
   else
      CameraZoomOut(1.0)
   end
end

GamePadActionsMixin.Actions = addon:ActionListToTable(Actions)
GamePadActionsMixin.Modifiers = addon:ActionListToTable(Modifiers)
GamePadActionsMixin.ModifierActions = addon:ActionListToTable(ModifierActions)
for key, value in pairs(addon:ActionListToTable(ExpandedModifierActions)) do GamePadActionsMixin.ModifierActions[key] = value  end
for key, value in pairs(addon:ActionListToTable(MacroModifierActions)) do GamePadActionsMixin.ModifierActions[key] = value  end
for key, value in pairs(addon:ActionListToTable(TargetModifierActions)) do GamePadActionsMixin.ModifierActions[key] = value  end
for key, value in pairs(addon:ActionListToTable(CameraModifierActions)) do GamePadActionsMixin.ModifierActions[key] = value  end
for key, value in pairs(addon:ActionListToTable(PageModifierActions)) do GamePadActionsMixin.ModifierActions[key] = value  end

