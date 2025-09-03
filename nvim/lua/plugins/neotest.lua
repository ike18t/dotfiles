return {
  {
    "nvim-neotest/neotest",
    -- Issue with neotest + neotest-jest compat with later versions
    commit = "52fca6717ef972113ddd6ca223e30ad0abb2800c",
    dependencies = {
      "nvim-neotest/neotest-jest",
    },
    config = function()
      require("neotest").setup({
        discovery = {
          enabled = false,
        },
        adapters = {
          require("neotest-jest")({
            jest_test_discovery = true,

            jestCommand = "npm test --",
            jestArguments = function(defaultArguments, context)
              return defaultArguments
            end,
            jestConfigFile = "jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
            isTestFile = require("neotest-jest.jest-util").defaultIsTestFile,
          }),
        },
      })
    end,
  },
}
