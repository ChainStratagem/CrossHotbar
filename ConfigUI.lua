local ADDON, addon = ...

local config = addon.Config

local GamePadButtonList = addon.GamePadButtonList

local GamePadBindingList = {
   { cat = nil, values = { "NONE" } },
   { cat = "CATEGORY_CONTROLLER",
     values = {
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
        "PADPADDLE4"
   }},
   { cat = "CATEGORY_KEYBOARD",
     values = {
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
   }}
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
   hotkeyTypeToolTip = "Button icons used in the gui and hotkeys can be set to shapes or letters.",
   expandedTypeToolTip = "Sets the visual appearance of the extra action buttons.",
   dclkTypeToolTip = "Sets the hotbar double click behavior. Double click is registered upon two quick releases presses",
   dadaTypeToolTip = "The Cross hotbar can have two layouts. One with each bar on a given side or another that interleaves the hotbars.",
   pageIndexToolTip = "The default page displayed by the hotbar for SET 1.",
   pageIndexBackbarToolTip = "The default page displayed by the back hotbars. Unaffected by the active SET.",
   pagePrefixToolTip = "The prefix macro conditional to control the hotbar paging under the specified conditionals. The default ActionPage should not be included in this string.",
   enabeGamePadToolTip = "Toggle global GamePad mode.",
   enabeCVarToolTip = "Toggle CVar settings and hooks used by Crosshotbar. Disabling requires reloading.",
   gamepadLookToolTip = "Toggle CrossHotbar camera look handling and mouse mode for GamePad controls.",
   mouseLookToolTip = "Toggle mouse look handling. Enabling allows camera look control for keyboard binding setup.",
   deviceToolTip = "The DeviceId of the gamepad.",
   leftclickToolTip = "Left click binding for mouse mode.",
   rightclickToolTip = "Right click binding for mouse mode.",
   actionbarhideToolTip = "Settings to hide Blizzard's ActionBars.",
   vehiclebarhideToolTip = "Settings to hide Blizzard's VehicleBar.",
   partyorienToolTip = "Settings to control traversal direction when navigating party unit frames.",
   raidorienToolTip = "Settings to control traversal direction when navigating raid unit frames.",
   CATEGORY_HOTBAR_TYPE = "Hotbar types",
   CATEGORY_HOTBAR_KEY = "Hotkey types",
   CATEGORY_HOTBAR_WXHB = "Expanded types",
   CATEGORY_HOTBAR_DCLK = "Expanded double click",
   CATEGORY_HOTBAR_DDAA = "Hotbar layouts",
   CATEGORY_HOTBAR_ACTIONS = "Hotbar actions",
   CATEGORY_HOTBAR_ACTIONS_TOOLTIP = "Selects the Action bar binding to use when the Hotbar modifier is activated. Requires LEFTHOTBAR/RIGHTHOTBAR modifier to be held.",
   CATEGORY_MODIFIERS = "Modifiers",
   CATEGORY_MODIFIERS_TOOLTIP = "Binding used to overide/modify other buttons. Similar to shift and control modifiers.",
   CATEGORY_HOTBAR_EXPANDED = "Hotbar Expand",
   CATEGORY_HOTBAR_EXPANDED_TOOLTIP = "Actions to expand the hotbar by a button press.",
   CATEGORY_ACTIONS = "Actions",
   CATEGORY_ACTIONS_TOOLTIP = "Button actions for basic commands.",
   CATEGORY_MACRO = "Macro",
   CATEGORY_MACRO_TOOLTIP = "Will call the named marco if it exists. Exampe: MACRO CH_MACRO_1 will call the user macro named CH_MACRO_1.",
   CATEGORY_TARGETING = "Targeting",
   CATEGORY_TARGETING_TOOLTIP = "Actions to control targeting.",
   CATEGORY_CAMERA = "Camera/Cursor",
   CATEGORY_CAMERA_TOOLTIP = "Actions to control camera look (show/hide cursor), zoom, and mouse mode.",
   CATEGORY_PAGING = "Paging",
   CATEGORY_PAGING_TOOLTIP = "Actions to change the page set of the left and right hotbars. Sets are determined based off the default page index of the left and right hotbars.",
   CATEGORY_PAGING_NEXTPAGE_TOOLTIP = "Action to advance the left and right hotBars to the next SET.",
   CATEGORY_PAGING_PREVPAGE_TOOLTIP = "Action to advance the left and right hotBars to the previous SET.",
   CATEGORY_PAGING_PAGEONE_TOOLTIP = "Action to change the left and right hotBars to SET 1 - Default hotbar ActionPages with conditional paging.",
   CATEGORY_PAGING_PAGETWO_TOOLTIP = "Action to change the left and right hotBars to SET 2 - ActionPages [1,2].",
   CATEGORY_PAGING_PAGETHREE_TOOLTIP = "Action to change the left and right hotBars to SET 3 - ActionPages [3,4].",
   CATEGORY_PAGING_PAGEFOUR_TOOLTIP = "Action to change the left and right hotBars to SET 4 - ActionPages [5,6].",
   CATEGORY_PAGING_PAGEFIVE_TOOLTIP = "Action to change the left and right hotBars to SET 4 - ActionPages [7,8].",
   CATEGORY_PAGING_PAGESIX_TOOLTIP = "Action to change the left and right hotBars to SET 4 - ActionPages [9,10].",
   CATEGORY_UNIT_NAVIGATION = "Unit Navigation",
   CATEGORY_UNIT_NAVIGATION_TOOLTIP = "Actions to navigate unit frames self, party and raid.",
   CATEGORY_UNIT_PARTYORIENTATION = "Party unit traversal direction.",
   CATEGORY_UNIT_RAIDORIENTATION = "Raid unit traversal direction.",
   CATEGORY_CONTROLLER = "Controller buttons",
   CATEGORY_KEYBOARD = "Keyboard buttons",
   CATEGORY_HOTBAR_EXPANDED_HOLDEXPANDED_TOOLTIP = "Action to expand the active hotbar when held. This action can be used as a double click binding in an external tool (ex. Steam) to better control the double click timing.",
   CATEGORY_HOTBAR_EXPANDED_LEFTEXPANDED_TOOLTIP = "Action to activate and expand the left hotbar.",
   CATEGORY_HOTBAR_EXPANDED_RIGHTEXPANDED_TOOLTIP = "Action to activate and expand the right hotbar.",
   CATEGORY_ACTIONBAR_HIDES = "Hide ActionBars",
   CATEGORY_VEHICLEBAR_HIDES = "Hide VehcleBars",
   ddaatypestr = {
      ["DADA"] = "DPad + Action / DPad + Action",
      ["DDAA"] = "DPad + DPad / Action + Action"
   },
   hkeytypestr = {
      ["_SHP"] = "Use shapes for button icons",
      ["_LTR"] = "Use letters for button icons",
   },
   wxhbtypestr = {
      ["HIDE"] = "Hide extra actions when not active",
      ["FADE"] = "Fade extra actions when not active",
      ["SHOW"] = "Show extra actions when not active"
   },
   dclktypestr = {
      ["ENABLE"] = "Enable extra actions",
      ["VISUAL"] = "Enable extra actions with visual",
      ["DISABLE"] = "Disable double click"
   },
   actionbarhidetypestr = {
      ["HIDEALL"] = "Hide all ActionBars",
      ["HIDEMAIN"] = "Hide MainActionBar",
      ["NOHIDE"] = "Show ActionBars"
   },
   vehiclebarhidetypestr = {
      ["HIDEALL"] = "Hide VehicleBars",
      ["NOHIDE"] = "Show VehicleBars"
   },
   partyorientypestr = {
      ["VERTICAL"] = "Vertical",
      ["HORIZONTAL"] = "Horizontal"
   },
   raidorientypestr = {
      ["VERTICAL"] = "Vertical",
      ["HORIZONTAL"] = "Horizontal"
   }
}

