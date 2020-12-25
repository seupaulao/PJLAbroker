--ID;PRECO;QTE;TIMESTAMP;COMPRADOR;VENDEDOR;OPERACAO[1-compra;2-venda;3-direto;4-leilão]
function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

function lines_from(file)
    if not file_exists(file) then return {} end
    lines = {}
    for line in io.lines(file) do
      lines[#lines + 1] = line
    end
    return lines
end

function separarDados(linhas)
    local dados={}
    for i=1,#linhas do 
        local lin = linhas[i]
        local t = {}
        if lin ~= nil then
            t.id=string.sub(lin,1,string.find(lin,";")-1)
            lin=string.sub(lin,string.find(lin,";")+1)
            t.preco=string.sub(lin,1,string.find(lin,";")-1)
            lin=string.sub(lin,string.find(lin,";")+1)
            t.quantidade=string.sub(lin,1,string.find(lin,";")-1)
            lin=string.sub(lin,string.find(lin,";")+1)
            t.timestamp=string.sub(lin,1,string.find(lin,";")-1)
            lin=string.sub(lin,string.find(lin,";")+1)
            t.comprador=string.sub(lin,1,string.find(lin,";")-1)
            lin=string.sub(lin,string.find(lin,";")+1)
            t.vendedor=string.sub(lin,1,string.find(lin,";")-1)
            lin=string.sub(lin,string.find(lin,";")+1)
            t.operacao=lin
            dados[#dados+1]=t
        end
    end
    return dados
end

local linhas = lines_from(arg[1])
local dados = separarDados(linhas)
for i,dado in ipairs(dados) do
    local ope = 'leilão'
    if tonumber(dado.operacao)==tonumber(1) then ope = 'COMPRADOR' end
    if tonumber(dado.operacao)==tonumber(2) then ope = 'VENDEDOR' end
    if tonumber(dado.operacao)==tonumber(3) then ope = 'DIRETO' end
    if tonumber(dado.operacao)==tonumber(4) then ope = 'LEILÃO' end
    print(dado.timestamp,dado.quantidade, dado.preco, ope)
    if i%10==0 then io.read() end
end
