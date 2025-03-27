-- Function to determine keyboard layout
local function getKeyboardLayout()
    local layout = hs.keycodes.currentLayout()
    if layout == "German" or layout == "German-DIN" then
        return "German"
    else
        return "US"
    end
end

-- Helper for key remapping
local function remapKey(modifiers, key, to)
    hs.hotkey.bind(modifiers, key, function()
        hs.eventtap.keyStrokes(to)
    end)
end

-- Common AltGr (Right Option) remappings
remapKey({ "rightalt" }, "f", "(")
remapKey({ "rightalt" }, "j", ")")
remapKey({ "rightalt" }, "d", "[")
remapKey({ "rightalt" }, "k", "]")
remapKey({ "rightalt" }, "s", "{")
remapKey({ "rightalt" }, "l", "}")
hs.hotkey.bind({ "rightalt" }, "a", function()
    hs.eventtap.keyStroke({}, "<")
end)
hs.hotkey.bind({ "rightalt", "shift" }, "a", function()
    local originalClipboard = hs.pasteboard.getContents()
    hs.pasteboard.setContents("@")
    hs.eventtap.keyStroke({ "cmd" }, "v")
    hs.timer.doAfter(0.1, function()
        if originalClipboard then
            hs.pasteboard.setContents(originalClipboard)
        end
    end)
end)
remapKey({ "rightalt" }, "g", "\\")
remapKey({ "rightalt" }, "h", "/")
remapKey({ "rightalt" }, "u", "+")
remapKey({ "rightalt" }, "t", "*")
remapKey({ "rightalt" }, "r", "-")
remapKey({ "rightalt" }, "e", "=")
remapKey({ "rightalt" }, "m", "\"")
remapKey({ "rightalt" }, "n", "'")
remapKey({ "rightalt" }, "b", "`")
remapKey({ "rightalt" }, "q", "?")
remapKey({ "rightalt" }, "w", "!")
remapKey({ "rightalt" }, "c", "_")
remapKey({ "rightalt" }, "x", "%")
remapKey({ "rightalt" }, "v", "#")
remapKey({ "rightalt" }, "p", "&")
remapKey({ "rightalt" }, "i", "~")
remapKey({ "rightalt" }, "o", "|")

-- Layout-specific mappings
local layoutSpecificHotkeys = {}

local function setupLayoutSpecificBindings()
    -- Clear existing bindings
    for _, hotkey in pairs(layoutSpecificHotkeys) do
        hotkey:delete()
    end
    layoutSpecificHotkeys = {}

    local layout = getKeyboardLayout()

    if layout == "German" then
        -- German layout specific shortcut
        table.insert(layoutSpecificHotkeys, hs.hotkey.bind({ "rightalt" }, "ö",
            function() hs.eventtap.keyStrokes(">") end))
        table.insert(layoutSpecificHotkeys, hs.hotkey.bind({ "rightalt" }, "z",
            function() hs.eventtap.keyStrokes("$") end))
        table.insert(layoutSpecificHotkeys,
            hs.hotkey.bind({ "rightalt", "shift" }, "z", function() hs.eventtap.keyStrokes("€") end))
    else
        -- US layout specific shortcuts
        table.insert(layoutSpecificHotkeys, hs.hotkey.bind({ "rightalt" }, ";",
            function() hs.eventtap.keyStrokes(">") end))
        table.insert(layoutSpecificHotkeys, hs.hotkey.bind({ "rightalt" }, "y",
            function() hs.eventtap.keyStrokes("$") end))
        table.insert(layoutSpecificHotkeys,
            hs.hotkey.bind({ "rightalt", "shift" }, "y", function() hs.eventtap.keyStrokes("€") end))
    end
end

-- Setup initial bindings
setupLayoutSpecificBindings()

-- Watch for layout changes
hs.keycodes.inputSourceChanged(function()
    setupLayoutSpecificBindings()
end)
