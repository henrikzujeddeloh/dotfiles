#SingleInstance Force
#Requires AutoHotkey v2.0

SC01B::Enter
SC02B::Enter 
SC056::LShift

GetKeyboardLanguage() {
    WinID := WinExist("A")
    ThreadID := DllCall("GetWindowThreadProcessId", "Ptr", WinID, "Ptr", 0)
    KeyboardLayout := DllCall("GetKeyboardLayout", "UInt", ThreadID, "Ptr")
    Return KeyboardLayout & 0xFFFF
}

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