function Locale:GetText(text)
   if text ~= nil and text ~= "" then
      return Locale[text]
   end
   return ""
end

function Locale:GetToolTip(category, action)
   local tiptext = nil
   if category ~= nil then
      if action ~= nil then
         tiptext = Locale:GetText(category .. "_" .. action .. "_TOOLTIP")
      end
      if tiptext == nil then
         tiptext = Locale:GetText(category .. "_TOOLTIP")
      end
   end
   return tiptext
end

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
   ConfigFrame = nil,
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
         config.PadActions[button]["ACTION"] == "RIGHTHOTBAR" or
         config.PadActions[button]["ACTION"] == "HOLDEXPANDED" or
         config.PadActions[button]["ACTION"] == "LEFTEXPANDED" or
         config.PadActions[button]["ACTION"] == "RIGHTEXPANDED" then
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

function ConfigUI:AddRefreshCallback(frame, func)
   if self.RefreshCallbacks[frame] == nil then
      self.RefreshCallbacks[frame] = {}
   end
   table.insert(self.RefreshCallbacks[frame], func)
end

function ConfigUI:Refresh(updated)
   for frame,callbacks in pairs(self.RefreshCallbacks)  do
      if frame:IsVisible() then
         for i,callback in ipairs(callbacks) do
            callback()
         end
      end
   end
   addon:ApplyConfig(updated)
end

function ConfigUI:OnConfigInit()
   ConfigUI.preset = CrossHotbar_DB.ActivePreset 
end

function ConfigUI:ClearLayout()
   -- EditModeManger is picking up Crosshotbar frames which causes taint.
   -- This function removes referances to Crosshotbar.
   local bool foundTaint = false
   layoutInfo = C_EditMode.GetLayouts()
   for i,layout in ipairs(layoutInfo.layouts) do
      for i,system in ipairs(layout.systems) do
         if system.anchorInfo then
            if string.find(system.anchorInfo.relativeTo, "Crosshotbar") then
               system.anchorInfo.relativeTo = UIParent:GetName()
               foundTaint = true
            end
         end
      end
   end
   if foundTaint then
      print("Removing frame from EditMode")
      C_EditMode.SaveLayouts(layoutInfo)
   else
      print("Not taint found.")
   end
end

