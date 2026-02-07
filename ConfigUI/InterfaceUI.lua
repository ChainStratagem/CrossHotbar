local ADDON, addon = ...

local config = addon.Config
local locale = addon.Locale
local cfgUI  = addon.ConfigUI

local InterfaceUI = {}

function InterfaceUI:CreateFrame()
   self.InterfaceFrame = CreateFrame("Frame", ADDON .. "InterfaceSettings", self.ConfigFrame)
   self.InterfaceFrame.name = "Interface"
   self.InterfaceFrame.parent = cfgUI.ConfigFrame.name
   self.InterfaceFrame:Hide()

   self.InterfaceFrame:SetScript("OnShow", function(InterfaceFrame)
      local title = InterfaceFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
      title:SetPoint("TOPLEFT", cfgUI.Inset, -cfgUI.Inset)
      title:SetText("Interface Settings")

      local anchor = title
      anchor = self:CreateInterfaceSettings(InterfaceFrame, anchor)
      
      InterfaceFrame:SetScript("OnShow", function(frame) cfgUI:Refresh() end) 
      cfgUI:Refresh()
      
   end)      

   Settings.RegisterCanvasLayoutSubcategory(cfgUI.category,
                                            self.InterfaceFrame,
                                            self.InterfaceFrame.name)
end

