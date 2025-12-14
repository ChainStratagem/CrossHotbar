local ADDON, addon = ...

local config = addon.Config

local GamePadButtonList = addon.GamePadButtonList

local GamePadBindingList = {
"PAD1",
"PAD2",
"PAD3",
"PAD4",
"PAD5",
"PAD6",
"PADDRIGHT",
"PADDUP",
"PADDDOWN",
"PADDLEFT",
"PADLSTICK",
"PADRSTICK",
"PADLSHOULDER",
"PADRSHOULDER",
"PADLTRIGGER",
"PADRTRIGGER",
"PADFORWARD",
"PADBACK",
"PADSYSTEM",
"PADSOCIAL",
"PADPADDLE1",
"PADPADDLE2",
"PADPADDLE3",
"PADPADDLE4",
"1", 
"2", 
"3", 
"4" ,
"5", 
"6", 
"7", 
"8", 
"9", 
"0", 
"-", 
"=", 
"[", 
"]", 
"\\",
"'",
",",
".",
"'",
";",
"/",
"`"
}

local GamePadActionMap = {
   FACER=addon.GamePadActions,
   FACEU=addon.GamePadActions,
   FACED=addon.GamePadActions,
   FACEL=addon.GamePadActions,
   DPADR=addon.GamePadActions,
   DPADU=addon.GamePadActions,
   DPADD=addon.GamePadActions,
   DPADL=addon.GamePadActions,
   STCKL=addon.GamePadActions,
   STCKR=addon.GamePadActions,
   SPADL=addon.GamePadModifiers,
   SPADR=addon.GamePadModifiers,
   TRIGL=addon.GamePadModifiers,
   TRIGR=addon.GamePadModifiers,
   PPADL=addon.GamePadModifiers,
   PPADR=addon.GamePadModifiers,
   TPADL=addon.GamePadActions,
   TPADR=addon.GamePadActions,
   SOCIA=addon.GamePadActions,
   OPTIO=addon.GamePadActions,
   SYSTM=addon.GamePadActions
}

local GamePadModifierActionMap = {
   FACER=addon.GamePadModifierActions,
   FACEU=addon.GamePadModifierActions,
   FACED=addon.GamePadModifierActions,
   FACEL=addon.GamePadModifierActions,
   DPADR=addon.GamePadModifierActions,
   DPADU=addon.GamePadModifierActions,
   DPADD=addon.GamePadModifierActions,
   DPADL=addon.GamePadModifierActions,
   STCKL=addon.GamePadModifierActions,
   STCKR=addon.GamePadModifierActions,
   SPADL=addon.GamePadModifierActions,
   SPADR=addon.GamePadModifierActions,
   TRIGL=addon.GamePadModifierActions,
   TRIGR=addon.GamePadModifierActions,
   PPADL=addon.GamePadModifierActions,
   PPADR=addon.GamePadModifierActions,
   TPADL=addon.GamePadModifierActions,
   TPADR=addon.GamePadModifierActions,
   SOCIA=addon.GamePadModifierActions,
   OPTIO=addon.GamePadModifierActions,
   SYSTM=addon.GamePadModifierActions,
}

local GamePadHotbarMap = {
   FACER=addon.HotbarActions,
   FACEU=addon.HotbarActions,
   FACED=addon.HotbarActions,
   FACEL=addon.HotbarActions,
   DPADR=addon.HotbarActions,
   DPADU=addon.HotbarActions,
   DPADD=addon.HotbarActions,
   DPADL=addon.HotbarActions,
   STCKL=addon.GamePadModifierActions,
   STCKR=addon.GamePadModifierActions,
   SPADL=addon.GamePadModifierActions,
   SPADR=addon.GamePadModifierActions,
   TRIGL=addon.GamePadModifierActions,
   TRIGR=addon.GamePadModifierActions,
   PPADL=addon.GamePadModifierActions,
   PPADR=addon.GamePadModifierActions,
   TPADL=addon.GamePadModifierActions,
   TPADR=addon.GamePadModifierActions,
   SOCIA=addon.GamePadModifierActions,
   OPTIO=addon.GamePadModifierActions,
   SYSTM=addon.GamePadModifierActions,
}

StaticPopupDialogs["CROSSHOTBAR_ENABLEGAMEPAD"] = {
   text = [[This config requires GamePad mode enabled.
CVar GamePadEnable is 0.
Click "Enable" to enable or use the Console command:
"/console GamePadEnable 1"]],
  button1 = "Enable",
  button2 = "Cancel",
  OnAccept = function()
     print("Enabled")
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3
}

local Locale = {
   bindingToolTip = "Button bindings used to assign buttons to actions. The bindings can be either controller or keyboards bindings. The bindings are for the Cross hotbar only, the controller needs to be configured seperately.",
   actionToolTip = "Actions assigned when hobars are not active. Available actions are dependant on the button type. Some buttons can be assigned to modifiers such as LEFTHOTBAR or LEFTSHOULDER which can remap other buttons.",
   hotbaractionToolTip = "Hotbar buttons or actions assigned with a hotbar is active. The hotbar buttons are index relative to the active hotbar.",
   defaultTabToolTip = "Default actions for controller buttons and hotbar button assignments.",
   spadlTabToolTip = "Actions and hotbar assignments when under the LEFTSHOULDER modifier. An unassigned button will recieve the DEFAULT actions. Modifiers are exclusive and only modify the DEFAULT tab.",
   spadrTabToolTip = "Actions and hotbar assignments when under the RIGHTSHOULDER modifier. An unassigned button will recieve the DEFAULT actions. Modifiers are exclusive and only modify the DEFAULT tab.",
   ppadlTabToolTip = "Actions and hotbar assignments when under the LEFTPADDLE modifier. An unassigned button will recieve the DEFAULT actions. Modifiers are exclusive and only modify the DEFAULT tab.",
   ppadrTabToolTip = "Actions and hotbar assignments when under the RIGHTPADDLE modifier. An unassigned button will recieve the DEFAULT actions. Modifiers are exclusive and only modify the DEFAULT tab.",
   hotbarTypeToolTip = "Hotbars can be internally recreated or reuse the existing Blizzard Actionbars. When using Blizzard Actiobars Edit Mode can change the hotbar positions. Interacting with the Crosshotbar will restore the positions if moved.",
   hotkeyTypeToolTip = "Button icons used in the gui and hotkeys can be set to shapes or letters.",
   expandedTypeToolTip = "When either LEFTHOTBAR or RIGHTHOTBAR  are double clicked HOTBARBTN[9-12] are mapped to HOTBARBTN[1-4]. This setting controls the visual cue of their activation.",
   dadaTypeToolTip = "The Cross hotbar can have two layouts. One with each bar on a given side or another that interleaves the hotbars.",
   pageIndexToolTip = "The default page displayed by the hotbar.",
   pagePrefixToolTip = "The prefix macro conditional to control paging under certain conditionals. Default page should not be included in this string.",
   enabeGamePadToolTip = "Toggle global GamePad mode.",
   enabeCVarToolTip = "Toggle CVar settings and hooks used by Crosshotbar. Disabling requires reloading.",
   gamepadLookToolTip = "Toggle CrossHotbar camera look handling and mouse mode for GamePad controls.",
   mouseLookToolTip = "Toggle mouse look handling. Enabling allows camera look control for keyboard binding setup.",
   deviceToolTip = "The DeviceId of the gamepad.",
   leftclickToolTip = "Left click binding for mouse mode.",
   rightclickToolTip = "Right click binding for mouse mode."
}


local ConfigUI = {
   preset = 0,
   Inset = 16,
   ConfigSpacing = 20,
   TextHeight = 20,
   SymbolHeight = 32,
   SymbolWidth = 32,
   ButtonWidth = 80,
   ButtonHeight = 24,
   TabWidth = 64,
   TabHeight = 32,
   DropDownSpacing = 20,
   EditBoxHeight = 30,
   EditBoxSpacing = 30,
   InterfaceFrame = nil,
   RefreshCallbacks = {}
}

local function FilterDropDownText(name)
   if name == "NONE" then
      return ""
   else
      return name
   end
end

local function ActionsAvailable(button, prefix, ActionType)
   if prefix .. ActionType ~= "ACTION" then
      if prefix == button then
         return false
      end
      if config.PadActions[button]["ACTION"] == "LEFTHOTBAR" or
         config.PadActions[button]["ACTION"] == "RIGHTHOTBAR" then
         return false
      end
   end
   return true
end

function ConfigUI:AddToolTip(frame, text, wrap)
   frame:SetScript("OnEnter", function(self)
     GameTooltip:SetOwner(self, "ANCHOR_TOP")
     GameTooltip:ClearLines()
     GameTooltip:SetText(text, 1, 1, 1, 1, wrap)
   end)
   frame:SetScript("OnLeave", function(self)
     GameTooltip:SetOwner(WorldFrame, "ANCHOR_LEFT")
     GameTooltip:ClearLines()
   end)
end

function ConfigUI:Refresh(updated)
   if self.InterfaceFrame:IsVisible() or
      self.PresetFrame:IsVisible() or
      self.ActionFrame:IsVisible() or
      self.HotbarFrame:IsVisible() or
      self.GamePadFrame:IsVisible() then 
      for i,callback in ipairs(self.RefreshCallbacks) do
         callback()
      end
      addon:ApplyConfig(updated)
   end
end

function ConfigUI:OnConfigInit()
   ConfigUI.preset = CrossHotbar_DB.ActivePreset 
end

