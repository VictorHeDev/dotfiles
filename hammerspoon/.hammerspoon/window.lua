-- Arrow keys
hs.hotkey.bind({ "cmd", "alt" }, "Left", function()
	-- focus current window to the left side of the screen
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

hs.hotkey.bind({ "cmd", "alt" }, "Right", function()
	-- focus current window to the right side of the screen
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

hs.hotkey.bind({ "cmd", "alt" }, "Up", function()
	-- focus current window to the top side of the screen
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

hs.hotkey.bind({ "cmd", "alt" }, "Down", function()
	-- focus current window to the bottom side of the screen
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local screen = win:screen()
	local max = screen:frame()

	f.x = max.x
	f.y = max.y / 2 + (max.h / 2)
	f.w = max.w
	f.h = max.h / 2
	win:setFrame(f)
end)

hs.hotkey.bind({ "cmd", "alt" }, "Return", function()
	-- focus current window full display
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

-- send current window to corners of the screen using u, i, j, k keys
hs.hotkey.bind({ "cmd", "alt" }, "u", function()
	hs.window.focusedWindow():moveToUnit({ 0, 0, 0.5, 0, 5 })
end)

hs.hotkey.bind({ "cmd", "alt" }, "k", function()
	hs.window.focusedWindow():moveToUnit({ 0.5, 0.5, 0.5, 0, 5 })
end)

hs.hotkey.bind({ "cmd", "alt" }, "i", function()
	hs.window.focusedWindow():moveToUnit({ 0.5, 0, 0.5, 0, 5 })
end)

hs.hotkey.bind({ "cmd", "alt" }, "j", function()
	hs.window.focusedWindow():moveToUnit({ 0, 0.5, 0.5, 0, 5 })
end)

hs.hotkey.bind({ "cmd", "alt" }, "c", function()
	-- center current window to the center of the screen
	hs.window.focusedWindow():centerOnScreen()
end)

hs.hotkey.bind({ "cmd", "alt" }, "c", function()
	-- move current window to the next monitor display
	local win = hs.window.focusedWindow()
	local screen = win:screen()
	win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)
