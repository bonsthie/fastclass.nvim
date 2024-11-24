local M = {}

local config = {
    header = false,
    clangformat = false,
    pragma_once_header = true,
	header_extension = ".h"
}


function M.setup(user_config)
	M.config.header = user_config.header
	M.config.clangformat = user_config.clangformat
	M.config.pragma_once_header = user_config.pragma_once_header
	M.config.header_extension = user_config.header_extension
end

M.config = config

--print("Fastclass setup with config:", vim.inspect(config))


return M
