# CrossHotbar Changelog

## Crosshotbar-1.0.22-release
* Fixed issue were spell alerts were removed when activiting hotbars.
* Fixed issue were cooldown pulse was visible for invisible buttons.
   * Primarly seen when using Masque skins with pulse enabled.

## Crosshotbar-1.0.21-release
* Added Masque support.
* Changed Fade and Strata when dragging actions or items.
* Disabled fade for expanded buttons when "double click with visual" is used.
* Fixed issue with target highlight not updating on party/raid roster change.
* Fixed issue when dragging collection items could not be dropped when using mouselook.
* Fixed issue when SET text was shown during movie playback.
* Fixed issue with incorrect paging when changing sets.

## Crosshotbar-1.0.20-release
* Updated Addon SaveVariables.
   * The session configuration is maintained between logins without saving.
   * Default button assignments of PAGEONE and PAGETWO were switched.
      * Exisiting saved profiles will not get the new default.
   * Configuration presets have new fields to support the new options.
      * Exisiting saved presets should be resaved to store the new field defaults.
* Added Interface UI to configure interfacing features.
   * Blizzard ActionBar and VehicleBar Hides.
   * Party and Raid orientation menus for unit frame traversal (left, right, up, down).
   * Unit highlight color settings for active and inactive party/raid frame targets.
   * Unit highlight size padding.
* Changed action lists for menus to retain order.
* Added SET identifier text at the bottom of the CrossHotbar.
   * Conditional paging was changed to apply to only SET 1 to mimic the MainActonBar behavior.
   * SET 1 contains the pages set in the Hotbar UI with conditionals applied.
   * SETs [2-6] now have a fixed assignment and not calculated from SET 1 assignments.
   * SETs [2-6] starts pages [1,2] and ends with pages [11,12].
* Updated behavor of LEFTEXPANDED, RIGHTEXPANDED to act as HOLDEXPANDED when the hotbar is active.

## Crosshotbar-1.0.19-release
* Change unit soft targeting highlight to unprotected frame and remove set parent call to unit frame.
   * This fixes an issue with secret values in Midnight PTR.

## Crosshotbar-1.0.18-release
* Updated toc for ptr 120000
* Added 3 additional action bindings HOLDEXPANDED, LEFTEXPANDED, RIGHTEXPANDED.
   * HOLDEXPANDED and be used with steam as a method to control double click timing.
*Added option to control double click behavior for expanded hotbars.

## Crosshotbar-1.0.17-release
* Removed LibUIDropDownMenu and replaced with Blizzard Menu API.
* Reorganized action menus and tooltips.
* Added action categories.
* Removed external dependencies that were no longer used.
* Fixed possible tainting issues.

## Crosshotbar-1.0.16-release
* Changes to support Midnight beta.
* Removing libActionButton dependencies and using native Blizzard button templates.
* libActionButton option description has been changed to "Create Hotbars internally".

## Crosshotbar-1.0.15-release
* TOC Version and ID updates.

## Crosshotbar-1.0.14-release
* Version toc updates for 11.1.

## Crosshotbar-1.0.13-release
* Toc changes for 11.0.5

## Crosshotbar-1.0.12-release
* Added back the visual desaturation when the expanded Crosshotbar is initially activated.
* Registered both up and down pressed for unit navigation to avoid CVAR setting dependency. Only executing on down presses.

## Crosshotbar-1.0.11-release
* Fixed issue where unit navigation would not work for some CVAR settings.
* Added ElvUI Unit Frames.

## Crosshotbar-1.0.10-release
* Improved performance of the unit frame navigator.
* Added support for Cell and Grid2 traversal.

## Crosshotbar-1.0.9-release
* Fix to previous hotbar binding were cycling was being prevented.
* Change to only update visible Hotbars to avoid unnecessary updates.

## Crosshotbar-1.0.8-release
* Creating release package for Crosshotbar.

## Crosshotbar-1.0.8-beta
* Added attribute to allow Consoleport to skip managing Crosshotbar's hotkey text.
* Updated spell cast reticle event to wait for mouse release prior to updating cvars to avoid error.
* Minor change to default controller config.

## Crosshotbar-1.0.7-beta
* Workaround for leftclick cancel override for spell targeting causing execution of protected code. Defaulting to ClearTarget binding to clear spelltarget.

## Crosshotbar-1.0.6-beta
* Changed fade a desaturation behavior on the main hotbars for better cool down visibility until a UI control can be added.
* Corrected multi-modifier action behavior were a mismatch of hotbar and gamepad actions was seen when hold multiple modifier combinations together.
* Added additional mouse look control when using mouse import. Mostly used for keyboard and mouse configurations.

## Crosshotbar-1.0.5-beta
* Changes for 110000 WoW 11.0.2
* Fixes errors within the configuration UI which prevented Crosshotbar from loading.

## Crosshotbar-1.0.4-beta
* Configuration and usability updates.

## Crosshotbar-1.0.3-beta
* Enabled preset storage and mouse mode indicator.

## Crosshotbar-1.0.2-beta
* Support for 10.2.5

## CrossHotbar-1.0.1-beta
* Initial Beta release.