function ConfigUI:CreateFrame()
   self.ConfigFrame = CreateFrame("Frame", ADDON .. "ConfigFrame", InterfaceOptionsFramePanelContainer)
   self.ConfigFrame.name = ADDON
   self.ConfigFrame:Hide()

   addon:AddInitCallback(GenerateClosure(self.OnConfigInit, self))

   self.ConfigFrame:SetScript("OnShow", function(ConfigFrame)
      local title = ConfigFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
      title:SetPoint("TOPLEFT", self.Inset, -self.Inset)
      title:SetText("CrossHotbar")

      local authortitle = ConfigFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
      authortitle:SetPoint("TOPLEFT", title, "TOPLEFT", 0, -2 * self.ConfigSpacing)
      authortitle:SetText("Author")
      
      local author = ConfigFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
      author:SetPoint("TOPLEFT", authortitle, "TOPLEFT", self.Inset, -self.TextHeight)
      author:SetWidth(ConfigFrame:GetWidth() - 4 * self.Inset)
      author:SetJustifyH("LEFT")
      author:SetText("ChainStratagem (phodoe)")
      author:SetTextColor(1,1,1,1)
      
      local descripttitle = ConfigFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
      descripttitle:SetPoint("TOPLEFT", author, "TOPLEFT", -self.Inset, -self.ConfigSpacing)
      descripttitle:SetText("Description")
      
      local descript = ConfigFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
      descript:SetPoint("TOPLEFT", descripttitle, "TOPLEFT", self.Inset, -self.TextHeight)
      descript:SetWidth(ConfigFrame:GetWidth() - 4 * self.Inset)
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
      
      ConfigFrame:SetScript("OnShow", function(frame) ConfigUI:Refresh() end) 
      ConfigUI:Refresh()
   end)

   local category, layout = Settings.RegisterCanvasLayoutCategory(self.ConfigFrame,
                                                                  self.ConfigFrame.name)
   Settings.RegisterAddOnCategory(category)

   -- Preset Frame
   
   self.PresetFrame = CreateFrame("Frame", ADDON .. "PresetsSettings", self.ConfigFrame)
   self.PresetFrame.name = "Presets"
   self.PresetFrame.parent = self.ConfigFrame.name
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

   -- Action Frame 
   
   self.ActionFrame = CreateFrame("Frame", ADDON .. "ActionsSettings", self.ConfigFrame)
   self.ActionFrame.name = "Actions"
   self.ActionFrame.parent = self.ConfigFrame.name
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
      
      ConfigUI:AddRefreshCallback(self.ActionFrame, function()
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

   -- Hotbar Frame
   
   self.HotbarFrame = CreateFrame("Frame", ADDON .. "HotbarsSettings", self.ConfigFrame)
   self.HotbarFrame.name = "Hotbars"
   self.HotbarFrame.parent = self.ConfigFrame.name
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

   -- Interface Frame
   
   self.InterfaceFrame = CreateFrame("Frame", ADDON .. "InterfaceSettings", self.ConfigFrame)
   self.InterfaceFrame.name = "Interface"
   self.InterfaceFrame.parent = self.ConfigFrame.name
   self.InterfaceFrame:Hide()

   self.InterfaceFrame:SetScript("OnShow", function(InterfaceFrame)
      local title = InterfaceFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
      title:SetPoint("TOPLEFT", self.Inset, -self.Inset)
      title:SetText("Interface Settings")

      local anchor = title
      anchor = ConfigUI:CreateInterfaceSettings(InterfaceFrame, anchor)
      
      InterfaceFrame:SetScript("OnShow", function(frame) ConfigUI:Refresh() end) 
      ConfigUI:Refresh()
      
   end)      

   Settings.RegisterCanvasLayoutSubcategory(category,
                                            self.InterfaceFrame,
                                            self.InterfaceFrame.name)
   -- GamePad Frame
   
   self.GamePadFrame = CreateFrame("Frame", ADDON .. "GamePadSettings", self.ConfigFrame)
   self.GamePadFrame.name = "GamePad"
   self.GamePadFrame.parent = self.ConfigFrame.name
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

   -- Slash commands
   
   SLASH_CROSSHOTBAR1, SLASH_CROSSHOTBAR2 = '/chb', '/wxhb'
   local function slashcmd(msg, editBox)
      if msg == "clear layout" then
         self:ClearLayout()
      else
         Settings.OpenToCategory(category:GetID())
      end
   end
   SlashCmdList["CROSSHOTBAR"] = slashcmd

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
      return ConfigUI.preset == index
   end
   
   local function SetSelected(index)
      ConfigUI.preset = index
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
   PresetsDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   PresetsDropDown:SetupMenu(GeneratorFunction)
   
   local presetloadbutton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
   presetloadbutton:SetPoint("TOPLEFT", PresetsDropDown, "TOPRIGHT", 24, 0)
   presetloadbutton:SetHeight(self.ButtonHeight)
   presetloadbutton:SetWidth(self.ButtonWidth)
   presetloadbutton:SetText("Load")
   
   presetloadbutton:SetScript("OnClick", function(self, button, down)
      CrossHotbar_DB.ActivePreset = ConfigUI.preset
      addon:StorePreset(config, CrossHotbar_DB.Presets[ConfigUI.preset])
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
      addon:StorePreset(config, CrossHotbar_DB.Presets[ConfigUI.preset])
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
            addon:StorePreset(newpreset, config)
            table.insert(CrossHotbar_DB.Presets, newpreset)
            ConfigUI.preset = #CrossHotbar_DB.Presets
            CrossHotbar_DB.ActivePreset = ConfigUI.preset
         elseif CrossHotbar_DB.Presets[foundpreset].Mutable then
            ConfigUI.preset = foundpreset
            CrossHotbar_DB.ActivePreset = ConfigUI.preset
            addon:StorePreset(CrossHotbar_DB.Presets[ConfigUI.preset], config)
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
   
   ConfigUI:AddRefreshCallback(self.PresetFrame, function()
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

   ConfigUI:AddToolTip(bindingsubtitle, Locale.bindingToolTip, true)
   
   local function IsBindingSelected(data)
      local button, binding = unpack(data)
      return config.PadActions[button].BIND == binding
   end
   
   local function SetBindingSelected(data)
      local button, binding = unpack(data)
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
      config.PadActions[button].BIND = binding
      ConfigUI:Refresh(true)
   end
   
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

         local function GeneratorFunction(owner, rootDescription)
            rootDescription:SetScrollMode(bindingframe:GetHeight()*0.75)
            for i,data in ipairs(GamePadBindingList) do
               if Locale:GetText(data.cat) ~= "" then
                  rootDescription:CreateTitle(Locale:GetText(data.cat))
               end
               for _,binding in ipairs(data.values) do
                  rootDescription:CreateRadio(binding, IsBindingSelected, SetBindingSelected, {button, binding})
               end
            end
         end
         
         local BindingDropDown = CreateFrame("DropdownButton", nil, bindingframe, "WowStyle1DropdownTemplate")
         BindingDropDown:SetDefaultText("NONE")
         BindingDropDown:SetPoint("TOP", bindinganchor, "BOTTOM", 0, 0)
         BindingDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
         BindingDropDown:SetHeight(buttonsubtitle:GetHeight())
         BindingDropDown:SetupMenu(GeneratorFunction)

         ConfigUI:AddRefreshCallback(self.ActionFrame, function() BindingDropDown:GenerateMenu() end)
         
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
   
   ConfigUI:AddToolTip(actionsubtitle, Locale.actionToolTip, true)
   
   local hotbarsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   hotbarsubtitle:SetHeight(self.TextHeight)
   hotbarsubtitle:SetWidth(DropDownWidth)
   hotbarsubtitle:SetPoint("TOPLEFT", actionsubtitle, "TOPRIGHT", 0, 0)
   hotbarsubtitle:SetNonSpaceWrap(true)
   hotbarsubtitle:SetJustifyH("CENTER")
   hotbarsubtitle:SetJustifyV("TOP")
   hotbarsubtitle:SetText("Hotbar Action")

   ConfigUI:AddToolTip(hotbarsubtitle, Locale.hotbaractionToolTip, true)
   
   local function IsActionSelected(data)
      local button, action = unpack(data)
      return config.PadActions[button][prefix .. "ACTION"] == action
   end
   
   local function SetActionSelected(data)
      local button, action = unpack(data)
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
      config.PadActions[button][prefix .. "ACTION"] = action
      ConfigUI:Refresh(true)
   end

   local function IsHotbarActionSelected(data)
      local button, action = unpack(data)
      return config.PadActions[button][prefix .. "TRIGACTION"] == action
   end
   
   local function SetHotbarActionSelected(data)
      local button, action = unpack(data)
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
      config.PadActions[button][prefix .. "TRIGACTION"] = action
      ConfigUI:Refresh(true)
   end

   local actionToolTip = function(tooltip, elementDescription)
      GameTooltip_SetTitle(tooltip, MenuUtil.GetElementText(elementDescription))
      GameTooltip_AddNormalLine(tooltip, Locale.actionToolTip)
   end

   local hotActionToolTip = function(tooltip, elementDescription)
      GameTooltip_SetTitle(tooltip, MenuUtil.GetElementText(elementDescription))
      GameTooltip_AddNormalLine(tooltip, Locale.hotbaractionToolTip)
   end

   local actionanchor = actionsubtitle
   local hotbaranchor = hotbarsubtitle
   for i,button in ipairs(GamePadButtonList) do
      if config.PadActions[button] then

         local function ActionGeneratorFunction(owner, rootDescription)
            rootDescription:SetScrollMode(configFrame:GetHeight()*.75)
            local actionlists = {{ cat = "", values =  { "NONE" } }}
            if ActionsAvailable(button, prefix, "ACTION") then
               actionlists = ActionMap[button]
            else
               config.PadActions[button][prefix .. "ACTION"] = "NONE"
            end 
            for i,data in ipairs(actionlists) do
               if Locale:GetText(data.cat) ~= "" then
                  local title = rootDescription:CreateTitle(Locale:GetText(data.cat))
               end
               for _,action in ipairs(data.values) do
                  local radio = rootDescription:CreateRadio(action, IsActionSelected, SetActionSelected, {button, action})
                  local tiptext = Locale:GetToolTip(data.cat, action)
                  if tiptext ~= nil then
                     radio:SetTooltip(function(tooltip, elementDescription)
                        GameTooltip_SetTitle(tooltip, MenuUtil.GetElementText(elementDescription))
                        GameTooltip_AddNormalLine(tooltip, tiptext)
                     end)
                  end
               end
            end
         end
         
         local ActionDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
         ActionDropDown:SetDefaultText("NONE")
         ActionDropDown:SetPoint("TOP", actionanchor, "BOTTOM", 0, 0)
         ActionDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
         ActionDropDown:SetHeight(32)
         ActionDropDown:SetupMenu(ActionGeneratorFunction)

         ConfigUI:AddRefreshCallback(configFrame, function() ActionDropDown:GenerateMenu() end)

         local function HotbarActionGeneratorFunction(owner, rootDescription)
            rootDescription:SetScrollMode(configFrame:GetHeight()*0.75)
            local actionlists = {{ cat = "", values =  {"NONE"} }}
            if ActionsAvailable(button, prefix, "TRIGACTION") then
               actionlists = HotbarMap[button]
            else
               config.PadActions[button][prefix .. "TRIGACTION"] = "NONE"
            end
            for i,data in ipairs(actionlists) do
               if Locale:GetText(data.cat) ~= "" then
                  rootDescription:CreateTitle(Locale:GetText(data.cat))
               end
               for _,action in ipairs(data.values) do
                  local radio = rootDescription:CreateRadio(action, IsHotbarActionSelected, SetHotbarActionSelected, {button, action})
                  local tiptext = Locale:GetToolTip(data.cat, action)
                  if tiptext ~= nil then
                     radio:SetTooltip(function(tooltip, elementDescription)
                        GameTooltip_SetTitle(tooltip, MenuUtil.GetElementText(elementDescription))
                        GameTooltip_AddNormalLine(tooltip, tiptext)
                     end)
                  end
               end
            end
         end
         
         local HotbarActionDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
         HotbarActionDropDown:SetDefaultText("NONE")
         HotbarActionDropDown:SetPoint("TOP", hotbaranchor, "BOTTOM", 0, 0)
         HotbarActionDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
         HotbarActionDropDown:SetHeight(32)
         HotbarActionDropDown:SetupMenu(HotbarActionGeneratorFunction)
         
         ConfigUI:AddRefreshCallback(configFrame, function() HotbarActionDropDown:GenerateMenu() end)
         
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
      DDAA hotbar button layout
   --]]    

   local ddaasubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   ddaasubtitle:SetHeight(self.TextHeight)
   ddaasubtitle:SetWidth(DropDownWidth)
   ddaasubtitle:SetPoint("TOPLEFT", featuresubtitle, "BOTTOMLEFT", 0, -self.ConfigSpacing)
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
      for i,data in ipairs(addon.HotbarDDAATypes) do
         if Locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(Locale:GetText(data.cat))
         end
         for i,ddaatype in ipairs(data.values) do
            rootDescription:CreateRadio(Locale.ddaatypestr[ddaatype], IsDDAATypeSelected, SetDDAATypeSelected, ddaatype)
         end
      end
   end

   local DDAADropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   DDAADropDown:SetDefaultText("Layout Types")
   DDAADropDown:SetPoint("TOP", ddaasubtitle, "BOTTOM", 0, 0)
   DDAADropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   DDAADropDown:SetupMenu(DDAATypeGeneratorFunction)
   
   ConfigUI:AddToolTip(ddaasubtitle, Locale.dadaTypeToolTip, true)
   
   --[[
      HKEY hotbar button layout
   --]]    

   local hkeysubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   hkeysubtitle:SetHeight(self.TextHeight)
   hkeysubtitle:SetWidth(DropDownWidth)
   hkeysubtitle:SetPoint("TOPLEFT", ddaasubtitle, "TOPRIGHT", 0, 0)
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
      for i,data in ipairs(addon.HotbarHKEYTypes) do
         if Locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(Locale:GetText(data.cat))
         end
         for i,hkeytype in ipairs(data.values) do
            rootDescription:CreateRadio(Locale.hkeytypestr[hkeytype], IsHKeyTypeSelected, SetHKeyTypeSelected, hkeytype)
         end
      end
   end

   local HKeyDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   HKeyDropDown:SetDefaultText("Hotkey Type")
   HKeyDropDown:SetPoint("TOP", hkeysubtitle, "BOTTOM", 0, 0)
   HKeyDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   HKeyDropDown:SetupMenu(HKeyTypeGeneratorFunction)
   
   ConfigUI:AddToolTip(hkeysubtitle, Locale.hotkeyTypeToolTip, true)
   
   --[[
      Expanded type settings
   --]]
   
   local wxhbsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   wxhbsubtitle:SetHeight(self.TextHeight)
   wxhbsubtitle:SetWidth(DropDownWidth)
   wxhbsubtitle:SetPoint("TOP", DDAADropDown, "BOTTOM", 0, -self.ConfigSpacing)
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
      for i,data in ipairs(addon.HotbarWXHBTypes) do
         if Locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(Locale:GetText(data.cat))
         end
         for i,wxhbtype in ipairs(data.values) do
            rootDescription:CreateRadio(Locale.wxhbtypestr[wxhbtype], IsWXHBTypeSelected, SetWXHBTypeSelected, wxhbtype)
         end
      end
   end

   local WXHBDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   WXHBDropDown:SetDefaultText("Expand Types")
   WXHBDropDown:SetPoint("TOP", wxhbsubtitle, "BOTTOM", 0, 0)
   WXHBDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   WXHBDropDown:SetupMenu(WXHBTypeGeneratorFunction)
   
   ConfigUI:AddToolTip(wxhbsubtitle, Locale.expandedTypeToolTip, true)


   --[[
      Expanded double click
   --]]
   
   local dclksubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   dclksubtitle:SetHeight(self.TextHeight)
   dclksubtitle:SetWidth(DropDownWidth)
   dclksubtitle:SetPoint("TOPLEFT", wxhbsubtitle, "TOPRIGHT", 0, 0)
   dclksubtitle:SetNonSpaceWrap(true)
   dclksubtitle:SetJustifyH("CENTER")
   dclksubtitle:SetJustifyV("TOP")
   dclksubtitle:SetText("Expanded Double Click")

   local function IsDCLKTypeSelected(type)
      return config.Hotbar.DCLKType == type
   end
   
   local function SetDCLKTypeSelected(type)
      config.Hotbar.DCLKType = type
      ConfigUI:Refresh(true)
   end

   local function DCLKTypeGeneratorFunction(owner, rootDescription)
      for i,data in ipairs(addon.HotbarDCLKTypes) do
         if Locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(Locale:GetText(data.cat))
         end
         for i,dclktype in ipairs(data.values) do
            rootDescription:CreateRadio(Locale.dclktypestr[dclktype], IsDCLKTypeSelected, SetDCLKTypeSelected, dclktype)
         end
      end
   end

   local DCLKDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   DCLKDropDown:SetDefaultText("Expanded Types")
   DCLKDropDown:SetPoint("TOP", dclksubtitle, "BOTTOM", 0, 0)
   DCLKDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   DCLKDropDown:SetupMenu(DCLKTypeGeneratorFunction)
   
   ConfigUI:AddToolTip(dclksubtitle, Locale.dclkTypeToolTip, true)
   
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
      rootDescription:CreateTitle("Action pages")
      for i = 1,10 do
         rootDescription:CreateRadio("ActionPage ".. i, IsLPageSelected, SetLPageSelected, i)
      end
   end

   local LPageDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   LPageDropDown:SetDefaultText("Action pages")
   LPageDropDown:SetPoint("TOP", lpagesubtitle, "BOTTOM", 0, 0)
   LPageDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   LPageDropDown:SetupMenu(LPageGeneratorFunction)
   
   ConfigUI:AddToolTip(lpagesubtitle, Locale.pageIndexToolTip, true)

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
      rootDescription:CreateTitle("Action pages")
      for i = 1,10 do
         rootDescription:CreateRadio("ActionPage ".. i, IsRPageSelected, SetRPageSelected, i)
      end
   end

   local RPageDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   RPageDropDown:SetDefaultText("Action pages")
   RPageDropDown:SetPoint("TOP", rpagesubtitle, "BOTTOM", 0, 0)
   RPageDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   RPageDropDown:SetupMenu(RPageGeneratorFunction)
   
   ConfigUI:AddToolTip(rpagesubtitle, Locale.pageIndexToolTip, true)

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
      rootDescription:CreateTitle("Action pages")
      for i = 1,10 do
         rootDescription:CreateRadio("ActionPage ".. i, IsLRPageSelected, SetLRPageSelected, i)
      end
   end

   local LRPageDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   LRPageDropDown:SetDefaultText("Action pages")
   LRPageDropDown:SetPoint("TOP", lrpagesubtitle, "BOTTOM", 0, 0)
   LRPageDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   LRPageDropDown:SetupMenu(LRPageGeneratorFunction)
   
   ConfigUI:AddToolTip(lrpagesubtitle, Locale.pageIndexBackbarToolTip, true)

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
      rootDescription:CreateTitle("Action pages")
      for i = 1,10 do
         rootDescription:CreateRadio("ActionPage ".. i, IsRLPageSelected, SetRLPageSelected, i)
      end
   end

   local RLPageDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   RLPageDropDown:SetDefaultText("Action pages")
   RLPageDropDown:SetPoint("TOP", rlpagesubtitle, "BOTTOM", 0, 0)
   RLPageDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   RLPageDropDown:SetupMenu(RLPageGeneratorFunction)
   
   ConfigUI:AddToolTip(rlpagesubtitle, Locale.pageIndexBackbarToolTip, true)

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
      local page_prefix = self:GetText()
      if page_prefix ~= config.Hotbar.LPagePrefix then        
         local result = SecureCmdOptionParse(page_prefix .. config.Hotbar.LPageIndex)
         if result ~= nil and tonumber(result) ~= nil then
            print("Setting conditional: " .. page_prefix)
            config.Hotbar.LPagePrefix = page_prefix
         ConfigUI:Refresh(true)
         else
            print("|cffffff00Not setting conditional: " .. page_prefix .. config.Hotbar.LPageIndex .. " Returned a non number [" .. result .. "] conditional not set.|r")
            self:SetText(config.Hotbar.LPagePrefix)
         end
      end
   end)

   ConfigUI:AddToolTip(lpagepresubtitle, Locale.pagePrefixToolTip, true)

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
      local page_prefix = self:GetText()
      if page_prefix ~= config.Hotbar.RPagePrefix then        
         local result = SecureCmdOptionParse(page_prefix .. config.Hotbar.RPageIndex)
         if result ~= nil and tonumber(result) ~= nil then
            print("Setting conditional: " .. page_prefix)
            config.Hotbar.RPagePrefix = page_prefix
            ConfigUI:Refresh(true)
         else
            print("|cffffff00Not setting conditional: " .. page_prefix .. config.Hotbar.RPageIndex .. " Returned a non number [" .. result .. "] conditional not set.|r")
            self:SetText(config.Hotbar.RPagePrefix)
         end
      end
   end)

   ConfigUI:AddToolTip(rpagepresubtitle, Locale.pagePrefixToolTip, true)

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
      local page_prefix = self:GetText()
      if page_prefix ~= config.Hotbar.LRPagePrefix then                           
         local result = SecureCmdOptionParse(page_prefix .. config.Hotbar.LRPageIndex)
         if result ~= nil and tonumber(result) ~= nil then
            print("Setting conditional: " .. page_prefix)
            config.Hotbar.LRPagePrefix = page_prefix
            ConfigUI:Refresh(true)
         else
         print("|cffffff00Not setting conditional: " .. page_prefix .. config.Hotbar.LRPageIndex .. " Returned a non number [" .. result .. "] conditional not set.|r")
         self:SetText(config.Hotbar.LRPagePrefix)
         end
      end
   end)

   ConfigUI:AddToolTip(lrpagepresubtitle, Locale.pagePrefixToolTip, true)

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
      local page_prefix = self:GetText()
      if page_prefix ~= config.Hotbar.RLPagePrefix then                          
         local result = SecureCmdOptionParse(page_prefix .. config.Hotbar.RLPageIndex)
         if result ~= nil and tonumber(result) ~= nil then
            print("Setting conditional: " .. page_prefix)
            config.Hotbar.RLPagePrefix = page_prefix
            ConfigUI:Refresh(true)
         else
            print("|cffffff00Not setting conditional: " .. page_prefix .. config.Hotbar.RLPageIndex .. " Returned a non number [" .. result .. "] conditional not set.|r")
            self:SetText(config.Hotbar.RLPagePrefix)
         end
      end
   end)

   ConfigUI:AddToolTip(rlpagepresubtitle, Locale.pagePrefixToolTip, true)

   ConfigUI:AddRefreshCallback(self.HotbarFrame, function()
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
   Interface settings.
--]]  

