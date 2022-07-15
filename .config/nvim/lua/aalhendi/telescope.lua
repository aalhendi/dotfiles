-- Telescope Setup
require("telescope").setup {
  defaults = {
    -- Your defaults config goes in here
    'rg',
    '--with-filename',
    '--no-heading',
    '--line-number',
    '--column',
    '--smart-case'
  },
  prompt_position = "bottom",
  prompt_prefix = " >",
  selection_caret = "> ",
  entry_prefix = "  ",
  initial_mode = "insert",
  selection_strategy = "reset",
  sorting_strategy = "descending",
  layout_strategy = "horizontal",
  layout_defaults = {
    horizontal = {
      mirror = false,
    },
    vertical = {
      mirror = false,
    },
  },
  file_sorter =  require'telescope.sorters'.get_fzy_sorter,
  file_ignore_patterns = {},
  generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
  shorten_path = true,
  winblend = 0,
  width = 0.75,
  preview_cutoff = 120,
  results_height = 1,
  results_width = 0.8,
  border = {},
  borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
  color_devicons = true,
  use_less = true,
  set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
  file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
  grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
  qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
  pickers = {
    -- Your special builtin config goes in here
    buffers = {
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
          ["<C-x>"] = false,
          ["<C-q>"] = require("telescope.actions").send_to_qflist,
        },
        n = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        }
      }
    },
    find_files = {
      theme = "dropdown"
    }
  },
  extensions = {
    -- Your extension config goes in here
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
      },
    media_files =  {
      find_cmd = "rg",
      filetypes = {"png", "webp", "jpg", "jpeg", "mp4", "webm", "pdf"},
    },
  }
}
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('media_files')
