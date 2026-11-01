hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd --all && systemctl --user stop graphical-session.target && systemctl --user start hyprland-session.target")
end)

hl.on("hyprland.shutdown", function()
	os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)

require("hyprland.animations")
require("hyprland.decorations")
require("hyprland.dwindle")
require("hyprland.execs")
require("hyprland.general")
require("hyprland.input")
require("hyprland.keybinds")
require("hyprland.misc")
require("hyprland.monitors")
require("hyprland.rules")

