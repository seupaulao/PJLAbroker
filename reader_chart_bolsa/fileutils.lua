-- function file_exists(file)
--     local f = io.open(file, "rb")
--     if f then f:close() end
--     return f ~= nil
-- end

-- function lines_from(file)
--     if not file_exists(file) then return {} end
--     local lines = {}
--     for line in io.lines(file) do 
--       lines[#lines + 1] = line
--     end
--     return lines
-- end

-- function split(texto, sep)
--     local v={}
--     local p1 = string.find(texto, ",")
--     while p1 ~= nil do
--         local s1 = texto:sub(1,p1-1)
--        v[#v+1] = s1
--        texto = texto:sub(p1+1)
--        p1 = string.find(texto, ",")
--    end
--    return v
--end

-- function carregarDoArquivo()
--     local linhas = lines_from(arquivos[rindex])
--     tCopiaArquivo={}
--     for i,linha in ipairs(linhas) do
--         local v = split(linha, ",")
--         local t={}
--         t.data=v[1]
--         t.hora=v[2]
--         local stmul = tostring(math.floor(tonumber(v[3]))) 
--         tmul = stmul:len()-1
--         t.abertura=tonumber(v[3])
--         t.alta=tonumber(v[4])
--         t.baixa=tonumber(v[5])
--         t.fechamento=tonumber(v[6])
--         tCopiaArquivo[#tCopiaArquivo+1]=t
--     end
-- end

function criarTabelaCandles(data,hora,ope,hig,low,clo,med)
        local t={}
        t.data=data
        t.hora=hora
        t.abertura=ope
        t.alta=hig
        t.baixa=low
        t.fechamento=clo
        tCopiaArquivo[#tCopiaArquivo+1]=t
end



function carregarExibicaoDemo()
    texibir = {
        {data='2020.01.01',hora='17:00',abertura=1121200,alta=1121210,baixa=1121170,fechamento=1121200},
        {data='2020.01.01',hora='17:01',abertura=1121060,alta=1121350,baixa=1121060,fechamento=1121350},
        {data='2020.01.01',hora='17:02',abertura=1121360,alta=1121390,baixa=1121360,fechamento=1121390},
        {data='2020.01.01',hora='17:03',abertura=1121350,alta=1121350,baixa=1121200,fechamento=1121220},
        {data='2020.01.01',hora='17:04',abertura=1121220,alta=1121250,baixa=1121220,fechamento=1121250},
        {data='2020.01.01',hora='17:05',abertura=1121250,alta=1121270,baixa=1121250,fechamento=1121270},
        {data='2020.01.01',hora='17:06',abertura=1121270,alta=1121270,baixa=1121270,fechamento=1121270},
        {data='2020.01.01',hora='17:07',abertura=1121270,alta=1121270,baixa=1121270,fechamento=1121270},
        {data='2020.01.01',hora='17:08',abertura=1121270,alta=1121270,baixa=1121270,fechamento=1121270},
        {data='2020.01.01',hora='17:09',abertura=1121270,alta=1121270,baixa=1121270,fechamento=1121270}  
    }
end

function carregarExibicao(_posicao)
    if _posicao == nil then 
        _posicao = 1
    end
    texibir = {}
    for i=_posicao,wcandles+_posicao-1 do 
        if i <= #tCopiaArquivo then 
           local elemento = tCopiaArquivo[i]
           texibir[#texibir+1] = elemento 
        end
    end
end
