vim9script

export class PythonConcealer
    public var conceallevel: number = 2
    public var concealcursor: string = 'nv'

    static var type_map: dict<list<string>> = {'int':     ['Int',     'ℤ'],
                                               'float':   ['Float',   'ℝ'],
                                               'bool':    ['Bool',    '𝔹'],
                                               'complex': ['Complex', 'ℂ']}

    def new(level: number = 2, cursor: string = 'nv')
        this.conceallevel  = level
        this.concealcursor = cursor
    enddef

    def ApplySettings()
        &l:conceallevel  = this.conceallevel
        &l:concealcursor = this.concealcursor
    enddef

    def SetupSyntax()
        var keyword_maps = {'lambda':  ['pythonLambda',   'λ'],
                            'and':     ['pythonOperator', '∧'],
                            'or':      ['pythonOperator', '∨'],
                            'not':     ['pythonOperator', '¬'],
                            'in':      ['pythonOperator', '∈'],
                            'is':      ['pythonOperator', '≐'],
                            'all':     ['pythonBuiltin',  '∀'],
                            'any':     ['pythonBuiltin',  '∃'],
                            'sum':     ['pythonBuiltin',  'Σ'],
                            'round':   ['pythonBuiltin',  '≈'],
                            'int':     ['pythonBuiltin',  'ℤ'],
                            'float':   ['pythonBuiltin',  'ℝ'],
                            'bool':    ['pythonBuiltin',  '𝔹'],
                            'complex': ['pythonBuiltin',  'ℂ'],
                            'set':     ['pythonBuiltin',  '𝕊'],
                            'list':    ['pythonListType', '𝕃'],
                            'List':    ['pythonListType', '𝕃'],
                            'tuple':   ['pythonListType', '𝕋'],
                            'Tuple':   ['pythonListType', '𝕋'],
                            'dict':    ['pythonBuiltin',  '𝔻'],
                            'Dict':    ['pythonBuiltin',  '𝔻'],
                            'True':    ['pythonBuiltin',  '⊤'],
                            'False':   ['pythonBuiltin',  '⊥']}

        for [kw, data] in items(keyword_maps)
            execute $'syntax keyword {data[0]} {kw} conceal cchar={data[1]}'
        endfor

        syntax match mathNotIn    "\<not in\>" conceal cchar=∉ containedin=ALL
        syntax match mathIsNot    "\<is not\>" conceal cchar=≢ containedin=ALL
        syntax match mathEmptySet "{}"         conceal cchar=∅

        var simple_ops = {'->': '→',
                          '==': '≡',
                          '!=': '≠',
                          '<=': '≤',
                          '>=': '≥',
                          '<<': '≪',
                          '>>': '≫',
                          '*':  '×'}

        for [pattern, char] in items(simple_ops)
            execute $'syntax match pythonOperator "{pattern}" conceal cchar={char}'
        endfor

        var superscripts = ['⁰', '¹', '²', '³', '⁴',
                            '⁵', '⁶', '⁷', '⁸', '⁹']

        for i in range(10)
            execute $'syntax match pythonOperator "\v\*\* ?{i}($|[^\d])@=" conceal cchar={superscripts[i]}'
        endfor

        syntax match pythonOperator "\*\*"                                 conceal cchar=^
        syntax match pythonBuiltin  "\v\.T|transpose\(\)@="                conceal cchar=ᵀ
        syntax match pythonBuiltin  "\v<(np\.|numpy\.)?dot>"               conceal cchar=⋅
        syntax match pythonBuiltin  "\v<(np\.|numpy\.)?gradient>"          conceal cchar=∇
        syntax match pythonBuiltin  "\v<(math\.|np\.|numpy\.)?prod(uct)?>" conceal cchar=∏
        syntax match pythonBuiltin  "\v<(math\.|np\.|numpy\.)?pi>"         conceal cchar=π
        syntax match pythonBuiltin  "\v<(math\.|np\.|numpy\.)?inf>"        conceal cchar=∞
        syntax match pythonBuiltin  "\v<(math\.|np\.|numpy\.)?sqrt>"       conceal cchar=√
        syntax match pythonBuiltin  "\v<(math\.|np\.|numpy\.)?exp>"        conceal cchar=ℯ
        syntax match pythonListType "\<list\["                             conceal cchar=[

        this.GenerateTupleSyntax(superscripts)
        this.ApplyHighlights()
        this.SyncSyntax()
    enddef

    def GenerateTupleSyntax(superscripts: list<string>)
        for i in range(2, 10)
            execute $'syntax match mathTupExp{i} "\]" contained conceal cchar={superscripts[i % 10]}'

            for [type_kw, type_data] in items(type_map)
                var base_pattern = $'\vtuple\[{type_kw}' .. repeat($',\s*{type_kw}', i - 1)
                var group_name = $'mathTup{type_data[0]}{i}'
                var base_group = $'mathTupBase{type_data[0]}{i}'

                execute $'syntax match {group_name} "{base_pattern}\]" contains={base_group},mathTupExp{i} containedin=ALL'
                execute $'syntax match {base_group} "{base_pattern}" contained conceal cchar={type_data[1]}'
                execute $'hi! link {group_name} pythonBuiltin'
                execute $'hi! link {base_group} pythonBuiltin'
            endfor

            execute $'hi! link mathTupExp{i} pythonBuiltin'
        endfor
    enddef

    def ApplyHighlights()
        hi Conceal ctermbg=NONE guibg=NONE
        hi! link pythonLambda Statement
        hi! link pythonListType pythonBuiltin
        hi! link mathNotIn pythonOperator
        hi! link mathIsNot pythonOperator
        hi! link mathEmptySet pythonStatement
    enddef

    def SyncSyntax()
        var dynamic_minlines: number = winheight(0) * 2
        execute $'syntax sync minlines={dynamic_minlines}'
    enddef
endclass

var python_concealer = PythonConcealer.new()

export def SetupPython()
    python_concealer.ApplySettings()
    python_concealer.SetupSyntax()
enddef

autocmd VimResized * if &ft == 'python' | python_concealer.SyncSyntax() | endif

export class CConcealer
    public var conceallevel: number = 2
    public var concealcursor: string = 'nv'

    def new(level: number = 2, cursor: string = 'nv')
        this.conceallevel  = level
        this.concealcursor = cursor
    enddef

    def ApplySettings()
        &l:conceallevel  = this.conceallevel
        &l:concealcursor = this.concealcursor
    enddef

    def SetupSyntax()
        var keyword_maps = {'void':      ['cType',         '∅'],
                            'bool':      ['cType',         '𝔹'],
                            'int':       ['cType',         'ℤ'],
                            'float':     ['cType',         'ℝ'],
                            'double':    ['cType',         '𝔻'],
                            'char':      ['cType',         'ℂ'],
                            'unsigned ': ['cStorageClass', '⁺'],  # TODO: Make this render "unsigned int" as "⁺ℤ", not "⁺ ℤ" like it currently does
                            'true':      ['cConstant',     '⊤'],
                            'false':     ['cConstant',     '⊥'],
                            'NULL':      ['cConstant',     'ø']}

        for [kw, data] in items(keyword_maps)
            execute $'syntax keyword {data[0]} {kw} conceal cchar={data[1]}'
        endfor

        var ops = {'==': '≡',
                   '!=': '≠',
                   '<=': '≤',
                   '>=': '≥',
                   '&&': '∧',
                   '||': '∨',
                   '!':  '¬'}

        for [pattern, char] in items(ops)
            execute $'syntax match cOperator "{pattern}" conceal cchar={char}'
        endfor

        syntax match cOperator "<<"           conceal cchar=≪
        syntax match cOperator ">>"           conceal cchar=≫
        syntax match cOperator "->"           conceal cchar=→
        syntax match cSpecial  "\v<M_PI>"     conceal cchar=π
        syntax match cSpecial  "\v<INFINITY>" conceal cchar=∞

        execute 'syntax match cSpecial /\v<sqrt>\(/me=e-1 conceal cchar=√ containedin=ALL'
        execute 'syntax match cSpecial /\v<sum>\(/me=e-1  conceal cchar=∑ containedin=ALL'

        this.ApplyHighlights()
    enddef

    def ApplyHighlights()
        hi! link Conceal Operator
        hi Conceal ctermbg=NONE guibg=NONE
    enddef
endclass

var c_concealer = CConcealer.new()

export def SetupC()
    c_concealer.ApplySettings()
    c_concealer.SetupSyntax()
enddef

# autocmd VimResized * if &ft == 'c' | c_concealer.SyncSyntax() | endif  # TODO: Do I need this?

export class CppConcealer
    public var conceallevel: number = 2
    public var concealcursor: string = 'nv'

    def new(level: number = 2, cursor: string = 'nv')
        this.conceallevel  = level
        this.concealcursor = cursor
    enddef

    def ApplySettings()
        &l:conceallevel  = this.conceallevel
        &l:concealcursor = this.concealcursor
    enddef

    def SetupSyntax()
        var keyword_maps = {'void':    ['cType',      '∅'],
                            'bool':    ['cType',      '𝔹'],
                            'int':     ['cType',      'ℤ'],
                            'float':   ['cType',      'ℝ'],
                            'double':  ['cType',      '𝔻'],
                            'char':    ['cType',      'ℂ'],
                            'true':    ['cConstant',  '⊤'],
                            'false':   ['cConstant',  '⊥'],
                            'nullptr': ['cConstant',  'ø'],
                            'NULL':    ['cConstant',  'ø']}

        for [kw, data] in items(keyword_maps)
            execute $'syntax keyword {data[0]} {kw} conceal cchar={data[1]}'
        endfor

        var ops = {'==': '≡',
                   '!=': '≠',
                   '<=': '≤',
                   '>=': '≥',
                   '&&': '∧',
                   '||': '∨',
                   '!':  '¬'}

        for [pattern, char] in items(ops)
            execute $'syntax match cOperator "{pattern}" conceal cchar={char}'
        endfor

        syntax match cOperator "<<"           conceal cchar=≪
        syntax match cOperator ">>"           conceal cchar=≫
        syntax match cOperator "->"           conceal cchar=→
        syntax match cOperator "::"           conceal cchar=∷
        syntax match cSpecial  "\v<M_PI>"     conceal cchar=π
        syntax match cSpecial  "\v<INFINITY>" conceal cchar=∞

        execute 'syntax match cSpecial /\v<sqrt>\(/me=e-1 conceal cchar=√ containedin=ALL'

        this.ApplyHighlights()
    enddef

    def ApplyHighlights()
        hi! link Conceal Operator
        hi Conceal ctermbg=NONE guibg=NONE
    enddef
endclass

var cpp_concealer = CppConcealer.new()

export def SetupCpp()
    cpp_concealer.ApplySettings()
    cpp_concealer.SetupSyntax()
enddef

export class HaskellConcealer
    public var conceallevel: number = 2
    public var concealcursor: string = 'nv'

    def new(level: number = 2, cursor: string = 'nv')
        this.conceallevel  = level
        this.concealcursor = cursor
    enddef

    def ApplySettings()
        &l:conceallevel  = this.conceallevel
        &l:concealcursor = this.concealcursor
    enddef

    def SetupSyntax()
        var keyword_maps = {'Int':      ['hsType',    'ℤ'],
                            'Integer':  ['hsType',    'ℤ'],
                            'Float':    ['hsType',    'ℝ'],
                            'Double':   ['hsType',    '𝔻'],
                            'Char':     ['hsType',    'ℂ'],
                            'Bool':     ['hsType',    '𝔹'],
                            'String':   ['hsType',    '𝕊'],
                            'True':     ['hsType',    '⊤'],
                            'False':    ['hsType',    '⊥'],
                            'Nothing':  ['hsType',    '∅'],
                            'not':      ['hsKeyword', '¬'],
                            'elem':     ['hsKeyword', '∈'],
                            'notElem':  ['hsKeyword', '∉'],
                            'forall':   ['hsKeyword', '∀'],
                            'sum':      ['hsKeyword', 'Σ'],
                            'product':  ['hsKeyword', '∏'],
                            'sqrt':     ['hsKeyword', '√'],
                            'pi':       ['hsKeyword', 'π']}

        for [kw, data] in items(keyword_maps)
            execute $'syntax keyword {data[0]} {kw} conceal cchar={data[1]}'
        endfor

        var ops = {'->': '→',
                   '=>': '⇒',
                   '<-': '←',
                   '::': '∷',
                   '==': '≡',
                   '/=': '≠',
                   '<=': '≤',
                   '>=': '≥',
                   '&&': '∧',
                   '||': '∨'}

        for [pattern, char] in items(ops)
            execute $'syntax match hsOperator "{pattern}" conceal cchar={char}'
        endfor

        this.ApplyHighlights()
    enddef

    def ApplyHighlights()
        hi Conceal ctermbg=NONE guibg=NONE
        hi! link hsKeyword Statement
    enddef
endclass

var haskell_concealer = HaskellConcealer.new()

export def SetupHaskell()
    haskell_concealer.ApplySettings()
    haskell_concealer.SetupSyntax()
enddef

export class LuaConcealer
    public var conceallevel: number = 2
    public var concealcursor: string = 'nv'

    def new(level: number = 2, cursor: string = 'nv')
        this.conceallevel  = level
        this.concealcursor = cursor
    enddef

    def ApplySettings()
        &l:conceallevel  = this.conceallevel
        &l:concealcursor = this.concealcursor
    enddef

    def SetupSyntax()
        var keyword_maps = {'nil':      ['luaConstant',  '∅'],
                            'true':     ['luaConstant',  '⊤'],
                            'false':    ['luaConstant',  '⊥'],
                            'and':      ['luaOperator',  '∧'],
                            'or':       ['luaOperator',  '∨'],
                            'not':      ['luaOperator',  '¬'],
                            'function': ['luaStatement', 'ƒ']}

        for [kw, data] in items(keyword_maps)
            execute $'syntax keyword {data[0]} {kw} conceal cchar={data[1]}'
        endfor

        var ops = {'==': '≡',
                   '~=': '≠',
                   '<=': '≤',
                   '>=': '≥'}

        for [pattern, char] in items(ops)
            execute $'syntax match luaOperator "{pattern}" conceal cchar={char}'
        endfor

        syntax match luaOperator "\v<math\.pi>"                   conceal cchar=π
        syntax match luaOperator "\v<math\.huge>"                 conceal cchar=∞
        execute 'syntax match luaOperator /\v<math\.sqrt>\(/me=e-1 conceal cchar=√ containedin=ALL'

        this.ApplyHighlights()
    enddef

    def ApplyHighlights()
        hi Conceal ctermbg=NONE guibg=NONE
    enddef
endclass

var lua_concealer = LuaConcealer.new()

export def SetupLua()
    lua_concealer.ApplySettings()
    lua_concealer.SetupSyntax()
enddef

export class GoConcealer
    public var conceallevel: number = 2
    public var concealcursor: string = 'nv'

    def new(level: number = 2, cursor: string = 'nv')
        this.conceallevel  = level
        this.concealcursor = cursor
    enddef

    def ApplySettings()
        &l:conceallevel  = this.conceallevel
        &l:concealcursor = this.concealcursor
    enddef

    def SetupSyntax()
        var keyword_maps = {'nil':        ['goDeclaration', '∅'],
                            'true':       ['goDeclaration', '⊤'],
                            'false':      ['goDeclaration', '⊥'],
                            'int':        ['goType',        'ℤ'],
                            'int8':       ['goType',        'ℤ'],
                            'int16':      ['goType',        'ℤ'],
                            'int32':      ['goType',        'ℤ'],
                            'int64':      ['goType',        'ℤ'],
                            'float32':    ['goType',        'ℝ'],
                            'float64':    ['goType',        'ℝ'],
                            'bool':       ['goType',        '𝔹'],
                            'string':     ['goType',        '𝕊'],
                            'complex128': ['goType',        'ℂ']}

        for [kw, data] in items(keyword_maps)
            execute $'syntax keyword {data[0]} {kw} conceal cchar={data[1]}'
        endfor

        var ops = {'<-': '←',
                   '==': '≡',
                   '!=': '≠',
                   '<=': '≤',
                   '>=': '≥',
                   '&&': '∧',
                   '||': '∨',
                   '!':  '¬'}

        for [pattern, char] in items(ops)
            execute $'syntax match goOperator "{pattern}" conceal cchar={char}'
        endfor

        syntax match goOperator "\v<math\.Pi>"                    conceal cchar=π
        syntax match goOperator "\v<math\.Inf>"                   conceal cchar=∞
        execute 'syntax match goOperator /\v<math\.Sqrt>\(/me=e-1 conceal cchar=√ containedin=ALL'

        this.ApplyHighlights()
    enddef

    def ApplyHighlights()
        hi Conceal ctermbg=NONE guibg=NONE
    enddef
endclass

var go_concealer = GoConcealer.new()

export def SetupGo()
    go_concealer.ApplySettings()
    go_concealer.SetupSyntax()
enddef

export class JavaConcealer
    public var conceallevel: number = 2
    public var concealcursor: string = 'nv'

    def new(level: number = 2, cursor: string = 'nv')
        this.conceallevel  = level
        this.concealcursor = cursor
    enddef

    def ApplySettings()
        &l:conceallevel  = this.conceallevel
        &l:concealcursor = this.concealcursor
    enddef

    def SetupSyntax()
        var keyword_maps = {'void':       ['javaType',      '∅'],
                            'boolean':    ['javaType',      '𝔹'],
                            'int':        ['javaType',      'ℤ'],
                            'float':      ['javaType',      'ℝ'],
                            'double':     ['javaType',      '𝔻'],
                            'char':       ['javaType',      'ℂ'],
                            'true':       ['javaBoolean',   '⊤'],
                            'false':      ['javaBoolean',   '⊥'],
                            'null':       ['javaConstant',  'ø'],
                            'instanceof': ['javaOperator',  '∈']}

        for [kw, data] in items(keyword_maps)
            execute $'syntax keyword {data[0]} {kw} conceal cchar={data[1]}'
        endfor

        var ops = {'==': '≡',
                   '!=': '≠',
                   '<=': '≤',
                   '>=': '≥',
                   '&&': '∧',
                   '||': '∨',
                   '!':  '¬',
                   '->': '→'}

        for [pattern, char] in items(ops)
            execute $'syntax match javaOperator "{pattern}" conceal cchar={char}'
        endfor

        this.ApplyHighlights()
    enddef

    def ApplyHighlights()
        hi Conceal ctermbg=NONE guibg=NONE
    enddef
endclass

var java_concealer = JavaConcealer.new()

export def SetupJava()
    java_concealer.ApplySettings()
    java_concealer.SetupSyntax()
enddef

export class RustConcealer
    public var conceallevel: number = 2
    public var concealcursor: string = 'nv'

    def new(level: number = 2, cursor: string = 'nv')
        this.conceallevel  = level
        this.concealcursor = cursor
    enddef

    def ApplySettings()
        &l:conceallevel  = this.conceallevel
        &l:concealcursor = this.concealcursor
    enddef

    def SetupSyntax()
        var keyword_maps = {'bool':  ['rustType',    '𝔹'],
                            'i32':   ['rustType',    'ℤ'],
                            'i64':   ['rustType',    'ℤ'],
                            'f32':   ['rustType',    'ℝ'],
                            'f64':   ['rustType',    'ℝ'],
                            'char':  ['rustType',    'ℂ'],
                            'str':   ['rustType',    '𝕊'],
                            'true':  ['rustBoolean', '⊤'],
                            'false': ['rustBoolean', '⊥'],
                            'None':  ['rustEnum',    '∅']}

        for [kw, data] in items(keyword_maps)
            execute $'syntax keyword {data[0]} {kw} conceal cchar={data[1]}'
        endfor

        var ops = {'->': '→',
                   '=>': '⇒',
                   '::': '∷',
                   '==': '≡',
                   '!=': '≠',
                   '<=': '≤',
                   '>=': '≥',
                   '&&': '∧',
                   '||': '∨',
                   '!':  '¬',
                   '<<': '≪',
                   '>>': '≫'}

        for [pattern, char] in items(ops)
            execute $'syntax match rustOperator "{pattern}" conceal cchar={char}'
        endfor

        this.ApplyHighlights()
    enddef

    def ApplyHighlights()
        hi Conceal ctermbg=NONE guibg=NONE
    enddef
endclass

var rust_concealer = RustConcealer.new()

export def SetupRust()
    rust_concealer.ApplySettings()
    rust_concealer.SetupSyntax()
enddef

export class SqlConcealer
    public var conceallevel: number = 2
    public var concealcursor: string = 'nv'

    def new(level: number = 2, cursor: string = 'nv')
        this.conceallevel  = level
        this.concealcursor = cursor
    enddef

    def ApplySettings()
        &l:conceallevel  = this.conceallevel
        &l:concealcursor = this.concealcursor
    enddef

    def SetupSyntax()
        var keyword_maps = {'NULL':      ['sqlSpecial',   'ø'],
                            'NOT':       ['sqlOperator',  '¬'],
                            'AND':       ['sqlOperator',  '∧'],
                            'OR':        ['sqlOperator',  '∨'],
                            'IN':        ['sqlOperator',  '∈'],
                            'LIKE':      ['sqlOperator',  '≈'],
                            'UNION':     ['sqlOperator',  '∪'],
                            'INTERSECT': ['sqlOperator',  '∩'],
                            'EXCEPT':    ['sqlOperator',  '∖'],
                            'SUM':       ['sqlFunction',  'Σ'],
                            'AVG':       ['sqlFunction',  'μ'],
                            'MIN':       ['sqlFunction',  '⌊'],
                            'MAX':       ['sqlFunction',  '⌈']}

        for [kw, data] in items(keyword_maps)
            execute $'syntax keyword {data[0]} {kw} conceal cchar={data[1]}'
        endfor

        var ops = {'<>': '≠',
                   '!=': '≠',
                   '<=': '≤',
                   '>=': '≥'}

        for [pattern, char] in items(ops)
            execute $'syntax match sqlOperator "{pattern}" conceal cchar={char}'
        endfor

        this.ApplyHighlights()
    enddef

    def ApplyHighlights()
        hi Conceal ctermbg=NONE guibg=NONE
    enddef
endclass

var sql_concealer = SqlConcealer.new()

export def SetupSql()
    sql_concealer.ApplySettings()
    sql_concealer.SetupSyntax()
enddef
