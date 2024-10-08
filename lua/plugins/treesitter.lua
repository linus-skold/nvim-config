require "nvim-treesitter.install".compilers = { "zig", "clang" } 

require("nvim-treesitter.configs").setup { 
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
  auto_install = true,
  highlight = { 
      enable = true,
      disable = { "txt" }
  }
}
