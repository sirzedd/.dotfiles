-----------------------------------------------
-- Hyper mode
-----------------------------------------------

-- A global variable for the Hyper Mode
hyper = hs.hotkey.modal.new({}, "F17")

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
local function enterHyperMode()
  hyper.triggered = false
  hyper:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
-- send ESCAPE if no other keys are pressed.
local function exitHyperMode()
  hyper:exit()
  if not hyper.triggered then
    -- hs.alert.show("Escape")
    hs.eventtap.keyStroke({}, 'ESCAPE')
    if hyper.caps then
      hs.alert.show("Small")
      hs.hid.capslock.set(false)
      hyper.caps = false
    end
  end
end


-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', enterHyperMode, exitHyperMode)