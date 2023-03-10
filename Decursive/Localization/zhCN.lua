--[[
    This file is part of Decursive.

    Decursive (v 2.7.7) add-on for World of Warcraft UI
    Copyright (C) 2006-2019 John Wellesz (Decursive AT 2072productions.com) ( http://www.2072productions.com/to/decursive.php )

    Decursive is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Decursive is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Decursive.  If not, see <https://www.gnu.org/licenses/>.


    Decursive is inspired from the original "Decursive v1.9.4" by Patrick Bohnet (Quu).
    The original "Decursive 1.9.4" is in public domain ( www.quutar.com )

    Decursive is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY.

    This file was last updated on 2019-11-18T13:42:00Z
--]]
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Simplified Chinese localization
-------------------------------------------------------------------------------

--[=[
--                      YOUR ATTENTION PLEASE
--
--         !!!!!!! TRANSLATORS TRANSLATORS TRANSLATORS !!!!!!!
--
--    Thank you very much for your interest in translating Decursive.
--    Do not edit those files. Use the localization interface available at the following address:
--
--      ################################################################
--      #  http://wow.curseforge.com/projects/decursive/localization/  #
--      ################################################################
--
--    Your translations made using this interface will be automatically included in the next release.
--
--]=]

local addonName, T = ...;
-- big ugly scary fatal error message display function {{{
if not T._FatalError then
-- the beautiful error popup : {{{ -
StaticPopupDialogs["DECURSIVE_ERROR_FRAME"] = {
    text = "|cFFFF0000Decursive Error:|r\n%s",
    button1 = "OK",
    OnAccept = function()
        return false;
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    showAlert = 1,
    preferredIndex = 3,
    }; -- }}}
T._FatalError = function (TheError) StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end
end
-- }}}
if not T._LoadedFiles or not T._LoadedFiles["enUS.lua"] then
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end
T._LoadedFiles["zhCN.lua"] = false;

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "zhCN");

if not L then
    T._LoadedFiles["zhCN.lua"] = "2.7.7";
    return;
end;

