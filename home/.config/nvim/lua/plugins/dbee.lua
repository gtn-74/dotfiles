return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    require("dbee").install()
  end,
  config = function()
    require("dbee").setup({
      sources = {
        require("dbee.sources").MemorySource:new({
          {
            name = "householdBudget",
            type = "postgres",
            url = os.getenv("DBEE_POSTGRES_URL") or "postgres://localhost:5432/householdBudget?sslmode=disable",
          },
        }),
      },
    })
  end,
}
