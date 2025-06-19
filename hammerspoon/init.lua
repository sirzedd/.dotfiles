
local hyperkey = {"cmd", "alt", "shift", "ctrl"};
--Center perfectly for wezterm
hs.hotkey.bind(hyperkey, "c", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = 500
  f.y = 10
  f.w = 2500
  f.h = 1350
  win:setFrame(f)
end)


-- Window jumping via hammerspoon

hs.hotkey.bind({"alt"}, "h", function()
    local win = hs.window.focusedWindow()
    local allWindows = hs.window.orderedWindows()
    local currentScreen = win:screen()
    local currentFrame = win:frame()
    local leftmost = nil
    local minDistance = math.huge

    -- Find the closest window to the left on the same screen
    for _, otherWin in ipairs(allWindows) do
        if otherWin ~= win and otherWin:screen() == currentScreen then
            local otherFrame = otherWin:frame()
            if otherFrame.x < currentFrame.x then
                local distance = currentFrame.x - otherFrame.x
                if distance < minDistance then
                    minDistance = distance
                    leftmost = otherWin
                end
            end
        end
    end
    if leftmost then leftmost:focus() end
end)

hs.hotkey.bind({"alt"}, "l", function()
    local win = hs.window.focusedWindow()
    local allWindows = hs.window.orderedWindows()
    local currentScreen = win:screen()
    local currentFrame = win:frame()
    local rightmost = nil
    local minDistance = math.huge

    -- Find the closest window to the right on the same screen
    for _, otherWin in ipairs(allWindows) do
        if otherWin ~= win and otherWin:screen() == currentScreen then
            local otherFrame = otherWin:frame()
            if otherFrame.x > currentFrame.x then
                local distance = otherFrame.x - currentFrame.x
                if distance < minDistance then
                    minDistance = distance
                    rightmost = otherWin
                end
            end
        end
    end
    if rightmost then rightmost:focus() end
end)

hs.hotkey.bind({"alt"}, "j", function()
    local win = hs.window.focusedWindow()
    local allWindows = hs.window.orderedWindows()
    local currentScreen = win:screen()
    local currentFrame = win:frame()
    local bottommost = nil
    local minDistance = math.huge

    -- Find the closest window below on the same screen
    for _, otherWin in ipairs(allWindows) do
        if otherWin ~= win and otherWin:screen() == currentScreen then
            local otherFrame = otherWin:frame()
            if otherFrame.y > currentFrame.y then
                local distance = otherFrame.y - currentFrame.y
                if distance < minDistance then
                    minDistance = distance
                    bottommost = otherWin
                end
            end
        end
    end
    if bottommost then bottommost:focus() end
end)

hs.hotkey.bind({"alt"}, "k", function()
    local win = hs.window.focusedWindow()
    local allWindows = hs.window.orderedWindows()
    local currentScreen = win:screen()
    local currentFrame = win:frame()
    local topmost = nil
    local minDistance = math.huge

    -- Find the closest window above on the same screen
    for _, otherWin in ipairs(allWindows) do
        if otherWin ~= win and otherWin:screen() == currentScreen then
            local otherFrame = otherWin:frame()
            if otherFrame.y < currentFrame.y then
                local distance = currentFrame.y - otherFrame.y
                if distance < minDistance then
                    minDistance = distance
                    topmost = otherWin
                end
            end
        end
    end
    if topmost then topmost:focus() end
end)



hs.hotkey.bind(hyperkey, "f", function()
  local win = hs.window.focusedWindow()
      hs.alert.show("Full")
  if win ~= nil then
    win:maximize();
    --  win:setFullScreen(not win:isFullScreen())
  end
end)

xyzzy = hs.hotkey.bind({"ctrl"}, "return", function()
--  hs.alert.show("Return")
    wez = hs.application.find("Wezterm")
    if wez then
        if wez:isFrontmost() then
            wez:hide()
        else
          
            wez:activate()
        end
    end
end)


local appModal = hs.hotkey.modal.new()
-- Function to focus an application
local function focusApp(appName)
    local app = hs.application.get(appName)
    if app then
        app:activate()
    else
        hs.application.launchOrFocus(appName)
    end
end

-- Enter hyper+a mode
hs.hotkey.bind(hyperkey, 'a', function()
    appModal:enter()
    -- Optional: show a notification that you're in app selection mode
    --hs.alert.show("App Selection Mode")
end)

commandApps = {
  {"i", "Intellij IDEA"},
  {"d", "Docker Desktop"},
  {"b", "DBeaver"},
  {"f", "Firefox"},
  {"c", "Wezterm"},
  {"v", "Visual Studio Code"},
  {"t", "Microsoft Teams"},
}

