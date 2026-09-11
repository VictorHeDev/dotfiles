return {
    {
        "3rd/image.nvim",
        build = false,
        opts = {
            backend = "kitty",
            processor = "magick_cli"
        },
    },
    {
        "3rd/diagram.nvim",
        dependencies = { "3rd/image.nvim" },
        ft = { "markdown" },
        opts = function()
            return {
                integrations = {
                    require("diagram.integrations.markdown"),
                },
            }
        end,
    },
}
