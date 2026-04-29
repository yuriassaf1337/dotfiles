Name = "appIdeas"
NamePretty = "App Ideas"
Cache = false
HideFromProviderlist = false

local home = os.getenv("HOME")

function GetEntries()
  return {
    {
      Text    = "App Ideas",
      Actions = { activate = "omarchy-launch-floating-terminal-with-presentation " .. home .. "/.local/bin/voice-ideas" },
    },
  }
end
