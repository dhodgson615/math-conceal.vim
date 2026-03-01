local M = {}

local function apply_settings()
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = 'nv'
end

local function run_commands(commands)
    for _, cmd in ipairs(commands) do
        vim.cmd(cmd)
    end
end

local function setup_python()
    apply_settings()

    local superscripts = {'⁰', '¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹'}
    local type_map = {
        {kw = 'int',     name = 'Int',     sym = 'ℤ'},
        {kw = 'float',   name = 'Float',   sym = 'ℝ'},
        {kw = 'bool',    name = 'Bool',    sym = '𝔹'},
        {kw = 'complex', name = 'Complex', sym = 'ℂ'},
    }

    run_commands({
        'syntax keyword pythonLambda   lambda  conceal cchar=λ',
        'syntax keyword pythonOperator and     conceal cchar=∧',
        'syntax keyword pythonOperator or      conceal cchar=∨',
        'syntax keyword pythonOperator not     conceal cchar=¬',
        'syntax keyword pythonOperator in      conceal cchar=∈',
        'syntax keyword pythonOperator is      conceal cchar=≐',
        'syntax keyword pythonBuiltin  all     conceal cchar=∀',
        'syntax keyword pythonBuiltin  any     conceal cchar=∃',
        'syntax keyword pythonBuiltin  sum     conceal cchar=Σ',
        'syntax keyword pythonBuiltin  round   conceal cchar=≈',
        'syntax keyword pythonBuiltin  int     conceal cchar=ℤ',
        'syntax keyword pythonBuiltin  float   conceal cchar=ℝ',
        'syntax keyword pythonBuiltin  bool    conceal cchar=𝔹',
        'syntax keyword pythonBuiltin  complex conceal cchar=ℂ',
        'syntax keyword pythonBuiltin  set     conceal cchar=𝕊',
        'syntax keyword pythonListType list    conceal cchar=𝕃',
        'syntax keyword pythonListType List    conceal cchar=𝕃',
        'syntax keyword pythonListType tuple   conceal cchar=𝕋',
        'syntax keyword pythonListType Tuple   conceal cchar=𝕋',
        'syntax keyword pythonBuiltin  dict    conceal cchar=𝔻',
        'syntax keyword pythonBuiltin  Dict    conceal cchar=𝔻',
        'syntax keyword pythonBuiltin  True    conceal cchar=⊤',
        'syntax keyword pythonBuiltin  False   conceal cchar=⊥',
        'syntax match mathNotIn    "\\<not in\\>" conceal cchar=∉ containedin=ALL',
        'syntax match mathIsNot    "\\<is not\\>" conceal cchar=≢ containedin=ALL',
        'syntax match mathEmptySet "{}"           conceal cchar=∅',
        'syntax match pythonOperator "->" conceal cchar=→',
        'syntax match pythonOperator "==" conceal cchar=≡',
        'syntax match pythonOperator "!=" conceal cchar=≠',
        'syntax match pythonOperator "<=" conceal cchar=≤',
        'syntax match pythonOperator ">=" conceal cchar=≥',
        'syntax match pythonOperator "<<" conceal cchar=≪',
        'syntax match pythonOperator ">>" conceal cchar=≫',
        'syntax match pythonOperator "*"  conceal cchar=×',
        'syntax match pythonOperator "\\*\\*" conceal cchar=^',
        'syntax match pythonBuiltin  "\\v\\.T|transpose\\(\\)@=" conceal cchar=ᵀ',
        'syntax match pythonBuiltin  "\\v<(np\\.|numpy\\.)?dot>" conceal cchar=⋅',
        'syntax match pythonBuiltin  "\\v<(np\\.|numpy\\.)?gradient>" conceal cchar=∇',
        'syntax match pythonBuiltin  "\\v<(math\\.|np\\.|numpy\\.)?prod(uct)?>" conceal cchar=∏',
        'syntax match pythonBuiltin  "\\v<(math\\.|np\\.|numpy\\.)?pi>" conceal cchar=π',
        'syntax match pythonBuiltin  "\\v<(math\\.|np\\.|numpy\\.)?inf>" conceal cchar=∞',
        'syntax match pythonBuiltin  "\\v<(math\\.|np\\.|numpy\\.)?sqrt>" conceal cchar=√',
        'syntax match pythonBuiltin  "\\v<(math\\.|np\\.|numpy\\.)?exp>" conceal cchar=ℯ',
        'syntax match pythonListType "\\<list\\[" conceal cchar=[',
    })

    for i = 0, 9 do
        vim.cmd(string.format(
            'syntax match pythonOperator "\\v\\*\\* ?%d($|[^\\d])@=" conceal cchar=%s',
            i, superscripts[i + 1]))
    end

    for i = 2, 9 do
        vim.cmd(string.format(
            'syntax match mathTupExp%d "]" contained conceal cchar=%s',
            i, superscripts[i + 1]))

        for _, t in ipairs(type_map) do
            local repeats     = string.rep(',\\s*' .. t.kw, i - 1)
            local base_pattern = '\\vtuple\\[' .. t.kw .. repeats
            local group_name  = string.format('mathTup%s%d', t.name, i)
            local base_group  = string.format('mathTupBase%s%d', t.name, i)

            vim.cmd(string.format(
                'syntax match %s "%s\\]" contains=%s,mathTupExp%d containedin=ALL',
                group_name, base_pattern, base_group, i))
            vim.cmd(string.format(
                'syntax match %s "%s" contained conceal cchar=%s',
                base_group, base_pattern, t.sym))
            vim.cmd(string.format('hi! link %s pythonBuiltin', group_name))
            vim.cmd(string.format('hi! link %s pythonBuiltin', base_group))
        end

        vim.cmd(string.format('hi! link mathTupExp%d pythonBuiltin', i))
    end

    run_commands({
        'hi Conceal ctermbg=NONE guibg=NONE',
        'hi! link pythonLambda Statement',
        'hi! link pythonListType pythonBuiltin',
        'hi! link mathNotIn pythonOperator',
        'hi! link mathIsNot pythonOperator',
        'hi! link mathEmptySet pythonStatement',
    })

    local dynamic_minlines = vim.fn.winheight(0) * 2
    vim.cmd(string.format('syntax sync minlines=%d', dynamic_minlines))
