local mod = "SUPER"
local smw = require("plugins.split-monitor-workspaces");
smw.setup({
	workspace_count = 9
})

-- Apps
-- hl.bind(mod .. " + W", hl.dsp.exec_cmd("zen-twilight"))
hl.bind("ALT + SHIFT + RETURN", hl.dsp.exec_cmd("kitty"))
-- hl.bind(mod .. " + E", hl.dsp.exec_cmd("nautilus -w"))
hl.bind("ALT + P", hl.dsp.exec_cmd("rofi -show drun"))
-- hl.bind(
--   mod .. " + ALT + V",
--   hl.dsp.exec_cmd("pkill fuzzel || stash list | fuzzel --dmenu | stash decode | stash store")
-- )
hl.bind(mod .. " + CTRL + R", hl.dsp.exec_cmd("pkill .quickshell-wra ; caelestia-shell &"))
hl.bind("up", hl.dsp.pass({ window = "class:^(JKPS)$" }), { non_consuming = true })

-- exit
hl.bind(mod .. "+ SHIFT + Q", hl.dsp.exit())

-- Window controls
hl.bind(mod .. " + C", hl.dsp.window.close())
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + SHIFT + S", hl.dsp.workspace.toggle_special("spotify"))
hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))
hl.bind("ALT + tab", hl.dsp.window.cycle_next({ next = true }))
hl.bind("ALT + SHIFT + tab", hl.dsp.window.cycle_next({ prev = true }))

-- Caelestia
hl.bind(mod .. " + tab", hl.dsp.global("caelestia:launcher"))
hl.bind(mod .. " + X", hl.dsp.global("caelestia:session"))
hl.bind(mod .. " + N", hl.dsp.exec_cmd("caelestia-shell ipc call drawers toggle sidebar"))
hl.bind(mod .. " + L", hl.dsp.global("caelestia:lock"))

-- Screnshots/recording
hl.bind(mod .. " + S", hl.dsp.global("caelestia:screenshotFreeze"))
hl.bind(mod .. " + CTRL + S", hl.dsp.exec_cmd("caelestia screenshot"))
hl.bind(mod .. " + R", hl.dsp.exec_cmd("caelestia record -s"))
hl.bind(mod .. " + ALT + R", hl.dsp.exec_cmd("caelestia record -s -r"))

-- Misc
hl.bind(mod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- Media controls
hl.bind("XF86MonBrightnessUp", hl.dsp.global("caelestia:brightnessUp"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.global("caelestia:brightnessDown"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.global("caelestia:mediaToggle"), { locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true })

-- Workspaces 1..10
for i = 1, 9 do
  local key = i % 10 -- 10 -> 0
  hl.bind("ALT + " .. key, smw.workspace(i))
  hl.bind("ALT + SHIFT + " .. key, smw.move_to_workspace(i))
end

-- Workspace scroll
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mod .. " + Page_down", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mod .. " + Page_up", hl.dsp.focus({ workspace = "-1" }))

-- Mouse drag / resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mod .. " + Z", hl.dsp.window.drag())

-- Resize
hl.bind(mod .. " + Semicolon", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + Apostrophe", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })

-- Submap: move
hl.bind(mod .. " + M", hl.dsp.submap("move"))
hl.define_submap("move", function()
  hl.bind("left", hl.dsp.window.move({ direction = "l" }), { repeating = true })
  hl.bind("right", hl.dsp.window.move({ direction = "r" }), { repeating = true })
  hl.bind("up", hl.dsp.window.move({ direction = "u" }), { repeating = true })
  hl.bind("down", hl.dsp.window.move({ direction = "d" }), { repeating = true })
  hl.bind("j", hl.dsp.window.move({ direction = "l" }), { repeating = true })
  hl.bind("l", hl.dsp.window.move({ direction = "r" }), { repeating = true })
  hl.bind("i", hl.dsp.window.move({ direction = "u" }), { repeating = true })
  hl.bind("k", hl.dsp.window.move({ direction = "d" }), { repeating = true })

  hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Submap: resize
hl.bind(mod .. " + SHIFT + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
  hl.bind("left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
  hl.bind("right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
  hl.bind("up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
  hl.bind("down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
  hl.bind("h", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
  hl.bind("j", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
  hl.bind("i", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
  hl.bind("k", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

  hl.bind("escape", hl.dsp.submap("reset"))
end)