function ConfigUI:CreateFrame()
   self.InterfaceFrame = CreateFrame("Frame", ADDON .. "ConfigFrame", InterfaceOptionsFramePanelContainer)
   self.InterfaceFrame.name = ADDON
   self.InterfaceFrame:Hide()

   addon:AddInitCallback(GenerateClosure(self.OnConfigInit, self))

   self.InterfaceFrame:SetScript("OnShow", function(InterfaceFrame)
      local title = InterfaceFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
      title:SetPoint("TOPLEFT", self.Inset, -self.Inset)
      title:SetText("CrossHotbar")

      local authortitle = InterfaceFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
      authortitle:SetPoint("TOPLEFT", title, "TOPLEFT", 0, -2 * self.ConfigSpacing)
      authortitle:SetText("Author")
      
      local author = InterfaceFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
      author:SetPoint("TOPLEFT", authortitle, "TOPLEFT", self.Inset, -self.TextHeight)
      author:SetWidth(InterfaceFrame:GetWidth() - 4 * self.Inset)
      author:SetJustifyH("LEFT")
      author:SetText("ChainStratagem (phodoe)")
      author:SetTextColor(1,1,1,1)
      
      local descripttitle = InterfaceFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
      descripttitle:SetPoint("TOPLEFT", author, "TOPLEFT", -self.Inset, -self.ConfigSpacing)
      descripttitle:SetText("Description")
      
      local descript = InterfaceFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
      descript:SetPoint("TOPLEFT", descripttitle, "TOPLEFT", self.Inset, -self.TextHeight)
      descript:SetWidth(InterfaceFrame:GetWidth() - 4 * self.Inset)
      descript:SetJustifyH("LEFT")
      descript:SetText([[
Addon to reconfigure default Actionbars into the WXHB Crosshotbar found in FFXIV.

Features:

         -Left and right hotbar selection with extended right-left and left-right back hotbars.
         -Double click expands hotbar and maps actions buttons[9-12] onto face buttons.
         -Reconfigurable modifier buttons to override default action settings.
         -Target traversal with trigger shoulder pad combinations.
         -Unit raid and party navigation actions for dpad party traversal.
         -Cursor and camera look support through bindable actions.
         -Actions to execute user macros named CH_MACRO_[1-4]
         -Drag bar activated by clicking on the hotbar seperator line.

Settings:

         Presets: Load and Save controler settings, bindings, and actions.
         Actions: Set button bindings and action assignments.
         Hotbars: Hotbar specific settings controlling paging and display.
         GamePad: Gamepad settings with camera and cursor controls.
]])
      descript:SetTextColor(1,1,1,1)
      
      InterfaceFrame:SetScript("OnShow", function(frame) ConfigUI:Refresh() end) 
      ConfigUI:Refresh()
   end)

   local category, layout = Settings.RegisterCanvasLayoutCategory(self.InterfaceFrame,
                                                                  self.InterfaceFrame.name)
   Settings.RegisterAddOnCategory(category)
   
   self.PresetFrame = CreateFrame("Frame", ADDON .. "PresetsSettings", self.InterfaceFrame)
   self.PresetFrame.name = "Presets"
   self.PresetFrame.parent = self.InterfaceFrame.name
   self.PresetFrame:Hide()
   
   self.PresetFrame:SetScript("OnShow", function(PresetFrame)
      local title = PresetFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
      title:SetPoint("TOPLEFT", self.Inset, -self.Inset)
      title:SetText("Presets")
      local anchor = title
      anchor = ConfigUI:CreatePresets(PresetFrame, anchor)
      PresetFrame:SetScript("OnShow", function(frame) ConfigUI:Refresh() end) 
      ConfigUI:Refresh()
   end)
   
   Settings.RegisterCanvasLayoutSubcategory(category,
                                            self.PresetFrame,
                                            self.PresetFrame.name)
   
   self.ActionFrame = CreateFrame("Frame", ADDON .. "ActionsSettings", self.InterfaceFrame)
   self.ActionFrame.name = "Actions"
   self.ActionFrame.parent = self.InterfaceFrame.name
   self.ActionFrame:Hide()

   self.ActionFrame:SetScript("OnShow", function(ActionFrame)
      local scrollFrame = CreateFrame("ScrollFrame", nil, ActionFrame, "UIPanelScrollFrameTemplate")
      scrollFrame:SetPoint("TOPLEFT", 3, -4)
      scrollFrame:SetPoint("BOTTOMRIGHT", -27, 4)
      
      local scrollChild = CreateFrame("Frame")
      scrollFrame:SetScrollChild(scrollChild)
      scrollChild:SetWidth(ActionFrame:GetWidth()-self.Inset)
      scrollChild:SetHeight(1)
      
      local title = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
      title:SetPoint("TOPLEFT", self.Inset, -self.Inset)
      title:SetText("Actions Settings")
      
      local anchor = title
      anchor = ConfigUI:CreatePadBindings(scrollChild, anchor)
      
      anchor, tab1, tab2, tab3, tab4, tab5 =
         ConfigUI:CreateTabFrame(scrollChild, anchor)

      ConfigUI:CreatePadActions(tab1, tab1, "", GamePadActionMap, GamePadHotbarMap)
      ConfigUI:CreatePadActions(tab2, tab2, "SPADL", GamePadModifierActionMap, GamePadHotbarMap)
      ConfigUI:CreatePadActions(tab3, tab3, "SPADR", GamePadModifierActionMap, GamePadHotbarMap)
      ConfigUI:CreatePadActions(tab4, tab4, "PPADL", GamePadModifierActionMap, GamePadHotbarMap)
      ConfigUI:CreatePadActions(tab5, tab5, "PPADR", GamePadModifierActionMap, GamePadHotbarMap)

      table.insert(self.RefreshCallbacks, function()
         local spadlactive = false
         local spadractive = false
         local ppadlactive = false
         local ppadractive = false
         for i,button in ipairs(GamePadButtonList) do
            if config.PadActions[button].ACTION == "LEFTSHOULDER" then spadlactive = true end
            if config.PadActions[button].ACTION == "RIGHTSHOULDER" then spadractive = true end
            if config.PadActions[button].ACTION == "LEFTPADDLE" then ppadlactive = true end
            if config.PadActions[button].ACTION == "RIGHTPADDLE" then ppadractive = true end
         end
         PanelTemplates_SetTabEnabled(anchor, 2, spadlactive)
         PanelTemplates_SetTabEnabled(anchor, 3, spadractive)
         PanelTemplates_SetTabEnabled(anchor, 4, ppadlactive)
         PanelTemplates_SetTabEnabled(anchor, 5, ppadractive)
      end)
      
      ActionFrame:SetScript("OnShow", function(frame) ConfigUI:Refresh() end) 
      ConfigUI:Refresh()
   end)

   Settings.RegisterCanvasLayoutSubcategory(category,
                                            self.ActionFrame,
                                            self.ActionFrame.name)
   
   self.HotbarFrame = CreateFrame("Frame", ADDON .. "HotbarsSettings", self.InterfaceFrame)
   self.HotbarFrame.name = "Hotbars"
   self.HotbarFrame.parent = self.InterfaceFrame.name
   self.HotbarFrame:Hide()

   self.HotbarFrame:SetScript("OnShow", function(HotbarFrame)
      local scrollFrame = CreateFrame("ScrollFrame", nil, HotbarFrame, "UIPanelScrollFrameTemplate")
      scrollFrame:SetPoint("TOPLEFT", 3, -4)
      scrollFrame:SetPoint("BOTTOMRIGHT", -27, 4)
      
      local scrollChild = CreateFrame("Frame")
      scrollFrame:SetScrollChild(scrollChild)
      scrollChild:SetWidth(HotbarFrame:GetWidth()-self.Inset)
      scrollChild:SetHeight(1)
      
      local title = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
      title:SetPoint("TOPLEFT", self.Inset, -self.Inset)
      title:SetText("Hotbar Settings")
      
      local anchor = title
  
      anchor = ConfigUI:CreateHotbarSettings(scrollChild, anchor)
      
      HotbarFrame:SetScript("OnShow", function(frame) ConfigUI:Refresh() end) 
      ConfigUI:Refresh()
   end)
   
   Settings.RegisterCanvasLayoutSubcategory(category,
                                            self.HotbarFrame,
                                            self.HotbarFrame.name)
   
   self.GamePadFrame = CreateFrame("Frame", ADDON .. "GamePadSettings", self.InterfaceFrame)
   self.GamePadFrame.name = "GamePad"
   self.GamePadFrame.parent = self.InterfaceFrame.name
   self.GamePadFrame:Hide()

   self.GamePadFrame:SetScript("OnShow", function(GamePadFrame)
      local title = GamePadFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
      title:SetPoint("TOPLEFT", self.Inset, -self.Inset)
      title:SetText("GamePad Settings")
      
      local anchor = title
      anchor = ConfigUI:CreateGamePadSettings(GamePadFrame, anchor)
      
      GamePadFrame:SetScript("OnShow", function(frame) ConfigUI:Refresh() end) 
      ConfigUI:Refresh()
   end)      

   Settings.RegisterCanvasLayoutSubcategory(category,
                                            self.GamePadFrame,
                                            self.GamePadFrame.name)

   SLASH_CROSSHOTBAR1, SLASH_CROSSHOTBAR2 = '/chb', '/wxhb';
   local function slashcmd(msg, editBox)
      Settings.OpenToCategory(category:GetID())
   end
   SlashCmdList["CROSSHOTBAR"] = slashcmd;

end


