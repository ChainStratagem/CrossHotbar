local ADDON, addon = ...

local config = addon.Config
local Locale = addon.Locale

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
   category = nil,
   layout = nil,
   RefreshCallbacks = {}
}

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
Addon to create Actionbars simlar to the WXHB Crosshotbar found in FFXIV.

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

   self.category, self.layout = Settings.RegisterCanvasLayoutCategory(self.ConfigFrame,
                                                                      self.ConfigFrame.name)
   Settings.RegisterAddOnCategory(self.category)
   
   SLASH_CROSSHOTBAR1, SLASH_CROSSHOTBAR2 = '/chb', '/wxhb'
   local function slashcmd(msg, editBox)
      if msg == "clear layout" then
         self:ClearLayout()
      else
         Settings.OpenToCategory(self.category:GetID())
      end
   end
   SlashCmdList["CROSSHOTBAR"] = slashcmd

end
   
ConfigUI:CreateFrame()
addon.ConfigUI = ConfigUI
