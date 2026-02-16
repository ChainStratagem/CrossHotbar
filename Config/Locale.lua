local ADDON, addon = ...

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
   actionbarhideToolTip = "Hide Blizzard's ActionBars (Requires reload).",
   vehiclebarhideToolTip = "Hide Blizzard's VehicleBar (Requires reload).",
   partyorienToolTip = "Traversal direction when navigating party unit frames.",
   raidorienToolTip = "Traversal direction when navigating raid unit frames.",
   targetcolorToolTip = "Color for the unit highlight. Active is the highlight around a party or raid unit that is currently targeted. Inactive is the highlight of the last targeted party unit that is no longer targeted.",
   highlightpaddingToolTip = "Padding for the unit highlight. The padding will increase the size of the hightlight.",
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
   CATEGORY_ACTIONS_EXTRAQUESTBUTTON1_TOOLTIP = "Button for addon ExtraQuestButton. Calls EXTRAACTIONBUTTON1 if visable or EXTRAQUESTBUTTON if not.",
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

addon.Locale = Locale
