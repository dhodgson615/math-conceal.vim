vim9script

export def Setup()
    setlocal conceallevel=2
    setlocal concealcursor=nv

    # Keywords
    syntax keyword pythonLambda lambda conceal cchar=λ
    syntax keyword pythonBuiltin sum conceal cchar=Σ
    syntax keyword pythonOperator and conceal cchar=∧
    syntax keyword pythonOperator or conceal cchar=∨
    syntax keyword pythonOperator not conceal cchar=¬
    syntax keyword pythonRepeat for conceal cchar=∀
    syntax keyword pythonOperator in conceal cchar=∈

    # Matches (Punctuation/Patterns)
    syntax match pythonOperator "->" conceal cchar=→
    syntax match pythonOperator "==" conceal cchar=≡
    syntax match pythonOperator "!=" conceal cchar=≠
    syntax match pythonOperator "<=" conceal cchar=≤
    syntax match pythonOperator ">=" conceal cchar=≥
enddef
