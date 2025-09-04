-- Open the sibling test file (.<test|spec>.<ts|tsx|js|jsx>) in a vertical split.
-- Usage: :VTest  or <leader>vt
return {
  {
    "LazyVim/LazyVim",
    init = function()
      local uv = vim.uv or vim.loop
      local function exists(p)
        return p and uv.fs_stat(p) ~= nil
      end

      vim.api.nvim_create_user_command("VTest", function()
        local path = vim.api.nvim_buf_get_name(0)
        if path == "" then
          vim.notify("Current buffer has no file path.", vim.log.levels.WARN)
          return
        end

        -- Already a test file? just split the same path
        if path:match("%.test%.") or path:match("%.spec%.") then
          vim.cmd("vsplit " .. vim.fn.fnameescape(path))
          return
        end

        -- Regex the final extension: .ts/.tsx/.js/.jsx
        local c_test = path:gsub("%.([tj]sx?)$", ".test.%1")
        local c_spec = path:gsub("%.([tj]sx?)$", ".spec.%1")

        if c_test == path and c_spec == path then
          vim.notify("Not a ts/tsx/js/jsx file; can't derive test file.", vim.log.levels.WARN)
          return
        end

        -- Prefer an existing file; otherwise pick .test.*
        local target = exists(c_test) and c_test or (exists(c_spec) and c_spec or c_test)
        vim.cmd("vsplit " .. vim.fn.fnameescape(target))
      end, { desc = "Open test file in a vertical split" })
    end,

    keys = {
      -- { "<leader>vt", "<cmd>VTest<CR>", desc = "Vsplit test file" },
    },
  },
}
