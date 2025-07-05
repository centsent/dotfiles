return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    flutter_lookup_cmd = "asdf where flutter",
  },
  keys = {
    { "<leader>rd", "<cmd>FlutterDevices<cr>", desc = "Brings up a list of connected devices to select from" },
    {
      "<leader>re",
      "<cmd>FlutterEmulators<cr>",
      desc = "Similar to devices but shows a list of emulators to choose from",
    },
    { "<leader>rl", "<cmd>FlutterLogToggle<cr>", desc = "Toggle the log buffer" },
    { "<leader>rr", "<cmd>FlutterRun<cr>", desc = "Run the current project. Respects config.debugger.enabled setting" },
    { "<leader>rq", "<cmd>FlutterQuit<cr>", desc = "Ends a running session" },
    { "<leader>rR", "<cmd>FlutterRestart<cr>", desc = "Restart the current project" },
  },
}
