function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end
--
--carrega todas as linhas do arquivo numa tabela, se o arquivo existir
function lines_from(file)
    if not file_exists(file) then return {} end
    lines = {}
    for line in io.lines(file) do
      lines[#lines + 1] = line
    end
    return lines
end

function carregar(arquivo)
    local nomedata = arquivo:sub(1,8)
    if not file_exists(arquivo) then 
        mostrarMsg=true
    end
    local linhas = lines_from(arquivo)
    print('function load'..nomedata..'()')
    for i=1,#linhas do 
        local item = linhas[i]
        local id,preco,qte,ts,idc,idv,tipo = string.match(item,"(%d+);(%d+.%d+);(%d+);(%d+);(%d+);(%d+);(%d+)")
        local ano = ts:sub(1,4)
        local mes = ts:sub(5,6)
        local dia = ts:sub(7,8)
        local hora = ts:sub(9,15)
        --filtrarCorretora(idc,idv)
        print('    criarSaida("'..hora..'",'..qte..','..tonumber(preco)..','..tipo..','..idc..','..idv..')')
    end
    print('end')
end

function insertCorretora(id)
    local x = nomecorretoras[id]
    if x == nil then
        idcorretoras[#idcorretoras+1]=id
        nomecorretoras[id] = true
    end
end

function filtrarCorretora(idc, idv)
    insertCorretora(tonumber(idc))
    insertCorretora(tonumber(idv))
end

local idcorretoras={}
local nomecorretoras={}
carregar(arg[1])

