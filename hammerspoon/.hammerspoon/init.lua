require("window")

hs.hotkey.bind({ "ctrl", "alt" }, "M", function()
	-- move mouse to the middle of the screen --
	local screen = hs.mouse.getCurrentScreen()
	local nextScreen = screen:next()
	local rect = nextScreen:fullFrame()
	local center = hs.geometry.rectMidPoint(rect)

	hs.mouse.setAbsolutePosition(center)
end)
