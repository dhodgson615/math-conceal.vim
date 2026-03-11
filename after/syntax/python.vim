if &filetype != 'python'
    finish
endif
if has('nvim')
    lua require('mathconceal').setup()
elseif has('vim9script')
    call mathconceal#SetupPython()
endif
