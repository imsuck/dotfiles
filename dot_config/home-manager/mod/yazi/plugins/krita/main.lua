local M = {}

function M:peek(job)
  local start, cache = os.clock(), ya.file_cache(job)
  if not cache or self:preload(job) ~= 1 then
    return
  end

  ya.sleep(math.max(0, PREVIEW.image_delay / 1000 + start - os.clock()))
  ya.image_show(cache, job.area)
  ya.preview_widgets(job, {})
end

function M:preload(job)
  local cache = ya.file_cache(job)
  if not cache or fs.cha(cache) then
    return true
  end

  local output, err = Command("unzip")
    :args({
      "-p",
      tostring(job.file.url),
      "preview.png",
    })
    :stdout(Command.PIPED)
    :output()

  if not output then
    return true, Err("Failed to start `unzip`, error: %s", err)
  elseif not output.status.success then
    return true, Err("Failed to unzip .kra file, stderr: %s", output.stderr)
  end

  return fs.write(cache, output.stdout)
end

return M