function InterfaceUI:CreateInterfaceSettings(configFrame, anchorFrame)
   local DropDownWidth = (configFrame:GetWidth() - 2*cfgUI.Inset)/2

   --[[
       ActionBar Hides
   --]]   
   
   local blizframesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
   blizframesubtitle:SetHeight(cfgUI.ButtonHeight)
   blizframesubtitle:SetWidth(DropDownWidth)
   blizframesubtitle:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -cfgUI.ConfigSpacing)
   blizframesubtitle:SetNonSpaceWrap(true)
   blizframesubtitle:SetJustifyH("Left")
   blizframesubtitle:SetJustifyV("TOP")
   blizframesubtitle:SetText("Blizzard frames")

   local actionbarhidesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   actionbarhidesubtitle:SetHeight(cfgUI.ButtonHeight)
   actionbarhidesubtitle:SetWidth(DropDownWidth)
   actionbarhidesubtitle:SetPoint("TOPLEFT", blizframesubtitle, "BOTTOMLEFT", cfgUI.Inset, -cfgUI.ConfigSpacing)
   actionbarhidesubtitle:SetNonSpaceWrap(true)
   actionbarhidesubtitle:SetJustifyH("CENTER")
   actionbarhidesubtitle:SetJustifyV("TOP")
   actionbarhidesubtitle:SetText("Hide ActionBars")

   local function IsActionBarHideTypeSelected(type)
      return config.Interface.ActionBarHide == type
   end
   
   local function SetActioBarHideTypeSelected(type)
      config.Interface.ActionBarHide = type
      cfgUI:Refresh(true)
   end

   local function ActionBarHideGeneratorFunction(owner, rootDescription)      
      for i,data in ipairs(addon.ActionBarHides) do
         if locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(locale:GetText(data.cat))
         end
         for i,hidetype in ipairs(data.values) do
            rootDescription:CreateRadio(locale.actionbarhidetypestr[hidetype], IsActionBarHideTypeSelected, SetActioBarHideTypeSelected, hidetype)
         end
      end
   end

   local ActionBarHideDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   ActionBarHideDropDown:SetDefaultText("Layout Types")
   ActionBarHideDropDown:SetPoint("TOP", actionbarhidesubtitle, "BOTTOM", 0, 0)
   ActionBarHideDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   ActionBarHideDropDown:SetupMenu(ActionBarHideGeneratorFunction)
   
   cfgUI:AddToolTip(actionbarhidesubtitle, locale.actionbarhideToolTip, true)

   --[[
       VehicleBar Hides
   --]] 
   
   local vehiclebarhidesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   vehiclebarhidesubtitle:SetHeight(cfgUI.ButtonHeight)
   vehiclebarhidesubtitle:SetWidth(DropDownWidth)
   vehiclebarhidesubtitle:SetPoint("TOPLEFT", actionbarhidesubtitle, "TOPRIGHT", 0, 0)
   vehiclebarhidesubtitle:SetNonSpaceWrap(true)
   vehiclebarhidesubtitle:SetJustifyH("CENTER")
   vehiclebarhidesubtitle:SetJustifyV("TOP")
   vehiclebarhidesubtitle:SetText("Hide VehicleBar")

   local function IsVehicleBarHideTypeSelected(type)
      return config.Interface.VehicleBarHide == type
   end
   
   local function SetActioBarHideTypeSelected(type)
      config.Interface.VehicleBarHide = type
      cfgUI:Refresh(true)
   end

   local function VehicleBarHideGeneratorFunction(owner, rootDescription)      
      for i,data in ipairs(addon.VehicleBarHides) do
         if locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(locale:GetText(data.cat))
         end
         for i,hidetype in ipairs(data.values) do
            rootDescription:CreateRadio(locale.vehiclebarhidetypestr[hidetype], IsVehicleBarHideTypeSelected, SetVehicleBarHideTypeSelected, hidetype)
         end
      end
   end

   local VehicleBarHideDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   VehicleBarHideDropDown:SetDefaultText("Layout Types")
   VehicleBarHideDropDown:SetPoint("TOP", vehiclebarhidesubtitle, "BOTTOM", 0, 0)
   VehicleBarHideDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   VehicleBarHideDropDown:SetupMenu(VehicleBarHideGeneratorFunction)
   
   cfgUI:AddToolTip(vehiclebarhidesubtitle, locale.vehiclebarhideToolTip, true)

   --[[
       Unit Targeting
   --]] 
   
   local unittargetsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
   unittargetsubtitle:SetHeight(cfgUI.ButtonHeight)
   unittargetsubtitle:SetWidth(DropDownWidth)
   unittargetsubtitle:SetPoint("TOP", ActionBarHideDropDown, "BOTTOM", 0, -cfgUI.ConfigSpacing)
   unittargetsubtitle:SetPoint("LEFT", anchorFrame, "LEFT", 0, 0)
   unittargetsubtitle:SetNonSpaceWrap(true)
   unittargetsubtitle:SetJustifyH("Left")
   unittargetsubtitle:SetJustifyV("TOP")
   unittargetsubtitle:SetText("Unit highlight")

   --[[
       Party Orientation
   --]] 
   
   local partyoriensubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   partyoriensubtitle:SetHeight(cfgUI.ButtonHeight)
   partyoriensubtitle:SetWidth(DropDownWidth)
   partyoriensubtitle:SetPoint("TOPLEFT", unittargetsubtitle, "BOTTOMLEFT", cfgUI.Inset, -cfgUI.ConfigSpacing)
   partyoriensubtitle:SetNonSpaceWrap(true)
   partyoriensubtitle:SetJustifyH("CENTER")
   partyoriensubtitle:SetJustifyV("TOP")
   partyoriensubtitle:SetText("Party Orientation")

   local function IsPartyOrienTypeSelected(type)
      return config.Interface.UnitPartyOrientation == type
   end
   
   local function SetPartyOrienTypeSelected(type)
      config.Interface.UnitPartyOrientation = type
      cfgUI:Refresh(true)
   end

   local function PartyOrienGeneratorFunction(owner, rootDescription)      
      for i,data in ipairs(addon.PartyOrientation) do
         if locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(locale:GetText(data.cat))
         end
         for i,orientype in ipairs(data.values) do
            rootDescription:CreateRadio(locale.partyorientypestr[orientype], IsPartyOrienTypeSelected, SetPartyOrienTypeSelected, orientype)
         end
      end
   end
   
   local PartyOrienDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   PartyOrienDropDown:SetDefaultText("Layout Types")
   PartyOrienDropDown:SetPoint("TOP", partyoriensubtitle, "BOTTOM", 0, 0)
   PartyOrienDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   PartyOrienDropDown:SetupMenu(PartyOrienGeneratorFunction)
   
   cfgUI:AddToolTip(partyoriensubtitle, locale.partyorienToolTip, true)
   
   --[[
       Raid Orientation
   --]]
   
   local raidoriensubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   raidoriensubtitle:SetHeight(cfgUI.ButtonHeight)
   raidoriensubtitle:SetWidth(DropDownWidth)
   raidoriensubtitle:SetPoint("TOPLEFT", partyoriensubtitle, "TOPRIGHT", 0, 0)
   raidoriensubtitle:SetNonSpaceWrap(true)
   raidoriensubtitle:SetJustifyH("CENTER")
   raidoriensubtitle:SetJustifyV("TOP")
   raidoriensubtitle:SetText("Raid Orientation")

   local function IsRaidOrienTypeSelected(type)
      return config.Interface.UnitRaidOrientation == type
   end
   
   local function SetRaidOrienTypeSelected(type)
      config.Interface.UnitRaidOrientation = type
      cfgUI:Refresh(true)
   end

   local function RaidOrienGeneratorFunction(owner, rootDescription)      
      for i,data in ipairs(addon.RaidOrientation) do
         if locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(locale:GetText(data.cat))
         end
         for i,orientype in ipairs(data.values) do
            rootDescription:CreateRadio(locale.raidorientypestr[orientype], IsRaidOrienTypeSelected, SetRaidOrienTypeSelected, orientype)
         end
      end
   end
   
   local RaidOrienDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   RaidOrienDropDown:SetDefaultText("Layout Types")
   RaidOrienDropDown:SetPoint("TOP", raidoriensubtitle, "BOTTOM", 0, 0)
   RaidOrienDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   RaidOrienDropDown:SetupMenu(RaidOrienGeneratorFunction)
   
   cfgUI:AddToolTip(raidoriensubtitle, locale.raidorienToolTip, true)

   --[[
        Highlight Color
   --]]
   
   local targetcolorsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   targetcolorsubtitle:SetHeight(cfgUI.ButtonHeight)
   targetcolorsubtitle:SetWidth(DropDownWidth)
   targetcolorsubtitle:SetPoint("TOP", PartyOrienDropDown, "BOTTOM", 0, -cfgUI.ConfigSpacing)
   targetcolorsubtitle:SetNonSpaceWrap(true)
   targetcolorsubtitle:SetJustifyH("CENTER")
   targetcolorsubtitle:SetJustifyV("TOP")
   targetcolorsubtitle:SetText("Highlight colors")
   cfgUI:AddToolTip(targetcolorsubtitle, locale.targetcolorToolTip, true)
   
   local ActiveTargetColorButtonsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontWhite")
   ActiveTargetColorButtonsubtitle:SetWidth(DropDownWidth/4-cfgUI.Inset)
   ActiveTargetColorButtonsubtitle:SetPoint("TOPLEFT", targetcolorsubtitle, "BOTTOMLEFT", cfgUI.Inset, -cfgUI.ConfigSpacing/2)
   ActiveTargetColorButtonsubtitle:SetNonSpaceWrap(true)
   ActiveTargetColorButtonsubtitle:SetJustifyH("RIGHT")
   ActiveTargetColorButtonsubtitle:SetJustifyV("TOP")
   ActiveTargetColorButtonsubtitle:SetText("Active")

   function ShowColorPicker(r, g, b, changedCallback)
      ColorPickerFrame.Content.ColorPicker:SetColorRGB(r,g,b)
      ColorPickerFrame.hasOpacity = false
      ColorPickerFrame.previousValues = {r,g,b,a}
      ColorPickerFrame.swatchFunc = changedCallback
      ColorPickerFrame.opacityFunc = changedCallback
      ColorPickerFrame.cancelFunc = changedCallback
      ColorPickerFrame:Hide()
      ColorPickerFrame:Show()
   end
           
   local ActiveTargetEnabledCheckBox = CreateFrame("CheckButton", nil, configFrame, "ChatConfigCheckButtonTemplate")
   ActiveTargetEnabledCheckBox:SetPoint("LEFT", ActiveTargetColorButtonsubtitle, "RIGHT", cfgUI.Inset, 0)
   ActiveTargetEnabledCheckBox:SetHitRectInsets(0,0,0,0)
   ActiveTargetEnabledCheckBox:SetChecked(config.Interface.UnitTargetActiveEnable)
   
   local ActiveTargetColorButton = CreateFrame("Button", nil, configFrame, "ColorSwatchTemplate")
   ActiveTargetColorButton:SetPoint("LEFT", ActiveTargetEnabledCheckBox, "RIGHT", 0, 0)
   ActiveTargetColorButton:SetColorRGB(unpack(config.Interface.UnitTargetActiveColor))
   
   ActiveTargetEnabledCheckBox:SetScript("OnClick", function(self)
      config.Interface.UnitTargetActiveEnable = self:GetChecked()
      if addon.SoftTargetFrame then
         addon.SoftTargetFrame.activeHighlight.isEnabled = config.Interface.UnitTargetActiveEnable
      end
   end)
     
   ActiveTargetColorButton:SetScript("OnClick", function(self)
      if ActiveTargetEnabledCheckBox:GetChecked() then
         ShowColorPicker(1, 0, 0, function(restore)
            if restore then
               ActiveTargetColorButton:SetColorRGB(unpack(restore))
               config.Interface.UnitTargetActiveColor = restore
               if addon.SoftTargetFrame then
                  addon.SoftTargetFrame.activeHighlight:SetVertexColor(unpack(config.Interface.UnitTargetActiveColor))
               end
            else
               ActiveTargetColorButton:SetColorRGB(ColorPickerFrame:GetColorRGB())
               config.Interface.UnitTargetActiveColor = {ColorPickerFrame:GetColorRGB()}
               if addon.SoftTargetFrame then
                  addon.SoftTargetFrame.activeHighlight:SetVertexColor(unpack(config.Interface.UnitTargetActiveColor))
               end
            end
         end)
      end
   end)
                               
   local InActiveTargetColorButtonButtonsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontWhite")
   InActiveTargetColorButtonButtonsubtitle:SetWidth(DropDownWidth/4)
   InActiveTargetColorButtonButtonsubtitle:SetPoint("LEFT", ActiveTargetColorButton, "RIGHT", cfgUI.Inset, 0)
   InActiveTargetColorButtonButtonsubtitle:SetNonSpaceWrap(true)
   InActiveTargetColorButtonButtonsubtitle:SetJustifyH("RIGHT")
   InActiveTargetColorButtonButtonsubtitle:SetJustifyV("TOP")
   InActiveTargetColorButtonButtonsubtitle:SetText("Inactive")

   local InActiveTargetEnabledCheckBox = CreateFrame("CheckButton", nil, configFrame, "ChatConfigCheckButtonTemplate")
   InActiveTargetEnabledCheckBox:SetPoint("LEFT", InActiveTargetColorButtonButtonsubtitle, "RIGHT", cfgUI.Inset, 0)
   InActiveTargetEnabledCheckBox:SetHitRectInsets(0,0,0,0)
   InActiveTargetEnabledCheckBox:SetChecked(config.Interface.UnitTargetInActiveEnable)
   
   local InActiveTargetColorButtonButton = CreateFrame("Button", nil, configFrame, "ColorSwatchTemplate")
   InActiveTargetColorButtonButton:SetPoint("LEFT", InActiveTargetEnabledCheckBox, "RIGHT", 0, 0)
   InActiveTargetColorButtonButton:SetColorRGB(unpack(config.Interface.UnitTargetInActiveColor))
    
   InActiveTargetEnabledCheckBox:SetScript("OnClick", function(self)
      config.Interface.UnitTargetInActiveEnable = self:GetChecked()
      if addon.SoftTargetFrame then
         addon.SoftTargetFrame.inactiveHighlight.isEnabled = config.Interface.UnitTargetInActiveEnable
      end
   end)
     
   InActiveTargetColorButtonButton:SetScript("OnClick", function(self)
      if InActiveTargetEnabledCheckBox:GetChecked() then
         ShowColorPicker(1, 0, 0, function(restore)
            if restore then
               InActiveTargetColorButtonButton:SetColorRGB(unpack(restore))
               config.Interface.UnitTargetInActiveColor = restore
               if addon.SoftTargetFrame then
                  addon.SoftTargetFrame.inactiveHighlight:SetVertexColor(unpack(config.Interface.UnitTargetInActiveColor))
               end
            else
               InActiveTargetColorButtonButton:SetColorRGB(ColorPickerFrame:GetColorRGB())
               config.Interface.UnitTargetInActiveColor = {ColorPickerFrame:GetColorRGB()}
               if addon.SoftTargetFrame then
                  addon.SoftTargetFrame.inactiveHighlight:SetVertexColor(unpack(config.Interface.UnitTargetInActiveColor))
               end
            end
         end)
      end
   end)

   --[[
        Highlight size offset
   --]]
   
   local highlightpaddingsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   highlightpaddingsubtitle:SetHeight(cfgUI.ButtonHeight)
   highlightpaddingsubtitle:SetWidth(DropDownWidth)
   highlightpaddingsubtitle:SetPoint("TOP", RaidOrienDropDown, "BOTTOM", 0, -cfgUI.ConfigSpacing)
   highlightpaddingsubtitle:SetNonSpaceWrap(true)
   highlightpaddingsubtitle:SetJustifyH("CENTER")
   highlightpaddingsubtitle:SetJustifyV("TOP")
   highlightpaddingsubtitle:SetText("Highlight padding")
   cfgUI:AddToolTip(highlightpaddingsubtitle, locale.highlightpaddingToolTip, true)
   
   local HighlightPaddingEditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   HighlightPaddingEditbox:SetPoint("TOP", highlightpaddingsubtitle, "BOTTOM", 0, 0)
   HighlightPaddingEditbox:SetWidth(cfgUI.ButtonWidth/2)
   HighlightPaddingEditbox:SetHeight(cfgUI.EditBoxHeight)
   HighlightPaddingEditbox:SetMovable(false)
   HighlightPaddingEditbox:SetAutoFocus(false)
   HighlightPaddingEditbox:EnableMouse(true)
   HighlightPaddingEditbox:SetText(config.Interface.UnitTargetPadding)
   HighlightPaddingEditbox:SetNumeric(true)
   HighlightPaddingEditbox:SetJustifyH("CENTER")
   HighlightPaddingEditbox:SetScript("OnEditFocusLost", function(self)
      config.Interface.UnitTargetPadding = tonumber(self:GetText())
      cfgUI:Refresh(true)
   end)

   cfgUI:AddRefreshCallback(self.InterfaceFrame, function()
      ActionBarHideDropDown:GenerateMenu()
      VehicleBarHideDropDown:GenerateMenu()
      PartyOrienDropDown:GenerateMenu()
      RaidOrienDropDown:GenerateMenu()
      ActiveTargetEnabledCheckBox:SetChecked(config.Interface.UnitTargetActiveEnable)
      ActiveTargetColorButton:SetColorRGB(unpack(config.Interface.UnitTargetActiveColor))
      InActiveTargetEnabledCheckBox:SetChecked(config.Interface.UnitTargetInActiveEnable)
      InActiveTargetColorButtonButton:SetColorRGB(unpack(config.Interface.UnitTargetInActiveColor))
      HighlightPaddingEditbox:SetText(config.Interface.UnitTargetPadding)
   end)
end

InterfaceUI:CreateFrame()
addon.InterfaceUI = InterfaceUI
