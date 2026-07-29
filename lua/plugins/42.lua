local maps = require('maps.extras')

return {
    {
        'Diogo-ss/42-header.nvim',
        cmd = { 'Stdheader' },
        keys = maps.school,
        opts = {
            default_map = false,
            auto_update = true, -- Update header when saving.
            -- user = 'abait-el', -- Your user.
            -- mail = 'abait-el@student.1337.ma', -- Your mail.
            -- add other options.
        },
        config = function(_, opts) require('42header').setup(opts) end,
    },
    {
        'hardyrafael17/norminette42.nvim',
        ft = { 'c', 'cpp' },
        config = function()
            local norminette = require('norminette')
            norminette.setup({
                runOnSave = true,
                maxErrorsToShow = 5,
                active = true,
            })
        end,
    },
}
