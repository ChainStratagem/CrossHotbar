local ADDON, addon = ...

local config = addon.Config
local locale = addon.Locale
local cfgUI  = addon.ConfigUI

local HotbarUI = {}

function HotbarUI:CreateFrame()
   self.HotbarFrame = CreateFrame("Frame", ADDON .. "HotbarsSettings", self.ConfigFrame)
   self.HotbarFrame.name = "Hotbars"
   self.HotbarFrame.parent = cfgUI.ConfigFrame.name
   self.HotbarFrame:Hide()

   self.HotbarFrame:SetScript("OnShow", function(HotbarFrame)
      local scrollFrame = CreateFrame("ScrollFrame", nil, HotbarFrame, "UIPanelScrollFrameTemplate")
      scrollFrame:SetPoint("TOPLEFT", 3, -4)
      scrollFrame:SetPoint("BOTTOMRIGHT", -27, 4)
      
      local scrollChild = CreateFrame("Frame")
      scrollFrame:SetScrollChild(scrollChild)
      scrollChild:SetWidth(HotbarFrame:GetWidth()-cfgUI.Inset)
      scrollChild:SetHeight(1)
      
      local title = scrollChild:CreateFontString(nil, "ARTWORK", "GameFontHighlightHuge")
      title:SetPoint("TOPLEFT", cfgUI.Inset, -cfgUI.Inset)
      title:SetText("Hotbar Settings")
      
      local anchor = title
  
      anchor = self:CreateHotbarSettings(scrollChild, anchor)
      
      HotbarFrame:SetScript("OnShow", function(frame) cfgUI:Refresh() end) 
      cfgUI:Refresh()
   end)
   
   Settings.RegisterCanvasLayoutSubcategory(cfgUI.category,
                                            self.HotbarFrame,
                                            self.HotbarFrame.name)
end

