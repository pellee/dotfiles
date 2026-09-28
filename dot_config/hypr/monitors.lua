-- monitor = eDP-1, 1920x1080@59.98, 0x0, 1
-- monitor = HDMI-A-1, 1920x1080@60, 1920x0, 1
hl.monitor({
  output = "eDP-1",
  mode = "1920x1080@59.98",
  position = "0x0",
  scale = 1
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@59.80",
  position = "1920x0",
  scale = 1
})