function ConfigUI:CreateTabFrame(configFrame, anchorFrame)

   local tabframe = CreateFrame("Frame", ADDON .. "ActionTabFrame", configFrame, "BackdropTemplate")
   tabframe:EnableMouse(true)
   tabframe:SetHeight(anchorFrame:GetHeight())
   tabframe:SetWidth(2*(configFrame:GetWidth() - 2*self.Inset)/3)
   tabframe:SetBackdropColor(0, 0, 1, .5)

   tabframe:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT", 0, 0)

   tabframe:SetBackdrop({
        bgFile="Interface/DialogFrame/UI-DialogBox-Background",
        edgeFile="Interface/DialogFrame/UI-DialogBox-Gold-Border",
	tile = false,
	tileEdge = false,
	tileSize = 0,
	edgeSize = 16,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
   })

   local tab1frame = CreateFrame("Frame", tabframe:GetName() .. "Page1", tabframe)
   tab1frame:SetPoint("TOPLEFT", tabframe, "TOPLEFT", 0, 0)
   tab1frame:SetHeight(tabframe:GetHeight())
   tab1frame:SetWidth(tabframe:GetWidth())
   
   local tab2frame = CreateFrame("Frame", tabframe:GetName() .. "Page2", tabframe)
   tab2frame:SetPoint("TOPLEFT", tabframe, "TOPLEFT", 0, 0)
   tab2frame:SetHeight(tabframe:GetHeight())
   tab2frame:SetWidth(tabframe:GetWidth())

   local tab3frame = CreateFrame("Frame", tabframe:GetName() .. "Page3", tabframe)
   tab3frame:SetPoint("TOPLEFT", tabframe, "TOPLEFT", 0, 0)
   tab3frame:SetHeight(tabframe:GetHeight())
   tab3frame:SetWidth(tabframe:GetWidth())

   local tab4frame = CreateFrame("Frame", tabframe:GetName() .. "Page4", tabframe)
   tab4frame:SetPoint("TOPLEFT", tabframe, "TOPLEFT", 0, 0)
   tab4frame:SetHeight(tabframe:GetHeight())
   tab4frame:SetWidth(tabframe:GetWidth())

   local tab5frame = CreateFrame("Frame", tabframe:GetName() .. "Page5", tabframe)
   tab5frame:SetPoint("TOPLEFT", tabframe, "TOPLEFT", 0, 0)
   tab5frame:SetHeight(tabframe:GetHeight())
   tab5frame:SetWidth(tabframe:GetWidth())
   
   --[[
      Tab Default
   --]]

   local tab1button = CreateFrame("Button", tabframe:GetName() .. "Tab1", tabframe, "PanelTopTabButtonTemplate")
   tab1button:SetPoint("BOTTOMLEFT", tabframe, "TOPLEFT", 0, 0)
   tab1button:SetHeight(self.TabHeight)
   tab1button:SetWidth(self.TabWidth)
   tab1button:SetText("DEFAULT")
   tab1button:SetID(1)

   ConfigUI:AddToolTip(tab1button, Locale.defaultTabToolTip, true)
            
   tab1button:SetScript("OnClick", function(self)
       PanelTemplates_SetTab(tabframe, 1)
       tab1frame:Show()
       tab2frame:Hide()
       tab3frame:Hide()
       tab4frame:Hide()
       tab5frame:Hide()
   end)
   
   --[[
      Tab Left Shoulder
   --]]
   
   local tab2button = CreateFrame("Button", tabframe:GetName() .. "Tab2", tabframe, "PanelTopTabButtonTemplate")
   tab2button:SetPoint("TOPLEFT", tab1button, "TOPRIGHT", 0, 0)
   tab2button:SetHeight(self.TabHeight)
   tab2button:SetWidth(self.TabWidth)
   tab2button:SetText("SPADL")
   tab2button:SetID(2)
   
   ConfigUI:AddToolTip(tab2button, Locale.spadlTabToolTip, true)
   
   tab2button:SetScript("OnClick", function(self)
       PanelTemplates_SetTab(tabframe, 2)
       tab1frame:Hide()
       tab2frame:Show()
       tab3frame:Hide()
       tab4frame:Hide()
       tab5frame:Hide()
   end)
   
   --[[
      Tab Right Shoulder
   --]]
   
   local tab3button = CreateFrame("Button", tabframe:GetName() .. "Tab3", tabframe, "PanelTopTabButtonTemplate")
   tab3button:SetPoint("TOPLEFT", tab2button, "TOPRIGHT", 0, 0)
   tab3button:SetHeight(self.TabHeight)
   tab3button:SetWidth(self.TabWidth)
   tab3button:SetText("SPADR")
   tab3button:SetID(3)

   ConfigUI:AddToolTip(tab3button, Locale.spadrTabToolTip, true)
   
   tab3button:SetScript("OnClick", function(self)
       PanelTemplates_SetTab(tabframe, 3)
       tab1frame:Hide()
       tab2frame:Hide()
       tab3frame:Show()
       tab4frame:Hide()
       tab5frame:Hide()
   end)
   
   --[[
      Tab Left Paddle
   --]]

   local tab4button = CreateFrame("Button", tabframe:GetName() .. "Tab4", tabframe, "PanelTopTabButtonTemplate")
   tab4button:SetPoint("TOPLEFT", tab3button, "TOPRIGHT", 0, 0)
   tab4button:SetHeight(self.TabHeight)
   tab4button:SetWidth(self.TabWidth)
   tab4button:SetText("PPADL")
   tab4button:SetID(4)

   ConfigUI:AddToolTip(tab4button, Locale.ppadlTabToolTip, true)

   tab4button:SetScript("OnClick", function(self)
       PanelTemplates_SetTab(tabframe, 4)
       tab1frame:Hide()
       tab2frame:Hide()
       tab3frame:Hide()
       tab4frame:Show()
       tab5frame:Hide()
   end)
   
   --[[
      Tab Right Paddle
   --]]

   local tab5button = CreateFrame("Button", tabframe:GetName() .. "Tab5", tabframe, "PanelTopTabButtonTemplate")
   tab5button:SetPoint("TOPLEFT", tab4button, "TOPRIGHT", 0, 0)
   tab5button:SetHeight(self.TabHeight)
   tab5button:SetWidth(self.TabWidth)
   tab5button:SetText("PPADR")
   tab5button:SetID(5)

   ConfigUI:AddToolTip(tab5button, Locale.ppadrTabToolTip, true)

   tab5button:SetScript("OnClick", function(self)
       PanelTemplates_SetTab(tabframe, 5)
       tab1frame:Hide()
       tab2frame:Hide()
       tab3frame:Hide()
       tab4frame:Hide()
       tab5frame:Show()
   end)
   
   tabframe:SetScript("OnShow", function(self)
      PanelTemplates_SetTab(tabframe, 1)
      tab1frame:Show()
      tab2frame:Hide()
      tab3frame:Hide()
      tab4frame:Hide()
      tab5frame:Hide()
   end)

   PanelTemplates_SetNumTabs(tabframe, 5)
   PanelTemplates_SetTab(tabframe, 1)
   tab1frame:Show()
   tab2frame:Hide()
   tab3frame:Hide()
   tab4frame:Hide()
   tab5frame:Hide()
      
   return tabframe, tab1frame, tab2frame, tab3frame, tab4frame, tab5frame
end

--[[
   Presets
--]]

