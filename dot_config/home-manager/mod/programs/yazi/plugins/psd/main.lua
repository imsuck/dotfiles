local M = {}

function M:peek(job)
  local start, cache = os.clock(), ya.file_cache(job)
  if not cache then
    return
  end

  local ok, err = self:preload(job)
  if not ok or err then
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

  local output, err = Command("magick")
    :args({
      tostring(job.file.url) .. "[0]",
      "-scale",
      "512x512",
      "png:-",
    })
    :stdout(Command.PIPED)
    :output()

  if not output then
    return true, Err("Failed to start `magick`, error: %s", err)
  elseif not output.status.success then
    return true, Err("Failed to convert psd to image, stderr: %s", output.stderr)
  end

  return fs.write(cache, output.stdout)
end

return M
