hl.window_rule({
  match = { title = "(?i)bitwarden" },
  float = true,
  size = "800 600",
})

hl.window_rule({
  match = {
    class = "^(download)$",
  },
  float = true,
})

hl.window_rule({
  match = {
    class = "^(zen-.*)$",
  },
  workspace = "1",
})

hl.window_rule({
  match = {
    class = "^(obsidian)$",
  },
  workspace = "2",
})

hl.window_rule({
  match = {
    class = "^(vesktop)$",
  },
  workspace = "3",
})

hl.window_rule({
  match = {
    class = "JKPS",
  },
  workspace = "11 silent",
})

hl.window_rule({
  match = {
    class = "dev.faetalize.waytator",
  },
  workspace = "special:waytator",
})

hl.workspace_rule({
  workspace = "special:waytator",
  gaps_out = 48,
  persistent = false,
})

-- https://wiki.hypr.land/configuring/code-snippets/#launching-programs-on-workspace-creation

local workspace_programs = {
  ["special:spotify"] = { "spotify", { no_shadow = true } },
}

hl.on("workspace.created", function(ws)
  if ws.is_empty then
    return
  end

  local program = workspace_programs[ws.name]
  if program == nil then
    return
  end

  local cmd, rules = table.unpack(program)
  hl.exec_cmd(cmd, rules)
end)
