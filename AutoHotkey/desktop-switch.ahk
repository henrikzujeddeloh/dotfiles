#Requires AutoHotkey v2.0

; Load necessary libraries
VirtualDesktopAccessor := DllCall("LoadLibrary", "Str", A_ScriptDir . "\VirtualDesktopAccessor.dll", "Ptr")

; Get function pointers
GetDesktopCount := DllCall("GetProcAddress", "Ptr", VirtualDesktopAccessor, "AStr", "GetDesktopCount", "Ptr")
GoToDesktopNumber := DllCall("GetProcAddress", "Ptr", VirtualDesktopAccessor, "AStr", "GoToDesktopNumber", "Ptr")

; Shortcuts to switch to specific desktops
<!1:: DllCall(GoToDesktopNumber, "Int", 0)  ; Desktop 1 (index 0)
<!2:: DllCall(GoToDesktopNumber, "Int", 1)  ; Desktop 2 (index 1)
<!3:: DllCall(GoToDesktopNumber, "Int", 2)  ; Desktop 3 (index 2)
<!4:: DllCall(GoToDesktopNumber, "Int", 3)  ; Desktop 4 (index 3)
<!5:: DllCall(GoToDesktopNumber, "Int", 5)  ; Desktop 5 (index 4)
