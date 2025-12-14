local ADDON, addon = ...

addon.ConfigUpdated = true
addon.ApplyCallbacks = {}
addon.InitializeCallbacks = {}

addon.GamePadButtonList = {
   "FACER",
   "FACEU",
   "FACED",
   "FACEL",
   "DPADR",
   "DPADU",
   "DPADD",
   "DPADL",
   "STCKL",
   "STCKR",
   "SPADL",
   "SPADR",
   "TRIGL",
   "TRIGR",
   "PPADL",
   "PPADR",
   "TPADL",
   "TPADR",
   "SOCIA",
   "OPTIO",
   "SYSTM"
}

addon.GamePadButtonHotKeys = {
   FACER = {'PAD2', '', ''},
   FACEU = {'PAD4', '', ''},
   FACED = {'PAD1', '', ''},
   FACEL = {'PAD3', '', ''},
   DPADR = {'PADDRIGHT', '', ''},
   DPADU = {'PADDUP', '', ''},
   DPADD = {'PADDDOWN', '', ''},
   DPADL = {'PADDLEFT', '', ''},
   STCKL = {'PADLSTICK', '', ''},
   STCKR = {'PADRSTICK', '', ''},
   SPADL = {'PADLSHOULDER', '', ''},
   SPADR = {'PADRSHOULDER', '', ''},
   TRIGL = {'PADLTRIGGER', '', ''},
   TRIGR = {'PADRTRIGGER', '', ''},
   PPADL = {'PADPADDLE2', '', ''},
   PPADR = {'PADPADDLE1', '', ''},
   TPADL = {'PADBACK', '', ''},
   TPADR = {'PAD6', '', ''},
   SOCIA = {'PADSOCIAL', '', ''},
   OPTIO = {'PADFORWARD', '', ''},
   SYSTM = {'PADSYSTEM', '', ''}
}

addon.GamePadModifierList = {
   "SPADL",
   "SPADR",
   "PPADL",
   "PPADR"
}

