vim9script

export def Setup()
    setlocal conceallevel=2
    setlocal concealcursor=nv

    # 1. Matches (Multi-character or Multi-word)
    syntax match mathNotIn "\<not in\>" conceal cchar=∉
    syntax match mathIsNot "\<is not\>" conceal cchar=≢
    syntax match mathEmptySet "{}" conceal cchar=∅

    syntax match pythonOperator "->" conceal cchar=→
    syntax match pythonOperator "==" conceal cchar=≡
    syntax match pythonOperator "!=" conceal cchar=≠
    syntax match pythonOperator "<=" conceal cchar=≤
    syntax match pythonOperator ">=" conceal cchar=≥

    # Much Less/Greater Than
    syntax match pythonOperator "<<" conceal cchar=≪
    syntax match pythonOperator ">>" conceal cchar=≫

    # 2. Superscripts (Single digits only)
    syntax match pythonOperator "\v\*\* ?0($|[^\d])@=" conceal cchar=⁰
    syntax match pythonOperator "\v\*\* ?1($|[^\d])@=" conceal cchar=¹
    syntax match pythonOperator "\v\*\* ?2($|[^\d])@=" conceal cchar=²
    syntax match pythonOperator "\v\*\* ?3($|[^\d])@=" conceal cchar=³
    syntax match pythonOperator "\v\*\* ?4($|[^\d])@=" conceal cchar=⁴
    syntax match pythonOperator "\v\*\* ?5($|[^\d])@=" conceal cchar=⁵
    syntax match pythonOperator "\v\*\* ?6($|[^\d])@=" conceal cchar=⁶
    syntax match pythonOperator "\v\*\* ?7($|[^\d])@=" conceal cchar=⁷
    syntax match pythonOperator "\v\*\* ?8($|[^\d])@=" conceal cchar=⁸
    syntax match pythonOperator "\v\*\* ?9($|[^\d])@=" conceal cchar=⁹

    syntax match pythonOperator "\*\*" conceal cchar=^

    # 3. NumPy / SciPy Specific Math (Handled with Word Boundaries)
    # .T or transpose() -> ᵀ
    syntax match pythonBuiltin "\v\.T|transpose\(\)@=" conceal cchar=ᵀ
    # dot() -> ⋅
    syntax match pythonBuiltin "\v<(np\.|numpy\.)?dot>" conceal cchar=⋅
    # gradient() or nabla -> ∇
    syntax match pythonBuiltin "\v<(np\.|numpy\.)?gradient>" conceal cchar=∇
    # prod() -> ∏
    syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?prod(uct)?>" conceal cchar=∏

    # 4. Constants and Prefixes
    syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?pi>" conceal cchar=π
    syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?inf>" conceal cchar=∞
    syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?sqrt>" conceal cchar=√
    syntax match pythonBuiltin "\v<(math\.|np\.|numpy\.)?exp>" conceal cchar=ℯ

    # 5. Keywords
    syntax keyword pythonLambda lambda conceal cchar=λ
    syntax keyword pythonOperator and conceal cchar=∧
    syntax keyword pythonOperator or conceal cchar=∨
    syntax keyword pythonOperator not conceal cchar=¬
    syntax keyword pythonBuiltin all conceal cchar=∀
    syntax keyword pythonBuiltin any conceal cchar=∃

    # Types (Sets)
    syntax keyword pythonBuiltin int conceal cchar=ℤ
    syntax keyword pythonBuiltin float conceal cchar=ℝ
    syntax keyword pythonBuiltin bool conceal cchar=𝔹
    syntax keyword pythonBuiltin complex conceal cchar=ℂ
    syntax keyword pythonBuiltin set conceal cchar=𝕊
    # syntax keyword pythonBuiltin list conceal cchar=𝑳
    # syntax keyword pythonBuiltin dict conceal cchar=𝑫

    # Logic & Sets
    syntax keyword pythonOperator in conceal cchar=∈
    syntax keyword pythonOperator is conceal cchar=≐
    syntax keyword pythonBuiltin sum conceal cchar=Σ
    syntax keyword pythonBuiltin round conceal cchar=≈

    # 6. Highlight Linking
    hi! link pythonLambda Keyword
    hi! link pythonBuiltin Function
    hi! link pythonOperator Operator
    hi! link mathNotIn Operator
    hi! link mathIsNot Operator
    hi! link mathEmptySet Constant

    # 7. Specific Tuple Mappings
    # Define the "container" match for the whole phrase
    syntax match mathTupleIntSq "\vtuple\[int, ?int\]" contains=mathTupIntBase,mathTupIntExp

    # Define the components that only exist INSIDE that container
    syntax match mathTupIntBase "\vtuple\[int, ?int" contained conceal cchar=ℤ
    syntax match mathTupIntExp "\]" contained conceal cchar=²

    # Highlighting
    hi! link mathTupIntBase pythonBuiltin
    hi! link mathTupIntExp pythonBuiltin





enddef
