local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local nnoremap = require('aalhendi.keymap').nnoremap

-- Telescope Setup
telescope.setup {
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
  file_previewer = previewers.vim_buffer_cat.new,
  grep_previewer = previewers.vim_buffer_vimgrep.new,
  qflist_previewer = previewers.vim_buffer_qflist.new,
  pickers = {
    -- Your special builtin config goes in here
    buffers = {
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-c>"] = actions.close,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,

          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.complete_tag,
          ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        },
        n = {
          ["<c-d>"] = actions.delete_buffer,
          ["<esc>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["?"] = actions.which_key,
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

require("telescope").load_extension("git_worktree")
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('media_files')
-- TELESCOPE MAPS
nnoremap('<leader>ps', ":lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep for > ') })<CR>")
nnoremap('<leader>pf', ":lua require('telescope.builtin').find_files()<CR>")
nnoremap('<leader>pg', ":lua require('telescope.builtin').live_grep()<CR>")
nnoremap('<leader>pb', ":lua require('telescope.builtin').buffers()<CR>")
nnoremap('<C-p>', ":lua require('telescope.builtin').git_files()<CR>")
nnoremap('<leader>pw', ":lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>')})<CR>")
nnoremap("<leader>pj", ":lua require('telescope.builtin').current_buffer_fuzzy_find{sorting_strategy='ascending',prompt_position='top'}<CR>")
