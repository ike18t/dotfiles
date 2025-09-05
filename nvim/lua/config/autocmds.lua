-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
if vim.env.TMUX then
  local aug = vim.api.nvim_create_augroup("TmuxRenameWindow", { clear = true })

  local function rename(name)
    -- Run tmux command and wait for it to complete (safe even during VimLeave).
    pcall(function()
      vim.system({ "tmux", "rename-window", name }):wait()
    end)
  end

  local function cwd_basename()
    local uv = vim.uv or vim.loop
    local cwd = (uv and uv.cwd()) or vim.fn.getcwd()
    local name = vim.fn.fnamemodify(cwd, ":t")
    return (name ~= nil and name ~= "") and name or "nvim"
  end

  vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    group = aug,
    callback = function()
      rename(cwd_basename())
    end,
    desc = "Rename tmux window to cwd basename",
  })

  vim.api.nvim_create_autocmd("VimLeave", {
    group = aug,
    callback = function()
      rename("zsh")
    end,
    desc = 'Restore tmux window name to "zsh" on exit',
  })
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.puml",
  callback = function()
    vim.o.filetype = "markdown"
  end,
})