function ConfigUI:CreatePresets(configFrame, anchorFrame)
   local DropDownWidth = configFrame:GetWidth()/2 - 2*self.Inset
   local presetsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   presetsubtitle:SetHeight(self.TextHeight)
   presetsubtitle:SetWidth(DropDownWidth)
   presetsubtitle:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -self.ConfigSpacing)
   presetsubtitle:SetNonSpaceWrap(true)
   presetsubtitle:SetJustifyH("CENTER")
   presetsubtitle:SetJustifyV("TOP")
   presetsubtitle:SetText("Presets")

   local function IsSelected(index)
      return ConfigUI.preset == index;
   end
   
   local function SetSelected(index)
      ConfigUI.preset = index;
   end

   local function GeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Saved Presets");
      for i,p in ipairs(CrossHotbar_DB.Presets) do
         rootDescription:CreateRadio(p.Name, IsSelected, SetSelected, i);
      end
   end;

   local PresetsDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate");
   PresetsDropDown:SetDefaultText("Presets");
   PresetsDropDown:SetPoint("TOP", presetsubtitle, "BOTTOM", 0, 0)
   PresetsDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   PresetsDropDown:SetupMenu(GeneratorFunction);
   
   local presetloadbutton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
   presetloadbutton:SetPoint("TOPLEFT", PresetsDropDown, "TOPRIGHT", 24, 0)
   presetloadbutton:SetHeight(self.ButtonHeight)
   presetloadbutton:SetWidth(self.ButtonWidth)
   presetloadbutton:SetText("Load")
   
   presetloadbutton:SetScript("OnClick", function(self, button, down)
      CrossHotbar_DB.ActivePreset = ConfigUI.preset
      config:StorePreset(config, CrossHotbar_DB.Presets[ConfigUI.preset])
      ConfigUI:Refresh(true)
   end)
   
   local presetdeletebutton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
   presetdeletebutton:SetPoint("TOPLEFT", presetloadbutton, "TOPRIGHT", 0, 0)
   presetdeletebutton:SetHeight(self.ButtonHeight)
   presetdeletebutton:SetWidth(self.ButtonWidth)
   presetdeletebutton:SetEnabled(false)
   presetdeletebutton:SetText("Delete")

   presetdeletebutton:SetScript("OnClick", function(self, button, down)
      if CrossHotbar_DB.Presets[ConfigUI.preset].Mutable then
         table.remove(CrossHotbar_DB.Presets, ConfigUI.preset)
         ConfigUI.preset = ConfigUI.preset + 1
         if ConfigUI.preset > #CrossHotbar_DB.Presets then             
            ConfigUI.preset = #CrossHotbar_DB.Presets
         end
         CrossHotbar_DB.ActivePreset = ConfigUI.preset
      end
      config.Name = "Custom"
      config:StorePreset(config, CrossHotbar_DB.Presets[ConfigUI.preset])
   end)

   local filesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   filesubtitle:SetHeight(self.TextHeight)
   filesubtitle:SetWidth(DropDownWidth)
   filesubtitle:SetPoint("TOP", PresetsDropDown, "BOTTOM", 0, -self.ConfigSpacing)
   filesubtitle:SetNonSpaceWrap(true)
   filesubtitle:SetJustifyH("CENTER")
   filesubtitle:SetJustifyV("TOP")
   filesubtitle:SetText("Name")
   
   local presetfileeditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   presetfileeditbox:SetPoint("TOP", filesubtitle, "BOTTOM", 0, 0)
   presetfileeditbox:SetWidth(DropDownWidth-self.DropDownSpacing)
   presetfileeditbox:SetHeight(self.EditBoxHeight)
   presetfileeditbox:SetMovable(false)
   presetfileeditbox:SetAutoFocus(false)
   presetfileeditbox:EnableMouse(true)
   presetfileeditbox:SetText(config.Name)
   
   local presetsavebutton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
   presetsavebutton:SetPoint("LEFT", presetfileeditbox, "RIGHT", 24, 0)
   presetsavebutton:SetHeight(self.ButtonHeight)
   presetsavebutton:SetWidth(self.ButtonWidth)
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
            config:StorePreset(newpreset, config)
            table.insert(CrossHotbar_DB.Presets, newpreset)
            ConfigUI.preset = #CrossHotbar_DB.Presets
            CrossHotbar_DB.ActivePreset = ConfigUI.preset
         elseif CrossHotbar_DB.Presets[foundpreset].Mutable then
            ConfigUI.preset = foundpreset
            CrossHotbar_DB.ActivePreset = ConfigUI.preset
            config:StorePreset(CrossHotbar_DB.Presets[ConfigUI.preset], config)
         end
      end
      ConfigUI:Refresh(true)
   end)

   local descripttitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   descripttitle:SetPoint("TOPLEFT", presetfileeditbox, "BOTTOMLEFT", 0, -4*self.ConfigSpacing)
   descripttitle:SetWidth(2*DropDownWidth-self.DropDownSpacing)
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
   
   backdropframe:SetPoint("TOPLEFT", descripttitle, "BOTTOMLEFT", 0, -self.ConfigSpacing)
   backdropframe:SetSize(2*DropDownWidth-self.DropDownSpacing, 200)
   
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
   
   table.insert(self.RefreshCallbacks, function()
                   PresetsDropDown:GenerateMenu()
                   presetdeletebutton:SetEnabled(CrossHotbar_DB.Presets[ConfigUI.preset].Mutable)
                   presetfileeditbox:SetText(config.Name)
                   descriptfileeditbox:SetText(config.Description)
                end)
   
   return PresetsDropDown
end

--[[
   Pad bindings.
--]]

function ConfigUI:CreatePadBindings(configFrame, anchorFrame)
   local DropDownWidth = configFrame:GetWidth()/3 - self.SymbolWidth - self.DropDownSpacing - 2*self.Inset

   local bindingframe = CreateFrame("Frame", nil, configFrame, "BackdropTemplate")
   bindingframe:EnableMouse(true)
   bindingframe:SetHeight(#GamePadButtonList * 32 + 2*self.TextHeight + self.ConfigSpacing)
   --bindingframe:SetWidth(self.SymbolWidth + DropDownWidth + self.DropDownSpacing + 2*self.Inset)
   bindingframe:SetWidth((configFrame:GetWidth() - 2*self.Inset)/3)
   bindingframe:SetBackdropColor(0, 0, 1, .5)
   bindingframe:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -self.ConfigSpacing -anchorFrame:GetHeight())

   bindingframe:SetBackdrop({
        bgFile="Interface/DialogFrame/UI-DialogBox-Background",
        edgeFile="Interface/DialogFrame/UI-DialogBox-Border",
	tile = false,
	tileEdge = false,
	tileSize = 0,
	edgeSize = 16,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
   })

   local buttonsubtitle = bindingframe:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   buttonsubtitle:SetHeight(self.TextHeight)
   buttonsubtitle:SetWidth(self.SymbolWidth+self.Inset)
   buttonsubtitle:SetPoint("TOPLEFT", bindingframe, "TOPLEFT", self.Inset, -self.ConfigSpacing)
   buttonsubtitle:SetNonSpaceWrap(true)
   buttonsubtitle:SetJustifyH("CENTER")
   buttonsubtitle:SetJustifyV("TOP")
   buttonsubtitle:SetText("Button")
   
   local bindingsubtitle = bindingframe:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   bindingsubtitle:SetHeight(self.TextHeight)
   bindingsubtitle:SetWidth(DropDownWidth)
   bindingsubtitle:SetPoint("TOPLEFT", buttonsubtitle, "TOPRIGHT", 0, 0)
   bindingsubtitle:SetNonSpaceWrap(true)
   bindingsubtitle:SetJustifyH("CENTER")
   bindingsubtitle:SetJustifyV("TOP")
   bindingsubtitle:SetText("Binding")

   local buttoninset = self.Inset
   local buttonanchor = buttonsubtitle
   local bindinganchor = bindingsubtitle
   for i,button in ipairs(GamePadButtonList) do
      if config.PadActions[button] then
         local attributes = config.PadActions[button]
         local buttonsubtitle = bindingframe:CreateFontString(nil, "ARTWORK", "GameFontNormal")
         buttonsubtitle:SetHeight(32)
         buttonsubtitle:SetWidth(self.SymbolWidth)
         buttonsubtitle:SetPoint("TOPLEFT", buttonanchor, "BOTTOMLEFT", 0.5*buttoninset, 0)
         buttonsubtitle:SetNonSpaceWrap(true)
         buttonsubtitle:SetJustifyH("CENTER")
         buttonsubtitle:SetJustifyV("TOP")
         buttonsubtitle:SetText(addon:GetButtonIcon(button))
         buttonsubtitle:SetScript("OnShow", function(frame) buttonsubtitle:SetText(addon:GetButtonIcon(button)) end) 

         local function IsSelected(binding)
            return config.PadActions[button].BIND == binding;
         end
         
         local function SetSelected(binding)
            if binding ~= "NONE" then
               for btn, attributes in pairs(config.PadActions) do
                  if btn ~= arg1 then
                     if attributes.BIND == binding then
                        config.PadActions[btn].BIND = "NONE"
                        break
                     end
                  end
               end
            end
            config.PadActions[button].BIND = binding;
            ConfigUI:Refresh(true)
         end

         local function GeneratorFunction(owner, rootDescription)
            rootDescription:CreateTitle("Bindings");
            for _,binding in ipairs(GamePadBindingList) do
               rootDescription:CreateRadio(binding, IsSelected, SetSelected, binding);
            end
         end;
         
         local BindingDropDown = CreateFrame("DropdownButton", nil, bindingframe, "WowStyle1DropdownTemplate");
         BindingDropDown:SetDefaultText("NONE");
         BindingDropDown:SetPoint("TOP", bindinganchor, "BOTTOM", 0, 0)
         BindingDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
         BindingDropDown:SetHeight(buttonsubtitle:GetHeight())
         BindingDropDown:SetupMenu(GeneratorFunction);
         
         table.insert(self.RefreshCallbacks, function() BindingDropDown:GenerateMenu() end)
         
         ConfigUI:AddToolTip(BindingDropDown, Locale.bindingToolTip, true)
         
         buttoninset = 0
         buttonanchor = buttonsubtitle
         bindinganchor = BindingDropDown
      end
   end
   
   return bindingframe
end

--[[
   Pad actions.
--]]

