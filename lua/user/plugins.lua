
if jit.os == 'OSX' then
    vim.fn['plug#begin']('~/.config/nvim/plugged')  
    -- vim.cmd("plug#begin( ~/.config/nvim/user/keymap.vim")
    vim.cmd("source ~/.config/nvim/plugins.vim")
elseif jit.os == 'Windows' then 
	vim.fn['plug#begin'](vim.fn.stdpath('data') .. '/plugged')  
	-- call plug#begin('~/AppData/Local/nvim/plugged')
    	vim.cmd("source ~/AppData/Local/nvim/plugins.vim")
end



vim.fn['plug#end']()  


