function file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

--carrega todas as linhas do arquivo numa tabela, se o arquivo existir
function lines_from(file)
    if not file_exists(file) then return {} end
    lines = {}
    for line in io.lines(file) do
      lines[#lines + 1] = line
    end
    return lines
end

function separarDadosNegocio(linhas)
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

function imprimirNegocio(hora)
    local linhas = lines_from('_negocios')
    local dados = separarDadosNegocio(linhas)
    for i,dado in ipairs(dados) do
        local ope = 'leilão'
        if tonumber(dado.operacao)==tonumber(1) then ope = 'COMPRADOR' end
        if tonumber(dado.operacao)==tonumber(2) then ope = 'VENDEDOR' end
        if tonumber(dado.operacao)==tonumber(3) then ope = 'DIRETO' end
        if tonumber(dado.operacao)==tonumber(4) then ope = 'LEILÃO' end
        if hora == dado.timestamp then 
            print(dado.timestamp,dado.quantidade, dado.preco, dado.comprador, dado.vendedor, ope)
        end    
    end
end

function separarDados(linhas)
    local dados={}
    for i=1,#linhas do 
	 local lin = linhas[i]
	 local t={}
	 local dt,ho,op,hi,lo,cl=string.match(lin,'(%d+):(%d+):(%d+.%d?):(%d+.%d?):(%d+.%d?):(%d+.%d?)')
	 t.data=dt
	 t.hora=ho
	 t.open=op
	 t.high=hi
	 t.low=lo
	 t.close=cl
	 dados[#dados+1]=t
    end
    return dados
end

function separarAmostra(dados, inicio, fim)
    local amostra = {}
    for i=inicio,fim do
        amostra[#amostra+1] = dados[i]
    end
    return amostra
end

function getMinimo(amostra)
    local m = amostra[1].low
    for i=2,#amostra do 
        if amostra[i].low < m then 
            m = amostra[i].low
        end
    end
    return m    
end

function getMaximo(amostra)
    local m = amostra[1].high
    for i=2,#amostra do 
        if amostra[i].high > m then 
            m = amostra[i].high
        end
    end
    return m    
end

function imprimirSaidaComum(amostra)
    local min = getMinimo(amostra)
    local max = getMaximo(amostra)
    for i,dado in ipairs(amostra) do
        print(dado.hora,dado.high,dado.low)
    end

    print()
    print("Minimo:", min)
    print("Maximo:", max)
end

function imprimirApenasHigh(amostra)
    local min = getMinimo(amostra)
    local max = getMaximo(amostra)
    for i=max,min,-0.5 do
        local s = i..' '
        for j=1,#amostra do 
            if tonumber(i) == tonumber(amostra[j].high) then 
                s = s .. '*'  
            else 
                s = s .. '0'     
            end 
        end
        print(s)
    end       
end

function construirVetorPreco(amostra)
    local min = getMinimo(amostra)
    local max = getMaximo(amostra)
    local v = {}
    for i=max,min,-0.5 do
        v[#v+1] = tonumber(i)
    end
    return v
end

function zerarMatriz(amostra, precos)
    local dados = {}
    for i=1,#precos do 
        dados[i] = {}
        for j=1,#amostra do 
            dados[i][j] = '0'
        end
    end
    return dados 
end

function zerarBarra(precos)
    local barra ={}
    for i=1,#precos do barra[i]='0' end
    return barra
end

function buscarPosicaoPreco(precos, valor)
    for i=1,#precos do 
        if tonumber(precos[i])==tonumber(valor) then 
            return i
        end
    end
end

function vetorBarraPreco(precos, item, tipo)
    local barra = zerarBarra(precos)
    --sombras
    if tipo=='a' then 
        local inicio = buscarPosicaoPreco(precos, item.high)
        local fim = buscarPosicaoPreco(precos, item.low)
        for i=inicio,fim do
            barra[i]='*'
        end
    elseif tipo == 'c' then 
        local inicio = buscarPosicaoPreco(precos, item.high)
        local fim = buscarPosicaoPreco(precos, item.low)
        for i=inicio,fim do
            barra[i]='*'
        end
        if item.close > item.open then 
            fim = buscarPosicaoPreco(precos, item.open)
            inicio = buscarPosicaoPreco(precos, item.close)        
            for i=inicio,fim do
                barra[i]='c'
            end
        else 
            inicio = buscarPosicaoPreco(precos, item.open)
            fim = buscarPosicaoPreco(precos, item.close)        
            for i=inicio,fim do
                barra[i]='v'
            end
        end
    elseif tipo == 'h' then 
        local inicio = buscarPosicaoPreco(precos, item.high)
        barra[inicio]='*'
    elseif tipo == 'l' then 
        local inicio = buscarPosicaoPreco(precos, item.low)
        barra[inicio]='*'
    end
return barra
end

function printBarraLinha(barra)
    local s = ''
    for i=1,#barra do s = s .. barra[i] end
    print(s)
end

function printVetor(vetor)
    for i=1,#vetor do print(vetor[i]) end
end

function pertence(preco, vetor)
   if vetor == nil then 
      return false
   end
   for i=1,#vetor do 
      if vetor[i] == preco then
         return true
      end   
   end
   return false
end

function ehSimbolo(simbolo)
   if simbolo == '*' or simbolo=='v' or simbolo=='c' then 
      return true
   end
   return false
end

function imprimirMatriz(amostra, precos, tipo, chaves)
    local matriz = zerarMatriz(amostra, precos)
    for j=1,#amostra do 
        local barra = vetorBarraPreco(precos, amostra[j],tipo)
        for i=1,#precos do 
            matriz[i][j]=barra[i]
        end
    end
    for i=1,#precos do 
        local s = precos[i]..' '
        for j=1,#amostra do 
            if pertence(precos[i], chaves) and chaves ~= nil and not ehSimbolo(matriz[i][j])then 
                s = s..'-'
            else 
               s = s..matriz[i][j]
            end
        end
        print(s)
    end
end

n = 100    

function procurar(dados, data)
    for i=1,#dados do
        if dados[i].data == data then 
            return i
        end      
    end
    return -1
end

function loop()
    local op = ''
    local linhas = lines_from(arg[1])
    local dados = separarDados(linhas)
    local ini = 1
    local fim = n
    local tipografico = 'a' --a - alta e baixa; c - candle; h - só linha de alta; l - só linha de baixa
    local marcas = {}
    while op ~= 'q' do 
	    op = nil    
        local amostra = separarAmostra(dados,ini,fim)
        local vetorPreco = construirVetorPreco(amostra)
        print(amostra[1].data,amostra[1].hora,amostra[#amostra].hora)
        imprimirMatriz(amostra, vetorPreco,tipografico,marcas)
        print('z - reset; a - pagina anterior; d - proxima pagina; c - candle; h - high line; l - low line; i - high/close; q - sair; ')
        print('g - ir para; x - regua; n - aumentar numero velas; m - diminuir numero velas; r - marcar região; ')
        print('f - desmarcar ultima região; v - desmarcar região; o - imprimir negocios ultima hora; $> comando + [ENTER]')
        op=io.read()
        if op == 'd' or op == '' or op==' ' or op==nil then 
            ini = ini + n 
            fim = fim + n
            if fim > #dados then 
                fim = #dados 
                ini = fim - n
            end
        elseif op == 'a' then 
            ini = ini - n 
            fim = fim - n
            if ini < 0 then 
                ini = 1 
                fim = n
            end
        elseif op == 'c' then 
            tipografico = 'c'
        elseif op == 'h' then 
            tipografico = 'h'
        elseif op == 'l' then 
            tipografico = 'l'
        elseif op == 'i' then
    	    tipografico='a'	
        elseif op == 'n' then
            n = n + 1
            --ini = 1
            fim = ini + n
        elseif op == 'm' then
            n = n - 1
            --ini = 1
            fim = ini + n
        elseif op == 'z' then 
            tipografico = 'a'
            ini=1
            fim= ini + n
        elseif op == 'x' then
            print('Numero A: ')
	        local a = tonumber(io.read())
	        print('Numero B: ')
	        local b = tonumber(io.read())
	        print('A-B = ',tostring(a-b))
        elseif op == 'g' then
            print('Ir para qual data?')
            local data = io.read()
            local b = procurar(dados, data)
            if b > 0 then
                ini = b
                fim = ini + n
            else    
                print('NAO ENCONTRADO')
            end    
        elseif op == 'r' then
            print('Qual a região de preço? ')
            local pr = io.read()
            table.insert(marcas, tonumber(pr))     
        elseif op == 'f' then
            table.remove(marcas)     
        elseif op == 'v' then
            print('Qual a região de preço a remover? ')
            local pr = io.read()
            for i=1,#marcas do 
                if marcas[i]==tonumber(pr) then 
                    table.remove(marcas, i)
                    break
                end
            end             
        end
end    
end

loop()

