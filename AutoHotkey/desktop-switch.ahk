#Requires AutoHotkey v2.0

; Load necessary libraries
VirtualDesktopAccessor := DllCall("LoadLibrary", "Str", A_ScriptDir . "\VirtualDesktopAccessor.dll", "Ptr")

; Get function pointers
GetDesktopCount := DllCall("GetProcAddress", "Ptr", VirtualDesktopAccessor, "AStr", "GetDesktopCount", "Ptr")
GoToDesktopNumber := DllCall("GetProcAddress", "Ptr", VirtualDesktopAccessor, "AStr", "GoToDesktopNumber", "Ptr")

; Function to switch desktop and send Alt+Tab
SwitchDesktopAndFocus(targetDesktop) {
    DllCall(GoToDesktopNumber, "Int", targetDesktop)
    Sleep 50
    Send "!{Tab}"
}

; Shortcuts to switch to specific desktops
<!1:: SwitchDesktopAndFocus(0)  ; Desktop 1 (index 0)
<!2:: SwitchDesktopAndFocus(1)  ; Desktop 2 (index 1)
<!3:: SwitchDesktopAndFocus(2)  ; Desktop 3 (index 2)
<!4:: SwitchDesktopAndFocus(3)  ; Desktop 4 (index 3)
<!5:: SwitchDesktopAndFocus(4)  ; Desktop 5 (index 4)