function ConfigUI:CreatePadActions(configFrame, anchorFrame, prefix, ActionMap, HotbarMap)
   local DropDownWidth = configFrame:GetWidth()/2 - self.DropDownSpacing 

   local actionsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   actionsubtitle:SetHeight(self.TextHeight)
   actionsubtitle:SetWidth(DropDownWidth)
   actionsubtitle:SetPoint("TOPLEFT", anchorFrame, "TOPLEFT", self.Inset, -self.ConfigSpacing)
   actionsubtitle:SetNonSpaceWrap(true)
   actionsubtitle:SetJustifyH("CENTER")
   actionsubtitle:SetJustifyV("TOP")
   actionsubtitle:SetText("Action")

   local hotbarsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   hotbarsubtitle:SetHeight(self.TextHeight)
   hotbarsubtitle:SetWidth(DropDownWidth)
   hotbarsubtitle:SetPoint("TOPLEFT", actionsubtitle, "TOPRIGHT", 0, 0)
   hotbarsubtitle:SetNonSpaceWrap(true)
   hotbarsubtitle:SetJustifyH("CENTER")
   hotbarsubtitle:SetJustifyV("TOP")
   hotbarsubtitle:SetText("Hotbar Action")

   local actionanchor = actionsubtitle
   local hotbaranchor = hotbarsubtitle
   for i,button in ipairs(GamePadButtonList) do
      if config.PadActions[button] then

         local function IsActionSelected(action)
            return config.PadActions[button][prefix .. "ACTION"] == action;
         end
         
         local function SetActionSelected(action)
            if action ~= "NONE" then
               for btn, attributes in pairs(config.PadActions) do
                  if btn ~= button then
                     if attributes[prefix .. "ACTION"] == action then
                        config.PadActions[btn][prefix .. "ACTION"] = "NONE"
                        break
                     end
                  end
               end
            end
            config.PadActions[button][prefix .. "ACTION"] = action;
            ConfigUI:Refresh(true)
         end

         local function ActionGeneratorFunction(owner, rootDescription)
            rootDescription:CreateTitle("Actions");
            local actions = {"NONE"}
            if ActionsAvailable(button, prefix, "ACTION") then
               actions = ActionMap[button]
            end
            for _,action in ipairs(actions) do
               rootDescription:CreateRadio(action, IsActionSelected, SetActionSelected, action);
            end
         end;
         
         local ActionDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate");
         ActionDropDown:SetDefaultText("NONE");
         ActionDropDown:SetPoint("TOP", actionanchor, "BOTTOM", 0, 0)
         ActionDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
         ActionDropDown:SetHeight(32)
         ActionDropDown:SetupMenu(ActionGeneratorFunction);
         
         ConfigUI:AddToolTip(ActionDropDown, Locale.actionToolTip, true)
         table.insert(self.RefreshCallbacks, function() ActionDropDown:GenerateMenu() end)

         local function IsHotbarActionSelected(action)
            return config.PadActions[button][prefix .. "TRIGACTION"] == action;
         end
         
         local function SetHotbarActionSelected(action)
            if action ~= "NONE" then
               for btn, attributes in pairs(config.PadActions) do
                  if btn ~= button then
                     if attributes[prefix .. "TRIGACTION"] == action then
                        config.PadActions[btn][prefix .. "TRIGACTION"] = "NONE"
                        break
                     end
                  end
               end
            end
            config.PadActions[button][prefix .. "TRIGACTION"] = action;
            ConfigUI:Refresh(true)
         end

         local function HotbarActionGeneratorFunction(owner, rootDescription)
            rootDescription:CreateTitle("Hotbar Actions");
            local actions = {"NONE"}
            if ActionsAvailable(button, prefix, "TRIGACTION") then
               actions = HotbarMap[button]
            end
            for _,action in ipairs(actions) do
               rootDescription:CreateRadio(action, IsHotbarActionSelected, SetHotbarActionSelected, action);
            end
         end;
         
         local HotbarActionDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate");
         HotbarActionDropDown:SetDefaultText("NONE");
         HotbarActionDropDown:SetPoint("TOP", hotbaranchor, "BOTTOM", 0, 0)
         HotbarActionDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
         HotbarActionDropDown:SetHeight(32)
         HotbarActionDropDown:SetupMenu(HotbarActionGeneratorFunction);
         
         ConfigUI:AddToolTip(HotbarActionDropDown, Locale.hotbaractionToolTip, true)
         table.insert(self.RefreshCallbacks, function() HotbarActionDropDown:GenerateMenu() end)
         
         actionanchor = ActionDropDown
         hotbaranchor = HotbarActionDropDown
      end
   end
   
   return buttonanchor
end

--[[
   Hotbar settings.
--]]  

