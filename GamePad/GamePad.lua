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

addon.GamePadMixin = {
   -- GamePadActionsMixin
   Actions = nil,
   Modifiers = nil,
   ModifierActions = nil,
   EnableSounds = false,
   -- GamePadLookMixin
   MouseLookEnabled = true,
   GamePadLookEnabled = true,
   GamePadLookHold = false,   
   GamePadMouseMode = false,
   GamePadCursorEnabled = false,
   MouseLookState = false,
   MouseStatusFrame = nil,
   GamePadLeftClickCache = "PADLTRIGGER",
   GamePadRightClickCache = "PADRTRIGGER",
   SpellTargetConfirmButton = "PAD1",
   SpellTargetCancelButton = "PAD3",
   SpellTargetingStarted = false,
   SpellTargetingUpdate = false,
   -- GamePadButtonsMixin
   LeftTriggerButton = nil,
   RightTriggerButton = nil,
   LeftShoulderButton = nil,
   RightShoulderButton = nil,
   LeftPaddleButton = nil,
   RightPaddleButton = nil,
   -- GamePadMixin
   GamePadEnabled = true,
   GamePadLeftClick = "PADLTRIGGER",
   GamePadRightClick = "PADRTRIGGER",
   GamePadAutoDisableSticks = 0,
   GamePadAutoDisableJump = 0,
   GamePadAutoEnable = 0
}

local GamePadMixin = addon.GamePadMixin

function GamePadMixin:OnLoad()
   self:SetAttribute("modname", "")
   self:SetAttribute("modtype", "")
   self:SetAttribute("wxhbdclk", 0)

   self:RegisterEvent("PLAYER_ENTERING_WORLD")
   self:RegisterEvent("CURSOR_CHANGED")
   self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED")

   self:SetupGamePad()
   
   addon:AddApplyCallback(GenerateClosure(self.ApplyConfig, self))
end

function GamePadMixin:SetupGamePad()
   SecureHandlerSetFrameRef(self, 'GamePad', addon.GamePad)
   SecureHandlerSetFrameRef(self, 'Crosshotbar', addon.Crosshotbar)
   SecureHandlerSetFrameRef(self, 'GroupNavigator', addon.GroupNavigator)

   self:AddStateHandlers()
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
   
   self:CreateLookStatusFrame()
   self:CreateLookUpdateHooks()
   self:AddMovieLookHandlers()
   self:AddMovieButtonHandlers()
end

function GamePadMixin:OnEvent(event, ...)
   -- print(event)
   if event == 'PLAYER_ENTERING_WORLD' then
      --[[
      local isInitialLogin, isReloadingUi = ...
      if isInitialLogin or isReloadingUi then
      end
      --]]
   elseif event == 'CURSOR_CHANGED' then
   elseif event == 'CURRENT_SPELL_CAST_CHANGED' then
      self:OnSpellTarget()
   end
end

function GamePadMixin:ApplyConfig()
   self:ConfigGamePad()
   self:ClearActions()
   self:ConfigActions()
end

function GamePadMixin:ConfigGamePad()
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

function GamePadMixin:ClearActions()
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

