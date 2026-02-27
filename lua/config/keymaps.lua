local function java_build()
  vim.cmd("write")
  local target = ""

  if vim.fn.filereadable("build.xml") == 1 then
    vim.opt_local.makeprg = "ant -find build.xml"
    target = "compile"
  elseif vim.fn.filereadable("pom.xml") == 1 then
    -- 'mvn' command specifically for Maven projects
    vim.opt_local.makeprg = "mvn"
    target = "compile exec:java"
  elseif vim.fn.filereadable("build.gradle") == 1 then
    vim.opt_local.makeprg = "gradle"
    target = "classes"
  else
    vim.opt_local.makeprg = "javac"
    target = vim.fn.expand("%")
  end

  print("Building Java project with " .. vim.bo.makeprg .. "...")
  vim.cmd("Make " .. target)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.keymap.set("n", "<leader>m", ":Make<CR>", { buffer = true, desc = "Build Project" })
    vim.keymap.set("n", "<leader>z", ":make run<CR>", { buffer = true, desc = "Run Project" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local maven_efm = table.concat({
      "%E[ERROR] %f:[%l\\,%c] %m",

      "%E%\\s#at %m\\s#(%f:%l)",
      "%E%\\s#at %m (%f:%l)",

      "%A%f:%l: %m",
      "%-Z%p^",
      "%-C%.%#",

      "%-G[INFO]%.%#",
      "%-G[WARNING]%.%#",
      "%-G%.%#",
    }, ",")

    vim.opt_local.efm = maven_efm

    vim.keymap.set("n", "<leader>m", java_build, { buffer = true, desc = "Java Smart Build" })
    vim.keymap.set("n", "<leader>z", ":!./run.sh<CR>", { buffer = true, desc = "Run Java" })
  end,
})

vim.keymap.set("n", "<C-n>", ":cnext<CR>", { desc = "Next Error" })
vim.keymap.set("n", "<C-p>", ":cprev<CR>", { desc = "Prev Error" })