end

local function setup_c()
    apply_settings()

    run_commands({
        'syntax keyword cType         void     conceal cchar=∅',
        'syntax keyword cType         bool     conceal cchar=𝔹',
        'syntax keyword cType         int      conceal cchar=ℤ',
        'syntax keyword cType         float    conceal cchar=ℝ',
        'syntax keyword cType         double   conceal cchar=𝔻',
        'syntax keyword cType         char     conceal cchar=ℂ',
        'syntax keyword cStorageClass unsigned conceal cchar=⁺',
        'syntax keyword cConstant     true     conceal cchar=⊤',
        'syntax keyword cConstant     false    conceal cchar=⊥',
        'syntax keyword cConstant     NULL     conceal cchar=ø',
        'syntax match cOperator "==" conceal cchar=≡',
        'syntax match cOperator "!=" conceal cchar=≠',
        'syntax match cOperator "<=" conceal cchar=≤',
        'syntax match cOperator ">=" conceal cchar=≥',
        'syntax match cOperator "&&" conceal cchar=∧',
        'syntax match cOperator "||" conceal cchar=∨',
        'syntax match cOperator "!"  conceal cchar=¬',
        'syntax match cOperator "<<" conceal cchar=≪',
        'syntax match cOperator ">>" conceal cchar=≫',
        'syntax match cOperator "->" conceal cchar=→',
        'syntax match cSpecial "\\v<M_PI>"     conceal cchar=π',
        'syntax match cSpecial "\\v<INFINITY>" conceal cchar=∞',
        'syntax match cSpecial /\\v<sqrt>\\(/me=e-1 conceal cchar=√ containedin=ALL',
        'syntax match cSpecial /\\v<sum>\\(/me=e-1  conceal cchar=∑ containedin=ALL',
        'hi Conceal ctermbg=NONE guibg=NONE',
    })
