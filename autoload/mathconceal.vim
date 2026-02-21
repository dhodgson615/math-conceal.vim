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

    # Power & superscripts
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

    # Built-ins & libraries
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

    # int tuples
    syntax match mathTupInt2 "\vtuple\[int,\s*int\]" contains=mathTupBaseInt2,mathTupExp2
    syntax match mathTupBaseInt2 "\vtuple\[int,\s*int" contained conceal cchar=ℤ
    syntax match mathTupExp2 "\]" contained conceal cchar=²
    hi! link mathTupInt2 pythonBuiltin
    hi! link mathTupBaseInt2 pythonBuiltin
    hi! link mathTupExp2 pythonBuiltin
    syntax match mathTupInt3 "\vtuple\[int,\s*int,\s*int\]" contains=mathTupBaseInt3,mathTupExp3
    syntax match mathTupBaseInt3 "\vtuple\[int,\s*int,\s*int" contained conceal cchar=ℤ
    syntax match mathTupExp3 "\]" contained conceal cchar=³
    hi! link mathTupInt3 pythonBuiltin
    hi! link mathTupBaseInt3 pythonBuiltin
    hi! link mathTupExp3 pythonBuiltin
    syntax match mathTupInt4 "\vtuple\[int,\s*int,\s*int,\s*int\]" contains=mathTupBaseInt4,mathTupExp4
    syntax match mathTupBaseInt4 "\vtuple\[int,\s*int,\s*int,\s*int" contained conceal cchar=ℤ
    syntax match mathTupExp4 "\]" contained conceal cchar=⁴
    hi! link mathTupInt4 pythonBuiltin
    hi! link mathTupBaseInt4 pythonBuiltin
    hi! link mathTupExp4 pythonBuiltin
    syntax match mathTupInt5 "\vtuple\[int,\s*int,\s*int,\s*int,\s*int\]" contains=mathTupBaseInt5,mathTupExp5
    syntax match mathTupBaseInt5 "\vtuple\[int,\s*int,\s*int,\s*int,\s*int" contained conceal cchar=ℤ
    syntax match mathTupExp5 "\]" contained conceal cchar=⁵
    hi! link mathTupInt5 pythonBuiltin
    hi! link mathTupBaseInt5 pythonBuiltin
    hi! link mathTupExp5 pythonBuiltin
    syntax match mathTupInt6 "\vtuple\[int,\s*int,\s*int,\s*int,\s*int,\s*int\]" contains=mathTupBaseInt6,mathTupExp6
    syntax match mathTupBaseInt6 "\vtuple\[int,\s*int,\s*int,\s*int,\s*int,\s*int" contained conceal cchar=ℤ
    syntax match mathTupExp6 "\]" contained conceal cchar=⁶
    hi! link mathTupInt6 pythonBuiltin
    hi! link mathTupBaseInt6 pythonBuiltin
    hi! link mathTupExp6 pythonBuiltin
    syntax match mathTupInt7 "\vtuple\[int,\s*int,\s*int,\s*int,\s*int,\s*int,\s*int\]" contains=mathTupBaseInt7,mathTupExp7
    syntax match mathTupBaseInt7 "\vtuple\[int,\s*int,\s*int,\s*int,\s*int,\s*int,\s*int" contained conceal cchar=ℤ
    syntax match mathTupExp7 "\]" contained conceal cchar=⁷
    hi! link mathTupInt7 pythonBuiltin
    hi! link mathTupBaseInt7 pythonBuiltin
    hi! link mathTupExp7 pythonBuiltin
    syntax match mathTupInt8 "\vtuple\[int,\s*int,\s*int,\s*int,\s*int,\s*int,\s*int,\s*int\]" contains=mathTupBaseInt8,mathTupExp8
    syntax match mathTupBaseInt8 "\vtuple\[int,\s*int,\s*int,\s*int,\s*int,\s*int,\s*int,\s*int" contained conceal cchar=ℤ
    syntax match mathTupExp8 "\]" contained conceal cchar=⁸
    hi! link mathTupInt8 pythonBuiltin
    hi! link mathTupBaseInt8 pythonBuiltin
    hi! link mathTupExp8 pythonBuiltin
    syntax match mathTupInt9 "\vtuple\[int,\s*int,\s*int,\s*int,\s*int,\s*int,\s*int,\s*int,\s*int\]" contains=mathTupBaseInt9,mathTupExp9
    syntax match mathTupBaseInt9 "\vtuple\[int,\s*int,\s*int,\s*int,\s*int,\s*int,\s*int,\s*int,\s*int" contained conceal cchar=ℤ
    syntax match mathTupExp9 "\]" contained conceal cchar=⁹
    hi! link mathTupInt9 pythonBuiltin
    hi! link mathTupBaseInt9 pythonBuiltin
    hi! link mathTupExp9 pythonBuiltin

    # float tuples
    syntax match mathTupFloat2 "\vtuple\[float,\s*float\]" contains=mathTupBaseFloat2,mathTupExp2
    syntax match mathTupBaseFloat2 "\vtuple\[float,\s*float" contained conceal cchar=ℝ
    syntax match mathTupExp2 "\]" contained conceal cchar=²
    hi! link mathTupFloat2 pythonBuiltin
    hi! link mathTupBaseFloat2 pythonBuiltin
    hi! link mathTupExp2 pythonBuiltin
    syntax match mathTupFloat3 "\vtuple\[float,\s*float,\s*float\]" contains=mathTupBaseFloat3,mathTupExp3
    syntax match mathTupBaseFloat3 "\vtuple\[float,\s*float,\s*float" contained conceal cchar=ℝ
    syntax match mathTupExp3 "\]" contained conceal cchar=³
    hi! link mathTupFloat3 pythonBuiltin
    hi! link mathTupBaseFloat3 pythonBuiltin
    hi! link mathTupExp3 pythonBuiltin
    syntax match mathTupFloat4 "\vtuple\[float,\s*float,\s*float,\s*float\]" contains=mathTupBaseFloat4,mathTupExp4
    syntax match mathTupBaseFloat4 "\vtuple\[float,\s*float,\s*float,\s*float" contained conceal cchar=ℝ
    syntax match mathTupExp4 "\]" contained conceal cchar=⁴
    hi! link mathTupFloat4 pythonBuiltin
    hi! link mathTupBaseFloat4 pythonBuiltin
    hi! link mathTupExp4 pythonBuiltin
    syntax match mathTupFloat5 "\vtuple\[float,\s*float,\s*float,\s*float,\s*float\]" contains=mathTupBaseFloat5,mathTupExp5
    syntax match mathTupBaseFloat5 "\vtuple\[float,\s*float,\s*float,\s*float,\s*float" contained conceal cchar=ℝ
    syntax match mathTupExp5 "\]" contained conceal cchar=⁵
    hi! link mathTupFloat5 pythonBuiltin
    hi! link mathTupBaseFloat5 pythonBuiltin
    hi! link mathTupExp5 pythonBuiltin
    syntax match mathTupFloat6 "\vtuple\[float,\s*float,\s*float,\s*float,\s*float,\s*float\]" contains=mathTupBaseFloat6,mathTupExp6
    syntax match mathTupBaseFloat6 "\vtuple\[float,\s*float,\s*float,\s*float,\s*float,\s*float" contained conceal cchar=ℝ
    syntax match mathTupExp6 "\]" contained conceal cchar=⁶
    hi! link mathTupFloat6 pythonBuiltin
    hi! link mathTupBaseFloat6 pythonBuiltin
    hi! link mathTupExp6 pythonBuiltin
    syntax match mathTupFloat7 "\vtuple\[float,\s*float,\s*float,\s*float,\s*float,\s*float,\s*float\]" contains=mathTupBaseFloat7,mathTupExp7
    syntax match mathTupBaseFloat7 "\vtuple\[float,\s*float,\s*float,\s*float,\s*float,\s*float,\s*float" contained conceal cchar=ℝ
    syntax match mathTupExp7 "\]" contained conceal cchar=⁷
    hi! link mathTupFloat7 pythonBuiltin
    hi! link mathTupBaseFloat7 pythonBuiltin
    hi! link mathTupExp7 pythonBuiltin
    syntax match mathTupFloat8 "\vtuple\[float,\s*float,\s*float,\s*float,\s*float,\s*float,\s*float,\s*float\]" contains=mathTupBaseFloat8,mathTupExp8
    syntax match mathTupBaseFloat8 "\vtuple\[float,\s*float,\s*float,\s*float,\s*float,\s*float,\s*float,\s*float" contained conceal cchar=ℝ
    syntax match mathTupExp8 "\]" contained conceal cchar=⁸
    hi! link mathTupFloat8 pythonBuiltin
    hi! link mathTupBaseFloat8 pythonBuiltin
    hi! link mathTupExp8 pythonBuiltin
    syntax match mathTupFloat9 "\vtuple\[float,\s*float,\s*float,\s*float,\s*float,\s*float,\s*float,\s*float,\s*float\]" contains=mathTupBaseFloat9,mathTupExp9
    syntax match mathTupBaseFloat9 "\vtuple\[float,\s*float,\s*float,\s*float,\s*float,\s*float,\s*float,\s*float,\s*float" contained conceal cchar=ℝ
    syntax match mathTupExp9 "\]" contained conceal cchar=⁹
    hi! link mathTupFloat9 pythonBuiltin
    hi! link mathTupBaseFloat9 pythonBuiltin
    hi! link mathTupExp9 pythonBuiltin

    # bool tuples
    syntax match mathTupBool2 "\vtuple\[bool,\s*bool\]" contains=mathTupBaseBool2,mathTupExp2
    syntax match mathTupBaseBool2 "\vtuple\[bool,\s*bool" contained conceal cchar=𝔹
    syntax match mathTupExp2 "\]" contained conceal cchar=²
    hi! link mathTupBool2 pythonBuiltin
    hi! link mathTupBaseBool2 pythonBuiltin
    hi! link mathTupExp2 pythonBuiltin
    syntax match mathTupBool3 "\vtuple\[bool,\s*bool,\s*bool\]" contains=mathTupBaseBool3,mathTupExp3
    syntax match mathTupBaseBool3 "\vtuple\[bool,\s*bool,\s*bool" contained conceal cchar=𝔹
    syntax match mathTupExp3 "\]" contained conceal cchar=³
    hi! link mathTupBool3 pythonBuiltin
    hi! link mathTupBaseBool3 pythonBuiltin
    hi! link mathTupExp3 pythonBuiltin
    syntax match mathTupBool4 "\vtuple\[bool,\s*bool,\s*bool,\s*bool\]" contains=mathTupBaseBool4,mathTupExp4
    syntax match mathTupBaseBool4 "\vtuple\[bool,\s*bool,\s*bool,\s*bool" contained conceal cchar=𝔹
    syntax match mathTupExp4 "\]" contained conceal cchar=⁴
    hi! link mathTupBool4 pythonBuiltin
    hi! link mathTupBaseBool4 pythonBuiltin
    hi! link mathTupExp4 pythonBuiltin
    syntax match mathTupBool5 "\vtuple\[bool,\s*bool,\s*bool,\s*bool,\s*bool\]" contains=mathTupBaseBool5,mathTupExp5
    syntax match mathTupBaseBool5 "\vtuple\[bool,\s*bool,\s*bool,\s*bool,\s*bool" contained conceal cchar=𝔹
    syntax match mathTupExp5 "\]" contained conceal cchar=⁵
    hi! link mathTupBool5 pythonBuiltin
    hi! link mathTupBaseBool5 pythonBuiltin
    hi! link mathTupExp5 pythonBuiltin
    syntax match mathTupBool6 "\vtuple\[bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool\]" contains=mathTupBaseBool6,mathTupExp6
    syntax match mathTupBaseBool6 "\vtuple\[bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool" contained conceal cchar=𝔹
    syntax match mathTupExp6 "\]" contained conceal cchar=⁶
    hi! link mathTupBool6 pythonBuiltin
    hi! link mathTupBaseBool6 pythonBuiltin
    hi! link mathTupExp6 pythonBuiltin
    syntax match mathTupBool7 "\vtuple\[bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool\]" contains=mathTupBaseBool7,mathTupExp7
    syntax match mathTupBaseBool7 "\vtuple\[bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool" contained conceal cchar=𝔹
    syntax match mathTupExp7 "\]" contained conceal cchar=⁷
    hi! link mathTupBool7 pythonBuiltin
    hi! link mathTupBaseBool7 pythonBuiltin
    hi! link mathTupExp7 pythonBuiltin
    syntax match mathTupBool8 "\vtuple\[bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool\]" contains=mathTupBaseBool8,mathTupExp8
    syntax match mathTupBaseBool8 "\vtuple\[bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool" contained conceal cchar=𝔹
    syntax match mathTupExp8 "\]" contained conceal cchar=⁸
    hi! link mathTupBool8 pythonBuiltin
    hi! link mathTupBaseBool8 pythonBuiltin
    hi! link mathTupExp8 pythonBuiltin
    syntax match mathTupBool9 "\vtuple\[bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool\]" contains=mathTupBaseBool9,mathTupExp9
    syntax match mathTupBaseBool9 "\vtuple\[bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool,\s*bool" contained conceal cchar=𝔹
    syntax match mathTupExp9 "\]" contained conceal cchar=⁹
    hi! link mathTupBool9 pythonBuiltin
    hi! link mathTupBaseBool9 pythonBuiltin
    hi! link mathTupExp9 pythonBuiltin

    # complex tuples
    syntax match mathTupComplex2 "\vtuple\[complex,\s*complex\]" contains=mathTupBaseComplex2,mathTupExp2
    syntax match mathTupBaseComplex2 "\vtuple\[complex,\s*complex" contained conceal cchar=ℂ
    syntax match mathTupExp2 "\]" contained conceal cchar=²
    hi! link mathTupComplex2 pythonBuiltin
    hi! link mathTupBaseComplex2 pythonBuiltin
    hi! link mathTupExp2 pythonBuiltin
    syntax match mathTupComplex3 "\vtuple\[complex,\s*complex,\s*complex\]" contains=mathTupBaseComplex3,mathTupExp3
    syntax match mathTupBaseComplex3 "\vtuple\[complex,\s*complex,\s*complex" contained conceal cchar=ℂ
    syntax match mathTupExp3 "\]" contained conceal cchar=³
    hi! link mathTupComplex3 pythonBuiltin
    hi! link mathTupBaseComplex3 pythonBuiltin
    hi! link mathTupExp3 pythonBuiltin
    syntax match mathTupComplex4 "\vtuple\[complex,\s*complex,\s*complex,\s*complex\]" contains=mathTupBaseComplex4,mathTupExp4
    syntax match mathTupBaseComplex4 "\vtuple\[complex,\s*complex,\s*complex,\s*complex" contained conceal cchar=ℂ
    syntax match mathTupExp4 "\]" contained conceal cchar=⁴
    hi! link mathTupComplex4 pythonBuiltin
    hi! link mathTupBaseComplex4 pythonBuiltin
    hi! link mathTupExp4 pythonBuiltin
    syntax match mathTupComplex5 "\vtuple\[complex,\s*complex,\s*complex,\s*complex,\s*complex\]" contains=mathTupBaseComplex5,mathTupExp5
    syntax match mathTupBaseComplex5 "\vtuple\[complex,\s*complex,\s*complex,\s*complex,\s*complex" contained conceal cchar=ℂ
    syntax match mathTupExp5 "\]" contained conceal cchar=⁵
    hi! link mathTupComplex5 pythonBuiltin
    hi! link mathTupBaseComplex5 pythonBuiltin
    hi! link mathTupExp5 pythonBuiltin
    syntax match mathTupComplex6 "\vtuple\[complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex\]" contains=mathTupBaseComplex6,mathTupExp6
    syntax match mathTupBaseComplex6 "\vtuple\[complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex" contained conceal cchar=ℂ
    syntax match mathTupExp6 "\]" contained conceal cchar=⁶
    hi! link mathTupComplex6 pythonBuiltin
    hi! link mathTupBaseComplex6 pythonBuiltin
    hi! link mathTupExp6 pythonBuiltin
    syntax match mathTupComplex7 "\vtuple\[complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex\]" contains=mathTupBaseComplex7,mathTupExp7
    syntax match mathTupBaseComplex7 "\vtuple\[complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex" contained conceal cchar=ℂ
    syntax match mathTupExp7 "\]" contained conceal cchar=⁷
    hi! link mathTupComplex7 pythonBuiltin
    hi! link mathTupBaseComplex7 pythonBuiltin
    hi! link mathTupExp7 pythonBuiltin
    syntax match mathTupComplex8 "\vtuple\[complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex\]" contains=mathTupBaseComplex8,mathTupExp8
    syntax match mathTupBaseComplex8 "\vtuple\[complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex" contained conceal cchar=ℂ
    syntax match mathTupExp8 "\]" contained conceal cchar=⁸
    hi! link mathTupComplex8 pythonBuiltin
    hi! link mathTupBaseComplex8 pythonBuiltin
    hi! link mathTupExp8 pythonBuiltin
    syntax match mathTupComplex9 "\vtuple\[complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex\]" contains=mathTupBaseComplex9,mathTupExp9
    syntax match mathTupBaseComplex9 "\vtuple\[complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex,\s*complex" contained conceal cchar=ℂ
    syntax match mathTupExp9 "\]" contained conceal cchar=⁹
    hi! link mathTupComplex9 pythonBuiltin
    hi! link mathTupBaseComplex9 pythonBuiltin
    hi! link mathTupExp9 pythonBuiltin

    # Highlight linking
    hi! link pythonLambda Keyword
    hi! link pythonBuiltin Function
    hi! link pythonOperator Operator
    hi! link mathNotIn Operator
    hi! link mathIsNot Operator
    hi! link mathEmptySet Constant

enddef
