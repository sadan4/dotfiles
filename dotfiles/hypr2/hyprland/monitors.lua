-- left
hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1200@59.95",
  position = "0x0",
  scale = "1",
})

-- center, primary
hl.monitor({
  output = "DP-2",
  mode = "1920x1080@143.98",
  position = "1920x120",
  scale = "1",
})

-- right
hl.monitor({
  output = "DP-1",
  mode = "1920x1080@60",
  position = "3840x120",
  scale = "1",
})

-- fallback for anything else
hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = "1",
})
