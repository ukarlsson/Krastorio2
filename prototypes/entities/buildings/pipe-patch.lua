function kr_pipe_path()
  return
  {
    north =
    {
      filename = kr_entities_path .. "empty.png",
      priority = "high",
      width = 1,
      height = 1,
	  scale = 0.5,
      shift = {0, 0}
    },
    east =
    {
      filename = kr_entities_path .. "empty.png",
      priority = "high",
      width = 1,
      height = 1,
	  scale = 0.5,
      shift = {0, 0}
    },
    south =
    {
      filename = kr_entities_path .. "pipe-patch/pipe-patch.png",
      priority = "high",
      width = 23,
      height = 20,
      shift = {0.01, -0.58},
	  hr_version =
		{
		  filename = kr_entities_path .. "pipe-patch/hr-pipe-patch.png",
		  priority = "high",
		  width = 45,
		  height = 40,
		  scale = 0.5,
		  shift = {0.01, -0.58}
		}
    },
    west =
    {
      filename = kr_entities_path .. "empty.png",
      priority = "high",
      width = 1,
      height = 1,
	  scale = 0.5,
      shift = {0, 0}
    }
  }
end