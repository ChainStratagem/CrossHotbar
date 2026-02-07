local ADDON, addon = ...

local config = addon.Config
local locale = addon.Locale
local cfgUI  = addon.ConfigUI

local GamePadUI = {}

function GamePadUI:CreateFrame()
   self.GamePadFrame = CreateFrame("Frame", ADDON .. "GamePadSettings", self.ConfigFrame)
   self.GamePadFrame.name = "GamePad"
   self.GamePadFrame.parent = cfgUI.ConfigFrame.name
   self.GamePadFrame:Hide()

   self.GamePadFrame:SetScript("OnShow", function(GamePadFrame)
      local title = GamePadFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
      title:SetPoint("TOPLEFT", cfgUI.Inset, -cfgUI.Inset)
      title:SetText("GamePad Settings")
      
      local anchor = title
      anchor = self:CreateGamePadSettings(GamePadFrame, anchor)
      
      GamePadFrame:SetScript("OnShow", function(frame) cfgUI:Refresh() end) 
      cfgUI:Refresh()
   end)      

   Settings.RegisterCanvasLayoutSubcategory(cfgUI.category,
                                            self.GamePadFrame,
                                            self.GamePadFrame.name)
end

function GamePadUI:CreateGamePadSettings(configFrame, anchorFrame)
   local OptionWidth = configFrame:GetWidth()/4 - 2*cfgUI.Inset
   local controlsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
   controlsubtitle:SetHeight(cfgUI.ButtonHeight)
   controlsubtitle:SetWidth(OptionWidth)
   controlsubtitle:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -cfgUI.ConfigSpacing)
   controlsubtitle:SetNonSpaceWrap(true)
   controlsubtitle:SetJustifyH("Left")
   controlsubtitle:SetJustifyV("TOP")
   controlsubtitle:SetText("Controls")

   --[[
      GamePadEnable
   --]]
   
   local gamepadenablesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   gamepadenablesubtitle:SetHeight(cfgUI.ButtonHeight)
   gamepadenablesubtitle:SetWidth(OptionWidth)
   gamepadenablesubtitle:SetPoint("TOPLEFT", controlsubtitle, "BOTTOMLEFT", cfgUI.Inset, -cfgUI.ConfigSpacing)
   gamepadenablesubtitle:SetNonSpaceWrap(true)
   gamepadenablesubtitle:SetJustifyH("CENTER")
   gamepadenablesubtitle:SetJustifyV("TOP")
   gamepadenablesubtitle:SetText("GamePadEnable")
   
   local gamepadenablebutton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
   gamepadenablebutton:SetPoint("TOPLEFT", gamepadenablesubtitle, "BOTTOMLEFT", 0, 0)
   gamepadenablebutton:SetHeight(cfgUI.ButtonHeight)
   gamepadenablebutton:SetWidth(OptionWidth)

   if config.GamePad.GPEnable ~= 0 then
      gamepadenablebutton:SetText("Enable")
   else
      gamepadenablebutton:SetText("Disable")
   end
   
   gamepadenablebutton:SetScript("OnClick", function(self, button, down)
      if config.GamePad.GPEnable == 1 then
         config.GamePad.GPEnable = 0
      else
         config.GamePad.GPEnable = 1
      end
      cfgUI:Refresh(true)
   end)

   cfgUI:AddToolTip(gamepadenablesubtitle, locale.enabeGamePadToolTip, true)
   
   --[[
      CVars Enable
   --]]

   local cvarenablesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   cvarenablesubtitle:SetHeight(cfgUI.ButtonHeight)
   cvarenablesubtitle:SetWidth(OptionWidth)
   cvarenablesubtitle:SetPoint("TOPLEFT", gamepadenablesubtitle, "TOPRIGHT", 0, 0)
   cvarenablesubtitle:SetNonSpaceWrap(true)
   cvarenablesubtitle:SetJustifyH("CENTER")
   cvarenablesubtitle:SetJustifyV("TOP")
   cvarenablesubtitle:SetText("CVars & Hooks")
   
   local cvarenablebutton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
   cvarenablebutton:SetPoint("TOPLEFT", cvarenablesubtitle, "BOTTOMLEFT", 0, 0)
   cvarenablebutton:SetHeight(cfgUI.ButtonHeight)
   cvarenablebutton:SetWidth(OptionWidth)

   if config.GamePad.CVSetup then
      cvarenablebutton:SetText("Disable")
   else
      cvarenablebutton:SetText("Enable")
   end
   
   cvarenablebutton:SetScript("OnClick", function(self, button, down)
      config.GamePad.CVSetup = not config.GamePad.CVSetup
      cfgUI:Refresh(true)
   end)
   
   cfgUI:AddToolTip(cvarenablesubtitle, locale.enabeCVarToolTip, true)
   
   --[[
      GamePadLook Enable
   --]]
   
   local gamepadlooksubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   gamepadlooksubtitle:SetHeight(cfgUI.ButtonHeight)
   gamepadlooksubtitle:SetWidth(OptionWidth)
   gamepadlooksubtitle:SetPoint("TOPLEFT", cvarenablesubtitle, "TOPRIGHT", 0, 0)
   gamepadlooksubtitle:SetNonSpaceWrap(true)
   gamepadlooksubtitle:SetJustifyH("CENTER")
   gamepadlooksubtitle:SetJustifyV("TOP")
   gamepadlooksubtitle:SetText("GamePadLook")
   
   local gamepadlookbutton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
   gamepadlookbutton:SetPoint("TOPLEFT", gamepadlooksubtitle, "BOTTOMLEFT", 0, 0)
   gamepadlookbutton:SetHeight(cfgUI.ButtonHeight)
   gamepadlookbutton:SetWidth(OptionWidth)

   if config.GamePad.GamePadLook then
      gamepadlookbutton:SetText("Disable")
   else
      gamepadlookbutton:SetText("Enable")
   end
   
   gamepadlookbutton:SetScript("OnClick", function(self, button, down)
      config.GamePad.GamePadLook = not config.GamePad.GamePadLook
      cfgUI:Refresh(true)
   end)

   cfgUI:AddToolTip(gamepadlooksubtitle, locale.gamepadLookToolTip, true)
   
   --[[
      Mouselook Enable
   --]]
   
   local mouselooksubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   mouselooksubtitle:SetHeight(cfgUI.ButtonHeight)
   mouselooksubtitle:SetWidth(OptionWidth)
   mouselooksubtitle:SetPoint("TOPLEFT", gamepadlooksubtitle, "TOPRIGHT", 0, 0)
   mouselooksubtitle:SetNonSpaceWrap(true)
   mouselooksubtitle:SetJustifyH("CENTER")
   mouselooksubtitle:SetJustifyV("TOP")
   mouselooksubtitle:SetText("MouseLook")
   
   local mouselookbutton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
   mouselookbutton:SetPoint("TOPLEFT", mouselooksubtitle, "BOTTOMLEFT", 0, 0)
   mouselookbutton:SetHeight(cfgUI.ButtonHeight)
   mouselookbutton:SetWidth(OptionWidth)

   if config.GamePad.MouseLook then
      mouselookbutton:SetText("Disable")
   else
      mouselookbutton:SetText("Enable")
   end
   
   mouselookbutton:SetScript("OnClick", function(self, button, down)
      config.GamePad.MouseLook = not config.GamePad.MouseLook
      cfgUI:Refresh(true)
   end)

   cfgUI:AddToolTip(mouselooksubtitle, locale.mouseLookToolTip, true)
   
   --[[
      CVars
   --]]
   
   local cvarsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
   cvarsubtitle:SetHeight(cfgUI.ButtonHeight)
   cvarsubtitle:SetWidth(OptionWidth)
   cvarsubtitle:SetPoint("TOPLEFT", gamepadenablebutton, "BOTTOMLEFT", -cfgUI.Inset, -cfgUI.ConfigSpacing)
   cvarsubtitle:SetNonSpaceWrap(true)
   cvarsubtitle:SetJustifyH("Left")
   cvarsubtitle:SetJustifyV("TOP")
   cvarsubtitle:SetText("CVars")

   --[[
      Devices
   --]]
     
   local DropDownWidth = configFrame:GetWidth()/3 - 2*cfgUI.Inset

   local bindings = {"NONE", "PAD1","PAD2","PAD3","PAD4","PAD5","PAD6",
                     "PADDRIGHT","PADDUP","PADDDOWN","PADDLEFT",
                     "PADLSTICK","PADRSTICK","PADLSHOULDER","PADRSHOULDER",
                     "PADLTRIGGER","PADRTRIGGER","PADFORWARD","PADBACK",
                     "PADPADDLE1","PADPADDLE2","PADPADDLE3","PADPADDLE4"}
   
   local devicetitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   devicetitle:SetHeight(cfgUI.TextHeight)
   devicetitle:SetWidth(DropDownWidth)
   devicetitle:SetPoint("TOPLEFT", cvarsubtitle, "BOTTOMLEFT", 0, -cfgUI.ConfigSpacing)
   devicetitle:SetNonSpaceWrap(true)
   devicetitle:SetJustifyH("CENTER")
   devicetitle:SetJustifyV("TOP")
   devicetitle:SetText("Device")
   
   local function IsDeviceSelected(id)
      return config.GamePad.GPDeviceID == id
   end
   
   local function SetDeviceSelected(id)
      config.GamePad.GPDeviceID = id
      cfgUI:Refresh(true)
   end

   local function DeviceGeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Devices")
      for i,device in ipairs(C_GamePad.GetAllDeviceIDs()) do
         local devicestate = C_GamePad.GetDeviceRawState(i-1)
         local name =""
         if devicestate then
            name = devicestate.name
         end
         if device == C_GamePad.GetCombinedDeviceID() then
            name = "Combined"
         end
         rootDescription:CreateRadio(name, IsDeviceSelected, SetDeviceSelected, device)
      end
   end

   local DeviceDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   DeviceDropDown:SetDefaultText("No devices found")
   DeviceDropDown:SetPoint("TOP", devicetitle, "BOTTOM", 0, 0)
   DeviceDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   DeviceDropDown:SetupMenu(DeviceGeneratorFunction)
   
   cfgUI:AddToolTip(devicetitle, locale.deviceToolTip, true)

   --[[
      Left mouse button
   --]]
     
   local leftclicktitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   leftclicktitle:SetHeight(cfgUI.TextHeight)
   leftclicktitle:SetWidth(DropDownWidth)
   leftclicktitle:SetPoint("TOPLEFT", devicetitle, "TOPRIGHT", 0,0 )
   leftclicktitle:SetNonSpaceWrap(true)
   leftclicktitle:SetJustifyH("CENTER")
   leftclicktitle:SetJustifyV("TOP")
   leftclicktitle:SetText("Left Click")

   local function IsLClickSelected(binding)
      return config.GamePad.GPLeftClick == binding
   end
   
   local function SetLClickSelected(binding)
      config.GamePad.GPLeftClick = binding
      if config.GamePad.GPRightClick == binding then
         config.GamePad.GPRightClick = "NONE"
      end
      cfgUI:Refresh(true)
   end

   local function LClickGeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Bindings")
      for i,binding in ipairs(bindings) do
         rootDescription:CreateRadio(binding, IsLClickSelected, SetLClickSelected, binding)
      end
   end

   local LClickDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   LClickDropDown:SetDefaultText("None")
   LClickDropDown:SetPoint("TOP", leftclicktitle, "BOTTOM", 0, 0)
   LClickDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   LClickDropDown:SetupMenu(LClickGeneratorFunction)
   
   cfgUI:AddToolTip(leftclicktitle, locale.leftclickToolTip, true)
   
   --[[
      Right mouse button
   --]]
     
   local rightclicktitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   rightclicktitle:SetHeight(cfgUI.TextHeight)
   rightclicktitle:SetWidth(DropDownWidth)
   rightclicktitle:SetPoint("TOPLEFT", leftclicktitle, "TOPRIGHT", 0,0 )
   rightclicktitle:SetNonSpaceWrap(true)
   rightclicktitle:SetJustifyH("CENTER")
   rightclicktitle:SetJustifyV("TOP")
   rightclicktitle:SetText("Right Click")
   
   local function IsRClickSelected(binding)
      return config.GamePad.GPRightClick == binding
   end
   
   local function SetRClickSelected(binding)
      config.GamePad.GPRightClick = binding
      if config.GamePad.GPLeftClick == binding then
         config.GamePad.GPLeftClick = "NONE"
      end
      cfgUI:Refresh(true)
   end

   local function RClickGeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Bindings")
      for i,binding in ipairs(bindings) do
         rootDescription:CreateRadio(binding, IsRClickSelected, SetRClickSelected, binding)
      end
   end

   local RClickDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   RClickDropDown:SetDefaultText("None")
   RClickDropDown:SetPoint("TOP", rightclicktitle, "BOTTOM", 0, 0)
   RClickDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   RClickDropDown:SetupMenu(RClickGeneratorFunction)
   
   cfgUI:AddToolTip(rightclicktitle, locale.rightclickToolTip, true)

   --[[
       Yaw speed
   --]]    

   local yawspeedsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   yawspeedsubtitle:SetHeight(cfgUI.TextHeight)
   yawspeedsubtitle:SetWidth(DropDownWidth-2*cfgUI.Inset)
   yawspeedsubtitle:SetPoint("TOP", DeviceDropDown, "BOTTOM", 0, -cfgUI.ConfigSpacing)
   yawspeedsubtitle:SetNonSpaceWrap(true)
   yawspeedsubtitle:SetJustifyH("CENTER")
   yawspeedsubtitle:SetJustifyV("TOP")
   yawspeedsubtitle:SetText("Camera yaw speed")
   
   local yaweditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   yaweditbox:SetPoint("TOPLEFT", yawspeedsubtitle, "BOTTOMLEFT", 0, 0)
   yaweditbox:SetWidth(DropDownWidth-2*cfgUI.Inset)
   yaweditbox:SetHeight(cfgUI.EditBoxHeight)
   yaweditbox:SetMovable(false)
   yaweditbox:SetAutoFocus(false)
   yaweditbox:EnableMouse(true)
   yaweditbox:SetNumeric(true)
   yaweditbox:SetJustifyH("CENTER")
   yaweditbox:SetText(config.GamePad.GPYawSpeed)
   yaweditbox:SetScript("OnEditFocusLost", function(self)
      config.GamePad.GPYawSpeed = self:GetText()
      cfgUI:Refresh(true)
   end)
   
   --[[
       Pitch speed
   --]]    

   local pitchspeedsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   pitchspeedsubtitle:SetHeight(cfgUI.TextHeight)
   pitchspeedsubtitle:SetWidth(DropDownWidth-2*cfgUI.Inset)
   pitchspeedsubtitle:SetPoint("TOPLEFT", yawspeedsubtitle, "TOPRIGHT", 2*cfgUI.Inset, 0)
   pitchspeedsubtitle:SetNonSpaceWrap(true)
   pitchspeedsubtitle:SetJustifyH("CENTER")
   pitchspeedsubtitle:SetJustifyV("TOP")
   pitchspeedsubtitle:SetText("Camera pitch speed")
   
   local pitcheditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   pitcheditbox:SetPoint("TOPLEFT", pitchspeedsubtitle, "BOTTOMLEFT", 0, 0)
   pitcheditbox:SetWidth(DropDownWidth-2*cfgUI.Inset)
   pitcheditbox:SetHeight(cfgUI.EditBoxHeight)
   pitcheditbox:SetMovable(false)
   pitcheditbox:SetAutoFocus(false)
   pitcheditbox:EnableMouse(true)
   pitcheditbox:SetNumeric(true)
   pitcheditbox:SetJustifyH("CENTER")
   pitcheditbox:SetText(config.GamePad.GPPitchSpeed)
   pitcheditbox:SetScript("OnEditFocusLost", function(self)
      config.GamePad.GPPitchSpeed = self:GetText()
      cfgUI:Refresh(true)
   end)
   
   --[[
       Overlap Mouse
   --]]    

   local overlapmousespeedsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   overlapmousespeedsubtitle:SetHeight(cfgUI.TextHeight)
   overlapmousespeedsubtitle:SetWidth(DropDownWidth-2*cfgUI.Inset)
   overlapmousespeedsubtitle:SetPoint("TOPLEFT", pitchspeedsubtitle, "TOPRIGHT", 2*cfgUI.Inset, 0)
   overlapmousespeedsubtitle:SetNonSpaceWrap(true)
   overlapmousespeedsubtitle:SetJustifyH("CENTER")
   overlapmousespeedsubtitle:SetJustifyV("TOP")
   overlapmousespeedsubtitle:SetText("Overlap Mouse (ms)")
   
   local overlapmouseeditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   overlapmouseeditbox:SetPoint("TOPLEFT", overlapmousespeedsubtitle, "BOTTOMLEFT", 0, 0)
   overlapmouseeditbox:SetWidth(DropDownWidth-2*cfgUI.Inset)
   overlapmouseeditbox:SetHeight(cfgUI.EditBoxHeight)
   overlapmouseeditbox:SetMovable(false)
   overlapmouseeditbox:SetAutoFocus(false)
   overlapmouseeditbox:EnableMouse(true)
   overlapmouseeditbox:SetNumeric(true)
   overlapmouseeditbox:SetJustifyH("CENTER")
   overlapmouseeditbox:SetText(config.GamePad.GPOverlapMouse)
   overlapmouseeditbox:SetScript("OnEditFocusLost", function(self)
      config.GamePad.GPOverlapMouse = self:GetText()
      cfgUI:Refresh(true)
   end)
   
   cfgUI:AddRefreshCallback(self.GamePadFrame, function()
      if config.GamePad.GPEnable == 0 then
         gamepadenablebutton:SetText("Enable")
      else
         gamepadenablebutton:SetText("Disable")
      end
      
      if config.GamePad.GamePadLook then
         gamepadlookbutton:SetText("Disable")
      else
         gamepadlookbutton:SetText("Enable")
      end
      
      if config.GamePad.MouseLook then
         mouselookbutton:SetText("Disable")
      else
         mouselookbutton:SetText("Enable")
      end
      
      if config.GamePad.CVSetup then
         cvarenablebutton:SetText("Disable")
      else
         cvarenablebutton:SetText("Enable")
      end
      local devicestate = C_GamePad.GetDeviceRawState(config.GamePad.GPDeviceID-1)
      if devicestate then
         DeviceDropDown:GenerateMenu()
      end
      LClickDropDown:GenerateMenu()
      RClickDropDown:GenerateMenu()
      yaweditbox:SetText(config.GamePad.GPYawSpeed)
      pitcheditbox:SetText(config.GamePad.GPPitchSpeed)
      overlapmouseeditbox:SetText(config.GamePad.GPOverlapMouse)
   end)
   
   return nil
end

GamePadUI:CreateFrame()
addon.GamePadUI = GamePadUI
