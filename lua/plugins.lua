M = {}
local plugins = {
  {
    -- 外观 颜色
    'folke/tokyonight.nvim',
    event = 'VeryLazy',
    config = function()
      vim.cmd('colorscheme tokyonight')
    end,
  },
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
      "kyazdani42/nvim-web-devicons"
    },
    config = function()
      local opt = require('plugins.nvimtree')
      require('nvim-tree').setup(opt.settings)
    end
  },
  {
    "akinsho/nvim-bufferline.lua",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      "moll/vim-bbye"
    },
    config = function()
      require('bufferline').setup {
        options = {
          -- 关闭tab的命令，使用的是vim-bbye的:Bdelete
          close_command = "Bdelete! %d",
          right_mouse_command = "Bdelete! %d",
          -- 侧边栏配置
          -- 左侧让出nvim-tree的位置，显示文字 File Explorer
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "left",
              highlight = "Directory",
              padding = 1
            },
          },
          -- 使用 nvim 内置 LSP  后续课程会配置
          diagnostics = "nvim_lsp",
          -- 可选，显示 LSP 报错图标
          ---@diagnostic disable-next-line: unused-local
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and " " or (e == "warning" and " " or "")
              s = s .. n .. sym
            end
            return s
          end,
        },
      }
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons"
    },
    config = function()
      require('lualine').setup {
        options = {
          theme = "tokyonight",
          component_separators = { left = "|", right = "|" },
          section_separators = { left = " ", right = "" },
        },
        extensions = { "nvim-tree", "toggleterm" },
        sections = {
          lualine_c = {
            "filename",
            {
              "lsp_progress",
              spinner_symbols = { " ", " ", " ", " ", " ", " " },
            },
          },
          lualine_x = {
            "filesize",
            {
              "fileformat",
              -- symbols = {
              --   unix = '', -- e712
              --   dos = '', -- e70f
              --   mac = '', -- e711
              -- },
              symbols = {
                unix = "LF",
                dos = "CRLF",
                mac = "CR",
              },
            },
            "encoding",
            "filetype",
          }
        }
      }
    end
  },
  {
    "arkav/lualine-lsp-progress"
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      local mappings = require('keybindings').telescopeList
      local telescope = require('telescope')
      telescope.setup({
        defaults = {
          -- 打开弹窗后进入的初始模式，默认为insert
          initial_mode = 'insert',
          mappings = mappings
        },
        pickers = {
          -- 内置 pickers 配置
          find_files = {
            -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
            -- theme = "dropdown",
          }
        },
        extensions = {
          -- 扩展插件配置
        },
      })
      pcall(telescope.load_extension, 'env')
    end
  },
  {
    "LinArcX/telescope-env.nvim"
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      vim.g.nvim_tree_respect_buf_cwd = 1
      local proj = require('project_nvim')
      proj.setup({
        detection_methods = { "pattern" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".sln" },
      })
      local telescope = require('telescope')
      pcall(telescope.load_extension, 'projects')
    end
  },
  {
    'goolord/alpha-nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons'
    },
    config = function()
      local present, alpha = pcall(require, 'alpha')
      if not present then
        return
      end
      local dashboard = require('alpha.themes.dashboard')
      local button = function(...)
        local result = dashboard.button(...)
        result.opts.hl = 'AlphaButtons'
        result.opts.hl_shortcut = ''
        return result
      end

      local buttons = {
        button('f', '  Find file', ':Telescope find_files <CR>'),
        button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        button('r', '  Recently used files', ':Telescope oldfiles <CR>'),
        button('F', '  Find text', ':Telescope live_grep <CR>'),
        button('c', '  Configuration', ':e $MYVIMRC | :cd %:p:h <CR>'),
        button('q', '  Quit Neovim', ':qa<CR>'),
      }
      dashboard.section.buttons.val = buttons
      -- 高亮
      dashboard.section.footer.opts.hl = 'AlphaType'
      dashboard.section.header.opts.hl = 'AlphaHeader'
      -- require('base46').load_highlight('alpha')
      alpha.setup(dashboard.opts)
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "json", "html", "css", "vim", "lua", "javascript", "typescript", "tsx", "vue", "dart" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<TAB>",
            node_decremental = "<BS>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      }
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldlevel = 99
    end
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate"
  },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp", },
  { "hrsh7th/cmp-nvim-lsp", },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path", },
  { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/vim-vsnip" },
  { "hrsh7th/cmp-cmdline" },
  { "rafamadriz/friendly-snippets" },
  { "onsails/lspkind-nvim" },
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      local opt = require('plugins.indent-blankline').opt
      require('indent_blankline').setup(opt)
    end
  },
  {
    "tami5/lspsaga.nvim",
    config = function()
      local opt = require('lsp.ui').lspSagaOpt
      require('lspsaga').setup(opt)
    end
  }
}
M.list = plugins
return M