function ConfigUI:CreateHotbarSettings(configFrame, anchorFrame)

   local hbartypestr = {
      ["LIBA"] = "Create hotbars internally.",
      ["BLIZ"] = "Reuse Blizzard actionbars.",
   }

   local hkeytypestr = {
      ["_SHP"] = "Use shapes for button icons.",
      ["_LTR"] = "Use letters for button icons.",
   }
   
   local wxhbtypestr = {
      ["HIDE"] = "Hide extra actions when not active",
      ["FADE"] = "Fade extra actions when not active",
      ["SHOW"] = "Show extra actions when not active"
   }

   local ddaatypestr = {
      ["DADA"] = "DPad + Action / DPad + Action",
      ["DDAA"] = "DPad + DPad / Action + Action"
   }
   
   local DropDownWidth = (configFrame:GetWidth() - 2*self.Inset)/2

   local featuresubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
   featuresubtitle:SetHeight(self.TextHeight)
   featuresubtitle:SetWidth(DropDownWidth)
   featuresubtitle:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -self.ConfigSpacing)
   featuresubtitle:SetNonSpaceWrap(true)
   featuresubtitle:SetJustifyH("Left")
   featuresubtitle:SetJustifyV("TOP")
   featuresubtitle:SetText("Features")

   --[[
      Hotbar button type
   --]]
   
   local hbarsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   hbarsubtitle:SetHeight(self.TextHeight)
   hbarsubtitle:SetWidth(DropDownWidth)
   hbarsubtitle:SetPoint("TOPLEFT", featuresubtitle, "BOTTOMLEFT", 0, -self.ConfigSpacing)
   hbarsubtitle:SetNonSpaceWrap(true)
   hbarsubtitle:SetJustifyH("CENTER")
   hbarsubtitle:SetJustifyV("TOP")
   hbarsubtitle:SetText("Hotbar Type")

   local function IsHBarTypeSelected(type)
      return CrossHotbar_DB.HBARType == type
   end
   
   local function SetHBarTypeSelected(type)
      CrossHotbar_DB.HBARType = type
      ConfigUI:Refresh(true)
   end

   local function HBarTypeGeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Hotbar Types");
      for i,hbartype in ipairs(addon.HotbarHBARTypes) do
         rootDescription:CreateRadio(hbartypestr[hbartype], IsHBarTypeSelected, SetHBarTypeSelected, hbartype);
      end
   end;

   local HBarDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate");
   HBarDropDown:SetDefaultText("Hotbar Type");
   HBarDropDown:SetPoint("TOP", hbarsubtitle, "BOTTOM", 0, 0)
   HBarDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   HBarDropDown:SetupMenu(HBarTypeGeneratorFunction);
   
   ConfigUI:AddToolTip(HBarDropDown, Locale.hotbarTypeToolTip, true)
   
   --[[
      HKEY hotbar button layout
   --]]    

   local hkeysubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   hkeysubtitle:SetHeight(self.TextHeight)
   hkeysubtitle:SetWidth(DropDownWidth)
   hkeysubtitle:SetPoint("TOPLEFT", hbarsubtitle, "TOPRIGHT", 0, 0)
   hkeysubtitle:SetNonSpaceWrap(true)
   hkeysubtitle:SetJustifyH("CENTER")
   hkeysubtitle:SetJustifyV("TOP")
   hkeysubtitle:SetText("HotKey Type")

   local function IsHKeyTypeSelected(type)
      return config.Hotbar.HKEYType == type
   end
   
   local function SetHKeyTypeSelected(type)
      config.Hotbar.HKEYType = type
      ConfigUI:Refresh(true)
   end

   local function HKeyTypeGeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Hotbar Types");
      for i,hkeytype in ipairs(addon.HotbarHKEYTypes) do
         rootDescription:CreateRadio(hkeytypestr[hkeytype], IsHKeyTypeSelected, SetHKeyTypeSelected, hkeytype);
      end
   end;

   local HKeyDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate");
   HKeyDropDown:SetDefaultText("Hotkey Type");
   HKeyDropDown:SetPoint("TOP", hkeysubtitle, "BOTTOM", 0, 0)
   HKeyDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   HKeyDropDown:SetupMenu(HKeyTypeGeneratorFunction);
   
   ConfigUI:AddToolTip(HKeyDropDown, Locale.hotkeyTypeToolTip, true)
   
   --[[
      Expanded button settings
   --]]
   
   local wxhbsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   wxhbsubtitle:SetHeight(self.TextHeight)
   wxhbsubtitle:SetWidth(DropDownWidth)
   wxhbsubtitle:SetPoint("TOP", HBarDropDown, "BOTTOM", 0, -self.ConfigSpacing)
   wxhbsubtitle:SetNonSpaceWrap(true)
   wxhbsubtitle:SetJustifyH("CENTER")
   wxhbsubtitle:SetJustifyV("TOP")
   wxhbsubtitle:SetText("Expanded Type")

   local function IsWXHBTypeSelected(type)
      return config.Hotbar.WXHBType == type
   end
   
   local function SetWXHBTypeSelected(type)
      config.Hotbar.WXHBType = type
      ConfigUI:Refresh(true)
   end

   local function WXHBTypeGeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Expand Types");
      for i,wxhbtype in ipairs(addon.HotbarWXHBTypes) do
         rootDescription:CreateRadio(wxhbtypestr[wxhbtype], IsWXHBTypeSelected, SetWXHBTypeSelected, wxhbtype);
      end
   end;

   local WXHBDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate");
   WXHBDropDown:SetDefaultText("Expand Types");
   WXHBDropDown:SetPoint("TOP", wxhbsubtitle, "BOTTOM", 0, 0)
   WXHBDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   WXHBDropDown:SetupMenu(WXHBTypeGeneratorFunction);
   
   ConfigUI:AddToolTip(WXHBDropDown, Locale.expandedTypeToolTip, true)

   --[[
      DDAA hotbar button layout
   --]]    

   local ddaasubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   ddaasubtitle:SetHeight(self.TextHeight)
   ddaasubtitle:SetWidth(DropDownWidth)
   ddaasubtitle:SetPoint("TOPLEFT", wxhbsubtitle, "TOPRIGHT", 0, 0)
   ddaasubtitle:SetNonSpaceWrap(true)
   ddaasubtitle:SetJustifyH("CENTER")
   ddaasubtitle:SetJustifyV("TOP")
   ddaasubtitle:SetText("Hotbar Layout")

   local function IsDDAATypeSelected(type)
      return config.Hotbar.DDAAType == type
   end
   
   local function SetDDAATypeSelected(type)
      config.Hotbar.DDAAType = type
      ConfigUI:Refresh(true)
   end

   local function DDAATypeGeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Expand Types");
      for i,ddaatype in ipairs(addon.HotbarDDAATypes) do
         rootDescription:CreateRadio(ddaatypestr[ddaatype], IsDDAATypeSelected, SetDDAATypeSelected, ddaatype);
      end
   end;

   local DDAADropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate");
   DDAADropDown:SetDefaultText("Layout Types");
   DDAADropDown:SetPoint("TOP", ddaasubtitle, "BOTTOM", 0, 0)
   DDAADropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   DDAADropDown:SetupMenu(DDAATypeGeneratorFunction);
   
   ConfigUI:AddToolTip(DDAADropDown, Locale.dadaTypeToolTip, true)

   --[[
       Actionbar paging
   --]]    
   
   local actionpagesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
   actionpagesubtitle:SetHeight(self.TextHeight)
   actionpagesubtitle:SetWidth(DropDownWidth)
   actionpagesubtitle:SetPoint("TOP", WXHBDropDown, "BOTTOM", 0, -self.ConfigSpacing)
   actionpagesubtitle:SetNonSpaceWrap(true)
   actionpagesubtitle:SetJustifyH("Left")
   actionpagesubtitle:SetJustifyV("TOP")
   actionpagesubtitle:SetText("ActionPage")

   --[[
       LHotbar page index
   --]]    

   local lpagesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   lpagesubtitle:SetHeight(self.TextHeight)
   lpagesubtitle:SetWidth(DropDownWidth)
   lpagesubtitle:SetPoint("TOPLEFT", actionpagesubtitle, "BOTTOMLEFT", 0, -self.ConfigSpacing)
   lpagesubtitle:SetNonSpaceWrap(true)
   lpagesubtitle:SetJustifyH("CENTER")
   lpagesubtitle:SetJustifyV("TOP")
   lpagesubtitle:SetText("Left Hotbar ActionPage")

   local function IsLPageSelected(page)
      return config.Hotbar.LPageIndex == page
   end
   
   local function SetLPageSelected(page)
      config.Hotbar.LPageIndex = page
      ConfigUI:Refresh(true)
   end

   local function LPageGeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Action pages");
      for i = 1,10 do
         rootDescription:CreateRadio("ActionPage ".. i, IsLPageSelected, SetLPageSelected, i);
      end
   end;

   local LPageDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate");
   LPageDropDown:SetDefaultText("Action pages");
   LPageDropDown:SetPoint("TOP", lpagesubtitle, "BOTTOM", 0, 0)
   LPageDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   LPageDropDown:SetupMenu(LPageGeneratorFunction);
   
   ConfigUI:AddToolTip(LPageDropDown, Locale.pageIndexToolTip, true)

   --[[
       RHotbar page index
   --]]    

   local rpagesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   rpagesubtitle:SetHeight(self.TextHeight)
   rpagesubtitle:SetWidth(DropDownWidth)
   rpagesubtitle:SetPoint("TOPLEFT", lpagesubtitle, "TOPRIGHT", 0, 0)
   rpagesubtitle:SetNonSpaceWrap(true)
   rpagesubtitle:SetJustifyH("CENTER")
   rpagesubtitle:SetJustifyV("TOP")
   rpagesubtitle:SetText("Right Hotbar ActionPage")

   local function IsRPageSelected(page)
      return config.Hotbar.RPageIndex == page
   end
   
   local function SetRPageSelected(page)
      config.Hotbar.RPageIndex = page
      ConfigUI:Refresh(true)
   end

   local function RPageGeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Action pages");
      for i = 1,10 do
         rootDescription:CreateRadio("ActionPage ".. i, IsRPageSelected, SetRPageSelected, i);
      end
   end;

   local RPageDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate");
   RPageDropDown:SetDefaultText("Action pages");
   RPageDropDown:SetPoint("TOP", rpagesubtitle, "BOTTOM", 0, 0)
   RPageDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   RPageDropDown:SetupMenu(RPageGeneratorFunction);
   
   ConfigUI:AddToolTip(RPageDropDown, Locale.pageIndexToolTip, true)

   --[[
       LRHotbar page index
   --]]    

   local lrpagesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   lrpagesubtitle:SetHeight(self.TextHeight)
   lrpagesubtitle:SetWidth(DropDownWidth)
   lrpagesubtitle:SetPoint("TOP", LPageDropDown, "BOTTOM", 0, -self.ConfigSpacing)
   lrpagesubtitle:SetNonSpaceWrap(true)
   lrpagesubtitle:SetJustifyH("CENTER")
   lrpagesubtitle:SetJustifyV("TOP")
   lrpagesubtitle:SetText("Left Right Hotbar ActionPage")

   local function IsLRPageSelected(page)
      return config.Hotbar.LRPageIndex == page
   end
   
   local function SetLRPageSelected(page)
      config.Hotbar.LRPageIndex = page
      ConfigUI:Refresh(true)
   end

   local function LRPageGeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Action pages");
      for i = 1,10 do
         rootDescription:CreateRadio("ActionPage ".. i, IsLRPageSelected, SetLRPageSelected, i);
      end
   end;

   local LRPageDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate");
   LRPageDropDown:SetDefaultText("Action pages");
   LRPageDropDown:SetPoint("TOP", lrpagesubtitle, "BOTTOM", 0, 0)
   LRPageDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   LRPageDropDown:SetupMenu(LRPageGeneratorFunction);
   
   ConfigUI:AddToolTip(LRPageDropDown, Locale.pageIndexToolTip, true)

   --[[
       RLHotbar page index
   --]]    

   local rlpagesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   rlpagesubtitle:SetHeight(self.TextHeight)
   rlpagesubtitle:SetWidth(DropDownWidth)
   rlpagesubtitle:SetPoint("TOPLEFT", lrpagesubtitle, "TOPRIGHT", 0, 0)
   rlpagesubtitle:SetNonSpaceWrap(true)
   rlpagesubtitle:SetJustifyH("CENTER")
   rlpagesubtitle:SetJustifyV("TOP")
   rlpagesubtitle:SetText("Right Left Hotbar ActionPage")
   
   local function IsRLPageSelected(page)
      return config.Hotbar.RLPageIndex == page
   end
   
   local function SetRLPageSelected(page)
      config.Hotbar.RLPageIndex = page
      ConfigUI:Refresh(true)
   end

   local function RLPageGeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Action pages");
      for i = 1,10 do
         rootDescription:CreateRadio("ActionPage ".. i, IsRLPageSelected, SetRLPageSelected, i);
      end
   end;

   local RLPageDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate");
   RLPageDropDown:SetDefaultText("Action pages");
   RLPageDropDown:SetPoint("TOP", rlpagesubtitle, "BOTTOM", 0, 0)
   RLPageDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   RLPageDropDown:SetupMenu(RLPageGeneratorFunction);
   
   ConfigUI:AddToolTip(RLPageDropDown, Locale.pageIndexToolTip, true)

   local conditionalsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
   conditionalsubtitle:SetHeight(self.TextHeight)
   conditionalsubtitle:SetWidth(DropDownWidth)
   conditionalsubtitle:SetPoint("TOP", LRPageDropDown, "BOTTOM", 0, -self.ConfigSpacing)
   conditionalsubtitle:SetNonSpaceWrap(true)
   conditionalsubtitle:SetJustifyH("Left")
   conditionalsubtitle:SetJustifyV("TOP")
   conditionalsubtitle:SetText("Conditionals")
   
   --[[
       LHotbar page prefix
   --]]    

   local lpagepresubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   lpagepresubtitle:SetHeight(self.TextHeight)
   lpagepresubtitle:SetWidth(DropDownWidth)
   lpagepresubtitle:SetPoint("TOPLEFT", conditionalsubtitle, "BOTTOMLEFT", self.Inset, -self.ConfigSpacing)
   lpagepresubtitle:SetNonSpaceWrap(true)
   lpagepresubtitle:SetJustifyH("LEFT")
   lpagepresubtitle:SetJustifyV("TOP")
   lpagepresubtitle:SetText("Left hotbar page prefix")
   
   local lhotbareditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   lhotbareditbox:SetPoint("TOPLEFT", lpagepresubtitle, "BOTTOMLEFT", 0, 0)
   lhotbareditbox:SetWidth(2*DropDownWidth-self.DropDownSpacing)
   lhotbareditbox:SetHeight(self.EditBoxHeight)
   lhotbareditbox:SetMovable(false)
   lhotbareditbox:SetAutoFocus(false)
   lhotbareditbox:EnableMouse(true)
   lhotbareditbox:SetText(config.Hotbar.LPagePrefix)
   lhotbareditbox:SetScript("OnEditFocusLost", function(self)
      config.Hotbar.LPagePrefix = self:GetText()
      ConfigUI:Refresh(true)
   end)

   ConfigUI:AddToolTip(lhotbareditbox, Locale.pagePrefixToolTip, true)

   --[[
       RHotbar page prefix
   --]]    

   local rpagepresubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   rpagepresubtitle:SetHeight(self.TextHeight)
   rpagepresubtitle:SetWidth(DropDownWidth)
   rpagepresubtitle:SetPoint("TOPLEFT", lhotbareditbox, "BOTTOMLEFT", 0, -self.ConfigSpacing)
   rpagepresubtitle:SetNonSpaceWrap(true)
   rpagepresubtitle:SetJustifyH("LEFT")
   rpagepresubtitle:SetJustifyV("TOP")
   rpagepresubtitle:SetText("Right hotbar page prefix")
   
   local rhotbareditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   rhotbareditbox:SetPoint("TOPLEFT", rpagepresubtitle, "BOTTOMLEFT", 0, 0)
   rhotbareditbox:SetWidth(2*DropDownWidth-self.DropDownSpacing)
   rhotbareditbox:SetHeight(self.EditBoxHeight)
   rhotbareditbox:SetMovable(false)
   rhotbareditbox:SetAutoFocus(false)
   rhotbareditbox:EnableMouse(true)
   rhotbareditbox:SetText(config.Hotbar.RPagePrefix)
   rhotbareditbox:SetScript("OnEditFocusLost", function(self)
      config.Hotbar.RPagePrefix = self:GetText()
      ConfigUI:Refresh(true)
   end)

   ConfigUI:AddToolTip(rhotbareditbox, Locale.pagePrefixToolTip, true)

   --[[
       LRHotbar page prefix
   --]]    

   local lrpagepresubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   lrpagepresubtitle:SetHeight(self.TextHeight)
   lrpagepresubtitle:SetWidth(DropDownWidth)
   lrpagepresubtitle:SetPoint("TOPLEFT", rhotbareditbox, "BOTTOMLEFT", 0, -self.ConfigSpacing)
   lrpagepresubtitle:SetNonSpaceWrap(true)
   lrpagepresubtitle:SetJustifyH("LEFT")
   lrpagepresubtitle:SetJustifyV("TOP")
   lrpagepresubtitle:SetText("Left Right hotbar page prefix")
   
   local lrhotbareditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   lrhotbareditbox:SetPoint("TOPLEFT", lrpagepresubtitle, "BOTTOMLEFT", 0, 0)
   lrhotbareditbox:SetWidth(2*DropDownWidth-self.DropDownSpacing)
   lrhotbareditbox:SetHeight(self.EditBoxHeight)
   lrhotbareditbox:SetMovable(false)
   lrhotbareditbox:SetAutoFocus(false)
   lrhotbareditbox:EnableMouse(true)
   lrhotbareditbox:SetText(config.Hotbar.LRPagePrefix)
   lrhotbareditbox:SetScript("OnEditFocusLost", function(self)
      config.Hotbar.LRPagePrefix = self:GetText()
      ConfigUI:Refresh(true)
   end)

   ConfigUI:AddToolTip(lrhotbareditbox, Locale.pagePrefixToolTip, true)

   --[[
       RLHotbar page prefix
   --]]    

   local rlpagepresubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   rlpagepresubtitle:SetHeight(self.TextHeight)
   rlpagepresubtitle:SetWidth(DropDownWidth)
   rlpagepresubtitle:SetPoint("TOPLEFT", lrhotbareditbox, "BOTTOMLEFT", 0, -self.ConfigSpacing)
   rlpagepresubtitle:SetNonSpaceWrap(true)
   rlpagepresubtitle:SetJustifyH("LEFT")
   rlpagepresubtitle:SetJustifyV("TOP")
   rlpagepresubtitle:SetText("Right Left hotbar page prefix")
   
   local rlhotbareditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   rlhotbareditbox:SetPoint("TOPLEFT", rlpagepresubtitle, "BOTTOMLEFT", 0, 0)
   rlhotbareditbox:SetWidth(2*DropDownWidth-self.DropDownSpacing)
   rlhotbareditbox:SetHeight(self.EditBoxHeight)
   rlhotbareditbox:SetMovable(false)
   rlhotbareditbox:SetAutoFocus(false)
   rlhotbareditbox:EnableMouse(true)
   rlhotbareditbox:SetText(config.Hotbar.RPagePrefix)
   rlhotbareditbox:SetScript("OnEditFocusLost", function(self)
      config.Hotbar.RLPagePrefix = self:GetText()
      ConfigUI:Refresh(true)
   end)

   ConfigUI:AddToolTip(rlhotbareditbox, Locale.pagePrefixToolTip, true)

   table.insert(self.RefreshCallbacks, function()
                   HBarDropDown:GenerateMenu()
                   HKeyDropDown:GenerateMenu()
                   WXHBDropDown:GenerateMenu()
                   DDAADropDown:GenerateMenu()
                   LPageDropDown:GenerateMenu()
                   RPageDropDown:GenerateMenu()
                   LRPageDropDown:GenerateMenu()
                   LRPageDropDown:GenerateMenu()
                   lhotbareditbox:SetText(config.Hotbar.LPagePrefix)
                   rhotbareditbox:SetText(config.Hotbar.RPagePrefix)
                   lrhotbareditbox:SetText(config.Hotbar.LRPagePrefix)
                   rlhotbareditbox:SetText(config.Hotbar.RLPagePrefix)
   end)
   
   return rlhotbareditbox
