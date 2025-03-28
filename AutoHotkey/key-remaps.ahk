#SingleInstance Force
#Requires AutoHotkey v2.0

; Remap keys surrounding Enter to Enter
SC01B::Enter
SC02B::Enter 
; Remap keys surrounding Shift to Shift
SC056::LShift

; Remap CapsLock to Esc or LControl if used as modifier
*CapsLock::
{
    Send "{LControl down}"
}

*CapsLock up::
{
    Send "{LControl Up}"

    if (A_PriorKey=="CapsLock"){
	if (A_TimeSincePriorHotkey < 1000)
		Suspend "1"
		Send "{Esc}"
		Suspend "0"
	}
}

; Detect keyboard language
GetKeyboardLanguage() {
    WinID := WinExist("A")
    ThreadID := DllCall("GetWindowThreadProcessId", "Ptr", WinID, "Ptr", 0)
    KeyboardLayout := DllCall("GetKeyboardLayout", "UInt", ThreadID, "Ptr")
    Return KeyboardLayout & 0xFFFF
}

; switch z and y for german keyboards
#HotIf GetKeyboardLanguage() = 0x0407
z::y
y::z
#HotIf



global umlautMode := false
; RAlt+U toggles umlaut mode
<^>!u::
{
    global umlautMode
    umlautMode := true
    ToolTip("Umlaut mode ON")
    SetTimer(() => ToolTip(), -1000)
    SetTimer(DisableUmlautMode, -3000)
}

DisableUmlautMode()
{
    global umlautMode
    umlautMode := false
    ToolTip("Umlaut mode OFF")
    SetTimer(() => ToolTip(), -1000)
}

#InputLevel 1

; Regular hotkeys that check the umlaut mode variable
a::
{
    global umlautMode
    if (umlautMode) {
        Send("ä")
        umlautMode := false
    } else {
        Send("{Blind}a")
    }
}

o::
{
    global umlautMode
    if (umlautMode) {
        Send("ö")
        umlautMode := false
    } else {
        Send("{Blind}o")
    }
}

u::
{
    global umlautMode
    if (umlautMode) {
        Send("ü")
        umlautMode := false
    } else {
        Send("{Blind}u")
    }
}

s::
{
    global umlautMode
    if (umlautMode) {
        Send("ß")
        umlautMode := false
    } else {
        Send("{Blind}s")
    }
}

+a::
{
    global umlautMode
    if (umlautMode) {
        Send("Ä")
        umlautMode := false
    } else {
        Send("{Blind}A")
    }
}

+o::
{
    global umlautMode
    if (umlautMode) {
        Send("Ö")
        umlautMode := false
    } else {
        Send("{Blind}O")
    }
}

+u::
{
    global umlautMode
    if (umlautMode) {
        Send("Ü")
        umlautMode := false
    } else {
        Send("{Blind}U")
    }
}

+s::
{
    global umlautMode
    if (umlautMode) {
        Send("ẞ")
        umlautMode := false
    } else {
        Send("{Blind}S")
    }
}

Escape::
{
    global umlautMode
    if (umlautMode) {
        umlautMode := false
        ToolTip("Umlaut mode canceled")
        SetTimer(() => ToolTip(), -1000)
    } else {
        Send("{Blind}{Escape}")
    }
}

; Reset input level
#InputLevel 0


; create symbol layer with R-Alt
<^>!f::Send "("
>!f::Send "("
<^>!j::Send ")"
>!j::Send ")"
<^>!d::Send "["
>!d::Send "["
<^>!k::Send "]"
>!k::Send "]"
<^>!s::Send "{{}"
>!s::Send "{{}"
<^>!l::Send "{}}"
>!l::Send "{}}"
<^>!a::Send "<"
>!a::Send "<"
+<^>!a::Send "@"
+>!a::Send "@"
#HotIf GetKeyboardLanguage() = 0x0407  ; German layout 
<^>!ö::Send ">"
#HotIf GetKeyboardLanguage() = 0x0409  ; English US layout  
>!`;::Send ">"
#HotIf
<^>!g::Send "\"
>!g::Send "\"
<^>!h::Send "/"
>!h::Send "/"
<^>!t::Send "{+}"
>!t::Send "{+}"
<^>!r::Send "-"
>!r::Send "-"
<^>!e::Send "="
>!e::Send "="
<^>!m::Send '"'
>!m::Send '"'
<^>!n::Send "'"
>!n::Send "'"
<^>!b::Send "``"
>!b::Send "``"
<^>!q::Send "?"
>!q::Send "?"
<^>!w::Send "{!}"
>!w::Send "{!}"
<^>!c::Send "_"
>!c::Send "_"
#HotIf GetKeyboardLanguage() = 0x0407  ; German layout
<^>!y::Send "$"
+<^>!y::Send "€"
<^>!z::Send "*"
#HotIf GetKeyboardLanguage() = 0x0409  ; English US layout
>!z::Send "$"
+>!z::Send "€"
#HotIf
<^>!x::Send "%"
>!x::Send "%"
<^>!v::Send "{#}"
>!v::Send "{#}"
<^>!i::Send "~"
>!i::Send "~"
<^>!p::Send "&"
>!p::Send "&"
<^>!o::Send "|"
>!o::Send "|"
