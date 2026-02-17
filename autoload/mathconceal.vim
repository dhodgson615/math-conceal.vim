vim9script

export def Setup()
    setlocal conceallevel=2
    setlocal concealcursor=nv

    # 1. Matches
    syntax match mathNotIn "not in" conceal cchar=∉
    syntax match pythonOperator "->" conceal cchar=→
    syntax match pythonOperator "==" conceal cchar=≡
    syntax match pythonOperator "!=" conceal cchar=≠
    syntax match pythonOperator "<=" conceal cchar=≤
    syntax match pythonOperator ">=" conceal cchar=≥

    # Keywords
    syntax keyword pythonLambda lambda conceal cchar=λ
    syntax keyword pythonBuiltin sum conceal cchar=Σ
    syntax keyword pythonOperator and conceal cchar=∧
    syntax keyword pythonOperator or conceal cchar=∨
    syntax keyword pythonOperator not conceal cchar=¬
    syntax keyword pythonOperator in conceal cchar=∈

    # 3. Highlight Linking
    hi! link pythonLambda Keyword
    hi! link pythonBuiltin Function
    hi! link pythonOperator Operator
    hi! link mathNotIn Operator
enddef
