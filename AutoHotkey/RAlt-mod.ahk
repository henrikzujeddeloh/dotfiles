#SingleInstance Force
#Requires AutoHotkey v2.0

GetKeyboardLanguage() {
    WinID := WinExist("A")
    ThreadID := DllCall("GetWindowThreadProcessId", "Ptr", WinID, "Ptr", 0)
    KeyboardLayout := DllCall("GetKeyboardLayout", "UInt", ThreadID, "Ptr")
    Return KeyboardLayout & 0xFFFF
}

RAlt & f::Send "("
RAlt & j::Send ")"
RAlt & d::Send "["
RAlt & k::Send "]"
RAlt & s::Send "{{}"
RAlt & l::Send "{}}"
RAlt & a::Send "<"
#HotIf GetKeyboardLanguage() = 0x0407  ; German layout 
RAlt & ö::Send ">"
#HotIf GetKeyboardLanguage() = 0x0409  ; English US layout  
RAlt & `;::Send ">"
#HotIf
RAlt & g::Send "\"
RAlt & h::Send "/"
RAlt & u::Send "{+}"
RAlt & t::Send "*"
RAlt & r::Send "-"
RAlt & e::Send "="
RAlt & m::Send '"'
RAlt & n::Send "'"
RAlt & b::Send "``"
RAlt & q::Send "?"
RAlt & w::Send "{!}"
RAlt & c::Send "_"
#HotIf GetKeyboardLanguage() = 0x0407  ; German layout
RAlt & y::Send "$"
#HotIf GetKeyboardLanguage() = 0x0409  ; English US layout
RAlt & z::Send "$"
#HotIf
RAlt & x::Send "%"
RAlt & v::Send "{#}"
RAlt & p::Send "&"
RAlt & o::Send "|"
