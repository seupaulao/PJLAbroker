function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

function lines_from(file)
    if not file_exists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do 
      lines[#lines + 1] = line
    end
    return lines
end

function carregar(arquivo)
    local linhas = lines_from(arquivo)
    print('function loadCandles()')
    for i=1,#linhas do 
        local item = linhas[i]
        local data,hora,open,high,low,close,media = string.match(item,"(%d+):(%d+):(%d+.%d+):(%d+.%d+):(%d+.%d+):(%d+.%d+):(%d+.%d+)")
        --filtrarCorretora(idc,idv)
        print('criarTabelaCandles("'..data..'","'..hora..'",'..open..','..high..','..low..','..close..','..media..')')
    end
    print('end')
end

carregar(arg[1])