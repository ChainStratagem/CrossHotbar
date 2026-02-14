local ADDON, addon = ...
local config = addon.Config

addon.GamePadLookMixin = {
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
   SpellTargetingUpdate = false
}

local GamePadLookMixin = addon.GamePadLookMixin

function GamePadLookMixin:SetMouseLook(enable)
   self.MouseLookState = enable
   if enable then
      MouselookStart()
   else
      MouselookStop()
   end
end
   
function GamePadLookMixin:CanAutoSetGamePadCursorControl(enable)
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

function GamePadLookMixin:SetGamePadCursorControl(enable)
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

function GamePadLookMixin:ToggleCameraLook()
   self:HoldCameraLook(not self.GamePadLookHold)
end

function GamePadLookMixin:HoldCameraLook(isheld)
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

function GamePadLookMixin:SetCameraLook(enable)
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

function GamePadLookMixin:SetGamePadMouse(enable)
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

function GamePadLookMixin:OnSpellTarget()
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
end

function GamePadLookMixin:CreateLookStatusFrame()
   self.MouseStatusFrame = CreateFrame("Frame")
   self.MouseStatusFrame:SetPoint("CENTER", Crosshotbar, "TOP", 0 , 4)
   self.MouseStatusFrame.backgtex = self.MouseStatusFrame:CreateTexture(nil,"BACKGROUND")
   self.MouseStatusFrame.backgtex:SetAtlas("CircleMaskScalable", true)
   self.MouseStatusFrame.backgtex:SetVertexColor(0,0,0,1)
   self.MouseStatusFrame.backgtex:SetPoint("CENTER")
   self.MouseStatusFrame.backgtex:SetSize(20, 20)
   self.MouseStatusFrame.backgtex:Show()
   self.MouseStatusFrame.mousetex = self.MouseStatusFrame:CreateTexture()
   self.MouseStatusFrame.mousetex:SetAtlas("ClickCast-Icon-Mouse", true)
   self.MouseStatusFrame.mousetex:SetPoint("CENTER")
   self.MouseStatusFrame.mousetex:SetSize(20, 20)
   self.MouseStatusFrame.mousetex:Hide()
   self.MouseStatusFrame.pointtex = self.MouseStatusFrame:CreateTexture()
   self.MouseStatusFrame.pointtex:SetAtlas("Cursor_cast_32", true)
   self.MouseStatusFrame.pointtex:SetPoint("CENTER", 2, -2)
   self.MouseStatusFrame.pointtex:SetSize(14, 14)
   self.MouseStatusFrame.pointtex:SetAlpha(0.9)
   self.MouseStatusFrame.pointtex:Hide()
   self.MouseStatusFrame:SetSize(20, 20)
   self.MouseStatusFrame:Hide()
   SecureHandlerSetFrameRef(self, "MouseStatusFrame", self.MouseStatusFrame)
end

function GamePadLookMixin:CreateLookUpdateHooks()
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

   if addon.GamePad.GamePadEnabled then
      hooksecurefunc('SetGamePadCursorControl',  GenerateClosure(self.SetGamePadCursorControl, self))
   end
end

function GamePadLookMixin:AddMovieLookHandlers()
   local mouselookhandlerstate = false
   local gamepadlookhandlerstate = false

   local createmousehandler = function(start)
      return function(frame)
         if addon.GamePad.MouseLookEnabled then
            if IsMouselooking() then
               addon.GamePad:SetMouseLook(not start)
               mouselookhandlerstate = start
            end
         end
         if addon.GamePad.GamePadLookEnabled then
            addon.GamePad:SetGamePadMouse(start)
            gamepadlookhandlerstate = start
         end
      end
   end
   
   local mousehandlerstart = createmousehandler(true)
   local mousehandlerstop = createmousehandler(false)

   if addon.GamePad.MouseLookEnabled or
      addon.GamePad.GamePadLookEnabled then
      CinematicFrameCloseDialog:HookScript("OnShow", mousehandlerstart)
      CinematicFrameCloseDialog:HookScript("OnHide", mousehandlerstop)
   end

   if addon.GamePad.MouseLookEnabled or
      addon.GamePad.GamePadLookEnabled then
      MovieFrame.CloseDialog:HookScript("OnShow", mousehandlerstart)
      MovieFrame.CloseDialog:HookScript("OnHide", mousehandlerstop)
   end
end
