vim9script

export class PythonConcealer
    public var conceallevel: number = 2
    public var concealcursor: string = 'nv'

    static var type_map: dict<list<string>> = {
        'int':     ['Int',     'ℤ'],
        'float':   ['Float',   'ℝ'],
        'bool':    ['Bool',    '𝔹'],
        'complex': ['Complex', 'ℂ']
    }

    def new(level: number = 2, cursor: string = 'nv')
        this.conceallevel = level
        this.concealcursor = cursor
    enddef

    def ApplySettings()
        &l:conceallevel = this.conceallevel
        &l:concealcursor = this.concealcursor
    enddef

    def SetupSyntax()
        # Operators & Constants
        syntax match mathNotIn "\<not in\>" conceal cchar=∉
        syntax match mathIsNot "\<is not\>" conceal cchar=≢
        syntax match mathEmptySet "{}"      conceal cchar=∅

        var simple_ops = {
            '->': '→', '==': '≡', '!=': '≠', '<=': '≤',
            '>=': '≥', '<<': '≪', '>>': '≫'
        }

        for [pattern, char] in items(simple_ops)
            execute $'syntax match pythonOperator "{pattern}" conceal cchar={char}'
        endfor

        # Power & Superscripts (0-9 and fallback ^)
        var superscripts = ['⁰', '¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹']

        for i in range(10)
            execute $'syntax match pythonOperator "\v\*\* ?{i}($|[^\d])@=" conceal cchar={superscripts[i]}'
        endfor

        syntax match pythonOperator "\*\*" conceal cchar=^

        # Built-ins & Libraries
        syntax match pythonBuiltin "\v\.T|transpose\(\)@="                 conceal cchar=ᵀ
        syntax match pythonBuiltin "\v<(np\.|numpy\.)?dot>"                conceal cchar=⋅
        syntax match pythonBuiltin "\v<(np\.|numpy\.)?gradient>"           conceal cchar=∇
        syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?prod(uct)?>"  conceal cchar=∏
        syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?pi>"          conceal cchar=π
        syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?inf>"         conceal cchar=∞
        syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?sqrt>"        conceal cchar=√
        syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?exp>"         conceal cchar=ℯ

        # Keywords & Logic
        var keyword_maps = {
            'lambda':  ['pythonLambda',  'λ'],
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
            'set':     ['pythonBuiltin',  '𝕊']
        }

        for [kw, data] in items(keyword_maps)
            execute $'syntax keyword {data[0]} {kw} conceal cchar={data[1]}'
        endfor

        syntax match pythonListType "\<list\[" conceal cchar=[

        this.GenerateTupleSyntax(superscripts)
        this.ApplyHighlights()
        this.SyncSyntax()
    enddef

    def GenerateTupleSyntax(superscripts: list<string>)
        for i in range(2, 9)
            execute $'syntax match mathTupExp{i} "\]" contained conceal cchar={superscripts[i]}'
            execute $'hi! link mathTupExp{i} pythonBuiltin'

            for [type_kw, type_data] in items(type_map)
                var camel_name = type_data[0]
                var symbol = type_data[1]
                var base_pattern = $'\vtuple\[{type_kw}' .. repeat($',\s*{type_kw}', i - 1)
                var group_name = $'mathTup{camel_name}{i}'
                var base_group = $'mathTupBase{camel_name}{i}'

                execute $'syntax match {group_name} "{base_pattern}\]" contains={base_group},mathTupExp{i}'
                execute $'syntax match {base_group} "{base_pattern}" contained conceal cchar={symbol}'
                execute $'hi! link {group_name} pythonBuiltin'
                execute $'hi! link {base_group} pythonBuiltin'
            endfor
        endfor
    enddef

    def ApplyHighlights()
        hi! link pythonLambda Keyword
        hi! link pythonBuiltin Function
        hi! link pythonOperator Operator
        hi! link pythonListType pythonBuiltin
        hi! link mathNotIn Operator
        hi! link mathIsNot Operator
        hi! link mathEmptySet Constant
    enddef

    def SyncSyntax()
        # Dynamically sync syntax highlighting lines to optimize editor performance
        var dynamic_minlines = winheight(0) * 2
        execute $'syntax sync minlines={dynamic_minlines}'
    enddef
endclass

var python_concealer = PythonConcealer.new()

export def Setup()
    python_concealer.ApplySettings()
    python_concealer.SetupSyntax()
enddef

autocmd VimResized * python_concealer.SyncSyntax()