function ConfigUI:CreateInterfaceSettings(configFrame, anchorFrame)
   local DropDownWidth = (configFrame:GetWidth() - 2*self.Inset)/2

   --[[
       ActionBar Hides
   --]]   
   
   local blizframesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
   blizframesubtitle:SetHeight(self.ButtonHeight)
   blizframesubtitle:SetWidth(DropDownWidth)
   blizframesubtitle:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -self.ConfigSpacing)
   blizframesubtitle:SetNonSpaceWrap(true)
   blizframesubtitle:SetJustifyH("Left")
   blizframesubtitle:SetJustifyV("TOP")
   blizframesubtitle:SetText("Blizzard frames")

   local actionbarhidesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   actionbarhidesubtitle:SetHeight(self.ButtonHeight)
   actionbarhidesubtitle:SetWidth(DropDownWidth)
   actionbarhidesubtitle:SetPoint("TOPLEFT", blizframesubtitle, "BOTTOMLEFT", self.Inset, -self.ConfigSpacing)
   actionbarhidesubtitle:SetNonSpaceWrap(true)
   actionbarhidesubtitle:SetJustifyH("CENTER")
   actionbarhidesubtitle:SetJustifyV("TOP")
   actionbarhidesubtitle:SetText("Hide ActionBars")

   local function IsActionBarHideTypeSelected(type)
      return config.Interface.ActionBarHide == type
   end
   
   local function SetActioBarHideTypeSelected(type)
      config.Interface.ActionBarHide = type
      ConfigUI:Refresh(true)
   end

   local function ActionBarHideGeneratorFunction(owner, rootDescription)      
      for i,data in ipairs(addon.ActionBarHides) do
         if Locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(Locale:GetText(data.cat))
         end
         for i,hidetype in ipairs(data.values) do
            rootDescription:CreateRadio(Locale.actionbarhidetypestr[hidetype], IsActionBarHideTypeSelected, SetActioBarHideTypeSelected, hidetype)
         end
      end
   end

   local ActionBarHideDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   ActionBarHideDropDown:SetDefaultText("Layout Types")
   ActionBarHideDropDown:SetPoint("TOP", actionbarhidesubtitle, "BOTTOM", 0, 0)
   ActionBarHideDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   ActionBarHideDropDown:SetupMenu(ActionBarHideGeneratorFunction)
   
   ConfigUI:AddToolTip(actionbarhidesubtitle, Locale.actionbarhideToolTip, true)

   --[[
       VehicleBar Hides
   --]] 
   
   local vehiclebarhidesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   vehiclebarhidesubtitle:SetHeight(self.ButtonHeight)
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
      ConfigUI:Refresh(true)
   end

   local function VehicleBarHideGeneratorFunction(owner, rootDescription)      
      for i,data in ipairs(addon.VehicleBarHides) do
         if Locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(Locale:GetText(data.cat))
         end
         for i,hidetype in ipairs(data.values) do
            rootDescription:CreateRadio(Locale.vehiclebarhidetypestr[hidetype], IsVehicleBarHideTypeSelected, SetVehicleBarHideTypeSelected, hidetype)
         end
      end
   end

   local VehicleBarHideDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   VehicleBarHideDropDown:SetDefaultText("Layout Types")
   VehicleBarHideDropDown:SetPoint("TOP", vehiclebarhidesubtitle, "BOTTOM", 0, 0)
   VehicleBarHideDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   VehicleBarHideDropDown:SetupMenu(VehicleBarHideGeneratorFunction)
   
   ConfigUI:AddToolTip(vehiclebarhidesubtitle, Locale.vehiclebarhideToolTip, true)

   --[[
       Unit Targeting
   --]] 
   
   local unittargetsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
   unittargetsubtitle:SetHeight(self.ButtonHeight)
   unittargetsubtitle:SetWidth(DropDownWidth)
   unittargetsubtitle:SetPoint("TOP", ActionBarHideDropDown, "BOTTOM", 0, -self.ConfigSpacing)
   unittargetsubtitle:SetPoint("LEFT", anchorFrame, "LEFT", 0, 0)
   unittargetsubtitle:SetNonSpaceWrap(true)
   unittargetsubtitle:SetJustifyH("Left")
   unittargetsubtitle:SetJustifyV("TOP")
   unittargetsubtitle:SetText("Unit highlight")

   --[[
       Party Orientation
   --]] 
   
   local partyoriensubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   partyoriensubtitle:SetHeight(self.ButtonHeight)
   partyoriensubtitle:SetWidth(DropDownWidth)
   partyoriensubtitle:SetPoint("TOPLEFT", unittargetsubtitle, "BOTTOMLEFT", self.Inset, -self.ConfigSpacing)
   partyoriensubtitle:SetNonSpaceWrap(true)
   partyoriensubtitle:SetJustifyH("CENTER")
   partyoriensubtitle:SetJustifyV("TOP")
   partyoriensubtitle:SetText("Party Orientation")

   local function IsPartyOrienTypeSelected(type)
      return config.Interface.UnitPartyOrientation == type
   end
   
   local function SetActioBarHideTypeSelected(type)
      config.Interface.UnitPartyOrientation = type
      ConfigUI:Refresh(true)
   end

   local function PartyOrienGeneratorFunction(owner, rootDescription)      
      for i,data in ipairs(addon.PartyOrientation) do
         if Locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(Locale:GetText(data.cat))
         end
         for i,orientype in ipairs(data.values) do
            rootDescription:CreateRadio(Locale.partyorientypestr[orientype], IsPartyOrienTypeSelected, SetPartyOrienTypeSelected, orientype)
         end
      end
   end
   
   local PartyOrienDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   PartyOrienDropDown:SetDefaultText("Layout Types")
   PartyOrienDropDown:SetPoint("TOP", partyoriensubtitle, "BOTTOM", 0, 0)
   PartyOrienDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   PartyOrienDropDown:SetupMenu(PartyOrienGeneratorFunction)
   
   ConfigUI:AddToolTip(partyoriensubtitle, Locale.partyorienToolTip, true)
   
   --[[
       Raid Orientation
   --]]
   
   local raidoriensubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   raidoriensubtitle:SetHeight(self.ButtonHeight)
   raidoriensubtitle:SetWidth(DropDownWidth)
   raidoriensubtitle:SetPoint("TOPLEFT", partyoriensubtitle, "TOPRIGHT", 0, 0)
   raidoriensubtitle:SetNonSpaceWrap(true)
   raidoriensubtitle:SetJustifyH("CENTER")
   raidoriensubtitle:SetJustifyV("TOP")
   raidoriensubtitle:SetText("Raid Orientation")

   local function IsRaidOrienTypeSelected(type)
      return config.Interface.UnitRaidOrientation == type
   end
   
   local function SetActioBarHideTypeSelected(type)
      config.Interface.UnitRaidOrientation = type
      ConfigUI:Refresh(true)
   end

   local function RaidOrienGeneratorFunction(owner, rootDescription)      
      for i,data in ipairs(addon.RaidOrientation) do
         if Locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(Locale:GetText(data.cat))
         end
         for i,orientype in ipairs(data.values) do
            rootDescription:CreateRadio(Locale.raidorientypestr[orientype], IsRaidOrienTypeSelected, SetRaidOrienTypeSelected, orientype)
         end
      end
   end
   
   local RaidOrienDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   RaidOrienDropDown:SetDefaultText("Layout Types")
   RaidOrienDropDown:SetPoint("TOP", raidoriensubtitle, "BOTTOM", 0, 0)
   RaidOrienDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   RaidOrienDropDown:SetupMenu(RaidOrienGeneratorFunction)
   
   ConfigUI:AddToolTip(raidoriensubtitle, Locale.raidorienToolTip, true)

   --[[
        Highlight Color
   --]]
   
   local targetcolorsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   targetcolorsubtitle:SetHeight(self.ButtonHeight)
   targetcolorsubtitle:SetWidth(DropDownWidth)
   targetcolorsubtitle:SetPoint("TOP", PartyOrienDropDown, "BOTTOM", 0, -self.ConfigSpacing)
   targetcolorsubtitle:SetNonSpaceWrap(true)
   targetcolorsubtitle:SetJustifyH("CENTER")
   targetcolorsubtitle:SetJustifyV("TOP")
   targetcolorsubtitle:SetText("Highlight colors")
   
   local ActiveTargetColorButtonsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontWhite")
   ActiveTargetColorButtonsubtitle:SetWidth(DropDownWidth/4-self.Inset)
   ActiveTargetColorButtonsubtitle:SetPoint("TOPLEFT", targetcolorsubtitle, "BOTTOMLEFT", self.Inset, -self.ConfigSpacing/2)
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
   ActiveTargetEnabledCheckBox:SetPoint("LEFT", ActiveTargetColorButtonsubtitle, "RIGHT", self.Inset, 0)
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
   InActiveTargetColorButtonButtonsubtitle:SetPoint("LEFT", ActiveTargetColorButton, "RIGHT", self.Inset, 0)
   InActiveTargetColorButtonButtonsubtitle:SetNonSpaceWrap(true)
   InActiveTargetColorButtonButtonsubtitle:SetJustifyH("RIGHT")
   InActiveTargetColorButtonButtonsubtitle:SetJustifyV("TOP")
   InActiveTargetColorButtonButtonsubtitle:SetText("Inactive")

   local InActiveTargetEnabledCheckBox = CreateFrame("CheckButton", nil, configFrame, "ChatConfigCheckButtonTemplate")
   InActiveTargetEnabledCheckBox:SetPoint("LEFT", InActiveTargetColorButtonButtonsubtitle, "RIGHT", self.Inset, 0)
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
   
   local highlightoffsetsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   highlightoffsetsubtitle:SetHeight(self.ButtonHeight)
   highlightoffsetsubtitle:SetWidth(DropDownWidth)
   highlightoffsetsubtitle:SetPoint("TOP", RaidOrienDropDown, "BOTTOM", 0, -self.ConfigSpacing)
   highlightoffsetsubtitle:SetNonSpaceWrap(true)
   highlightoffsetsubtitle:SetJustifyH("CENTER")
   highlightoffsetsubtitle:SetJustifyV("TOP")
   highlightoffsetsubtitle:SetText("Highlight padding")
   
   local HighlightPaddingEditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   HighlightPaddingEditbox:SetPoint("TOP", highlightoffsetsubtitle, "BOTTOM", 0, 0)
   HighlightPaddingEditbox:SetWidth(self.ButtonWidth/2)
   HighlightPaddingEditbox:SetHeight(self.EditBoxHeight)
   HighlightPaddingEditbox:SetMovable(false)
   HighlightPaddingEditbox:SetAutoFocus(false)
   HighlightPaddingEditbox:EnableMouse(true)
   HighlightPaddingEditbox:SetText(config.Interface.UnitTargetPadding)
   HighlightPaddingEditbox:SetNumeric(true)
   HighlightPaddingEditbox:SetJustifyH("CENTER")
   HighlightPaddingEditbox:SetScript("OnEditFocusLost", function(self)
      config.Interface.UnitTargetPadding = tonumber(self:GetText())
      ConfigUI:Refresh(true)
   end)

   ConfigUI:AddRefreshCallback(self.InterfaceFrame, function()
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
      ConfigUI:Refresh(true)
   end)

   ConfigUI:AddToolTip(gamepadenablesubtitle, Locale.enabeGamePadToolTip, true)
   
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
   
   ConfigUI:AddToolTip(cvarenablesubtitle, Locale.enabeCVarToolTip, true)
   
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

   ConfigUI:AddToolTip(gamepadlooksubtitle, Locale.gamepadLookToolTip, true)
   
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

   
   ConfigUI:AddToolTip(mouselooksubtitle, Locale.mouseLookToolTip, true)
   
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
   DeviceDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   DeviceDropDown:SetupMenu(DeviceGeneratorFunction)
   
   ConfigUI:AddToolTip(devicetitle, Locale.deviceToolTip, true)

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
   end

   local LClickDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   LClickDropDown:SetDefaultText("None")
   LClickDropDown:SetPoint("TOP", leftclicktitle, "BOTTOM", 0, 0)
   LClickDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   LClickDropDown:SetupMenu(LClickGeneratorFunction)
   
   ConfigUI:AddToolTip(leftclicktitle, Locale.leftclickToolTip, true)
   
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
   end

   local RClickDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   RClickDropDown:SetDefaultText("None")
   RClickDropDown:SetPoint("TOP", rightclicktitle, "BOTTOM", 0, 0)
   RClickDropDown:SetWidth(DropDownWidth-self.DropDownSpacing)
   RClickDropDown:SetupMenu(RClickGeneratorFunction)
   
   ConfigUI:AddToolTip(rightclicktitle, Locale.rightclickToolTip, true)

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
   yaweditbox:SetNumeric(true)
   yaweditbox:SetJustifyH("CENTER")
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
   pitcheditbox:SetNumeric(true)
   pitcheditbox:SetJustifyH("CENTER")
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
   overlapmouseeditbox:SetNumeric(true)
   overlapmouseeditbox:SetJustifyH("CENTER")
   overlapmouseeditbox:SetText(config.GamePad.GPOverlapMouse)
   overlapmouseeditbox:SetScript("OnEditFocusLost", function(self)
      config.GamePad.GPOverlapMouse = self:GetText()
      ConfigUI:Refresh(true)
   end)
   
   ConfigUI:AddRefreshCallback(self.GamePadFrame, function()
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
   
ConfigUI:CreateFrame()
