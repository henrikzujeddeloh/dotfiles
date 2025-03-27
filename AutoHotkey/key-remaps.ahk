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

; 
<^>!f::Send "("
<^>!j::Send ")"
<^>!d::Send "["
<^>!k::Send "]"
<^>!s::Send "{{}"
<^>!l::Send "{}}"
<^>!a::Send "<"
+<^>!a::Send "@"
#HotIf GetKeyboardLanguage() = 0x0407  ; German layout 
<^>!ö::Send ">"
#HotIf GetKeyboardLanguage() = 0x0409  ; English US layout  
<^>!`;::Send ">"
#HotIf
<^>!g::Send "\"
<^>!h::Send "/"
<^>!u::Send "{+}"
<^>!t::Send "*"
<^>!r::Send "-"
<^>!e::Send "="
<^>!m::Send '"'
<^>!n::Send "'"
<^>!b::Send "``"
<^>!q::Send "?"
<^>!w::Send "{!}"
<^>!c::Send "_"
#HotIf GetKeyboardLanguage() = 0x0407  ; German layout
<^>!y::Send "$"
+<^>!y::Send "€"
#HotIf GetKeyboardLanguage() = 0x0409  ; English US layout
<^>!z::Send "$"
+<^>!z::Send "€"
#HotIf
<^>!x::Send "%"
<^>!v::Send "{#}"
<^>!p::Send "&"
<^>!o::Send "|"
