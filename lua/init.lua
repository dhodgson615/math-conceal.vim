local M = {}

function M.setup()
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = 'nv'

    local commands = {
        'syntax keyword pythonLambda lambda conceal cchar=λ',
        'syntax keyword pythonBuiltin sum conceal cchar=Σ',
        'syntax keyword pythonOperator and conceal cchar=∧',
        'syntax keyword pythonOperator or conceal cchar=∨',
        'syntax keyword pythonOperator not conceal cchar=¬',
        'syntax keyword pythonRepeat for conceal cchar=∀',
        'syntax keyword pythonOperator in conceal cchar=∈',
        'syntax match pythonOperator "->" conceal cchar=→',
        'syntax match pythonOperator "==" conceal cchar=≡',
        'syntax match pythonOperator "!=" conceal cchar=≠',
        'syntax match pythonOperator "<=" conceal cchar=≤',
        'syntax match pythonOperator ">=" conceal cchar=≥',
    }

    for _, cmd in ipairs(commands) do
        vim.cmd(cmd)
    end
end

return M