function HotbarUI:CreateHotbarSettings(configFrame, anchorFrame)   
   local DropDownWidth = (configFrame:GetWidth() - 2*cfgUI.Inset)/2

   local featuresubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
   featuresubtitle:SetHeight(cfgUI.TextHeight)
   featuresubtitle:SetWidth(DropDownWidth)
   featuresubtitle:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -cfgUI.ConfigSpacing)
   featuresubtitle:SetNonSpaceWrap(true)
   featuresubtitle:SetJustifyH("Left")
   featuresubtitle:SetJustifyV("TOP")
   featuresubtitle:SetText("Features")
   
   --[[
      DDAA hotbar button layout
   --]]    

   local ddaasubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   ddaasubtitle:SetHeight(cfgUI.TextHeight)
   ddaasubtitle:SetWidth(DropDownWidth)
   ddaasubtitle:SetPoint("TOPLEFT", featuresubtitle, "BOTTOMLEFT", 0, -cfgUI.ConfigSpacing)
   ddaasubtitle:SetNonSpaceWrap(true)
   ddaasubtitle:SetJustifyH("CENTER")
   ddaasubtitle:SetJustifyV("TOP")
   ddaasubtitle:SetText("Hotbar Layout")

   local function IsDDAATypeSelected(type)
      return config.Hotbar.DDAAType == type
   end
   
   local function SetDDAATypeSelected(type)
      config.Hotbar.DDAAType = type
      cfgUI:Refresh(true)
   end

   local function DDAATypeGeneratorFunction(owner, rootDescription)      
      for i,data in ipairs(addon.HotbarDDAATypes) do
         if locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(locale:GetText(data.cat))
         end
         for i,ddaatype in ipairs(data.values) do
            rootDescription:CreateRadio(locale.ddaatypestr[ddaatype], IsDDAATypeSelected, SetDDAATypeSelected, ddaatype)
         end
      end
   end

   local DDAADropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   DDAADropDown:SetDefaultText("Layout Types")
   DDAADropDown:SetPoint("TOP", ddaasubtitle, "BOTTOM", 0, 0)
   DDAADropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   DDAADropDown:SetupMenu(DDAATypeGeneratorFunction)
   
   cfgUI:AddToolTip(ddaasubtitle, locale.dadaTypeToolTip, true)
   
   --[[
      HKEY hotbar button layout
   --]]    

   local hkeysubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   hkeysubtitle:SetHeight(cfgUI.TextHeight)
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
      cfgUI:Refresh(true)
   end

   local function HKeyTypeGeneratorFunction(owner, rootDescription)      
      for i,data in ipairs(addon.HotbarHKEYTypes) do
         if locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(locale:GetText(data.cat))
         end
         for i,hkeytype in ipairs(data.values) do
            rootDescription:CreateRadio(locale.hkeytypestr[hkeytype], IsHKeyTypeSelected, SetHKeyTypeSelected, hkeytype)
         end
      end
   end

   local HKeyDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   HKeyDropDown:SetDefaultText("Hotkey Type")
   HKeyDropDown:SetPoint("TOP", hkeysubtitle, "BOTTOM", 0, 0)
   HKeyDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   HKeyDropDown:SetupMenu(HKeyTypeGeneratorFunction)
   
   cfgUI:AddToolTip(hkeysubtitle, locale.hotkeyTypeToolTip, true)
   
   --[[
      Expanded type settings
   --]]
   
   local wxhbsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   wxhbsubtitle:SetHeight(cfgUI.TextHeight)
   wxhbsubtitle:SetWidth(DropDownWidth)
   wxhbsubtitle:SetPoint("TOP", DDAADropDown, "BOTTOM", 0, -cfgUI.ConfigSpacing)
   wxhbsubtitle:SetNonSpaceWrap(true)
   wxhbsubtitle:SetJustifyH("CENTER")
   wxhbsubtitle:SetJustifyV("TOP")
   wxhbsubtitle:SetText("Expanded Type")

   local function IsWXHBTypeSelected(type)
      return config.Hotbar.WXHBType == type
   end
   
   local function SetWXHBTypeSelected(type)
      config.Hotbar.WXHBType = type
      cfgUI:Refresh(true)
   end

   local function WXHBTypeGeneratorFunction(owner, rootDescription)
      for i,data in ipairs(addon.HotbarWXHBTypes) do
         if locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(locale:GetText(data.cat))
         end
         for i,wxhbtype in ipairs(data.values) do
            rootDescription:CreateRadio(locale.wxhbtypestr[wxhbtype], IsWXHBTypeSelected, SetWXHBTypeSelected, wxhbtype)
         end
      end
   end

   local WXHBDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   WXHBDropDown:SetDefaultText("Expand Types")
   WXHBDropDown:SetPoint("TOP", wxhbsubtitle, "BOTTOM", 0, 0)
   WXHBDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   WXHBDropDown:SetupMenu(WXHBTypeGeneratorFunction)
   
   cfgUI:AddToolTip(wxhbsubtitle, locale.expandedTypeToolTip, true)


   --[[
      Expanded double click
   --]]
   
   local dclksubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   dclksubtitle:SetHeight(cfgUI.TextHeight)
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
      cfgUI:Refresh(true)
   end

   local function DCLKTypeGeneratorFunction(owner, rootDescription)
      for i,data in ipairs(addon.HotbarDCLKTypes) do
         if locale:GetText(data.cat) ~= "" then
            rootDescription:CreateTitle(locale:GetText(data.cat))
         end
         for i,dclktype in ipairs(data.values) do
            rootDescription:CreateRadio(locale.dclktypestr[dclktype], IsDCLKTypeSelected, SetDCLKTypeSelected, dclktype)
         end
      end
   end

   local DCLKDropDown = CreateFrame("DropdownButton", nil, configFrame, "WowStyle1DropdownTemplate")
   DCLKDropDown:SetDefaultText("Expanded Types")
   DCLKDropDown:SetPoint("TOP", dclksubtitle, "BOTTOM", 0, 0)
   DCLKDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   DCLKDropDown:SetupMenu(DCLKTypeGeneratorFunction)
   
   cfgUI:AddToolTip(dclksubtitle, locale.dclkTypeToolTip, true)
   
   --[[
       Actionbar paging
   --]]    
   
   local actionpagesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
   actionpagesubtitle:SetHeight(cfgUI.TextHeight)
   actionpagesubtitle:SetWidth(DropDownWidth)
   actionpagesubtitle:SetPoint("TOP", WXHBDropDown, "BOTTOM", 0, -cfgUI.ConfigSpacing)
   actionpagesubtitle:SetNonSpaceWrap(true)
   actionpagesubtitle:SetJustifyH("Left")
   actionpagesubtitle:SetJustifyV("TOP")
   actionpagesubtitle:SetText("ActionPage")

   --[[
       LHotbar page index
   --]]    

   local lpagesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   lpagesubtitle:SetHeight(cfgUI.TextHeight)
   lpagesubtitle:SetWidth(DropDownWidth)
   lpagesubtitle:SetPoint("TOPLEFT", actionpagesubtitle, "BOTTOMLEFT", 0, -cfgUI.ConfigSpacing)
   lpagesubtitle:SetNonSpaceWrap(true)
   lpagesubtitle:SetJustifyH("CENTER")
   lpagesubtitle:SetJustifyV("TOP")
   lpagesubtitle:SetText("Left Hotbar ActionPage")

   local function IsLPageSelected(page)
      return config.Hotbar.LPageIndex == page
   end
   
   local function SetLPageSelected(page)
      config.Hotbar.LPageIndex = page
      cfgUI:Refresh(true)
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
   LPageDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   LPageDropDown:SetupMenu(LPageGeneratorFunction)
   
   cfgUI:AddToolTip(lpagesubtitle, locale.pageIndexToolTip, true)

   --[[
       RHotbar page index
   --]]    

   local rpagesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   rpagesubtitle:SetHeight(cfgUI.TextHeight)
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
      cfgUI:Refresh(true)
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
   RPageDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   RPageDropDown:SetupMenu(RPageGeneratorFunction)
   
   cfgUI:AddToolTip(rpagesubtitle, locale.pageIndexToolTip, true)

   --[[
       LRHotbar page index
   --]]    

   local lrpagesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   lrpagesubtitle:SetHeight(cfgUI.TextHeight)
   lrpagesubtitle:SetWidth(DropDownWidth)
   lrpagesubtitle:SetPoint("TOP", LPageDropDown, "BOTTOM", 0, -cfgUI.ConfigSpacing)
   lrpagesubtitle:SetNonSpaceWrap(true)
   lrpagesubtitle:SetJustifyH("CENTER")
   lrpagesubtitle:SetJustifyV("TOP")
   lrpagesubtitle:SetText("Left Right Hotbar ActionPage")

   local function IsLRPageSelected(page)
      return config.Hotbar.LRPageIndex == page
   end
   
   local function SetLRPageSelected(page)
      config.Hotbar.LRPageIndex = page
      cfgUI:Refresh(true)
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
   LRPageDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   LRPageDropDown:SetupMenu(LRPageGeneratorFunction)
   
   cfgUI:AddToolTip(lrpagesubtitle, locale.pageIndexBackbarToolTip, true)

   --[[
       RLHotbar page index
   --]]    

   local rlpagesubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   rlpagesubtitle:SetHeight(cfgUI.TextHeight)
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
      cfgUI:Refresh(true)
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
   RLPageDropDown:SetWidth(DropDownWidth-cfgUI.DropDownSpacing)
   RLPageDropDown:SetupMenu(RLPageGeneratorFunction)
   
   cfgUI:AddToolTip(rlpagesubtitle, locale.pageIndexBackbarToolTip, true)

   local conditionalsubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
   conditionalsubtitle:SetHeight(cfgUI.TextHeight)
   conditionalsubtitle:SetWidth(DropDownWidth)
   conditionalsubtitle:SetPoint("TOP", LRPageDropDown, "BOTTOM", 0, -cfgUI.ConfigSpacing)
   conditionalsubtitle:SetNonSpaceWrap(true)
   conditionalsubtitle:SetJustifyH("Left")
   conditionalsubtitle:SetJustifyV("TOP")
   conditionalsubtitle:SetText("Conditionals")
   
   --[[
       LHotbar page prefix
   --]]    

   local lpagepresubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   lpagepresubtitle:SetHeight(cfgUI.TextHeight)
   lpagepresubtitle:SetWidth(DropDownWidth)
   lpagepresubtitle:SetPoint("TOPLEFT", conditionalsubtitle, "BOTTOMLEFT", cfgUI.Inset, -cfgUI.ConfigSpacing)
   lpagepresubtitle:SetNonSpaceWrap(true)
   lpagepresubtitle:SetJustifyH("LEFT")
   lpagepresubtitle:SetJustifyV("TOP")
   lpagepresubtitle:SetText("Left hotbar page prefix")
   
   local lhotbareditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   lhotbareditbox:SetPoint("TOPLEFT", lpagepresubtitle, "BOTTOMLEFT", 0, 0)
   lhotbareditbox:SetWidth(2*DropDownWidth-cfgUI.DropDownSpacing)
   lhotbareditbox:SetHeight(cfgUI.EditBoxHeight)
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
         cfgUI:Refresh(true)
         else
            print("|cffffff00Not setting conditional: " .. page_prefix .. config.Hotbar.LPageIndex .. " Returned a non number [" .. result .. "] conditional not set.|r")
            self:SetText(config.Hotbar.LPagePrefix)
         end
      end
   end)

   cfgUI:AddToolTip(lpagepresubtitle, locale.pagePrefixToolTip, true)

   --[[
       RHotbar page prefix
   --]]    

   local rpagepresubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   rpagepresubtitle:SetHeight(cfgUI.TextHeight)
   rpagepresubtitle:SetWidth(DropDownWidth)
   rpagepresubtitle:SetPoint("TOPLEFT", lhotbareditbox, "BOTTOMLEFT", 0, -cfgUI.ConfigSpacing)
   rpagepresubtitle:SetNonSpaceWrap(true)
   rpagepresubtitle:SetJustifyH("LEFT")
   rpagepresubtitle:SetJustifyV("TOP")
   rpagepresubtitle:SetText("Right hotbar page prefix")
   
   local rhotbareditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   rhotbareditbox:SetPoint("TOPLEFT", rpagepresubtitle, "BOTTOMLEFT", 0, 0)
   rhotbareditbox:SetWidth(2*DropDownWidth-cfgUI.DropDownSpacing)
   rhotbareditbox:SetHeight(cfgUI.EditBoxHeight)
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
            cfgUI:Refresh(true)
         else
            print("|cffffff00Not setting conditional: " .. page_prefix .. config.Hotbar.RPageIndex .. " Returned a non number [" .. result .. "] conditional not set.|r")
            self:SetText(config.Hotbar.RPagePrefix)
         end
      end
   end)

   cfgUI:AddToolTip(rpagepresubtitle, locale.pagePrefixToolTip, true)

   --[[
       LRHotbar page prefix
   --]]    

   local lrpagepresubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   lrpagepresubtitle:SetHeight(cfgUI.TextHeight)
   lrpagepresubtitle:SetWidth(DropDownWidth)
   lrpagepresubtitle:SetPoint("TOPLEFT", rhotbareditbox, "BOTTOMLEFT", 0, -cfgUI.ConfigSpacing)
   lrpagepresubtitle:SetNonSpaceWrap(true)
   lrpagepresubtitle:SetJustifyH("LEFT")
   lrpagepresubtitle:SetJustifyV("TOP")
   lrpagepresubtitle:SetText("Left Right hotbar page prefix")
   
   local lrhotbareditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   lrhotbareditbox:SetPoint("TOPLEFT", lrpagepresubtitle, "BOTTOMLEFT", 0, 0)
   lrhotbareditbox:SetWidth(2*DropDownWidth-cfgUI.DropDownSpacing)
   lrhotbareditbox:SetHeight(cfgUI.EditBoxHeight)
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
            cfgUI:Refresh(true)
         else
         print("|cffffff00Not setting conditional: " .. page_prefix .. config.Hotbar.LRPageIndex .. " Returned a non number [" .. result .. "] conditional not set.|r")
         self:SetText(config.Hotbar.LRPagePrefix)
         end
      end
   end)

   cfgUI:AddToolTip(lrpagepresubtitle, locale.pagePrefixToolTip, true)

   --[[
       RLHotbar page prefix
   --]]    

   local rlpagepresubtitle = configFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
   rlpagepresubtitle:SetHeight(cfgUI.TextHeight)
   rlpagepresubtitle:SetWidth(DropDownWidth)
   rlpagepresubtitle:SetPoint("TOPLEFT", lrhotbareditbox, "BOTTOMLEFT", 0, -cfgUI.ConfigSpacing)
   rlpagepresubtitle:SetNonSpaceWrap(true)
   rlpagepresubtitle:SetJustifyH("LEFT")
   rlpagepresubtitle:SetJustifyV("TOP")
   rlpagepresubtitle:SetText("Right Left hotbar page prefix")
   
   local rlhotbareditbox = CreateFrame("EditBox", nil, configFrame, "InputBoxTemplate")
   rlhotbareditbox:SetPoint("TOPLEFT", rlpagepresubtitle, "BOTTOMLEFT", 0, 0)
   rlhotbareditbox:SetWidth(2*DropDownWidth-cfgUI.DropDownSpacing)
   rlhotbareditbox:SetHeight(cfgUI.EditBoxHeight)
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
            cfgUI:Refresh(true)
         else
            print("|cffffff00Not setting conditional: " .. page_prefix .. config.Hotbar.RLPageIndex .. " Returned a non number [" .. result .. "] conditional not set.|r")
            self:SetText(config.Hotbar.RLPagePrefix)
         end
      end
   end)

   cfgUI:AddToolTip(rlpagepresubtitle, locale.pagePrefixToolTip, true)

   cfgUI:AddRefreshCallback(self.HotbarFrame, function()
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

HotbarUI:CreateFrame()
addon.HotbarUI = HotbarUI
