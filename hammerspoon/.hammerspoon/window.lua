--[[
Control window tiling configurations using hotkeys and arrow keys

References:
- https://gist.github.com/nyergler/7056c61174194a9af9b4d5d727f1b566
- https://gist.github.com/mrooney/c13e82b5811b2a87b5a413b7cb5f61ef
]]

-- ===================== Arrow keys =====================
-- focus current window to left side of the screen
hs.hotkey.bind({"ctrl", "alt"}, "Left", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h
	win:setFrame(f)
  end)

-- focus current window to right side of the screen
  hs.hotkey.bind({"ctrl", "alt"}, "Right", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x + (max.w / 2)
	f.y = max.y
	f.w = max.w / 2
	f.h = max.h
	win:setFrame(f)
  end)

-- focus current window to upside of the screen
  hs.hotkey.bind({"ctrl", "alt"}, "Up", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = max.h / 2
	win:setFrame(f)
  end)

-- focus current window to downside of the screen
  hs.hotkey.bind({"ctrl", "alt"}, "Down", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y + (max.h / 2)
	f.w = max.w
	f.h = max.h / 2
	win:setFrame(f)
  end)

-- focus current window to full display
  hs.hotkey.bind({"ctrl", "alt"}, "Return", function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = max.h
	win:setFrame(f)
  end)

-- ===================== Corners =====================
-- quarter of screen
-- shortcuts: ctrl + alt
--   [[
--     u i
--     j k
--   ]]
hs.hotkey.bind({ "alt", "ctrl" }, "u", function()
	hs.window.focusedWindow():moveToUnit({ 0, 0, 0.5, 0.5 })
end)
hs.hotkey.bind({ "alt", "ctrl" }, "k", function()
	hs.window.focusedWindow():moveToUnit({ 0.5, 0.5, 0.5, 0.5 })
end)
hs.hotkey.bind({ "alt", "ctrl" }, "i", function()
	hs.window.focusedWindow():moveToUnit({ 0.5, 0, 0.5, 0.5 })
end)
hs.hotkey.bind({ "alt", "ctrl" }, "j", function()
	hs.window.focusedWindow():moveToUnit({ 0, 0.5, 0.5, 0.5 })
end)

hs.hotkey.bind({ "alt", "ctrl" }, "c", function()
	-- center current window to center of display
	hs.window.focusedWindow():centerOnScreen()
end)

hs.hotkey.bind({"ctrl", "alt"}, "n", function()
  -- move current window to next monitor display
  local win = hs.window.focusedWindow()
  local screen = win:screen()
  win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)
