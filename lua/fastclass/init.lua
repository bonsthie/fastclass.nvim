local M = {}

local config = {
    header = false,
    clangformat = false,
    prama_once_header = false,
	header_extension = ".h"
}


function M.setup(user_config)
	M.config.header = user_config.header
	M.config.clangformat = user_config.clangformat
	M.config.prama_once_header = user_config.prama_once_header
	M.config.header_extension = user_config.header_extension
end

M.config = config


return M
