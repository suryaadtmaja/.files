local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
	return vim.fn.expand('%:p:h')
end

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- need to install this to make grep_string work
-- https://github.com/BurntSushi/ripgrep#installation
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)


local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
    defaults = {
        mappings = {
            n = {
                ["q"] = actions.close
            },
        },
    },
    extensions = {
        file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            mappings = {
                -- your custom insert mode mappings
                ["i"] = {
                    ["<C-w>"] = function() vim.cmd('normal vbd') end,
                },
                ["n"] = {
                    -- your custom normal mode mappings
                    -- ["N"] = fb_actions.create,
                    -- ["h"] = fb_actions.goto_parent_dir,
                    ["/"] = function()
	                    vim.cmd('startinsert')
                    end
                },
            },
        },
    },
}


vim.keymap.set('n', 'ff',
    function()
	    builtin.find_files({
	        no_ignore = false,
	        hidden = true
	    })
    end)
vim.keymap.set('n', 'fg', function()
	builtin.live_grep()
end)
vim.keymap.set('n', 'fb', function()
	builtin.buffers()
end)
vim.keymap.set('n', 'fh', function()
	builtin.help_tags()
end)
-- vim.keymap.set('n', ';;', function()
-- builtin.resume()
-- end)
-- vim.keymap.set('n', ';e', function()
-- builtin.diagnostics()
-- end)

-- Load telescope-file-browser
telescope.load_extension("file_browser")
vim.keymap.set("n", "<leader>fb", function()
	telescope.extensions.file_browser.file_browser({
	    path = "%:p:h",
	    cwd = telescope_buffer_dir(),
	    respect_gitignore = false,
	    hidden = true,
	    grouped = true,
	    -- previewer = false,
	    initial_mode = "normal",
	    -- layout_config = { height = 40 }
	})
end)
