if has('nvim')
    lua require('mathconceal').setup()
elseif has('vim9script')
    import autoload 'mathconceal.vim' as mc
    mc.SetupC()
endif