end

local function setup_cpp()
    apply_settings()

    run_commands({
        'syntax keyword cType     void    conceal cchar=∅',
        'syntax keyword cType     bool    conceal cchar=𝔹',
        'syntax keyword cType     int     conceal cchar=ℤ',
        'syntax keyword cType     float   conceal cchar=ℝ',
        'syntax keyword cType     double  conceal cchar=𝔻',
        'syntax keyword cType     char    conceal cchar=ℂ',
        'syntax keyword cConstant true    conceal cchar=⊤',
        'syntax keyword cConstant false   conceal cchar=⊥',
        'syntax keyword cConstant nullptr conceal cchar=ø',
        'syntax keyword cConstant NULL    conceal cchar=ø',
        'syntax match cOperator "==" conceal cchar=≡',
        'syntax match cOperator "!=" conceal cchar=≠',
        'syntax match cOperator "<=" conceal cchar=≤',
        'syntax match cOperator ">=" conceal cchar=≥',
        'syntax match cOperator "&&" conceal cchar=∧',
        'syntax match cOperator "||" conceal cchar=∨',
        'syntax match cOperator "!"  conceal cchar=¬',
        'syntax match cOperator "<<" conceal cchar=≪',
        'syntax match cOperator ">>" conceal cchar=≫',
        'syntax match cOperator "->" conceal cchar=→',
        'syntax match cOperator "::" conceal cchar=∷',
        'syntax match cSpecial "\\v<M_PI>"     conceal cchar=π',
        'syntax match cSpecial "\\v<INFINITY>" conceal cchar=∞',
        'syntax match cSpecial /\\v<sqrt>\\(/me=e-1 conceal cchar=√ containedin=ALL',
        'hi Conceal ctermbg=NONE guibg=NONE',
    })
end

local function setup_haskell()
    apply_settings()

    run_commands({
        'syntax keyword hsType    Int      conceal cchar=ℤ',
        'syntax keyword hsType    Integer  conceal cchar=ℤ',
        'syntax keyword hsType    Float    conceal cchar=ℝ',
        'syntax keyword hsType    Double   conceal cchar=𝔻',
        'syntax keyword hsType    Char     conceal cchar=ℂ',
        'syntax keyword hsType    Bool     conceal cchar=𝔹',
        'syntax keyword hsType    String   conceal cchar=𝕊',
        'syntax keyword hsType    True     conceal cchar=⊤',
        'syntax keyword hsType    False    conceal cchar=⊥',
        'syntax keyword hsType    Nothing  conceal cchar=∅',
        'syntax keyword hsKeyword not      conceal cchar=¬',
        'syntax keyword hsKeyword elem     conceal cchar=∈',
        'syntax keyword hsKeyword notElem  conceal cchar=∉',
        'syntax keyword hsKeyword forall   conceal cchar=∀',
        'syntax keyword hsKeyword sum      conceal cchar=Σ',
        'syntax keyword hsKeyword product  conceal cchar=∏',
        'syntax keyword hsKeyword sqrt     conceal cchar=√',
        'syntax keyword hsKeyword pi       conceal cchar=π',
        'syntax match hsOperator "->" conceal cchar=→',
        'syntax match hsOperator "=>" conceal cchar=⇒',
        'syntax match hsOperator "<-" conceal cchar=←',
        'syntax match hsOperator "::" conceal cchar=∷',
        'syntax match hsOperator "==" conceal cchar=≡',
        'syntax match hsOperator "/=" conceal cchar=≠',
        'syntax match hsOperator "<=" conceal cchar=≤',
        'syntax match hsOperator ">=" conceal cchar=≥',
        'syntax match hsOperator "&&" conceal cchar=∧',
        'syntax match hsOperator "||" conceal cchar=∨',
        'hi Conceal ctermbg=NONE guibg=NONE',
        'hi! link hsKeyword Statement',
    })
