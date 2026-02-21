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
        # --- 1. Keywords (Standard performance, keeps colors) ---
        var keyword_maps = {
            'lambda': ['pythonLambda',   'λ'],
            'and':    ['pythonOperator', '∧'],
            'or':     ['pythonOperator', '∨'],
            'not':    ['pythonOperator', '¬'],
            'in':     ['pythonOperator', '∈'],
            'is':     ['pythonOperator', '≐'],
            'all':    ['pythonBuiltin',  '∀'],
            'any':    ['pythonBuiltin',  '∃'],
            'sum':    ['pythonBuiltin',  'Σ'],
            'round':  ['pythonBuiltin',  '≈'],
            'int':    ['pythonBuiltin',  'ℤ'],
            'float':  ['pythonBuiltin',  'ℝ'],
            'bool':   ['pythonBuiltin',  '𝔹'],
            'complex': ['pythonBuiltin',  'ℂ'],
            'set':    ['pythonBuiltin',  '𝕊']
        }
        for [kw, data] in items(keyword_maps)
            execute $'syntax keyword {data[0]} {kw} conceal cchar={data[1]}'
        endfor

        # --- 2. The Fix for "not in" / "is not" ---
        # Defining these as matches with 'containedin=ALL' allows them to 
        # override the individual keywords above.
        syntax match mathNotIn "\<not in\>" conceal cchar=∉ containedin=ALL
        syntax match mathIsNot "\<is not\>" conceal cchar=≢ containedin=ALL
        syntax match mathEmptySet "{}"      conceal cchar=∅

        # --- 3. Operators & Constants ---
        var simple_ops = {
            '->': '→', '==': '≡', '!=': '≠', '<=': '≤',
            '>=': '≥', '<<': '≪', '>>': '≫'
        }
        for [pattern, char] in items(simple_ops)
            execute $'syntax match pythonOperator "{pattern}" conceal cchar={char}'
        endfor

        # --- 4. Power & Superscripts ---
        var superscripts = ['⁰', '¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹']
        for i in range(10)
            execute $'syntax match pythonOperator "\v\*\* ?{i}($|[^\d])@=" conceal cchar={superscripts[i]}'
        endfor
        syntax match pythonOperator "\*\*" conceal cchar=^

        # --- 5. Built-ins & Libraries ---
        syntax match pythonBuiltin "\v\.T|transpose\(\)@="                 conceal cchar=ᵀ
        syntax match pythonBuiltin "\v<(np\.|numpy\.)?dot>"                conceal cchar=⋅
        syntax match pythonBuiltin "\v<(np\.|numpy\.)?gradient>"           conceal cchar=∇
        syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?prod(uct)?>" conceal cchar=∏
        syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?pi>"          conceal cchar=π
        syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?inf>"         conceal cchar=∞
        syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?sqrt>"        conceal cchar=√
        syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?exp>"         conceal cchar=ℯ
        syntax match pythonListType "\<list\["                             conceal cchar=[

        # --- 6. Dynamic Tuples ---
        this.GenerateTupleSyntax(superscripts)

        # --- 7. Final Polish ---
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

export def Setup()
    python_concealer.ApplySettings()
    python_concealer.SetupSyntax()
enddef

autocmd VimResized * python_concealer.SyncSyntax()