for i,shortcut in ipairs(commandApps) do
    hs.hotkey.bind({"ctrl","cmd"}, shortcut[1], function()
        hs.application.launchOrFocus(shortcut[2])
    end)
    appModal:bind({}, shortcut[1], function()
        focusApp(shortcut[2])
        appModal:exit()
    end)
end

-- Exit the mode when escape is pressed
appModal:bind({}, 'escape', function()
    appModal:exit()
end)

-- Set the timeout after all bindings are defined
appModal:bind({}, 'escape', function() appModal:exit() end)
function appModal:entered()
    hs.timer.doAfter(2, function() appModal:exit() end)
end

-------------------
----- For this to work we need to remap caps lock to F18.  I usually use Karabiner to do this but due to anti-virus software I used the mac command
--
---- hidutil property --set \
----     '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039, ----     "HIDKeyboardModifierMappingDst":0x70000006D}]}' -- --xyzzy = hs.hotkey.bind({"ctrl"}, "return", function() ----  hs.alert.show("Return") --    wez = hs.application.find("Wezterm") --    if wez then --        if wez:isFrontmost() then --            wez:hide() --        else
--          
--            wez:activate()
--        end
--    end
--end)
--
-------------------------------------------------
---- Reload config on write
-------------------------------------------------
--local function reload_config()
--    hs.reload()
--  end
--  
--hyper:bind({}, "r", function()
--    reload_config()
--    hyper.triggered = true
-- end)
--
--
--local hyperBind = function(key)
--
--
----   k:bind('', key, msg, hyperDown(key), hyperUp(key), nil)
--  hyper:bind({}, key, function()
--    hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, key) 
--    hyper.triggered = true
--  end)
--end
--
----------------
---- All keys that will be remapped to cmd+alt+shift+ctrl + <letter> when pushed.  Replacing karabiner
--local keys = {
--  "a",
--  "b",
--  "c",
--  "d",
--  "e",
--  "f",
--  "g",
--  "h",
--  "i",
--  "j",
--  "k",
--  "l",
--  "m",
--  "n",
--  "o",
--  "p",
--  "q",
----   "r", used for reload
--  "s",
--  "t",
--  "u",
--  "v",
--  "w",
--  "x",
--  "y",
--  "z",
--  "0",
--  "1",
--  "2",
--  "3",
--  "4",
--  "5",
--  "6",
--  "7",
--  "8",
--  "9",
--  "`",
--  "=",
--  "-",
--  "]",
--  "[",
--  "\'",
----   ";", using for extra layer
--  "\\",
--  ",",
--  "/",
--  ".",
--  "return",
--  "tab",
--  "space",
--  "LEFT",
--  "RIGHT"
--}
--
--
---- bind all the keys in the huge keys table
--for index, key in pairs(keys) do hyperBind(key) end
--
----------------------------
--
---- Sequential keybindings, e.g. Hyper-;, f for Finder
--a = hs.hotkey.modal.new({}, "F16")
--
--
--launch = function(appname)
--  hs.application.launchOrFocus(appname)
--  hyper.triggered = true
--end
--
--apps = {
----   {'d', 'Twitter'},
--  {'f', 'Finder'},
----   {'s', 'Skype'},
--}
--for i, app in ipairs(apps) do
--  a:bind({}, app[1], function() launch(app[2]); a:exit(); end)
--end
--
--pressedA = function() 
--    a:enter() 
--end
--releasedA = function()
--end
--
--hyper:bind({}, ';', nil, pressedA, releasedA)
--
----   caps lock + h to do hyper+h.  TODO: Might be a way to include all letters I want.  Would be cool to do that hyper+; for other commands
----   hyper:bind({}, "h", function()
----     hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, 'h') 
----     hyper.triggered = true
----   end)
--
----   k:bind({}, 'm', nil, function() hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, 'm') end)
--  --- A closure function
----   function open(name)
----     return function()
----         hs.application.launchOrFocus(name)
----         if name == 'Finder' then
----             hs.appfinder.appFromName(name):activate()
----         end
----     end
----   end
---- hyper:bind({}, "shift", nil, function() hs.hid.capslock.toggle() end, hs.hid.capslock.toggle())
--
---- caps with escape-shift-f
--hyper.caps = hs.hid.capslock.get()
--hyper:bind("shift", "f", function()
--    hyper.caps = not hyper.caps 
--    if hyper.caps then
--      hs.alert.show("Caps")
--    else
--      hs.alert.show("Small")
--    end
--    hs.hid.capslock.toggle() 
--    hyper.triggered = true
-- end)
---- -- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
---- --   send ESCAPE if no other keys are pressed.
--releasedF18 = function()
--  k:exit()
--  if not k.triggered then
--    hs.eventtap.keyStroke({}, 'ESCAPE')
--  end
--end
--
--
local function reload_config()
    hs.reload()
  end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
hs.alert.show("Config loaded")
--
