require("dir-rules"):setup {
  rules = {
    screenshots = {
      sort = { "alphabetical", reverse = true },
    },
    Downloads = {
      sort = { "mtime", reverse = true },
      linemode = { "permissions" },
      hidden = { "show" },
    }
  }
}

th.git = th.git or {}
th.git.added_sign = "+"
th.git.modified_sign = "!"
th.git.deleted_sign = "-"
require("git"):setup()

function Linemode:mtime()
  local time = math.floor(self._file.cha.mtime or 0)
  if time == 0 then
	  time = ""
  elseif os.date("%Y", time) == os.date("%Y") then
	  time = os.date("%m-%d %H:%M", time)
  else
	  time = os.date("%Y-%m-%d", time)
  end
  return time
end
