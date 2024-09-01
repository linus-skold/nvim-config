require("roslyn").setup{ 
    ft = 'cs',
    opts = {
        config = {
            settings = { 
                ["csharp|code_lens"] = {
                    dotnet_enable_reference_code_lens = true,
                }
            }
        }
    }
}
