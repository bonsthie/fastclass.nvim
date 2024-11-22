local M = {}

local config = require('fastclass').config

local dummy_class_template = require("fastclass.assets.Dummyh")
local dummy_class_template_func = require("fastclass.assets.Dummyc")

local log_file = require("fastclass.assets.log")
local log_file_name = "log" .. config.header_extension

local function exec_formatting(file_path)
    local original_buf = vim.api.nvim_get_current_buf()
    local original_win = vim.api.nvim_get_current_win()

    vim.cmd("edit " .. vim.fn.fnameescape(file_path))

	vim.bo.filetype = "cpp"

    if config.header then
        vim.cmd("Stdheader")
    end

    if config.clangformat then
        vim.lsp.buf.format()
    end

    if vim.api.nvim_buf_is_valid(original_buf) then
        vim.api.nvim_set_current_buf(original_buf)
    end

    if vim.api.nvim_win_is_valid(original_win) then
        vim.api.nvim_set_current_win(original_win)
    end
end


local function write_file(file_path, content)
	local file = io.open(file_path, "w")
	if not file then
		error("Could not write to file: " .. file_path)
	end
	file:write(content)
	file:close()
end

local function get_current_dir()
	if vim.bo.filetype == "oil" then
		local oil_ok, oil = pcall(require, "oil")
		if oil_ok then
			return oil.get_current_dir()
		else
			error("Oil plugin is not available")
		end
	end

	local filepath = vim.fn.expand('%:p')
	if filepath == "" then
		return vim.fn.getcwd()
	end

	return vim.fn.expand('%:p:h')
end

function M.create_file(class_name, content, extension)
	if not class_name or class_name == "" then
		print("Error: Class name is required.")
		return
	end
	local current_dir = get_current_dir()

	local new_class_content = content
		:gsub("DUMMY", class_name:upper())
		:gsub("Dummy", class_name)
		:gsub(".h", config.header_extension)

	local new_file_path = string.format("%s/%s" .. extension, current_dir, class_name)

	write_file(new_file_path, new_class_content)
	exec_formatting(new_file_path)

end

local oil_save = function()
	if vim.bo.filetype == "oil" then
		local oil_ok, oil = pcall(require, "oil")
		if oil_ok and oil.save then
			oil.save()
		end
	end
end

local create_log = function()
	local current_dir = get_current_dir()
	local log_file_path = string.format("%s/%s", current_dir, log_file_name)

    local file_info = vim.loop.fs_stat(log_file_path)
    if file_info then
        return
    end

	write_file(log_file_path, log_file)
	exec_formatting(log_file_path)
end

vim.api.nvim_create_user_command(
	"Fastclass",
	function(opts)
		M.create_file(opts.args, dummy_class_template, config.header_extension)
		M.create_file(opts.args, dummy_class_template_func, ".cpp")
		create_log()
		oil_save()
	end,
	{ nargs = 1 }
)

return M