end

local function setup_lua()
    apply_settings()

    run_commands({
        'syntax keyword luaConstant  nil      conceal cchar=∅',
        'syntax keyword luaConstant  true     conceal cchar=⊤',
        'syntax keyword luaConstant  false    conceal cchar=⊥',
        'syntax keyword luaOperator  and      conceal cchar=∧',
        'syntax keyword luaOperator  or       conceal cchar=∨',
        'syntax keyword luaOperator  not      conceal cchar=¬',
        'syntax keyword luaStatement function conceal cchar=ƒ',
        'syntax match luaOperator "==" conceal cchar=≡',
        'syntax match luaOperator "~=" conceal cchar=≠',
        'syntax match luaOperator "<=" conceal cchar=≤',
        'syntax match luaOperator ">=" conceal cchar=≥',
        'syntax match luaOperator "\\v<math\\.pi>"   conceal cchar=π',
        'syntax match luaOperator "\\v<math\\.huge>" conceal cchar=∞',
        'syntax match luaOperator /\\v<math\\.sqrt>\\(/me=e-1 conceal cchar=√ containedin=ALL',
        'hi Conceal ctermbg=NONE guibg=NONE',
    })
end

local function setup_go()
    apply_settings()

    run_commands({
        'syntax keyword goDeclaration nil        conceal cchar=∅',
        'syntax keyword goDeclaration true       conceal cchar=⊤',
        'syntax keyword goDeclaration false      conceal cchar=⊥',
        'syntax keyword goType        int        conceal cchar=ℤ',
        'syntax keyword goType        int8       conceal cchar=ℤ',
        'syntax keyword goType        int16      conceal cchar=ℤ',
        'syntax keyword goType        int32      conceal cchar=ℤ',
        'syntax keyword goType        int64      conceal cchar=ℤ',
        'syntax keyword goType        float32    conceal cchar=ℝ',
        'syntax keyword goType        float64    conceal cchar=ℝ',
        'syntax keyword goType        bool       conceal cchar=𝔹',
        'syntax keyword goType        string     conceal cchar=𝕊',
        'syntax keyword goType        complex128 conceal cchar=ℂ',
        'syntax match goOperator "<-" conceal cchar=←',
        'syntax match goOperator "==" conceal cchar=≡',
        'syntax match goOperator "!=" conceal cchar=≠',
        'syntax match goOperator "<=" conceal cchar=≤',
        'syntax match goOperator ">=" conceal cchar=≥',
        'syntax match goOperator "&&" conceal cchar=∧',
        'syntax match goOperator "||" conceal cchar=∨',
        'syntax match goOperator "!"  conceal cchar=¬',
        'syntax match goOperator "\\v<math\\.Pi>"   conceal cchar=π',
        'syntax match goOperator "\\v<math\\.Inf>"  conceal cchar=∞',
        'syntax match goOperator /\\v<math\\.Sqrt>\\(/me=e-1 conceal cchar=√ containedin=ALL',
        'hi Conceal ctermbg=NONE guibg=NONE',
    })
end

local function setup_java()
    apply_settings()

    run_commands({
        'syntax keyword javaType     void       conceal cchar=∅',
        'syntax keyword javaType     boolean    conceal cchar=𝔹',
        'syntax keyword javaType     int        conceal cchar=ℤ',
        'syntax keyword javaType     float      conceal cchar=ℝ',
        'syntax keyword javaType     double     conceal cchar=𝔻',
        'syntax keyword javaType     char       conceal cchar=ℂ',
        'syntax keyword javaBoolean  true       conceal cchar=⊤',
        'syntax keyword javaBoolean  false      conceal cchar=⊥',
        'syntax keyword javaConstant null       conceal cchar=ø',
        'syntax keyword javaOperator instanceof conceal cchar=∈',
        'syntax match javaOperator "==" conceal cchar=≡',
        'syntax match javaOperator "!=" conceal cchar=≠',
        'syntax match javaOperator "<=" conceal cchar=≤',
        'syntax match javaOperator ">=" conceal cchar=≥',
        'syntax match javaOperator "&&" conceal cchar=∧',
        'syntax match javaOperator "||" conceal cchar=∨',
        'syntax match javaOperator "!"  conceal cchar=¬',
        'syntax match javaOperator "->" conceal cchar=→',
        'hi Conceal ctermbg=NONE guibg=NONE',
    })
