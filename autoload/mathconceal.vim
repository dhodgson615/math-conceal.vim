vim9script

export def Setup()
    setlocal conceallevel=2
    setlocal concealcursor=nv

    # Basic operators & constants
    syntax match mathNotIn "\<not in\>" conceal cchar=∉
    syntax match mathIsNot "\<is not\>" conceal cchar=≢
    syntax match mathEmptySet "{}" conceal cchar=∅

    syntax match pythonOperator "->" conceal cchar=→
    syntax match pythonOperator "==" conceal cchar=≡
    syntax match pythonOperator "!=" conceal cchar=≠
    syntax match pythonOperator "<=" conceal cchar=≤
    syntax match pythonOperator ">=" conceal cchar=≥
    syntax match pythonOperator "<<" conceal cchar=≪
    syntax match pythonOperator ">>" conceal cchar=≫

    # Power & superscripts (standard ** syntax)
    var supers = ['⁰', '¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹']
    for i in range(10)
        execute $'syntax match pythonOperator "\v\*\* ?{i}($|[^\d])@=" conceal cchar={supers[i]}'
    endfor
    syntax match pythonOperator "\*\*" conceal cchar=^

    # Built-ins & libraries (numpy/math)
    syntax match pythonBuiltin "\v\.T|transpose\(\)@=" conceal cchar=ᵀ
    syntax match pythonBuiltin "\v<(np\.|numpy\.)?dot>" conceal cchar=⋅
    syntax match pythonBuiltin "\v<(np\.|numpy\.)?gradient>" conceal cchar=∇
    syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?prod(uct)?>" conceal cchar=∏
    syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?pi>" conceal cchar=π
    syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?inf>" conceal cchar=∞
    syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?sqrt>" conceal cchar=√
    syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?exp>" conceal cchar=ℯ

    # Keywords & logic
    syntax keyword pythonLambda lambda conceal cchar=λ
    syntax keyword pythonOperator and conceal cchar=∧
    syntax keyword pythonOperator or conceal cchar=∨
    syntax keyword pythonOperator not conceal cchar=¬
    syntax keyword pythonBuiltin all conceal cchar=∀
    syntax keyword pythonBuiltin any conceal cchar=∃
    syntax keyword pythonOperator in conceal cchar=∈
    syntax keyword pythonOperator is conceal cchar=≐
    syntax keyword pythonBuiltin sum conceal cchar=Σ
    syntax keyword pythonBuiltin round conceal cchar=≈

    # Types & set notation
    syntax keyword pythonBuiltin int conceal cchar=ℤ
    syntax keyword pythonBuiltin float conceal cchar=ℝ
    syntax keyword pythonBuiltin bool conceal cchar=𝔹
    syntax keyword pythonBuiltin complex conceal cchar=ℂ
    syntax keyword pythonBuiltin set conceal cchar=𝕊
    # syntax keyword pythonBuiltin list conceal cchar=𝑳
    # syntax keyword pythonBuiltin dict conceal cchar=𝑫

    # Tuple overrides (e.g., tuple[int, int] -> ℤ²)
    var types = {
        'int': 'ℤ',
        'float': 'ℝ',
        'bool': '𝔹',
        'complex': 'ℂ'
    }

    for [t_name, t_char] in items(types)
        for n in range(2, 10)
            # Create a comma-separated string of the type: "int, ?int, ?int"
            var pattern = t_name .. (range(n - 1)->mapnew((_, _) => $', ?{t_name}')->join(''))
            var grpName = $'mathTup{t_name}{n}'
            var baseName = $'mathTupBase{t_name}{n}'
            var expName = $'mathTupExp{n}'

            execute $'syntax match {grpName} "\vtuple\[{pattern}\]" contains={baseName},{expName}'
            execute $'syntax match {baseName} "\vtuple\[{pattern}" contained conceal cchar={t_char}'
            execute $'syntax match {expName} "\]" contained conceal cchar={supers[n]}'

            execute $'hi! link {grpName} pythonBuiltin'
            execute $'hi! link {baseName} pythonBuiltin'
            execute $'hi! link {expName} pythonBuiltin'
        endfor
    endfor

    # Highlight linking
    hi! link pythonLambda Keyword
    hi! link pythonBuiltin Function
    hi! link pythonOperator Operator
    hi! link mathNotIn Operator
    hi! link mathIsNot Operator
    hi! link mathEmptySet Constant

enddef
