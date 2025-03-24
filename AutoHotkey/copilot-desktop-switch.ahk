#Requires AutoHotkey v2.0

; Ensure instant key press handling
SetKeyDelay(0, 50)

; F23 + Left Arrow -> RCtrl + Win + Left Arrow
F23 & Left::Send("{RCtrl Down}{LWin Down}{Left}{RCtrl Up}{LWin Up}")

; F23 + Right Arrow -> RCtrl + Win + Right Arrow
F23 & Right::Send("{RCtrl Down}{LWin Down}{Right}{RCtrl Up}{LWin Up}")


