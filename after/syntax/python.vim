if has('nvim')
    lua require('mathconceal').setup()
elseif has('vim9script')
    let s:mc = v9.import('mathconceal.vim')
    call s:mc.SetupPython()
endif
