require 'hyper'


-----------------
--- For this to work we need to remap caps lock to F18.  I usually use Karabiner to do this but due to anti-virus software I used the mac command

-- hidutil property --set \
--     '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,
--     "HIDKeyboardModifierMappingDst":0x70000006D}]}'



-----------------------------------------------
-- Reload config on write
-----------------------------------------------
local function reload_config()
    hs.reload()
  end
  
hyper:bind({}, "r", function()
    reload_config()
    hyper.triggered = true
 end)


local hyperBind = function(key)


--   k:bind('', key, msg, hyperDown(key), hyperUp(key), nil)
  hyper:bind({}, key, function()
    hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, key) 
    hyper.triggered = true
  end)
end

--------------
-- All keys that will be remapped to cmd+alt+shift+ctrl + <letter> when pushed.  Replacing karabiner
local keys = {
  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
--   "r", used for reload
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z",
  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "`",
  "=",
  "-",
  "]",
  "[",
  "\'",
--   ";", using for extra layer
  "\\",
  ",",
  "/",
  ".",
  "return",
  "tab",
  "space",
  "LEFT",
  "RIGHT"
}


-- bind all the keys in the huge keys table
for index, key in pairs(keys) do hyperBind(key) end

--------------------------

-- Sequential keybindings, e.g. Hyper-;, f for Finder
a = hs.hotkey.modal.new({}, "F16")


launch = function(appname)
  hs.application.launchOrFocus(appname)
  hyper.triggered = true
end

apps = {
--   {'d', 'Twitter'},
  {'f', 'Finder'},
--   {'s', 'Skype'},
}
for i, app in ipairs(apps) do
  a:bind({}, app[1], function() launch(app[2]); a:exit(); end)
end

pressedA = function() 
    a:enter() 
end
releasedA = function()
end

hyper:bind({}, ';', nil, pressedA, releasedA)

--   caps lock + h to do hyper+h.  TODO: Might be a way to include all letters I want.  Would be cool to do that hyper+; for other commands
--   hyper:bind({}, "h", function()
--     hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, 'h') 
--     hyper.triggered = true
--   end)

--   k:bind({}, 'm', nil, function() hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, 'm') end)
  --- A closure function
--   function open(name)
--     return function()
--         hs.application.launchOrFocus(name)
--         if name == 'Finder' then
--             hs.appfinder.appFromName(name):activate()
--         end
--     end
--   end
-- hyper:bind({}, "shift", nil, function() hs.hid.capslock.toggle() end, hs.hid.capslock.toggle())

-- caps with escape-shift-f
hyper.caps = hs.hid.capslock.get()
hyper:bind("shift", "f", function()
    hyper.caps = not hyper.caps 
    if hyper.caps then
      hs.alert.show("Caps")
    else
      hs.alert.show("Small")
    end
    hs.hid.capslock.toggle() 
    hyper.triggered = true
 end)
-- -- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
-- --   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end


  hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
  hs.alert.show("Config loaded")

-------------------------------------
-- print([[
-- HYPER
-- ## install
-- Use karabiner-elements to bind capslock to F18
-- install hammerspoon
-- save this file as ~/.hammerspoon/hyper.lua
-- add `require 'hyper'` to ~/.hammerspoon/init.lua
-- ## use
-- press capslock by itself to send escape.
-- or use it as a modifier:
-- It acts like command+option+ctrl+shift. All
-- the modifiers at once.
-- It's hard to type all the modifiers at once, so
-- app keyboard shortcuts almost never require you
-- to.
-- But it's still allowed in set-your-own-shortcut
-- fields!
-- You now have an extra modifier key _and_ an
-- extra escape key. Go nuts.
-- ]])

-- -- A variable for the Hyper Mode
-- local k = hs.hotkey.modal.new({}, 'F17')

-- -- All of the keys, from here:
-- -- https://github.com/Hammerspoon/hammerspoon/blob/f3446073f3e58bba0539ff8b2017a65b446954f7/extensions/keycodes/internal.m
-- -- except with ' instead of " (not sure why but it didn't work otherwise)
-- -- and the function keys greater than F12 removed.
-- local keys = {
--   "a",
--   "b",
--   "c",
--   "d",
--   "e",
--   "f",
--   "g",
--   "h",
--   "i",
--   "j",
--   "k",
--   "l",
--   "m",
--   "n",
--   "o",
--   "p",
--   "q",
--   "r",
--   "s",
--   "t",
--   "u",
--   "v",
--   "w",
--   "x",
--   "y",
--   "z",
--   "0",
--   "1",
--   "2",
--   "3",
--   "4",
--   "5",
--   "6",
--   "7",
--   "8",
--   "9",
--   "`",
--   "=",
--   "-",
--   "]",
--   "[",
--   "\'",
--   ";",
--   "\\",
--   ",",
--   "/",
--   ".",
--   "§",
--   "f1",
--   "f2",
--   "f3",
--   "f4",
--   "f5",
--   "f6",
--   "f7",
--   "f8",
--   "f9",
--   "f10",
--   "f11",
--   "f12",
--   "pad.",
--   "pad*",
--   "pad+",
--   "pad/",
--   "pad-",
--   "pad=",
--   "pad0",
--   "pad1",
--   "pad2",
--   "pad3",
--   "pad4",
--   "pad5",
--   "pad6",
--   "pad7",
--   "pad8",
--   "pad9",
--   "padclear",
--   "padenter",
--   "return",
--   "tab",
--   "space",
--   "delete",
--   "help",
--   "home",
--   "pageup",
--   "forwarddelete",
--   "end",
--   "pagedown",
--   "left",
--   "right",
--   "down",
--   "up"
-- }

