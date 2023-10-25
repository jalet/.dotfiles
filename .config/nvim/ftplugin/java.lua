require("jdtls").start_or_attach({
    cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls") },
    root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", "mvnw", ".git" }, { upward = true })[1]),
})
