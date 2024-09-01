require("nvim-tree").setup{ 
  sync_root_with_cwd = true,
  disable_netrw = true,
  hijack_netrw = true,
  update_focused_file = {
      enable = true,
      update_root = true
  },
  sort = { 
      -- could be a custom function as well.
      sorter = "case_sensitive"
      -- sorter = function(nodes) table.sort(nodes, function(a,b) return #a.name < #b.name end) end
  },
  renderer = {
      indent_markers = {
          enable = false
      },
      highlight_git = true,
      highlight_opened_files = "all",
      root_folder_modifier = ":~",
      add_trailing = true,
      group_empty = true,
      icons = {
          padding = " ",
          symlink_arrow = " >>"
      }
  },
  respect_buf_cwd = true,
  create_in_closed_folder = false
}