-- local printIsdown = function(b) return b and 'down' or 'up' end

-- -- sends a key event with all modifiers
-- -- bool -> string -> void -> side effect
-- local hyper = function(isdown)
--   return function(key)
--     return function()
--       k.triggered = true
--       local event = hs.eventtap.event.newKeyEvent(
-- 	{'cmd', 'alt', 'shift', 'ctrl'},
-- 	key, 
-- 	isdown
--       )
--       event:post()
--     end
--   end
-- end

-- local hyperDown = hyper(true)
-- local hyperUp = hyper(false)

-- -- actually bind a key
-- local hyperBind = function(key)
--   k:bind('', key, msg, hyperDown(key), hyperUp(key), nil)
-- end

-- -- bind all the keys in the huge keys table
-- for index, key in pairs(keys) do hyperBind(key) end

-- -- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
-- local pressedF18 = function()
--   k.triggered = false
--   k:enter()
-- end

-- -- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
-- --   send ESCAPE if no other keys are pressed.
-- local releasedF18 = function()
--   k:exit()
--   if not k.triggered then
--     hs.eventtap.keyStroke({}, 'ESCAPE')
--   end
-- end

-- -- Bind the Hyper key
-- local f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

----------------------------------

-- -- A global variable for the Hyper Mode
-- k = hs.hotkey.modal.new({}, "F17")

-- -- Trigger existing hyper key shortcuts

-- k:bind({}, 'm', nil, function() hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, 'm') end)

-- -- OR build your own

-- launch = function(appname)
--   hs.application.launchOrFocus(appname)
--   k.triggered = true
-- end

-- -- Single keybinding for app launch
-- singleapps = {
--   {'q', 'MailMate'},
--   {'w', 'OmniFocus'},
--   {'e', 'Sublime Text'},
--   {'r', 'Google Chrome'}
-- }

-- for i, app in ipairs(singleapps) do
--   k:bind({}, app[1], function() launch(app[2]); k:exit(); end)
-- end

-- -- Sequential keybindings, e.g. Hyper-a,f for Finder
-- a = hs.hotkey.modal.new({}, "F16")
-- apps = {
--   {'d', 'Twitter'},
--   {'f', 'Finder'},
--   {'s', 'Skype'},
-- }
-- for i, app in ipairs(apps) do
--   a:bind({}, app[1], function() launch(app[2]); a:exit(); end)
-- end

-- pressedA = function() a:enter() end
-- releasedA = function() end
-- k:bind({}, 'a', nil, pressedA, releasedA)

-- -- Shortcut to reload config

-- ofun = function()
--   hs.reload()
--   hs.alert.show("Config loaded")
--   k.triggered = true
-- end
-- k:bind({}, 'o', nil, ofun)

-- -- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
-- pressedF18 = function()
--   k.triggered = false
--   k:enter()
-- end

-- -- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
-- --   send ESCAPE if no other keys are pressed.
-- releasedF18 = function()
--   k:exit()
--   if not k.triggered then
--     hs.eventtap.keyStroke({}, 'ESCAPE')
--   end
-- end

-- -- Bind the Hyper key
-- f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)


-- -- Cursor locator

-- local mouseCircle = nil
-- local mouseCircleTimer = nil

-- function mouseHighlight()
--   size = 150
--     -- Delete an existing highlight if it exists
--     if mouseCircle then
--         mouseCircle:delete()
--         mouseCircle2:delete()
--         if mouseCircleTimer then
--             mouseCircleTimer:stop()
--         end
--     end
--     -- Get the current co-ordinates of the mouse pointer
--     mousepoint = hs.mouse.getAbsolutePosition()
--     -- Prepare a big red circle around the mouse pointer
--     mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-(size/2), mousepoint.y-(size/2), size, size))
--     mouseCircle2 = hs.drawing.circle(hs.geometry.rect(mousepoint.x-(size/4), mousepoint.y-(size/4), size/2, size/2))
--     mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
--     mouseCircle2:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
--     mouseCircle:setFill(false)
--     mouseCircle2:setFill(false)
--     mouseCircle:setStrokeWidth(3)
--     mouseCircle2:setStrokeWidth(5)
--     mouseCircle:show()
--     mouseCircle2:show()

--     -- Set a timer to delete the circle after 3 seconds
--     mouseCircleTimer = hs.timer.doAfter(1, function() mouseCircle:delete() mouseCircle2:delete() end)
-- end
-- hs.hotkey.bind({"cmd","alt","shift"}, "D", mouseHighlight)



-------------------------

-- HYPER+L: Open news.google.com in the default browser
-- lfun = function()
--   news = "app = Application.currentApplication(); app.includeStandardAdditions = true; app.doShellScript('open http://news.google.com')"
--   hs.osascript.javascript(news)
--   k.triggered = true
-- end
-- k:bind('', 'l', nil, lfun)


-- -- A global variable for the Hyper Mode
-- k = hs.hotkey.modal.new({}, "F18")

-- -- Trigger existing hyper key shortcuts

-- k:bind({}, 'm', nil, function() hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, 'm') end)

-- -- OR build your own

-- launch = function(appname)


-- -- A global variable for the Hyper Mode
-- k = hs.hotkey.modal.new({}, "F17")

-- -- Trigger existing hyper key shortcuts

-- k:bind({}, 'm', nil, function() hs.eventtap.keyStroke({"cmd","alt","shift","ctrl"}, 'm') end)

-- -- OR build your own

-- launch = function(appname)