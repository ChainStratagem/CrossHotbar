local ADDON, addon = ...

local config = addon.Config
local locale = addon.Locale
local cfgUI  = addon.ConfigUI

local PresetUI = {}

function PresetUI:CreateFrame()
   self.PresetFrame = CreateFrame("Frame", ADDON .. "PresetsSettings", cfgUI.ConfigFrame)
   self.PresetFrame.name = "Presets"
   self.PresetFrame.parent = cfgUI.ConfigFrame.name
   self.PresetFrame:Hide()
   
   self.PresetFrame:SetScript("OnShow", function(PresetFrame)
      local title = PresetFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
      title:SetPoint("TOPLEFT", cfgUI.Inset, -cfgUI.Inset)
      title:SetText("Presets")
      local anchor = title
      anchor = PresetUI:CreatePresets(PresetFrame, anchor)
      PresetFrame:SetScript("OnShow", function(frame) cfgUI:Refresh() end) 
      cfgUI:Refresh()
   end)
   
   Settings.RegisterCanvasLayoutSubcategory(cfgUI.category,
                                            self.PresetFrame,
                                            self.PresetFrame.name)
end

function PresetUI:CreatePresets(configFrame, anchorFrame)
   local DropDownWidth = configFrame:GetWidth()/2 - 2*cfgUI.Inset
   local presetsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   presetsubtitle:SetHeight(cfgUI.TextHeight)
   presetsubtitle:SetWidth(DropDownWidth)
   presetsubtitle:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -cfgUI.ConfigSpacing)
   presetsubtitle:SetNonSpaceWrap(true)
   presetsubtitle:SetJustifyH("CENTER")
   presetsubtitle:SetJustifyV("TOP")
   presetsubtitle:SetText("Presets")

   local function IsSelected(index)
      return cfgUI.preset == index
   end
   
   local function SetSelected(index)
      cfgUI.preset = index
   end

   local function GeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Saved Presets")
      for i,p in ipairs(CrossHotbar_DB.Presets) do
         rootDescription:CreateRadio(p.Name, IsSelected, SetSelected, i)
      end
   end

   local PresetsDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   PresetsDropDown:SetDefaultText("Presets")
   PresetsDropDown:SetPoint("TOP", presetsubtitle, "BOTTOM", 0, 0)
   PresetsDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   PresetsDropDown:SetupMenu(GeneratorFunction)
   
   local presetloadbutton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
   presetloadbutton:SetPoint("TOPLEFT", PresetsDropDown, "TOPRIGHT", 24, 0)
   presetloadbutton:SetHeight(cfgUI.ButtonHeight)
   presetloadbutton:SetWidth(cfgUI.ButtonWidth)
   presetloadbutton:SetText("Load")
   
   presetloadbutton:SetScript("OnClick", function(self, button, down)
      CrossHotbar_DB.ActivePreset = cfgUI.preset
      addon:StorePreset(config, CrossHotbar_DB.Presets[cfgUI.preset])
      cfgUI:Refresh(true)
   end)
   
   local presetdeletebutton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
   presetdeletebutton:SetPoint("TOPLEFT", presetloadbutton, "TOPRIGHT", 0, 0)
   presetdeletebutton:SetHeight(cfgUI.ButtonHeight)
   presetdeletebutton:SetWidth(cfgUI.ButtonWidth)
   presetdeletebutton:SetEnabled(false)
   presetdeletebutton:SetText("Delete")

   presetdeletebutton:SetScript("OnClick", function(self, button, down)
      if CrossHotbar_DB.Presets[cfgUI.preset].Mutable then
         table.remove(CrossHotbar_DB.Presets, cfgUI.preset)
         cfgUI.preset = cfgUI.preset + 1
         if cfgUI.preset > #CrossHotbar_DB.Presets then             
            cfgUI.preset = #CrossHotbar_DB.Presets
         end
         CrossHotbar_DB.ActivePreset = cfgUI.preset
      end
      config.Name = "Custom"
      addon:StorePreset(config, CrossHotbar_DB.Presets[cfgUI.preset])
   end)

   local filesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   filesubtitle:SetHeight(cfgUI.TextHeight)
   filesubtitle:SetWidth(DropDownWidth)
   filesubtitle:SetPoint("TOP", PresetsDropDown, "BOTTOM", 0, -cfgUI.ConfigSpacing)
   filesubtitle:SetNonSpaceWrap(true)
   filesubtitle:SetJustifyH("CENTER")
   filesubtitle:SetJustifyV("TOP")
   filesubtitle:SetText("Name")
   
   local presetfileeditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   presetfileeditbox:SetPoint("TOP", filesubtitle, "BOTTOM", 0, 0)
   presetfileeditbox:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   presetfileeditbox:SetHeight(cfgUI.EditBoxHeight)
   presetfileeditbox:SetMovable(false)
   presetfileeditbox:SetAutoFocus(false)
   presetfileeditbox:EnableMouse(true)
   presetfileeditbox:SetText(config.Name)
   
   local presetsavebutton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
   presetsavebutton:SetPoint("LEFT", presetfileeditbox, "RIGHT", 24, 0)
   presetsavebutton:SetHeight(cfgUI.ButtonHeight)
   presetsavebutton:SetWidth(cfgUI.ButtonWidth)
   presetsavebutton:SetText("Save")
   
   presetsavebutton:SetScript("OnClick", function(self, button, down)
      if presetfileeditbox:GetText() ~= "" then
         local foundpreset = 0
         for i,p in ipairs(CrossHotbar_DB.Presets) do
            if p.Name == presetfileeditbox:GetText() then
               foundpreset = i
            end
         end
         if foundpreset == 0 then
            config.Name = presetfileeditbox:GetText()
            local newpreset = {
               Mutable = true
            }
            addon:StorePreset(newpreset, config)
            table.insert(CrossHotbar_DB.Presets, newpreset)
            cfgUI.preset = #CrossHotbar_DB.Presets
            CrossHotbar_DB.ActivePreset = cfgUI.preset
         elseif CrossHotbar_DB.Presets[foundpreset].Mutable then
            cfgUI.preset = foundpreset
            CrossHotbar_DB.ActivePreset = cfgUI.preset
            addon:StorePreset(CrossHotbar_DB.Presets[cfgUI.preset], config)
         end
      end
      cfgUI:Refresh(true)
   end)

   local descripttitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   descripttitle:SetPoint("TOPLEFT", presetfileeditbox, "BOTTOMLEFT", 0, -4*cfgUI.ConfigSpacing)
   descripttitle:SetWidth(2*DropDownWidth-cfgUI.DropDownSpacing)
   descripttitle:SetNonSpaceWrap(true)
   descripttitle:SetJustifyH("CENTER")
   descripttitle:SetJustifyV("TOP")
   descripttitle:SetText("Description")
   
   local backdropframe = CreateFrame("Frame", nil, configFrame, "BackdropTemplate")
   
   backdropframe:SetBackdrop({
        bgFile="Interface/DialogFrame/UI-DialogBox-Background",
        edgeFile="Interface/DialogFrame/UI-DialogBox-Border",
	tile = false,
	tileEdge = false,
	tileSize = 0,
	edgeSize = 8,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
   })
   
   backdropframe:SetPoint("TOPLEFT", descripttitle, "BOTTOMLEFT", 0, -cfgUI.ConfigSpacing)
   backdropframe:SetSize(2*DropDownWidth-cfgUI.DropDownSpacing, 200)
   
   local scrollFrame = CreateFrame("ScrollFrame", nil, backdropframe, "UIPanelScrollFrameTemplate, BackdropTemplate")
   scrollFrame:SetSize(backdropframe:GetWidth()-40, backdropframe:GetHeight()-20)
   scrollFrame:SetPoint("TOPLEFT", backdropframe, "TOPLEFT", 10, -10)

   local descriptfileeditbox = CreateFrame("EditBox", nil, scrollFrame)
   descriptfileeditbox:SetMultiLine(true)
   descriptfileeditbox:SetMovable(false)
   descriptfileeditbox:SetAutoFocus(false)
   descriptfileeditbox:EnableMouse(true)
   descriptfileeditbox:SetFontObject(ChatFontNormal)
   descriptfileeditbox:SetSize(backdropframe:GetWidth()-40,
                               backdropframe:GetHeight()-20)
   descriptfileeditbox:SetText(config.Description)

   scrollFrame:SetScrollChild(descriptfileeditbox)
   
   cfgUI:AddRefreshCallback(self.PresetFrame, function()
      PresetsDropDown:GenerateMenu()
      presetdeletebutton:SetEnabled(CrossHotbar_DB.Presets[cfgUI.preset].Mutable)
      presetfileeditbox:SetText(config.Name)
      descriptfileeditbox:SetText(config.Description)
   end)
   
   return PresetsDropDown
end

PresetUI:CreateFrame()
addon.PresetUI = PresetUI