addon.Defaults_DB = {
   HBARType = "LIBA",
   GPEnable = true,
   Presets = {
      [1] = {
         Mutable = false,
         Name = "Gamepad_Preset",
         Description="Preset for PS4/5 Controllers which mirrors FFXIV controller settings. The default dpad is set to party and raid unit naviation for both up and down and left and right. Zoom actions are moved from L1 RSTICK to L1 DPad up and DPad down. Paging is available with R1 and Face buttons with next and previous page in DPad up and down.",
         Hotbar = {
            WXHBType = "HIDE",
            DDAAType = "DADA",
            HKEYType = "_SHP",
            LPagePrefix = "",
            RPagePrefix = "[overridebar][possessbar][shapeshift][bonusbar:5]possess;[bonusbar:3]9;[bonusbar:1,stealth:1]8;[bonusbar:1]7;[bonusbar:4]10;",
            LRPagePrefix = "",
            RLPagePrefix = "",
            LPageIndex = 2,
            RPageIndex = 1,
            LRPageIndex = 6,
            RLPageIndex = 5
         },
         GamePad = {
            CVSetup = true,
            MouseLook = false,
            GamePadLook = true,
            GPAutoCursor = 0,
            GPAutoSticks = 0,
            GPAutoJump = 0,
            GPTargetCursor = 1,
            GPCenterCursor = 0,
            GPCenterEmu = 1,
            GPDeviceID = 1,
            GPYawSpeed = 3,
            GPPitchSpeed = 3,
            GPShift = "NONE",
            GPCtrl = "NONE",
            GPAlt = "NONE",
            GPLeftClick = "PADLTRIGGER",
            GPRightClick = "PADRTRIGGER",
            GPOverlapMouse = 2000
         },
         PadActions = {
            FACER = {BIND="PAD2",         ACTION="CLEARTARGETING",   TRIGACTION="HOTBARBTN1",          SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="PAGEONE",      SPADRTRIGACTION="NONE",     PPADLACTION="UNITNAVRIGHT",        PPADLTRIGACTION="HOTBARBTN5",      PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            FACEU = {BIND="PAD4",         ACTION="JUMP",             TRIGACTION="HOTBARBTN2",          SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="PAGETWO",      SPADRTRIGACTION="NONE",     PPADLACTION="UNITNAVUP",           PPADLTRIGACTION="HOTBARBTN6",      PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            FACED = {BIND="PAD1",         ACTION="INTERACTTARGET",   TRIGACTION="HOTBARBTN3",          SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="PAGETHREE",    SPADRTRIGACTION="NONE",     PPADLACTION="UNITNAVDOWN",         PPADLTRIGACTION="HOTBARBTN7",      PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            FACEL = {BIND="PAD3" ,        ACTION="TOGGLEWORLDMAP",   TRIGACTION="HOTBARBTN4",          SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="PAGEFOUR",     SPADRTRIGACTION="NONE",     PPADLACTION="UNITNAVLEFT",         PPADLTRIGACTION="HOTBARBTN8",      PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            DPADR = {BIND="PADDRIGHT",    ACTION="UNITNAVRIGHT",     TRIGACTION="HOTBARBTN5",          SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="HOTBARBTN9",      PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            DPADU = {BIND="PADDUP",       ACTION="UNITNAVUP",        TRIGACTION="HOTBARBTN6",          SPADLACTION="ZOOMIN",        SPADLTRIGACTION="NONE",     SPADRACTION="NEXTPAGE",     SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="HOTBARBTN10",     PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            DPADD = {BIND="PADDDOWN",     ACTION="UNITNAVDOWN",      TRIGACTION="HOTBARBTN7",          SPADLACTION="ZOOMOUT",       SPADLTRIGACTION="NONE",     SPADRACTION="PREVPAGE",     SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="HOTBARBTN11",     PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            DPADL = {BIND="PADDLEFT",     ACTION="UNITNAVLEFT",      TRIGACTION="HOTBARBTN8",          SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="HOTBARBTN12",     PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            STCKL = {BIND="PADLSTICK",    ACTION="MACRO CH_MACRO_1", TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            STCKR = {BIND="PADRSTICK",    ACTION="TOGGLESHEATH",     TRIGACTION="EXTRAACTIONBUTTON1",  SPADLACTION="GAMEPADMOUSE",  SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            SPADL = {BIND="PADLSHOULDER", ACTION="LEFTSHOULDER",     TRIGACTION="TARGETPREVIOUSENEMY", SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="TARGETLASTHOSTILE",   PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            SPADR = {BIND="PADRSHOULDER", ACTION="RIGHTSHOULDER",    TRIGACTION="TARGETNEARESTENEMY",  SPADLACTION="TOGGLESHEATH",  SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="ASSISTTARGET",        PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            TRIGL = {BIND="PADLTRIGGER",  ACTION="LEFTHOTBAR",       TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            TRIGR = {BIND="PADRTRIGGER",  ACTION="RIGHTHOTBAR",      TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            PPADL = {BIND="PADPADDLE2",   ACTION="LEFTPADDLE",       TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            PPADR = {BIND="PADPADDLE1",   ACTION="RIGHTPADDLE",      TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            TPADL = {BIND="PADBACK",      ACTION="NONE",             TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            TPADR = {BIND="PAD6",         ACTION="NONE",             TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            SOCIA = {BIND="PADSOCIAL",    ACTION="TOGGLEGAMEMENU",   TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            OPTIO = {BIND="PADFORWARD",   ACTION="GAMEPADMOUSE",     TRIGACTION="CAMERALOOKTOGGLE",    SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            SYSTM = {BIND="PADSYSTEM",    ACTION="NONE",             TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}
         }
      },
      [2] = {
         Mutable = false,
         Name = "Keyboard_Preset",
         Description="Preset for keyboard binding swhich mirrors FFXIV controller settings. The default dpad is set to party and raid unit naviation for both up and down and left and right. Zoom actions are moved from L1 RSTICK to L1 DPad up and DPad down. Paging is available with R1 and Face buttons with next and previous page in DPad up and down.",
         Hotbar = {
            WXHBType = "HIDE",
            DDAAType = "DADA",
            HKEYType = "_LTR",
            LPagePrefix = "",
            RPagePrefix = "[overridebar][possessbar][shapeshift][bonusbar:5]possess;[bonusbar:3]9;[bonusbar:1,stealth:1]8;[bonusbar:1]7;[bonusbar:4]10;",
            LRPagePrefix = "",
            RLPagePrefix = "",
            LPageIndex = 2,
            RPageIndex = 1,
            LRPageIndex = 6,
            RLPageIndex = 5
         },
         GamePad = {
            CVSetup = true,
            MouseLook = true,
            GamePadLook = false,
            GPAutoCursor = 0,
            GPAutoSticks = 0,
            GPAutoJump = 0,
            GPTargetCursor = 1,
            GPCenterCursor = 0,
            GPCenterEmu = 1,
            GPDeviceID = 1,
            GPYawSpeed = 3,
            GPPitchSpeed = 3,
            GPShift = "NONE",
            GPCtrl = "NONE",
            GPAlt = "NONE",
            GPLeftClick = "PADLTRIGGER",
            GPRightClick = "PADRTRIGGER",
            GPOverlapMouse = 2000
         },
         PadActions = {
            FACER = {BIND="1", ACTION="CLEARTARGETING",   TRIGACTION="HOTBARBTN1",          SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="PAGEONE",      SPADRTRIGACTION="NONE",     PPADLACTION="UNITNAVRIGHT",        PPADLTRIGACTION="HOTBARBTN5",      PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            FACEU = {BIND="2", ACTION="JUMP",             TRIGACTION="HOTBARBTN2",          SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="PAGETWO",      SPADRTRIGACTION="NONE",     PPADLACTION="UNITNAVUP",           PPADLTRIGACTION="HOTBARBTN6",      PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}, 
            FACED = {BIND="3", ACTION="INTERACTTARGET",   TRIGACTION="HOTBARBTN3",          SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="PAGETHREE",    SPADRTRIGACTION="NONE",     PPADLACTION="UNITNAVDOWN",         PPADLTRIGACTION="HOTBARBTN7",      PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}, 
            FACEL = {BIND="4" ,ACTION="TOGGLEWORLDMAP",   TRIGACTION="HOTBARBTN4",          SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="PAGEFOUR",     SPADRTRIGACTION="NONE",     PPADLACTION="UNITNAVLEFT",         PPADLTRIGACTION="HOTBARBTN8",      PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}, 
            DPADR = {BIND="5", ACTION="UNITNAVRIGHT",     TRIGACTION="HOTBARBTN5",          SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="HOTBARBTN9",      PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}, 
            DPADU = {BIND="6", ACTION="UNITNAVUP",        TRIGACTION="HOTBARBTN6",          SPADLACTION="ZOOMIN",        SPADLTRIGACTION="NONE",     SPADRACTION="NEXTPAGE",     SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="HOTBARBTN10",     PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}, 
            DPADD = {BIND="7", ACTION="UNITNAVDOWN",      TRIGACTION="HOTBARBTN7",          SPADLACTION="ZOOMOUT",       SPADLTRIGACTION="NONE",     SPADRACTION="PREVPAGE",     SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="HOTBARBTN11",     PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}, 
            DPADL = {BIND="8", ACTION="UNITNAVLEFT",      TRIGACTION="HOTBARBTN8",          SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="HOTBARBTN12",     PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}, 
            STCKL = {BIND="9", ACTION="MACRO CH_MACRO_1", TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}, 
            STCKR = {BIND="0", ACTION="TOGGLESHEATH",     TRIGACTION="EXTRAACTIONBUTTON1",  SPADLACTION="GAMEPADMOUSE",  SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}, 
            SPADL = {BIND="-", ACTION="LEFTSHOULDER",     TRIGACTION="TARGETPREVIOUSENEMY", SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="TARGETLASTHOSTILE",   PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}, 
            SPADR = {BIND="=", ACTION="RIGHTSHOULDER",    TRIGACTION="TARGETNEARESTENEMY",  SPADLACTION="TOGGLESHEATH",  SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="ASSISTTARGET",        PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}, 
            TRIGL = {BIND="[", ACTION="LEFTHOTBAR",       TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}, 
            TRIGR = {BIND="]", ACTION="RIGHTHOTBAR",      TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}, 
            PPADL = {BIND="\\",ACTION="LEFTPADDLE",       TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}, 
            PPADR = {BIND="'", ACTION="RIGHTPADDLE",      TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},             
            TPADL = {BIND=",", ACTION="NONE",             TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            TPADR = {BIND=".", ACTION="NONE",             TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            SOCIA = {BIND=";", ACTION="NONE",             TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            OPTIO = {BIND="/", ACTION="NONE",             TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            SYSTM = {BIND="`", ACTION="NONE",             TRIGACTION="NONE",                SPADLACTION="NONE",          SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}
         }
      },
      [3] = {
         Mutable = true,
         Name = "Steam_Controller",
         Description="Preset for Steam Controller with Face buttons on the touch pad and dpad mapped to controller face buttons. DPad swap with left back paddle. Quick party select with R1 and Face buttons. Hold mouse with right back paddle for mouse over actions. Requires correct steam config.",
         Hotbar = {
            WXHBType = "SHOW",
            DDAAType = "DDAA",
            HKEYType = "_LTR",
            LPagePrefix = "[overridebar][possessbar][shapeshift][bonusbar:5]possess;[bonusbar:3]9;[bonusbar:1,stealth:1]8;[bonusbar:1]7;[bonusbar:4]10;",
            RPagePrefix = "",
            LRPagePrefix = "",
            RLPagePrefix = "",
            LPageIndex = 2,
            RPageIndex = 1,
            LRPageIndex = 6,
            RLPageIndex = 5
         },
         GamePad = {
            CVSetup = true,
            MouseLook = true,
            GamePadLook = false,
            GPAutoCursor = 0,
            GPAutoSticks = 0,
            GPAutoJump = 0,
            GPTargetCursor = 1,
            GPCenterCursor = 0,
            GPCenterEmu = 1,
            GPDeviceID = 1,
            GPYawSpeed = 3,
            GPPitchSpeed = 3,
            GPShift = "NONE",
            GPCtrl = "NONE",
            GPAlt = "NONE",
            GPLeftClick = "PADLTRIGGER",
            GPRightClick = "PADRTRIGGER",
            GPOverlapMouse = 2000
         },
         PadActions = {
            FACER = {BIND="1",  ACTION="UNITNAVRIGHT",     TRIGACTION="HOTBARBTN1",          SPADLACTION="TARGETPARTYMEMBER2",     SPADLTRIGACTION="NONE",     SPADRACTION="PAGEONE",     SPADRTRIGACTION="NONE",         PPADLACTION="NONE",               PPADLTRIGACTION="HOTBARBTN5",          PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            FACEU = {BIND="2",  ACTION="UNITNAVUP",        TRIGACTION="HOTBARBTN2",          SPADLACTION="TARGETPARTYMEMBER1",     SPADLTRIGACTION="NONE",     SPADRACTION="PAGETWO",     SPADRTRIGACTION="NONE",         PPADLACTION="NONE",               PPADLTRIGACTION="HOTBARBTN6",          PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            FACED = {BIND="3",  ACTION="UNITNAVDOWN",      TRIGACTION="HOTBARBTN3",          SPADLACTION="TARGETPARTYMEMBER3",     SPADLTRIGACTION="NONE",     SPADRACTION="PAGETHREE",   SPADRTRIGACTION="NONE",         PPADLACTION="NONE",               PPADLTRIGACTION="HOTBARBTN7",          PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            FACEL = {BIND="4" , ACTION="UNITNAVLEFT",      TRIGACTION="HOTBARBTN4",          SPADLACTION="TARGETPARTYMEMBER4",     SPADLTRIGACTION="NONE",     SPADRACTION="PAGEFOUR",    SPADRTRIGACTION="NONE",         PPADLACTION="NONE",               PPADLTRIGACTION="HOTBARBTN8",          PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            DPADR = {BIND="5",  ACTION="CLEARTARGETING",   TRIGACTION="HOTBARBTN9",          SPADLACTION="NONE",                   SPADLTRIGACTION="NONE",     SPADRACTION="NEXTPAGE",    SPADRTRIGACTION="NONE",         PPADLACTION="UNITNAVRIGHT",       PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            DPADU = {BIND="6",  ACTION="JUMP",             TRIGACTION="HOTBARBTN10",         SPADLACTION="NONE",                   SPADLTRIGACTION="NONE",     SPADRACTION="ZOOMIN",      SPADRTRIGACTION="NONE",         PPADLACTION="UNITNAVUP",          PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            DPADD = {BIND="7",  ACTION="INTERACTTARGET",   TRIGACTION="HOTBARBTN11",         SPADLACTION="NONE",                   SPADLTRIGACTION="NONE",     SPADRACTION="ZOOMOUT",     SPADRTRIGACTION="NONE",         PPADLACTION="UNITNAVDOWN",        PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            DPADL = {BIND="8",  ACTION="TOGGLEWORLDMAP",   TRIGACTION="HOTBARBTN12",         SPADLACTION="NONE",                   SPADLTRIGACTION="NONE",     SPADRACTION="PREVPAGE",    SPADRTRIGACTION="NONE",         PPADLACTION="UNITNAVLEFT",        PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            STCKL = {BIND="9",  ACTION="MACRO CH_MACRO_1", TRIGACTION="NONE",                SPADLACTION="NONE",                   SPADLTRIGACTION="NONE",     SPADRACTION="NONE",        SPADRTRIGACTION="NONE",         PPADLACTION="NONE",               PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            STCKR = {BIND="0",  ACTION="TOGGLESHEATH",     TRIGACTION="EXTRAACTIONBUTTON1",  SPADLACTION="TARGETSELF",             SPADLTRIGACTION="NONE",     SPADRACTION="NONE",        SPADRTRIGACTION="NONE",         PPADLACTION="NONE",               PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            SPADL = {BIND="-",  ACTION="LEFTSHOULDER",     TRIGACTION="TARGETPREVIOUSENEMY", SPADLACTION="NONE",                   SPADLTRIGACTION="NONE",     SPADRACTION="NONE",        SPADRTRIGACTION="NONE",         PPADLACTION="TARGETLASTHOSTILE",  PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            SPADR = {BIND="=",  ACTION="RIGHTSHOULDER",    TRIGACTION="TARGETNEARESTENEMY",  SPADLACTION="TOGGLESHEATH",           SPADLTRIGACTION="NONE",     SPADRACTION="NONE",        SPADRTRIGACTION="NONE",         PPADLACTION="ASSISTTARGET",       PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            TRIGL = {BIND="[",  ACTION="LEFTHOTBAR",       TRIGACTION="NONE",                SPADLACTION="NONE",                   SPADLTRIGACTION="NONE",     SPADRACTION="NONE",        SPADRTRIGACTION="NONE",         PPADLACTION="NONE",               PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            TRIGR = {BIND="]",  ACTION="RIGHTHOTBAR",      TRIGACTION="NONE",                SPADLACTION="NONE",                   SPADLTRIGACTION="NONE",     SPADRACTION="NONE",        SPADRTRIGACTION="NONE",         PPADLACTION="NONE",               PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            PPADL = {BIND="\\", ACTION="LEFTPADDLE",       TRIGACTION="NONE",                SPADLACTION="NONE",                   SPADLTRIGACTION="NONE",     SPADRACTION="NONE",        SPADRTRIGACTION="NONE",         PPADLACTION="NONE",               PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            PPADR = {BIND="'",  ACTION="CAMERALOOKHOLD",   TRIGACTION="NONE",                SPADLACTION="NONE",                   SPADLTRIGACTION="NONE",     SPADRACTION="NONE",        SPADRTRIGACTION="NONE",         PPADLACTION="NONE",               PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            TPADL = {BIND=",",  ACTION="CAMERALOOKON",     TRIGACTION="NONE",                SPADLACTION="NONE",                   SPADLTRIGACTION="NONE",     SPADRACTION="NONE",        SPADRTRIGACTION="NONE",         PPADLACTION="NONE",               PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            TPADR = {BIND=".",  ACTION="CAMERALOOKOFF",    TRIGACTION="NONE",                SPADLACTION="NONE",                   SPADLTRIGACTION="NONE",     SPADRACTION="NONE",        SPADRTRIGACTION="NONE",         PPADLACTION="NONE",               PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            SOCIA = {BIND=";",  ACTION="GAMEMENU",         TRIGACTION="NONE",                SPADLACTION="NONE",                   SPADLTRIGACTION="NONE",     SPADRACTION="NONE",        SPADRTRIGACTION="NONE",         PPADLACTION="NONE",               PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            OPTIO = {BIND="/",  ACTION="NONE",             TRIGACTION="NONE",                SPADLACTION="NONE",                   SPADLTRIGACTION="NONE",     SPADRACTION="NONE",        SPADRTRIGACTION="NONE",         PPADLACTION="NONE",               PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            SYSTM = {BIND="`",  ACTION="NONE",             TRIGACTION="NONE",                SPADLACTION="NONE",                   SPADLTRIGACTION="NONE",     SPADRACTION="NONE",        SPADRTRIGACTION="NONE",         PPADLACTION="NONE",               PPADLTRIGACTION="NONE",                PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}
         }
      },
      [4] = {
         Mutable = true,
         Name = "Dualshock 5 Edge",
         Description="Preset for DS5 Edge with back paddles. DPad swap with left back paddle. Quick party select with R1 and Face buttons. Hold mouse with right back paddle for mouse over actions.",
         Hotbar = {
            WXHBType = "SHOW",
            DDAAType = "DDAA",
            HKEYType = "_SHP",
            LPagePrefix = "[overridebar][possessbar][shapeshift][bonusbar:5]possess;[bonusbar:3]9;[bonusbar:1,stealth:1]8;[bonusbar:1]7;[bonusbar:4]10;",
            RPagePrefix = "",
            LRPagePrefix = "",
            RLPagePrefix = "",
            LPageIndex = 2,
            RPageIndex = 1,
            LRPageIndex = 6,
            RLPageIndex = 5
         },
         GamePad = {
            CVSetup = true,
            MouseLook = false,
            GamePadLook = true,
            GPAutoCursor = 0,
            GPAutoSticks = 0,
            GPAutoJump = 0,
            GPTargetCursor = 0,
            GPCenterCursor = 0,
            GPCenterEmu = 1,
            GPDeviceID = 1,
            GPYawSpeed = 3,
            GPPitchSpeed = 3,
            GPShift = "NONE",
            GPCtrl = "NONE",
            GPAlt = "NONE",
            GPLeftClick = "PADLTRIGGER",
            GPRightClick = "PADRTRIGGER",
            GPOverlapMouse = 2000
         },
         PadActions = {
            FACER = {BIND="PAD2",         ACTION="CLEARTARGETING",   TRIGACTION="HOTBARBTN1",          SPADLACTION="TARGETPARTYMEMBER2",      SPADLTRIGACTION="NONE",     SPADRACTION="PAGEONE",      SPADRTRIGACTION="NONE",     PPADLACTION="UNITNAVRIGHT",        PPADLTRIGACTION="HOTBARBTN5",      PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            FACEU = {BIND="PAD4",         ACTION="JUMP",             TRIGACTION="HOTBARBTN2",          SPADLACTION="TARGETPARTYMEMBER1",      SPADLTRIGACTION="NONE",     SPADRACTION="PAGETWO",      SPADRTRIGACTION="NONE",     PPADLACTION="UNITNAVUP",           PPADLTRIGACTION="HOTBARBTN6",      PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            FACED = {BIND="PAD1",         ACTION="INTERACTTARGET",   TRIGACTION="HOTBARBTN3",          SPADLACTION="TARGETPARTYMEMBER3",      SPADLTRIGACTION="NONE",     SPADRACTION="PAGETHREE",    SPADRTRIGACTION="NONE",     PPADLACTION="UNITNAVDOWN",         PPADLTRIGACTION="HOTBARBTN7",      PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            FACEL = {BIND="PAD3" ,        ACTION="TOGGLEWORLDMAP",   TRIGACTION="HOTBARBTN4",          SPADLACTION="TARGETPARTYMEMBER4",      SPADLTRIGACTION="NONE",     SPADRACTION="PAGEFOUR",     SPADRTRIGACTION="NONE",     PPADLACTION="UNITNAVLEFT",         PPADLTRIGACTION="HOTBARBTN8",      PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            DPADR = {BIND="PADDRIGHT",    ACTION="UNITNAVRIGHT",     TRIGACTION="HOTBARBTN5",          SPADLACTION="NONE",                    SPADLTRIGACTION="NONE",     SPADRACTION="NEXTPAGE",     SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="HOTBARBTN9",      PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            DPADU = {BIND="PADDUP",       ACTION="UNITNAVUP",        TRIGACTION="HOTBARBTN6",          SPADLACTION="NONE",                    SPADLTRIGACTION="NONE",     SPADRACTION="ZOOMIN",       SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="HOTBARBTN10",     PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            DPADD = {BIND="PADDDOWN",     ACTION="UNITNAVDOWN",      TRIGACTION="HOTBARBTN7",          SPADLACTION="NONE",                    SPADLTRIGACTION="NONE",     SPADRACTION="ZOOMOUT",      SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="HOTBARBTN11",     PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            DPADL = {BIND="PADDLEFT",     ACTION="UNITNAVLEFT",      TRIGACTION="HOTBARBTN8",          SPADLACTION="NONE",                    SPADLTRIGACTION="NONE",     SPADRACTION="PREVPAGE",     SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="HOTBARBTN12",     PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            STCKL = {BIND="PADLSTICK",    ACTION="MACRO CH_MACRO_1", TRIGACTION="NONE",                SPADLACTION="NONE",                    SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            STCKR = {BIND="PADRSTICK",    ACTION="TOGGLESHEATH",     TRIGACTION="EXTRAACTIONBUTTON1",  SPADLACTION="TARGETSELF",              SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            SPADL = {BIND="PADLSHOULDER", ACTION="LEFTSHOULDER",     TRIGACTION="TARGETPREVIOUSENEMY", SPADLACTION="NONE",                    SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="TARGETLASTHOSTILE",   PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            SPADR = {BIND="PADRSHOULDER", ACTION="RIGHTSHOULDER",    TRIGACTION="TARGETNEARESTENEMY",  SPADLACTION="TOGGLESHEATH",            SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="ASSISTTARGET",        PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            TRIGL = {BIND="PADLTRIGGER",  ACTION="LEFTHOTBAR",       TRIGACTION="NONE",                SPADLACTION="NONE",                    SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            TRIGR = {BIND="PADRTRIGGER",  ACTION="RIGHTHOTBAR",      TRIGACTION="NONE",                SPADLACTION="NONE",                    SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            PPADL = {BIND="PADPADDLE2",   ACTION="LEFTPADDLE",       TRIGACTION="NONE",                SPADLACTION="NONE",                    SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            PPADR = {BIND="PADPADDLE1",   ACTION="CAMERALOOKHOLD",   TRIGACTION="NONE",                SPADLACTION="NONE",                    SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            TPADL = {BIND="PADBACK",      ACTION="NONE",             TRIGACTION="NONE",                SPADLACTION="NONE",                    SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            TPADR = {BIND="PAD6",         ACTION="NONE",             TRIGACTION="NONE",                SPADLACTION="NONE",                    SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            SOCIA = {BIND="PADSOCIAL",    ACTION="TOGGLEGAMEMENU",   TRIGACTION="NONE",                SPADLACTION="NONE",                    SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            OPTIO = {BIND="PADFORWARD",   ACTION="GAMEPADMOUSE",     TRIGACTION="NONE",                SPADLACTION="NONE",                    SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"},
            SYSTM = {BIND="PADSYSTEM",    ACTION="NONE",             TRIGACTION="NONE",                SPADLACTION="NONE",                    SPADLTRIGACTION="NONE",     SPADRACTION="NONE",         SPADRTRIGACTION="NONE",     PPADLACTION="NONE",                PPADLTRIGACTION="NONE",            PPADRACTION="NONE",      PPADRTRIGACTION="NONE"}
         }
      }
   }
}

addon.Config = CopyTable(addon.Defaults_DB.Presets[1])
addon.Config.Mutable = true
addon.Config.Name = ""

function addon.Config:SetHotKeyText()
end

function addon.Config:ConfigListAdd(listname, valuetable, initvalue)
   if addon[listname] == nil then
      addon[listname] = {initvalue}
   end
   
   local keys = {}
   for key in pairs(valuetable) do
      table.insert(keys, key)
   end
   table.sort(keys)

   for i,key in ipairs(keys) do
      table.insert(addon[listname], key)
   end
end

function addon.Config:StorePreset(to, from)
   if to.Mutable then
      if from.Mutable then
         to.Name = from.Name
      else
         to.Name = ""
      end
      to.Description = from.Description
      to.Hotbar = {}
      for key, value in pairs(from.Hotbar) do
         to.Hotbar[key] = value 
      end
      
      to.GamePad = {}
      for key, value in pairs(from.GamePad) do
         to.GamePad[key] = value 
      end
      
      to.PadActions = {}
      for button, attributes in pairs(from.PadActions) do
         for key, value in pairs(attributes) do
            if to.PadActions[button] == nil then
               to.PadActions[button] = {}
            end
            to.PadActions[button][key] = value 
         end
      end
   end
end

function addon:AddApplyCallback(applyfunc)
   table.insert(self.ApplyCallbacks, applyfunc)
end

function addon:AddInitCallback(initfunc)
   table.insert(self.InitializeCallbacks, initfunc)
end

function addon:GetButtonIcon(button)
   return addon.GamePadButtonHotKeys[button][2]
end

function addon:GetButtonHotKey(button)
   return addon.GamePadButtonHotKeys[button][3]
end

function addon:ApplyConfig(updated)
   if updated then
      addon.ConfigUpdated = true
   end
   for key,button in pairs(addon.GamePadButtonHotKeys) do
      local text = button[1] .. addon.Config.Hotbar.HKEYType
      button[2] = GetBindingText(text)
      if button[2] == text then
         button[2] = GetBindingText(button[1])
      end
      button[3] = GetBindingText(text, 'KEY_ABBR_')
      if button[3] == text then
         button[3] = GetBindingText(button[1], 'KEY_ABBR_')
      end
      addon.GamePadButtonHotKeys[key][2] = button[2]
      addon.GamePadButtonHotKeys[key][3] = button[3]
   end
   if addon.ConfigUpdated then
      if not InCombatLockdown() then 
         for i,callback in ipairs(addon.ApplyCallbacks) do
            callback()
         end
         addon.ConfigUpdated = false
      end
   end
end

function addon:InitConfig()
   
   if CrossHotbar_DB == nil then
      CrossHotbar_DB = {
         Version = "v1.0.0",
         ActivePreset = 1,
         HBARType = "LIBA",
         GPEnable = true,
         Presets = {}
      }
   end
   
   local preset = CrossHotbar_DB.ActivePreset;
   local hassaves = false
   for k,preset in pairs(CrossHotbar_DB.Presets) do
      if preset.Mutable then
         hassaves = true
      end
   end
   
   for k,default in pairs(addon.Defaults_DB) do
      if CrossHotbar_DB[k] == nil then
         if type(default) == "table" then
            CrossHotbar_DB[k] = CopyTable(default)
         else
            CrossHotbar_DB[k] = default
         end
      end
   end
   
   for k,default in pairs(addon.Defaults_DB.Presets) do
      if not default.Mutable or not hassaves then
         CrossHotbar_DB.Presets[k] = CopyTable(default)
      end
   end

   addon.Config:StorePreset(addon.Config, CrossHotbar_DB.Presets[preset])
   for i,callback in ipairs(addon.InitializeCallbacks) do
      callback()
   end
   
   EventRegistry:UnregisterFrameEventAndCallback("ADDON_LOADED", addon)
end

EventRegistry:RegisterFrameEventAndCallback("PLAYER_ENTERING_WORLD", addon.ApplyConfig, addon)
EventRegistry:RegisterFrameEventAndCallback("PLAYER_REGEN_ENABLED", addon.ApplyConfig, addon)
EventRegistry:RegisterFrameEventAndCallback("ADDON_LOADED", addon.InitConfig, addon)

addon.UIHider = CreateFrame("Frame", nil, UIParent)
addon.UIHider:SetAllPoints(UIParent)
addon.UIHider:Hide()