end

local function setup_rust()
    apply_settings()

    run_commands({
        'syntax keyword rustType    bool  conceal cchar=𝔹',
        'syntax keyword rustType    i32   conceal cchar=ℤ',
        'syntax keyword rustType    i64   conceal cchar=ℤ',
        'syntax keyword rustType    f32   conceal cchar=ℝ',
        'syntax keyword rustType    f64   conceal cchar=ℝ',
        'syntax keyword rustType    char  conceal cchar=ℂ',
        'syntax keyword rustType    str   conceal cchar=𝕊',
        'syntax keyword rustBoolean true  conceal cchar=⊤',
        'syntax keyword rustBoolean false conceal cchar=⊥',
        'syntax keyword rustEnum    None  conceal cchar=∅',
        'syntax match rustOperator "->" conceal cchar=→',
        'syntax match rustOperator "=>" conceal cchar=⇒',
        'syntax match rustOperator "::" conceal cchar=∷',
        'syntax match rustOperator "==" conceal cchar=≡',
        'syntax match rustOperator "!=" conceal cchar=≠',
        'syntax match rustOperator "<=" conceal cchar=≤',
        'syntax match rustOperator ">=" conceal cchar=≥',
        'syntax match rustOperator "&&" conceal cchar=∧',
        'syntax match rustOperator "||" conceal cchar=∨',
        'syntax match rustOperator "!"  conceal cchar=¬',
        'syntax match rustOperator "<<" conceal cchar=≪',
        'syntax match rustOperator ">>" conceal cchar=≫',
        'hi Conceal ctermbg=NONE guibg=NONE',
    })
end

local function setup_sql()
    apply_settings()

    run_commands({
        'syntax keyword sqlSpecial  NULL      conceal cchar=ø',
        'syntax keyword sqlOperator NOT       conceal cchar=¬',
        'syntax keyword sqlOperator AND       conceal cchar=∧',
        'syntax keyword sqlOperator OR        conceal cchar=∨',
        'syntax keyword sqlOperator IN        conceal cchar=∈',
        'syntax keyword sqlOperator LIKE      conceal cchar=≈',
        'syntax keyword sqlOperator UNION     conceal cchar=∪',
        'syntax keyword sqlOperator INTERSECT conceal cchar=∩',
        'syntax keyword sqlOperator EXCEPT    conceal cchar=∖',
        'syntax keyword sqlFunction SUM       conceal cchar=Σ',
        'syntax keyword sqlFunction AVG       conceal cchar=μ',
        'syntax keyword sqlFunction MIN       conceal cchar=⌊',
        'syntax keyword sqlFunction MAX       conceal cchar=⌈',
        'syntax match sqlOperator "<>" conceal cchar=≠',
        'syntax match sqlOperator "!=" conceal cchar=≠',
        'syntax match sqlOperator "<=" conceal cchar=≤',
        'syntax match sqlOperator ">=" conceal cchar=≥',
        'hi Conceal ctermbg=NONE guibg=NONE',
    })
end

function M.setup()
    local ft = vim.bo.filetype
    if     ft == 'python'  then setup_python()
    elseif ft == 'c'       then setup_c()
    elseif ft == 'cpp'     then setup_cpp()
    elseif ft == 'haskell' then setup_haskell()
    elseif ft == 'lua'     then setup_lua()
    elseif ft == 'go'      then setup_go()
    elseif ft == 'java'    then setup_java()
    elseif ft == 'rust'    then setup_rust()
    elseif ft == 'sql'     then setup_sql()
    end
end

return M
