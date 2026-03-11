if &filetype != 'c'
    finish
endif
if has('nvim')
    lua require('mathconceal').setup()
elseif has('vim9script')
    call mathconceal#SetupC()
endif