L["ABOLISH_CHECK"] = "?????????????????????????????????"
L["ABOUT_AUTHOREMAIL"] = "?????? E-MAIL"
L["ABOUT_CREDITS"] = "?????????"
L["ABOUT_LICENSE"] = "??????"
L["ABOUT_NOTES"] = "???????????????????????????????????????????????????????????????????????????????????????????????????"
L["ABOUT_OFFICIALWEBSITE"] = "????????????"
L["ABOUT_SHAREDLIBS"] = "?????????"
L["ABSENT"] = "????????????%s???"
L["AFFLICTEDBY"] = "???%s??????"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "???????????????????????????"
L["ANCHOR"] = "Decursive ????????????"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "??????????????????????????????"
L["BINDING_NAME_DCRPRADD"] = "???????????????????????????"
L["BINDING_NAME_DCRPRCLEAR"] = "??????????????????"
L["BINDING_NAME_DCRPRLIST"] = "??????????????????????????????"
L["BINDING_NAME_DCRPRSHOW"] = "??????/??????????????????"
L["BINDING_NAME_DCRSHOW"] = [=[??????????????? Decursive ?????????
????????????????????????]=]
L["BINDING_NAME_DCRSHOWOPTION"] = "????????????????????????"
L["BINDING_NAME_DCRSKADD"] = "???????????????????????????"
L["BINDING_NAME_DCRSKCLEAR"] = "??????????????????"
L["BINDING_NAME_DCRSKLIST"] = "??????????????????????????????"
L["BINDING_NAME_DCRSKSHOW"] = "??????/??????????????????"
L["BLACK_LENGTH"] = "????????????????????????"
L["BLACKLISTED"] = "?????????"
L["CHARM"] = "??????"
L["CLASS_HUNTER"] = "??????"
L["CLEAR_PRIO"] = "C"
L["CLEAR_SKIP"] = "C"
L["COLORALERT"] = "??????%s?????????????????????????????????"
L["COLORCHRONOS"] = "???????????????"
L["COLORCHRONOS_DESC"] = "???????????????????????????"
L["COLORSTATUS"] = "?????????%s?????????????????????????????????"
L["CTRL"] = "Ctrl"
L["CURE_PETS"] = "?????????????????????"
L["CURSE"] = "??????"
L["DEBUG_REPORT_HEADER"] = "|cFF11FF33?????????????????????????????? <%s>|r |cFF009999????????? Ctrl+A ???????????? Ctrl+C ???????????????????????????|r ???????????? %s ???????????????????????????????????????"
L["DECURSIVE_DEBUG_REPORT"] = "**** |cFFFF0000Decursive ????????????|r ****"
L["DECURSIVE_DEBUG_REPORT_BUT_NEW_VERSION"] = [=[|cFF11FF33Decursive ???????????????????????????????????? Decursive ????????????????????????%s????????????????????????????????? curse.com ????????????Decursive???'????????? Curse ??????????????????????????????????????????|r
|cFFFF1133????????????????????????????????????????????????????????????????????????????????? Decursive ????????????????????????|r
|cFF11FF33????????????????????????|r
]=]
L["DECURSIVE_DEBUG_REPORT_NOTIFY"] = [=[???????????????????????????
??????|cFFFF0000/DCRREPORT|r ??????]=]
L["DECURSIVE_DEBUG_REPORT_SHOW"] = "?????????????????????"
L["DECURSIVE_DEBUG_REPORT_SHOW_DESC"] = "??????????????????????????????????????????"
L["DEFAULT_MACROKEY"] = "`"
L["DEV_VERSION_ALERT"] = [=[???????????????????????????????????? Decursive???

???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? curse.com ??? wowace.com ????????????????????????????????????

??????????????????????????????????????????????????????]=]
L["DEV_VERSION_EXPIRED"] = [=[???????????? Decursive ????????????
?????? CURSE.COM ??? WOWACE.COM ???????????????????????????????????????????????????
?????????????????????????????????]=]
L["DEWDROPISGONE"] = "??????????????? Ace3 ??? DewDrop???Alt+?????????????????????????????????"
L["DISABLEWARNING"] = [=[Decursive ???????????????

???????????????????????? |cFFFFAA44/DCR ENABLE|r]=]
L["DISEASE"] = "??????"
L["DONOT_BL_PRIO"] = "?????????????????????????????????????????????"
L["DONT_SHOOT_THE_MESSENGER"] = "Decursive ??????????????????????????????????????????????????????????????????????????????"
L["FAILEDCAST"] = [=[|cFF22FFFF%s %s|r |cFFAA0000???????????????|r %s
|cFF00AAAA%s|r]=]
L["FOCUSUNIT"] = "????????????"
L["FUBARMENU"] = "FuBar ??????"
L["FUBARMENU_DESC"] = "?????? FuBar ??????????????????"
L["GLOR1"] = "?????? Glorfindal"
L["GLOR2"] = [=[Decursive ?????????????????????????????? Bertrand???
?????????????????????????????????]=]
L["GLOR3"] = [=[?????? Bertrand
1969 - 2007]=]
L["GLOR4"] = [=[??????????????????????????????????????? Glorfindal ???????????????????????????????????????????????????????????????????????????????????????

??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????

?????????????????????????????????38????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????]=]
L["GLOR5"] = "????????????????????????????????????"
L["HANDLEHELP"] = "???????????????????????????"
L["HIDE_MAIN"] = "?????? Decursive ??????"
L["HIDESHOW_BUTTONS"] = "??????/?????????????????????/?????????Decursive??????"
L["HLP_LEFTCLICK"] = "????????????"
L["HLP_LL_ONCLICK_TEXT"] = [=[????????????????????????????????????????????????????????????????????????????????????????????? WoWAce.com ???????????????Decursive???
?????? Decursive ???????????????????????????/dcrshow ????????????Alt+???????????????]=]
L["HLP_MIDDLECLICK"] = "????????????"
L["HLP_MOUSE4"] = "????????????4"
L["HLP_MOUSE5"] = "????????????5"
L["HLP_NOTHINGTOCURE"] = "?????????????????????????????????"
L["HLP_RIGHTCLICK"] = "????????????"
L["HLP_USEXBUTTONTOCURE"] = "??????%s?????????????????????????????????"
L["HLP_WRONGMBUTTON"] = "????????????????????????"
L["IGNORE_STEALTH"] = "?????????????????????"
L["IS_HERE_MSG"] = "Decursive ?????????????????????????????????????????????/decursive???"
L["LIST_ENTRY_ACTIONS"] = [=[|cFF33AA33[Ctrl]+??????|r??????????????????
|cFF33AA33??????|r??????????????????
|cFF33AA33??????|r??????????????????
|cFF33AA33[Shift]+??????|r???????????????????????????
|cFF33AA33[Shift]+??????|r???????????????????????????]=]
L["MACROKEYALREADYMAPPED"] = [=[?????????Decursive ???????????????[%s]??????????????????%s??????
?????????????????????????????? Decursive ????????????????????????????????????]=]
L["MACROKEYMAPPINGFAILED"] = "??????[%s]??????????????? Decursive ??????"
L["MACROKEYMAPPINGSUCCESS"] = "??????[%s]?????????????????? Decursive ??????"
L["MACROKEYNOTMAPPED"] = "????????? Decursive ????????????????????????????????????????????????????????????"
L["MAGIC"] = "??????"
L["MAGICCHARMED"] = "????????????"
L["MISSINGUNIT"] = "????????????"
L["NEW_VERSION_ALERT"] = [=[????????? Decursive ????????????|cFFEE7722%q|r ?????????|cFFEE7722%s|r???


??? |cFFFF0000WoWAce.com|r ?????????
--------]=]
L["NORMAL"] = "??????"
L["NOSPELL"] = "??????????????????"
L["OPT_ABOLISHCHECK_DESC"] = "?????????????????????????????????????????????????????????????????????"
L["OPT_ABOUT"] = "??????"
L["OPT_ADD_A_CUSTOM_SPELL"] = "???????????????????????????/??????"
L["OPT_ADD_A_CUSTOM_SPELL_DESC"] = "??????????????????????????????????????????????????????????????????????????????????????? ID???????????????Shift+?????????"
L["OPT_ADDDEBUFF"] = "?????????????????????"
L["OPT_ADDDEBUFF_DESC"] = "?????????????????????????????????"
L["OPT_ADDDEBUFF_USAGE"] = "<????????????>???????????? WoWHead.com ????????????????????? ID???"
L["OPT_ADDDEBUFFFHIST"] = "?????????????????????????????????"
L["OPT_ADDDEBUFFFHIST_DESC"] = "???????????????????????????????????????????????????"
L["OPT_ADVDISP"] = "??????????????????"
L["OPT_ADVDISP_DESC"] = "?????????????????????????????????????????????????????????????????????????????????"
L["OPT_AFFLICTEDBYSKIPPED"] = "%s??????%s??????????????????????????????"
L["OPT_ALLOWMACROEDIT"] = "?????????????????????"
L["OPT_ALLOWMACROEDIT_DESC"] = "????????????????????? Decursive ????????????????????????????????????????????????"
L["OPT_ALWAYSIGNORE"] = "??????????????????????????????"
L["OPT_ALWAYSIGNORE_DESC"] = "???????????????????????????????????????????????????"
L["OPT_AMOUNT_AFFLIC_DESC"] = "?????????????????????????????????????????????"
L["OPT_ANCHOR_DESC"] = "?????????????????????????????????"
L["OPT_AUTOHIDEMFS"] = "????????????????????????"
L["OPT_AUTOHIDEMFS_DESC"] = "??????????????????????????????????????????"
L["OPT_BLACKLENTGH_DESC"] = "??????????????????????????????????????????????????????????????????"
L["OPT_BORDERTRANSP"] = "???????????????"
L["OPT_BORDERTRANSP_DESC"] = "????????????????????????"
L["OPT_CENTERTEXT"] = "??????????????????"
L["OPT_CENTERTEXT_DESC"] = [=[?????????????????????????????????????????????????????????????????????????????????

???????????????
- ????????????????????????
- ????????????????????????????????????
- ????????????]=]
L["OPT_CENTERTEXT_DISABLED"] = "?????????"
L["OPT_CENTERTEXT_ELAPSED"] = "????????????"
L["OPT_CENTERTEXT_STACKS"] = "??????"
L["OPT_CENTERTEXT_TIMELEFT"] = "????????????"
L["OPT_CENTERTRANSP"] = "???????????????"
L["OPT_CENTERTRANSP_DESC"] = "????????????????????????"
L["OPT_CHARMEDCHECK_DESC"] = "??????????????????????????????????????????????????????"
L["OPT_CHATFRAME_DESC"] = "Decursive ?????????????????????????????????????????????"
L["OPT_CHECKOTHERPLAYERS"] = "??????????????????"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "????????????????????????????????? Decursive ????????????????????? Decursive 2.4.6?????????????????????"
L["OPT_CMD_DISBLED"] = "?????????"
L["OPT_CMD_ENABLED"] = "?????????"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "????????????????????????????????????"
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "?????????????????????????????? Decursive ??????????????????"
L["OPT_CURE_PRIORITY_NUM"] = "????????? #%d"
L["OPT_CUREPETS_DESC"] = "??????????????????????????????"
L["OPT_CURINGOPTIONS"] = "????????????"
L["OPT_CURINGOPTIONS_DESC"] = "?????????????????????????????????????????????????????????"
L["OPT_CURINGOPTIONS_EXPLANATION"] = [=[?????????????????????????????????????????????????????????????????? Decursive ???????????????

???????????????????????????????????????????????????????????????????????????

- ??????????????????????????????????????????????????????Decursive ??????????????????

- ??????????????????????????????????????????

????????????????????????????????????????????????????????????????????????]=]
L["OPT_CURINGORDEROPTIONS"] = "????????????????????????"
L["OPT_CURSECHECK_DESC"] = "?????????????????????????????????????????????????????????????????????"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING"] = "?????????????????????????????????"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING_DESC"] = [=[????????????????????????????????? Decursive ???????????????????????????

??????????????????????????? Decursive ?????????????????????

???????????????????????????????????????????????????????????????????????????????????????

???---??????????????????---???]=]
L["OPT_CUSTOM_SPELL_CURE_TYPES"] = "????????????"
L["OPT_CUSTOM_SPELL_IS_DEFAULT"] = "??????????????? Decursive ?????????????????????????????????????????????????????????????????????????????????????????????????????? Decursive ?????????"
L["OPT_CUSTOM_SPELL_ISPET"] = "????????????"
L["OPT_CUSTOM_SPELL_ISPET_DESC"] = "???????????????????????????????????????????????????Decursive ???????????????????????????"
L["OPT_CUSTOM_SPELL_MACRO_MISSING_NOMINAL_SPELL"] = "???????????????%q?????????????????????????????????????????????????????????????????????"
L["OPT_CUSTOM_SPELL_MACRO_MISSING_UNITID_KEYWORD"] = "UNITID ???????????????"
L["OPT_CUSTOM_SPELL_MACRO_TEXT"] = "????????????"
L["OPT_CUSTOM_SPELL_MACRO_TEXT_DESC"] = [=[???????????????????????????
|cFFFF0000??????2?????????|r

- ???????????????????????? UNITID ??????????????????????????????????????????????????? ID ?????????

- ????????????????????????????????????????????? Decursive ????????????????????????????????????????????????
?????????????????????????????????????????????????????????]=]
L["OPT_CUSTOM_SPELL_MACRO_TOO_LONG"] = "????????????????????????%d?????????"
L["OPT_CUSTOM_SPELL_PRIORITY"] = "???????????????"
L["OPT_CUSTOM_SPELL_PRIORITY_DESC"] = [=[?????????????????????????????????????????????????????????????????????????????????

????????????Decursive ??????????????????????????????????????????????????????0???9???

????????????????????????????????????????????????????????????????????????????????????????????????]=]
L["OPT_CUSTOM_SPELL_UNAVAILABLE"] = "?????????"
L["OPT_CUSTOM_SPELL_UNIT_FILTER"] = "???????????????"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_DESC"] = "????????????????????????????????????"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONE"] = "????????????"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONPLAYER"] = "????????????"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_PLAYER"] = "????????????"
L["OPT_CUSTOMSPELLS"] = "???????????????/??????"
L["OPT_CUSTOMSPELLS_DESC"] = [=[???????????????????????? Decursive ??????????????????
????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
]=]
L["OPT_CUSTOMSPELLS_EFFECTIVE_ASSIGNMENTS"] = "?????????????????????"
L["OPT_DEBCHECKEDBYDEF"] = [=[

???????????????]=]
L["OPT_DEBUFFENTRY_DESC"] = "??????????????????????????????????????????????????????????????????"
L["OPT_DEBUFFFILTER"] = "????????????"
L["OPT_DEBUFFFILTER_DESC"] = "????????????????????????????????????????????????????????????"
L["OPT_DELETE_A_CUSTOM_SPELL"] = "??????"
L["OPT_DISABLEABOLISH"] = "?????????????????????????????????"
L["OPT_DISABLEABOLISH_DESC"] = "????????????Decursive ??????????????????????????????????????????????????????????????????????????????"
L["OPT_DISABLEMACROCREATION"] = "???????????????"
L["OPT_DISABLEMACROCREATION_DESC"] = "Decursive ???????????????????????????"
L["OPT_DISEASECHECK_DESC"] = "?????????????????????????????????????????????????????????????????????"
L["OPT_DISPLAYOPTIONS"] = "????????????"
L["OPT_DONOTBLPRIO_DESC"] = "????????????????????????????????????????????????"
L["OPT_ENABLE_A_CUSTOM_SPELL"] = "??????"
L["OPT_ENABLE_LIVELIST"] = "??????????????????"
L["OPT_ENABLE_LIVELIST_DESC"] = [=[???????????????????????????????????????

???????????? Decursive ??????????????????Y????????? /DCRSHOW ??????????????????]=]
L["OPT_ENABLEDEBUG"] = "????????????"
L["OPT_ENABLEDEBUG_DESC"] = "??????????????????"
L["OPT_ENABLEDECURSIVE"] = "?????? Decursive"
L["OPT_FILTERED_DEBUFF_RENAMED"] = "??????????????????%s?????????????????????%s???????????? ID %d"
L["OPT_FILTEROUTCLASSES_FOR_X"] = "???????????????????????????%q???????????????"
L["OPT_GENERAL"] = "????????????"
L["OPT_GROWDIRECTION"] = "???????????????????????????"
L["OPT_GROWDIRECTION_DESC"] = "????????????????????????????????????"
L["OPT_HIDEMFS_GROUP"] = "???????????????"
L["OPT_HIDEMFS_GROUP_DESC"] = "???????????????????????????????????????"
L["OPT_HIDEMFS_NEVER"] = "??????????????????"
L["OPT_HIDEMFS_NEVER_DESC"] = "????????????????????????????????????"
L["OPT_HIDEMFS_SOLO"] = "??????"
L["OPT_HIDEMFS_SOLO_DESC"] = "??????????????????????????????????????????????????????"
L["OPT_HIDEMUFSHANDLE"] = "???????????????????????????"
L["OPT_HIDEMUFSHANDLE_DESC"] = [=[?????????????????????????????????????????????
???????????????????????????]=]
L["OPT_IGNORESTEALTHED_DESC"] = "??????????????????????????????????????????"
L["OPT_INPUT_SPELL_BAD_INPUT_ALREADY_HERE"] = "????????????????????????"
L["OPT_INPUT_SPELL_BAD_INPUT_DEFAULT_SPELL"] = "Decursive ????????????????????????Shift+?????????????????????????????? ID ???????????????????????????"
L["OPT_INPUT_SPELL_BAD_INPUT_ID"] = "?????? ID ????????????"
L["OPT_INPUT_SPELL_BAD_INPUT_NOT_SPELL"] = "????????????????????????????????????"
L["OPT_ISNOTVALID_SPELLID"] = "????????????????????? ID"
L["OPT_LIVELIST"] = "????????????"
L["OPT_LIVELIST_DESC"] = [=[??????????????? Decursive ????????????????????????????????????????????????

????????????????????????????????????????????? Decursive ??????????????????????????????????????????????????????????????????????????????????????????????????? |cff20CC20/DCRSHOW|r ???????????????

??????????????????????????????????????????????????????????????????????????????????????? |cff20CC20/DCRHIDE|r ?????????????????? Decursive ?????????]=]
L["OPT_LLALPHA"] = "?????????????????????"
L["OPT_LLALPHA_DESC"] = "?????? Decursive ??????????????????????????????????????????????????????????????????"
L["OPT_LLSCALE"] = "??????????????????"
L["OPT_LLSCALE_DESC"] = "????????????????????????????????????????????????????????????????????????"
L["OPT_LVONLYINRANGE"] = "???????????????????????????????????????"
L["OPT_LVONLYINRANGE_DESC"] = "??????????????????????????????????????????????????????,?????????????????????????????????"
L["OPT_MACROBIND"] = "?????????????????????"
L["OPT_MACROBIND_DESC"] = [=[Decursive ???????????????

?????????????????????????????? 'Enter' ???????????????(???????????????????????????????????????)]=]
L["OPT_MACROOPTIONS"] = "?????????"
L["OPT_MACROOPTIONS_DESC"] = "?????? Decursive ??????????????????????????????????????????"
L["OPT_MAGICCHARMEDCHECK_DESC"] = "???????????????????????????????????????????????????????????????????????????"
L["OPT_MAGICCHECK_DESC"] = "???????????????????????????????????????????????????????????????????????????"
L["OPT_MAXMFS"] = "??????????????????"
L["OPT_MAXMFS_DESC"] = "???????????????????????????????????????????????????"
L["OPT_MESSAGES"] = "??????"
L["OPT_MESSAGES_DESC"] = "????????????????????????"
L["OPT_MFALPHA"] = "?????????"
L["OPT_MFALPHA_DESC"] = "??????????????????????????????????????????????????????????????????"
L["OPT_MFPERFOPT"] = "????????????"
L["OPT_MFREFRESHRATE"] = "?????????"
L["OPT_MFREFRESHRATE_DESC"] = "??????????????????????????????????????????????????????????????????????????????????????????"
L["OPT_MFREFRESHSPEED"] = "????????????"
L["OPT_MFREFRESHSPEED_DESC"] = "??????????????????????????????????????????"
L["OPT_MFSCALE"] = "?????????????????????"
L["OPT_MFSCALE_DESC"] = "??????????????????????????????"
L["OPT_MFSETTINGS"] = "?????????????????????"
L["OPT_MFSETTINGS_DESC"] = "??????????????????????????????????????????????????????????????????"
L["OPT_MUFFOCUSBUTTON"] = "???????????????"
L["OPT_MUFHANDLE_HINT"] = "????????????????????????????????????????????????????????? Alt+????????????????????????"
L["OPT_MUFMOUSEBUTTONS"] = "????????????"
L["OPT_MUFMOUSEBUTTONS_DESC"] = [=[????????????????????????????????????????????????????????????????????????

????????????????????????????????????????????????????????????|cFFFF5533????????????|r????????????

??????????????????????????????????????????????????????????????????|cFF00DDDD???????????????|r?????????????????? ]=]
L["OPT_MUFSCOLORS"] = "??????"
L["OPT_MUFSCOLORS_DESC"] = [=[???????????????????????????????????????????????????????????????????????????

???????????????|cFFFF5533????????????|r?????????????????????????????????????????????????????????]=]
L["OPT_MUFSVERTICALDISPLAY"] = "????????????"
L["OPT_MUFSVERTICALDISPLAY_DESC"] = "????????????????????????????????????"
L["OPT_MUFTARGETBUTTON"] = "???????????????"
L["OPT_NEWVERSIONBUGMENOT"] = "???????????????"
L["OPT_NEWVERSIONBUGMENOT_DESC"] = "??????????????? Decursive ??????????????????????????????????????????????????????"
L["OPT_NOKEYWARN"] = "??????????????????????????????"
L["OPT_NOKEYWARN_DESC"] = "???????????????????????????????????????"
L["OPT_NOSTARTMESSAGES"] = "??????????????????"
L["OPT_NOSTARTMESSAGES_DESC"] = "??????????????????????????????????????????????????? Decursive ?????????"
L["OPT_OPTIONS_DISABLED_WHILE_IN_COMBAT"] = "??????????????????????????????"
L["OPT_PERFOPTIONWARNING"] = "???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????0.1???10???????????????"
L["OPT_PLAYSOUND_DESC"] = "????????????????????????????????????"
L["OPT_POISONCHECK_DESC"] = "?????????????????????????????????????????????????????????????????????"
L["OPT_PRINT_CUSTOM_DESC"] = "Decursive ?????????????????????????????????????????????"
L["OPT_PRINT_ERRORS_DESC"] = "????????????????????????"
L["OPT_PROFILERESET"] = "?????????????????????"
L["OPT_RANDOMORDER_DESC"] = "????????????????????????????????????????????????"
L["OPT_READDDEFAULTSD"] = "????????????????????????"
L["OPT_READDDEFAULTSD_DESC1"] = [=[????????????????????????????????? Decursive ????????????
????????????????????????]=]
L["OPT_READDDEFAULTSD_DESC2"] = "?????? Decursive ??????????????????????????????"
L["OPT_REMOVESKDEBCONF"] = [=[???????????????
???%s???
??? Decursive ?????????????????????????????????]=]
L["OPT_REMOVETHISDEBUFF"] = "???????????????"
L["OPT_REMOVETHISDEBUFF_DESC"] = "???????????????????????????%s???"
L["OPT_RESETDEBUFF"] = "???????????????"
L["OPT_RESETDTDCRDEFAULT"] = "??????%s????????? Decursive ??????"
L["OPT_RESETMUFMOUSEBUTTONS"] = "??????"
L["OPT_RESETMUFMOUSEBUTTONS_DESC"] = "????????????????????????????????????"
L["OPT_RESETOPTIONS"] = "?????????????????????"
L["OPT_RESETOPTIONS_DESC"] = "????????????????????????????????????"
L["OPT_RESTPROFILECONF"] = [=[??????????????????????????????
???(%s) %s???
??????????????????]=]
L["OPT_REVERSE_LIVELIST_DESC"] = "?????????????????????????????????"
L["OPT_SCANLENGTH_DESC"] = "?????????????????????????????????"
L["OPT_SETAFFTYPECOLOR_DESC"] = "?????????%s????????????????????????????????????????????????????????????????????????????????????"
L["OPT_SHOW_STEALTH_STATUS"] = "??????????????????"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "?????????????????????????????????????????????????????????????????????"
L["OPT_SHOWBORDER"] = "????????????????????????"
L["OPT_SHOWBORDER_DESC"] = "??????????????????????????????????????????????????????????????????"
L["OPT_SHOWHELP"] = "????????????"
L["OPT_SHOWHELP_DESC"] = "???????????????????????????????????????????????????????????????"
L["OPT_SHOWMFS"] = "?????????????????????????????????"
L["OPT_SHOWMFS_DESC"] = "???????????????????????????????????????"
L["OPT_SHOWMINIMAPICON"] = "???????????????"
L["OPT_SHOWMINIMAPICON_DESC"] = "?????????????????????"
L["OPT_SHOWTOOLTIP_DESC"] = "?????????????????????????????????????????????????????????"
L["OPT_SPELL_DESCRIPTION_LOADING"] = "?????????????????????????????????"
L["OPT_SPELL_DESCRIPTION_UNAVAILABLE"] = "???????????????"
L["OPT_SPELLID_MISSING_READD"] = "????????????????????????????????????????????? ID ????????????????????????????????????????????????"
L["OPT_STICKTORIGHT"] = "??????????????????????????????"
L["OPT_STICKTORIGHT_DESC"] = "???????????????????????????????????????????????????"
L["OPT_TESTLAYOUT"] = "????????????"
L["OPT_TESTLAYOUT_DESC"] = [=[??????????????????????????????????????????
???????????????????????????]=]
L["OPT_TESTLAYOUTUNUM"] = "????????????"
L["OPT_TESTLAYOUTUNUM_DESC"] = "?????????????????????????????????"
L["OPT_TIE_LIVELIST_DESC"] = "?????????????????? Decursive ????????????????????????"
L["OPT_TIECENTERANDBORDER"] = "?????????????????????????????????"
L["OPT_TIECENTERANDBORDER_OPT"] = "?????????????????????????????????????????????"
L["OPT_TIEXYSPACING"] = "???????????????????????????"
L["OPT_TIEXYSPACING_DESC"] = "??????????????????????????????????????????????????????"
L["OPT_UNITPERLINES"] = "???????????????"
L["OPT_UNITPERLINES_DESC"] = "??????????????????????????????????????????????????????"
L["OPT_USERDEBUFF"] = "??????????????? Decursive ?????????????????????"
L["OPT_XSPACING"] = "????????????"
L["OPT_XSPACING_DESC"] = "???????????????????????????????????????"
L["OPT_YSPACING"] = "????????????"
L["OPT_YSPACING_DESC"] = "???????????????????????????????????????"
L["OPTION_MENU"] = "Decursive ????????????"
L["PLAY_SOUND"] = "????????????????????????????????????"
L["POISON"] = "??????"
L["POPULATE"] = "p"
L["POPULATE_LIST"] = "Decursive ?????????????????????"
L["PRINT_CHATFRAME"] = "?????????????????????????????????"
L["PRINT_CUSTOM"] = "???????????????????????????"
L["PRINT_ERRORS"] = "??????????????????"
L["PRIORITY_LIST"] = "Decursive ????????????"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "????????????"
L["REVERSE_LIVELIST"] = "????????????????????????"
L["SCAN_LENGTH"] = "????????????????????????????????????"
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "???????????? Decursive ?????????????????? /dcrshow"
L["SHOW_TOOLTIP"] = "???????????????????????????"
L["SKIP_LIST_STR"] = "Decursive ????????????"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "??????%s?????????"
L["STEALTHED"] = "?????????"
L["STR_CLOSE"] = "??????"
L["STR_DCR_PRIO"] = "Decursive ??????"
L["STR_DCR_SKIP"] = "Decursive ??????"
L["STR_GROUP"] = "??????"
L["STR_OPTIONS"] = "Decursive ??????"
L["STR_OTHER"] = "??????"
L["STR_POP"] = "??????????????????"
L["STR_QUICK_POP"] = "???????????????"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r |cFF00AA00???????????????|r %s"
L["TARGETUNIT"] = "????????????"
L["TIE_LIVELIST"] = "?????? Decursive ??????????????????????????????"
L["TOC_VERSION_EXPIRED"] = [=[Decursive ?????????????????????????????? Decursive ????????????????????????????????????????????????
???????????? Decursive ????????????????????????????????????????????????

??? curse.com ?????????Decursive???????????? Curse ??????????????????????????????????????????

?????????2????????????????????????]=]
L["TOO_MANY_ERRORS_ALERT"] = [=[?????????????????????%d??????????????? Lua ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
??????????????? Lua ???????????????/console scriptErrors 1???????????????????????????????????????]=]
L["TOOFAR"] = "??????"
L["UNITSTATUS"] = "???????????????"
L["UNSTABLERELEASE"] = "???????????????"



T._LoadedFiles["zhCN.lua"] = "2.7.7";
