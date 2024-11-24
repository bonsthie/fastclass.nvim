local M = {}

local function get_config()
    return require("fastclass").config
end

--print("Using config:", vim.inspect(get_config()))

function M.generate_dummy_class()
    local config = get_config()

    local base_template = [[
{header}

class Dummy {
    public:
    Dummy(const Dummy &ref);
    Dummy(void);
    ~Dummy(void);

    Dummy &operator=(Dummy const &src);
};

{endofheader}
]]

    --print("Generating dummy class with pragma_once_header =", config.pragma_once_header)

    local header, endofheader
    if config.pragma_once_header then
        header = "#pragma once"
        endofheader = ""
    else
        header = "#ifndef __DUMMY__\n#define __DUMMY__"
        endofheader = "#endif /* __DUMMY__ */"
    end

    return base_template
        :gsub("{header}", header)
        :gsub("{endofheader}", endofheader)
end

return M