function GamePadMixin:ConfigActions()
   for button, attributes in pairs(config.PadActions) do
      if button == "FACED" then
         self.SpellTargetConfirmButton = attributes.BIND
      end
      if button == "FACER" then
         self.SpellTargetCancelButton = attributes.BIND
      end
      if self.Actions[attributes.ACTION] then
         SetOverrideBinding(self, true, attributes.BIND, attributes.ACTION)
      elseif self.Modifiers[attributes.ACTION] then
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
         
      elseif self.ModifierActions[ attributes["ACTION"] ] then
         if self[button.."Button"] ~= nil then
            self[button.."Button"]:SetAttribute("BINDING", attributes.BIND)
            self[button.."Button"]:SetAttribute("ACTION", self.ModifierActions[ attributes["ACTION" ] ])
         end
      end

      for i,modifier in ipairs(GamePadModifierList) do
         if self.ModifierActions[ attributes[modifier .. "ACTION"] ] then
            if self[button.."Button"] ~= nil then
               self[button.."Button"]:SetAttribute(modifier .. "BINDING", attributes.BIND)
               self[button.."Button"]:SetAttribute(modifier .. "ACTION", self.ModifierActions[ attributes[modifier .. "ACTION" ] ])
            end
         end
         if self.ModifierActions[ attributes[modifier .. "TRIGACTION"] ] then
            if self[button.."Button"] ~= nil then
               self[button.."Button"]:SetAttribute(modifier .. "TRIGBINDING", attributes.BIND)
               self[button.."Button"]:SetAttribute(modifier .. "TRIGACTION", self.ModifierActions[ attributes[modifier .. "TRIGACTION"] ])
            end
         end
      end
      
      if self.ModifierActions[attributes.TRIGACTION] then
         if self[button.."Button"] ~= nil then
            self[button.."Button"]:SetAttribute("TRIGBINDING", attributes.BIND)
            self[button.."Button"]:SetAttribute("TRIGACTION", self.ModifierActions[attributes.TRIGACTION])
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

function GamePadMixin:AddMovieButtonHandlers()
   local cinematichandler = function(frame, button)
      if not InCombatLockdown() then 
         CinematicFrameCloseDialogResumeButton:SetText(('%s %s'):format(GetBindingText('PAD2', 'KEY_ABBR'), NO))
         CinematicFrameCloseDialogConfirmButton:SetText(('%s %s'):format(GetBindingText('PAD1', 'KEY_ABBR'), YES))
         if frame.closeDialog then
            if frame.closeDialog:IsShown() then
               if button == config.PadActions.FACER.BIND then CinematicFrameCloseDialogResumeButton:Click() end
               if button == config.PadActions.FACED.BIND then CinematicFrameCloseDialogConfirmButton:Click() end
            else
               frame.closeDialog:Show()
            end
         end
      end
   end
   
   if addon.GamePad.GamePadEnabled then
      CinematicFrame:HookScript('OnGamePadButtonDown', cinematichandler)
      CinematicFrame:HookScript('OnKeyDown', cinematichandler)
   end
   
   local moviehandler = function(frame, button)
      if not InCombatLockdown() then 
         MovieFrame.CloseDialog.ResumeButton:SetText(('%s %s'):format(GetBindingText('PAD2', '_ABBR'), NO))
         MovieFrame.CloseDialog.ConfirmButton:SetText(('%s %s'):format(GetBindingText('PAD1', '_ABBR'), YES))
         if frame.CloseDialog then
            if frame.CloseDialog:IsShown() then
               if button == config.PadActions.FACER.BIND then frame.CloseDialog.ResumeButton:Click() end
               if button == config.PadActions.FACED.BIND then frame.CloseDialog.ConfirmButton:Click() end
            else
               frame.CloseDialog:Show()
            end
         end
      end
   end
   
   if addon.GamePad.GamePadEnabled then
      MovieFrame:HookScript('OnGamePadButtonDown', moviehandler)
      MovieFrame:HookScript('OnKeyDown', moviehandler)
   end
end

local InitGamePad = function()
   local parent = addon.parentFrame
   local GamePad = CreateFrame("Frame", ADDON .. "GamePadFrame",
                                      parent, "SecureHandlerStateTemplate" )
   Mixin(GamePad, addon.GamePadMixin, addon.GamePadButtonsMixin, addon.GamePadLookMixin, addon.GamePadActionsMixin)
   addon.GamePad = GamePad
   
   GamePad:SetFrameStrata("BACKGROUND")
   GamePad:SetPoint("TOP", parent:GetName(), "LEFT", 0, 0)
   GamePad:HookScript("OnEvent", GamePad.OnEvent)
   GamePad:Hide()
   GamePad:OnLoad()
end

addon:AddInitCallback(InitGamePad)
