if &filetype != 'cpp'
    finish
endif
if has('nvim')
    lua require('mathconceal').setup()
elseif has('vim9script')
    call mathconceal#SetupCpp()
endif
