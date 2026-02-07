local ADDON, addon = ...

local config = addon.Config
local locale = addon.Locale
local cfgUI  = addon.ConfigUI

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

local ActionUI = {}

function ActionUI:CreateFrame()
   self.ActionFrame = CreateFrame("Frame", ADDON .. "ActionsSettings", self.ConfigFrame)
   self.ActionFrame.name = "Actions"
   self.ActionFrame.parent = cfgUI.ConfigFrame.name
   self.ActionFrame:Hide()

   self.ActionFrame:SetScript("OnShow", function(ActionFrame)
      local scrollFrame = CreateFrame("ScrollFrame", nil, ActionFrame, "UIPanelScrollFrameTemplate")
      scrollFrame:SetPoint("TOPLEFT", 3, -4)
      scrollFrame:SetPoint("BOTTOMRIGHT", -27, 4)
      
      local scrollChild = CreateFrame("Frame")
      scrollFrame:SetScrollChild(scrollChild)
      scrollChild:SetWidth(ActionFrame:GetWidth()-cfgUI.Inset)
      scrollChild:SetHeight(1)
      
      local title = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
      title:SetPoint("TOPLEFT", cfgUI.Inset, -cfgUI.Inset)
      title:SetText("Actions Settings")
      
      local anchor = title
      anchor = ActionUI:CreatePadBindings(scrollChild, anchor)
      
      anchor, tab1, tab2, tab3, tab4, tab5 =
         ActionUI:CreateTabFrame(scrollChild, anchor)

      ActionUI:CreatePadActions(tab1, tab1, "", GamePadActionMap, GamePadHotbarMap)
      ActionUI:CreatePadActions(tab2, tab2, "SPADL", GamePadModifierActionMap, GamePadHotbarMap)
      ActionUI:CreatePadActions(tab3, tab3, "SPADR", GamePadModifierActionMap, GamePadHotbarMap)
      ActionUI:CreatePadActions(tab4, tab4, "PPADL", GamePadModifierActionMap, GamePadHotbarMap)
      ActionUI:CreatePadActions(tab5, tab5, "PPADR", GamePadModifierActionMap, GamePadHotbarMap)
      
      cfgUI:AddRefreshCallback(self.ActionFrame, function()
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
      
      ActionFrame:SetScript("OnShow", function(frame) cfgUI:Refresh() end) 
      cfgUI:Refresh()
   end)

   Settings.RegisterCanvasLayoutSubcategory(cfgUI.category,
                                            self.ActionFrame,
                                            self.ActionFrame.name)
end

function ActionUI:CreateTabFrame(configFrame, anchorFrame)
   local tabframe = CreateFrame("Frame", ADDON .. "ActionTabFrame", configFrame, "BackdropTemplate")
   tabframe:EnableMouse(true)
   tabframe:SetHeight(anchorFrame:GetHeight())
   tabframe:SetWidth(2*(configFrame:GetWidth() - 2*cfgUI.Inset)/3)
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
   tab1button:SetHeight(cfgUI.TabHeight)
   tab1button:SetWidth(cfgUI.TabWidth)
   tab1button:SetText("DEFAULT")
   tab1button:SetID(1)

   cfgUI:AddToolTip(tab1button, locale.defaultTabToolTip, true)
            
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
   tab2button:SetHeight(cfgUI.TabHeight)
   tab2button:SetWidth(cfgUI.TabWidth)
   tab2button:SetText("SPADL")
   tab2button:SetID(2)
   
   cfgUI:AddToolTip(tab2button, locale.spadlTabToolTip, true)
   
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
   tab3button:SetHeight(cfgUI.TabHeight)
   tab3button:SetWidth(cfgUI.TabWidth)
   tab3button:SetText("SPADR")
   tab3button:SetID(3)

   cfgUI:AddToolTip(tab3button, locale.spadrTabToolTip, true)
   
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
   tab4button:SetHeight(cfgUI.TabHeight)
   tab4button:SetWidth(cfgUI.TabWidth)
   tab4button:SetText("PPADL")
   tab4button:SetID(4)

   cfgUI:AddToolTip(tab4button, locale.ppadlTabToolTip, true)

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
   tab5button:SetHeight(cfgUI.TabHeight)
   tab5button:SetWidth(cfgUI.TabWidth)
   tab5button:SetText("PPADR")
   tab5button:SetID(5)

   cfgUI:AddToolTip(tab5button, locale.ppadrTabToolTip, true)

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

function ActionUI:CreatePadBindings(configFrame, anchorFrame)
   local DropDownWidth = configFrame:GetWidth()/3 - cfgUI.SymbolWidth - cfgUI.DropDownSpacing - 2*cfgUI.Inset

   local bindingframe = CreateFrame("Frame", nil, configFrame, "BackdropTemplate")
   bindingframe:EnableMouse(true)
   bindingframe:SetHeight(#GamePadButtonList * 32 + 2*cfgUI.TextHeight + cfgUI.ConfigSpacing)
   --bindingframe:SetWidth(cfgUI.SymbolWidth + DropDownWidth + cfgUI.DropDownSpacing + 2*cfgUI.Inset)
   bindingframe:SetWidth((configFrame:GetWidth() - 2*cfgUI.Inset)/3)
   bindingframe:SetBackdropColor(0, 0, 1, .5)
   bindingframe:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -cfgUI.ConfigSpacing -anchorFrame:GetHeight())

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
   buttonsubtitle:SetHeight(cfgUI.TextHeight)
   buttonsubtitle:SetWidth(cfgUI.SymbolWidth+cfgUI.Inset)
   buttonsubtitle:SetPoint("TOPLEFT", bindingframe, "TOPLEFT", cfgUI.Inset, -cfgUI.ConfigSpacing)
   buttonsubtitle:SetNonSpaceWrap(true)
   buttonsubtitle:SetJustifyH("CENTER")
   buttonsubtitle:SetJustifyV("TOP")
   buttonsubtitle:SetText("Button")
   
   local bindingsubtitle = bindingframe:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   bindingsubtitle:SetHeight(cfgUI.TextHeight)
   bindingsubtitle:SetWidth(DropDownWidth)
   bindingsubtitle:SetPoint("TOPLEFT", buttonsubtitle, "TOPRIGHT", 0, 0)
   bindingsubtitle:SetNonSpaceWrap(true)
   bindingsubtitle:SetJustifyH("CENTER")
   bindingsubtitle:SetJustifyV("TOP")
   bindingsubtitle:SetText("Binding")

   cfgUI:AddToolTip(bindingsubtitle, locale.bindingToolTip, true)
   
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
      cfgUI:Refresh(true)
   end
   
   local buttoninset = cfgUI.Inset
   local buttonanchor = buttonsubtitle
   local bindinganchor = bindingsubtitle
   for i,button in ipairs(GamePadButtonList) do
      if config.PadActions[button] then
         local attributes = config.PadActions[button]
         local buttonsubtitle = bindingframe:CreateFontString(nil, "ARTWORK", "GameFontNormal")
         buttonsubtitle:SetHeight(32)
         buttonsubtitle:SetWidth(cfgUI.SymbolWidth)
         buttonsubtitle:SetPoint("TOPLEFT", buttonanchor, "BOTTOMLEFT", 0.5*buttoninset, 0)
         buttonsubtitle:SetNonSpaceWrap(true)
         buttonsubtitle:SetJustifyH("CENTER")
         buttonsubtitle:SetJustifyV("TOP")
         buttonsubtitle:SetText(addon:GetButtonIcon(button))
         buttonsubtitle:SetScript("OnShow", function(frame) buttonsubtitle:SetText(addon:GetButtonIcon(button)) end) 

         local function GeneratorFunction(owner, rootDescription)
            rootDescription:SetScrollMode(bindingframe:GetHeight()*0.75)
            for i,data in ipairs(GamePadBindingList) do
               if locale:GetText(data.cat) ~= "" then
                  rootDescription:CreateTitle(locale:GetText(data.cat))
               end
               for _,binding in ipairs(data.values) do
                  rootDescription:CreateRadio(binding, IsBindingSelected, SetBindingSelected, {button, binding})
               end
            end
         end
         
         local BindingDropDown = CreateFrame("DropdownButton", nil, bindingframe, "WowStyle1DropdownTemplate")
         BindingDropDown:SetDefaultText("NONE")
         BindingDropDown:SetPoint("TOP", bindinganchor, "BOTTOM", 0, 0)
         BindingDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
         BindingDropDown:SetHeight(buttonsubtitle:GetHeight())
         BindingDropDown:SetupMenu(GeneratorFunction)

         cfgUI:AddRefreshCallback(self.ActionFrame, function() BindingDropDown:GenerateMenu() end)
         
         buttoninset = 0
         buttonanchor = buttonsubtitle
         bindinganchor = BindingDropDown
      end
   end
   
   return bindingframe
end

function ActionUI:CreatePadActions(configFrame, anchorFrame, prefix, ActionMap, HotbarMap)
   local DropDownWidth = configFrame:GetWidth()/2 - cfgUI.DropDownSpacing 

   local actionsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   actionsubtitle:SetHeight(cfgUI.TextHeight)
   actionsubtitle:SetWidth(DropDownWidth)
   actionsubtitle:SetPoint("TOPLEFT", anchorFrame, "TOPLEFT", cfgUI.Inset, -cfgUI.ConfigSpacing)
   actionsubtitle:SetNonSpaceWrap(true)
   actionsubtitle:SetJustifyH("CENTER")
   actionsubtitle:SetJustifyV("TOP")
   actionsubtitle:SetText("Action")
   
   cfgUI:AddToolTip(actionsubtitle, locale.actionToolTip, true)
   
   local hotbarsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   hotbarsubtitle:SetHeight(cfgUI.TextHeight)
   hotbarsubtitle:SetWidth(DropDownWidth)
   hotbarsubtitle:SetPoint("TOPLEFT", actionsubtitle, "TOPRIGHT", 0, 0)
   hotbarsubtitle:SetNonSpaceWrap(true)
   hotbarsubtitle:SetJustifyH("CENTER")
   hotbarsubtitle:SetJustifyV("TOP")
   hotbarsubtitle:SetText("Hotbar Action")

   cfgUI:AddToolTip(hotbarsubtitle, locale.hotbaractionToolTip, true)
   
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
      cfgUI:Refresh(true)
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
      cfgUI:Refresh(true)
   end

   local actionToolTip = function(tooltip, elementDescription)
      GameTooltip_SetTitle(tooltip, MenuUtil.GetElementText(elementDescription))
      GameTooltip_AddNormalLine(tooltip, locale.actionToolTip)
   end

   local hotActionToolTip = function(tooltip, elementDescription)
      GameTooltip_SetTitle(tooltip, MenuUtil.GetElementText(elementDescription))
      GameTooltip_AddNormalLine(tooltip, locale.hotbaractionToolTip)
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
               if locale:GetText(data.cat) ~= "" then
                  local title = rootDescription:CreateTitle(locale:GetText(data.cat))
               end
               for _,action in ipairs(data.values) do
                  local radio = rootDescription:CreateRadio(action, IsActionSelected, SetActionSelected, {button, action})
                  local tiptext = locale:GetToolTip(data.cat, action)
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
         ActionDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
         ActionDropDown:SetHeight(32)
         ActionDropDown:SetupMenu(ActionGeneratorFunction)

         cfgUI:AddRefreshCallback(configFrame, function() ActionDropDown:GenerateMenu() end)

         local function HotbarActionGeneratorFunction(owner, rootDescription)
            rootDescription:SetScrollMode(configFrame:GetHeight()*0.75)
            local actionlists = {{ cat = "", values =  {"NONE"} }}
            if ActionsAvailable(button, prefix, "TRIGACTION") then
               actionlists = HotbarMap[button]
            else
               config.PadActions[button][prefix .. "TRIGACTION"] = "NONE"
            end
            for i,data in ipairs(actionlists) do
               if locale:GetText(data.cat) ~= "" then
                  rootDescription:CreateTitle(locale:GetText(data.cat))
               end
               for _,action in ipairs(data.values) do
                  local radio = rootDescription:CreateRadio(action, IsHotbarActionSelected, SetHotbarActionSelected, {button, action})
                  local tiptext = locale:GetToolTip(data.cat, action)
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
         HotbarActionDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
         HotbarActionDropDown:SetHeight(32)
         HotbarActionDropDown:SetupMenu(HotbarActionGeneratorFunction)
         
         cfgUI:AddRefreshCallback(configFrame, function() HotbarActionDropDown:GenerateMenu() end)
         
         actionanchor = ActionDropDown
         hotbaranchor = HotbarActionDropDown
      end
   end
   
   return buttonanchor
end

ActionUI:CreateFrame()
addon.ActionUI = ActionUI
