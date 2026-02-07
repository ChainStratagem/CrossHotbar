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

local GamePadMixin = {
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

function GamePadMixin:OnLoad()
   self:SetAttribute("modname", "")
   self:SetAttribute("modtype", "")
   self:SetAttribute("wxhbdclk", 0)

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

   self:RegisterEvent("ADDON_LOADED")
   self:RegisterEvent("PLAYER_ENTERING_WORLD")
   self:RegisterEvent("CURSOR_CHANGED")
   self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED")

   addon:AddApplyCallback(GenerateClosure(self.ApplyConfig, self))
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
   elseif event == 'ADDON_LOADED' then
      SecureHandlerSetFrameRef(self, 'GamePad', addon.GamePad)
      SecureHandlerSetFrameRef(self, 'Crosshotbar', addon.Crosshotbar)
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
         if addon.GamePad.MouseLookEnabled then
            if addon.GamePad.MouseLookState then
               if IsMouselooking() ~= addon.GamePad.MouseLookState then
                  addon.GamePad:SetMouseLook(addon.GamePad.MouseLookState)
               end
            end
         end
      end

      self.MouseOnUpdateFrame:SetScript("OnUpdate", self.MouseOnUpdateFrame.onUpdate)
      self.MouseOnUpdateFrame:Hide()
      
      local mouselookhandlerstate = false
      local gamepadlookhandlerstate = false
      local mousehandlerstart = function(self)
         if addon.GamePad.MouseLookEnabled then
            if IsMouselooking() then
               addon.GamePad:SetMouseLook(false)
               mouselookhandlerstate = true
            end
         end
         if addon.GamePad.GamePadLookEnabled then
            addon.GamePad:SetGamePadMouse(true)
            gamepadlookhandlerstate = true
         end
      end
      local mousehandlerstop = function(self)
         if addon.GamePad.MouseLookEnabled then
            if mouselookhandlerstate then
               addon.GamePad:SetMouseLook(true)
               mouselookhandlerstate = false
            end
         end
         if addon.GamePad.GamePadLookEnabled then
            if gamepadlookhandlerstate then
               addon.GamePad:SetGamePadMouse(false)
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
      
      if addon.GamePad.MouseLookEnabled or
         addon.GamePad.GamePadLookEnabled then
         CinematicFrameCloseDialog:HookScript("OnShow", mousehandlerstart)
         CinematicFrameCloseDialog:HookScript("OnHide", mousehandlerstop)
      end
      
      if addon.GamePad.GamePadEnabled then
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
      
      if addon.GamePad.MouseLookEnabled or
         addon.GamePad.GamePadLookEnabled then
         MovieFrame.CloseDialog:HookScript("OnShow", mousehandlerstart)
         MovieFrame.CloseDialog:HookScript("OnHide", mousehandlerstop)
      end
      
      if addon.GamePad.GamePadEnabled then
         MovieFrame:HookScript('OnGamePadButtonDown', moviehandler)
         MovieFrame:HookScript('OnKeyDown', moviehandler)
      end

      if addon.GamePad.GamePadEnabled then
         hooksecurefunc('SetGamePadCursorControl',  GenerateClosure(self.SetGamePadCursorControl, self))
      end
      
      self:UnregisterEvent("ADDON_LOADED")
   end
end

function GamePadMixin:SetupGamePad()
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

function GamePadMixin:ClearConfig()
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

function GamePadMixin:ApplyConfig()
   self:SetupGamePad()
   self:ClearConfig()
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

addon.GamePadMixin = GamePadMixin

local CreateGamePad = function()
   local parent = addon.parentFrame
   local GamePad = CreateFrame("Frame", ADDON .. "GamePadFrame",
                                      parent, "SecureHandlerStateTemplate" )
   Mixin(GamePad, addon.GamePadMixin, addon.GamePadButtonsMixin, addon.GamePadLookMixin, addon.GamePadActionsMixin)
   GamePad:SetFrameStrata("BACKGROUND")
   GamePad:SetPoint("TOP", parent:GetName(), "LEFT", 0, 0)
   GamePad:HookScript("OnEvent", GamePad.OnEvent)
   GamePad:Hide()
   GamePad:OnLoad()
   addon.GamePad = GamePad
end

addon:AddInitCallback(CreateGamePad)