end


--[[
   GamePad settings.
--]]  

function ConfigUI:CreateGamePadSettings(configFrame, anchorFrame)
   local OptionWidth = configFrame:GetWidth()/4 - 2*self.Inset
   local controlsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
   controlsubtitle:SetHeight(self.ButtonHeight)
   controlsubtitle:SetWidth(OptionWidth)
   controlsubtitle:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -self.ConfigSpacing)
   controlsubtitle:SetNonSpaceWrap(true)
   controlsubtitle:SetJustifyH("Left")
   controlsubtitle:SetJustifyV("TOP")
   controlsubtitle:SetText("Controls")

   --[[
      GamePadEnable
   --]]
   
   local gamepadenablesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   gamepadenablesubtitle:SetHeight(self.ButtonHeight)
   gamepadenablesubtitle:SetWidth(OptionWidth)
   gamepadenablesubtitle:SetPoint("TOPLEFT", controlsubtitle, "BOTTOMLEFT", self.Inset, -self.ConfigSpacing)
   gamepadenablesubtitle:SetNonSpaceWrap(true)
   gamepadenablesubtitle:SetJustifyH("CENTER")
   gamepadenablesubtitle:SetJustifyV("TOP")
   gamepadenablesubtitle:SetText("GamePadEnable")
   
   local gamepadenablebutton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
   gamepadenablebutton:SetPoint("TOPLEFT", gamepadenablesubtitle, "BOTTOMLEFT", 0, 0)
   gamepadenablebutton:SetHeight(self.ButtonHeight)
   gamepadenablebutton:SetWidth(OptionWidth)

   if GetCVar('GamePadEnable') == "0" then
      gamepadenablebutton:SetText("Enable")
   else
      gamepadenablebutton:SetText("Disable")
   end
   
   gamepadenablebutton:SetScript("OnClick", function(self, button, down)
      CrossHotbar_DB.GPEnable = config.GPEnable
      ConfigUI:Refresh(true)
   end)

   ConfigUI:AddToolTip(gamepadenablebutton, Locale.enabeGamePadToolTip, true)
   
   --[[
      CVars Enable
   --]]

   local cvarenablesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   cvarenablesubtitle:SetHeight(self.ButtonHeight)
   cvarenablesubtitle:SetWidth(OptionWidth)
   cvarenablesubtitle:SetPoint("TOPLEFT", gamepadenablesubtitle, "TOPRIGHT", 0, 0)
   cvarenablesubtitle:SetNonSpaceWrap(true)
   cvarenablesubtitle:SetJustifyH("CENTER")
   cvarenablesubtitle:SetJustifyV("TOP")
   cvarenablesubtitle:SetText("CVars & Hooks")
   
   local cvarenablebutton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
   cvarenablebutton:SetPoint("TOPLEFT", cvarenablesubtitle, "BOTTOMLEFT", 0, 0)
   cvarenablebutton:SetHeight(self.ButtonHeight)
   cvarenablebutton:SetWidth(OptionWidth)

   if config.GamePad.CVSetup then
      cvarenablebutton:SetText("Disable")
   else
      cvarenablebutton:SetText("Enable")
   end
   
   cvarenablebutton:SetScript("OnClick", function(self, button, down)
      config.GamePad.CVSetup = not config.GamePad.CVSetup
      ConfigUI:Refresh(true)
   end)
   
   ConfigUI:AddToolTip(cvarenablebutton, Locale.enabeCVarToolTip, true)
   
   --[[
      GamePadLook Enable
   --]]
   
   local gamepadlooksubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   gamepadlooksubtitle:SetHeight(self.ButtonHeight)
   gamepadlooksubtitle:SetWidth(OptionWidth)
   gamepadlooksubtitle:SetPoint("TOPLEFT", cvarenablesubtitle, "TOPRIGHT", 0, 0)
   gamepadlooksubtitle:SetNonSpaceWrap(true)
   gamepadlooksubtitle:SetJustifyH("CENTER")
   gamepadlooksubtitle:SetJustifyV("TOP")
   gamepadlooksubtitle:SetText("GamePadLook")
   
   local gamepadlookbutton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
   gamepadlookbutton:SetPoint("TOPLEFT", gamepadlooksubtitle, "BOTTOMLEFT", 0, 0)
   gamepadlookbutton:SetHeight(self.ButtonHeight)
   gamepadlookbutton:SetWidth(OptionWidth)

   if config.GamePad.GamePadLook then
      gamepadlookbutton:SetText("Disable")
   else
      gamepadlookbutton:SetText("Enable")
   end
   
   gamepadlookbutton:SetScript("OnClick", function(self, button, down)
      config.GamePad.GamePadLook = not config.GamePad.GamePadLook
      ConfigUI:Refresh(true)
   end)

   ConfigUI:AddToolTip(gamepadlookbutton, Locale.gamepadLookToolTip, true)
   
   --[[
      Mouselook Enable
   --]]
   
   local mouselooksubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   mouselooksubtitle:SetHeight(self.ButtonHeight)
   mouselooksubtitle:SetWidth(OptionWidth)
   mouselooksubtitle:SetPoint("TOPLEFT", gamepadlooksubtitle, "TOPRIGHT", 0, 0)
   mouselooksubtitle:SetNonSpaceWrap(true)
   mouselooksubtitle:SetJustifyH("CENTER")
   mouselooksubtitle:SetJustifyV("TOP")
   mouselooksubtitle:SetText("MouseLook")
   
   local mouselookbutton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
   mouselookbutton:SetPoint("TOPLEFT", mouselooksubtitle, "BOTTOMLEFT", 0, 0)
   mouselookbutton:SetHeight(self.ButtonHeight)
   mouselookbutton:SetWidth(OptionWidth)

   if config.GamePad.MouseLook then
      mouselookbutton:SetText("Disable")
   else
      mouselookbutton:SetText("Enable")
   end
   
   mouselookbutton:SetScript("OnClick", function(self, button, down)
      config.GamePad.MouseLook = not config.GamePad.MouseLook
      ConfigUI:Refresh(true)
   end)

   
   ConfigUI:AddToolTip(mouselookbutton, Locale.mouseLookToolTip, true)
   
   --[[
      CVars
   --]]
   
   local cvarsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
   cvarsubtitle:SetHeight(self.ButtonHeight)
   cvarsubtitle:SetWidth(OptionWidth)
   cvarsubtitle:SetPoint("TOPLEFT", gamepadenablebutton, "BOTTOMLEFT", -self.Inset, -self.ConfigSpacing)
   cvarsubtitle:SetNonSpaceWrap(true)
   cvarsubtitle:SetJustifyH("Left")
   cvarsubtitle:SetJustifyV("TOP")
   cvarsubtitle:SetText("CVars")

   --[[
      Devices
   --]]
     
   local DropDownWidth = configFrame:GetWidth()/3 - 2*self.Inset

   local bindings = {"NONE", "PAD1","PAD2","PAD3","PAD4","PAD5","PAD6",
                     "PADDRIGHT","PADDUP","PADDDOWN","PADDLEFT",
                     "PADLSTICK","PADRSTICK","PADLSHOULDER","PADRSHOULDER",
                     "PADLTRIGGER","PADRTRIGGER","PADFORWARD","PADBACK",
                     "PADPADDLE1","PADPADDLE2","PADPADDLE3","PADPADDLE4"}
   
   local devicetitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   devicetitle:SetHeight(self.TextHeight)
   devicetitle:SetWidth(DropDownWidth)
   devicetitle:SetPoint("TOPLEFT", cvarsubtitle, "BOTTOMLEFT", 0, -self.ConfigSpacing)
   devicetitle:SetNonSpaceWrap(true)
   devicetitle:SetJustifyH("CENTER")
   devicetitle:SetJustifyV("TOP")
   devicetitle:SetText("Device")
   
   local function IsDeviceSelected(id)
      return config.GamePad.GPDeviceID == id
   end
   
   local function SetDeviceSelected(id)
      config.GamePad.GPDeviceID = id
      ConfigUI:Refresh(true)
   end

   local function DeviceGeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Devices");
      for i,device in ipairs(C_GamePad.GetAllDeviceIDs()) do
         local devicestate = C_GamePad.GetDeviceRawState(i-1)
         local name =""
         if devicestate then
            name = devicestate.name
         end
         if device == C_GamePad.GetCombinedDeviceID() then
            name = "Combined"
         end
         rootDescription:CreateRadio(name, IsDeviceSelected, SetDeviceSelected, device);
      end
   end;

   local DeviceDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate");
   DeviceDropDown:SetDefaultText("No devices found");
   DeviceDropDown:SetPoint("TOP", devicetitle, "BOTTOM", 0, 0)
   DeviceDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   DeviceDropDown:SetupMenu(DeviceGeneratorFunction);
   
   ConfigUI:AddToolTip(DeviceDropDown, Locale.deviceToolTip, true)

   --[[
      Left mouse button
   --]]
     
   local leftclicktitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   leftclicktitle:SetHeight(self.TextHeight)
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
      ConfigUI:Refresh(true)
   end

   local function LClickGeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Bindings")
      for i,binding in ipairs(bindings) do
         rootDescription:CreateRadio(binding, IsLClickSelected, SetLClickSelected, binding)
      end
   end;

   local LClickDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   LClickDropDown:SetDefaultText("None")
   LClickDropDown:SetPoint("TOP", leftclicktitle, "BOTTOM", 0, 0)
   LClickDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   LClickDropDown:SetupMenu(LClickGeneratorFunction)
   
   ConfigUI:AddToolTip(LClickDropDown, Locale.leftclickToolTip, true)
   
   --[[
      Right mouse button
   --]]
     
   local rightclicktitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   rightclicktitle:SetHeight(self.TextHeight)
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
      ConfigUI:Refresh(true)
   end

   local function RClickGeneratorFunction(owner, rootDescription)
      rootDescription:CreateTitle("Bindings")
      for i,binding in ipairs(bindings) do
         rootDescription:CreateRadio(binding, IsRClickSelected, SetRClickSelected, binding)
      end
   end;

   local RClickDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   RClickDropDown:SetDefaultText("None")
   RClickDropDown:SetPoint("TOP", rightclicktitle, "BOTTOM", 0, 0)
   RClickDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   RClickDropDown:SetupMenu(RClickGeneratorFunction)
   
   ConfigUI:AddToolTip(RClickDropDown, Locale.rightclickToolTip, true)

   --[[
       Yaw speed
   --]]    

   local yawspeedsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   yawspeedsubtitle:SetHeight(self.TextHeight)
   yawspeedsubtitle:SetWidth(DropDownWidth-2*self.Inset)
   yawspeedsubtitle:SetPoint("TOP", DeviceDropDown, "BOTTOM", 0, -self.ConfigSpacing)
   yawspeedsubtitle:SetNonSpaceWrap(true)
   yawspeedsubtitle:SetJustifyH("CENTER")
   yawspeedsubtitle:SetJustifyV("TOP")
   yawspeedsubtitle:SetText("Camera yaw speed")
   
   local yaweditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   yaweditbox:SetPoint("TOPLEFT", yawspeedsubtitle, "BOTTOMLEFT", 0, 0)
   yaweditbox:SetWidth(DropDownWidth-2*self.Inset)
   yaweditbox:SetHeight(self.EditBoxHeight)
   yaweditbox:SetMovable(false)
   yaweditbox:SetAutoFocus(false)
   yaweditbox:EnableMouse(true)
   yaweditbox:SetText(config.GamePad.GPYawSpeed)
   yaweditbox:SetScript("OnEditFocusLost", function(self)
      config.GamePad.GPYawSpeed = self:GetText()
      ConfigUI:Refresh(true)
   end)
   
   --[[
       Pitch speed
   --]]    

   local pitchspeedsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   pitchspeedsubtitle:SetHeight(self.TextHeight)
   pitchspeedsubtitle:SetWidth(DropDownWidth-2*self.Inset)
   pitchspeedsubtitle:SetPoint("TOPLEFT", yawspeedsubtitle, "TOPRIGHT", 2*self.Inset, 0)
   pitchspeedsubtitle:SetNonSpaceWrap(true)
   pitchspeedsubtitle:SetJustifyH("CENTER")
   pitchspeedsubtitle:SetJustifyV("TOP")
   pitchspeedsubtitle:SetText("Camera pitch speed")
   
   local pitcheditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   pitcheditbox:SetPoint("TOPLEFT", pitchspeedsubtitle, "BOTTOMLEFT", 0, 0)
   pitcheditbox:SetWidth(DropDownWidth-2*self.Inset)
   pitcheditbox:SetHeight(self.EditBoxHeight)
   pitcheditbox:SetMovable(false)
   pitcheditbox:SetAutoFocus(false)
   pitcheditbox:EnableMouse(true)
   pitcheditbox:SetText(config.GamePad.GPPitchSpeed)
   pitcheditbox:SetScript("OnEditFocusLost", function(self)
      config.GamePad.GPPitchSpeed = self:GetText()
      ConfigUI:Refresh(true)
   end)
   
   --[[
       Overlap Mouse
   --]]    

   local overlapmousespeedsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   overlapmousespeedsubtitle:SetHeight(self.TextHeight)
   overlapmousespeedsubtitle:SetWidth(DropDownWidth-2*self.Inset)
   overlapmousespeedsubtitle:SetPoint("TOPLEFT", pitchspeedsubtitle, "TOPRIGHT", 2*self.Inset, 0)
   overlapmousespeedsubtitle:SetNonSpaceWrap(true)
   overlapmousespeedsubtitle:SetJustifyH("CENTER")
   overlapmousespeedsubtitle:SetJustifyV("TOP")
   overlapmousespeedsubtitle:SetText("Overlap Mouse (ms)")
   
   local overlapmouseeditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   overlapmouseeditbox:SetPoint("TOPLEFT", overlapmousespeedsubtitle, "BOTTOMLEFT", 0, 0)
   overlapmouseeditbox:SetWidth(DropDownWidth-2*self.Inset)
   overlapmouseeditbox:SetHeight(self.EditBoxHeight)
   overlapmouseeditbox:SetMovable(false)
   overlapmouseeditbox:SetAutoFocus(false)
   overlapmouseeditbox:EnableMouse(true)
   overlapmouseeditbox:SetText(config.GamePad.GPOverlapMouse)
   overlapmouseeditbox:SetScript("OnEditFocusLost", function(self)
      config.GamePad.GPOverlapMouse = self:GetText()
      ConfigUI:Refresh(true)
   end)
   
   table.insert(self.RefreshCallbacks, function()
      if GetCVar('GamePadEnable') == "0" then
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
   
ConfigUI:CreateFrame()
