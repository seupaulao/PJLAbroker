
lume = require "lume"
local variavel=require 'variavel'


function carregarRecursos()
    tempotextob = "Tempo"
    contador=0
    preco=1245.0
    hini=9
    mini=0
    sini=36
    idcorretoras={}
    saida={}
    estrutura={}
    linhas = 22
    iUltimo=0
    iPrimeiro=0
  
    fonte16 = love.graphics.newFont("courier.ttf",16)
    fonte22 = love.graphics.newFont("courier.ttf",22)
    love.graphics.setFont(fonte16)
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    angulo = 0
    --operacional
    pontos = 0 
    preco_operacao = 0
    tipocontrato='WDO'
    operacao = nil
    estaAberta=false
    posicao = 0
    posicaotemp = 0
    precocorrente={}
    mostrarMsg=false
    numcontratos=1
    tela = variavel.fn(0)
    numarquivo=1
    numeroOperacoes=0
    placar={}
    placartemp={}
    
    --estruturas telas auxiliares
    qte_no_preco = {}
    qte_por_agressor = {}

    isNegocio = 2

    --print('iniciado')
    carregarPlacar()
end

-- para fazer o dom
function addQuantidadeNoPreco(preco, quantidade, negocio)
    print(preco, quantidade, negocio)
    if qte_no_preco[preco] ~= nil then
        if negocio == 1 then 
            qte_no_preco[preco].qtecompra = qte_no_preco[preco].qtecompra + quantidade
        elseif  negocio == 2 then 
            qte_no_preco[preco].qtevenda = qte_no_preco[preco].qtevenda + quantidade
        end
    else 
        local t = {}
        if negocio == 1 then
            t.qtecompra = quantidade    
            t.qtevenda = 0
        elseif negocio == 2 then 
            t.qtecompra = 0
            t.qtevenda = quantidade                
        end
        qte_no_preco[preco] = t
    end
end

-- para fazer a tela de agressores por quantidade de contratos
function addQuantidadePorAgressor(agressor, quantidade, negocio)
    if qte_por_agressor[agressor] ~= nil then
        if negocio == 1 then 
            qte_por_agressor[agressor].qte = qte_por_agressor[agressor].qte + quantidade
        elseif  negocio == 2 then 
            qte_por_agressor[agressor].qte = qte_por_agressor[agressor].qte - quantidade
        end
    else 
        local t = {}
        if negocio == 1 then
            t.qte = quantidade    
        elseif negocio == 2 then 
            t.qte = 0 - quantidade                 
        end
        qte_por_agressor[agressor] = t
    end
end

function addPlacar(_placar, _dia, _operacoes, _posicao)
    local t = {}
    t.dia=_dia
    t.operacoes=_operacoes
    t.posicao=_posicao
    _placar[#_placar+1]=t
end

function salvarPlacar()
    local data = {}
    data.placar = {}

    for i,v in ipairs(placar) do 
        data.placar[i] = {dia=v.dia, operacoes=v.operacoes, posicao=v.posicao}
    end

    local serialized = lume.serialize(data)
    love.filesystem.write("saveplacar.txt", serialized)
end

function carregarPlacar()

    if love.filesystem.getInfo("saveplacar.txt") then
        local file = love.filesystem.read("saveplacar.txt")
        local data = lume.deserialize(file)
        for i,v in ipairs(data.placar) do 
            addPlacar(placar, v.dia, v.operacoes, v.posicao)
        end    
    end
end

function zerarPlacar()
    placar={}
    local data={}
    data.placar={}
    local serialized = lume.serialize(data)
    love.filesystem.write("saveplacar.txt", serialized)
end

function getNomeCorretora(id)
    local nomecorretoras={}
    nomecorretoras[1982]='AAX'
    nomecorretoras[308]='AAB'
    nomecorretoras[127]='XAD'
    nomecorretoras[120]='XCX'
    nomecorretoras[386]='DXC'
    nomecorretoras[122]='DCQ'
    nomecorretoras[3]='DDF'
    nomecorretoras[88]='FDA'
    nomecorretoras[8]='FRT'
    nomecorretoras[45]='FRR'
    nomecorretoras[16]='FXC'
    nomecorretoras[93]='FAW'
    nomecorretoras[147]='DWE'
    nomecorretoras[15]='ERT'
    nomecorretoras[107]='LOI'
    nomecorretoras[114]='LUA'
    nomecorretoras[85]='SAL'
    nomecorretoras[3701]='MAL'
    nomecorretoras[72]='NUO'
    nomecorretoras[27]='NIL'
    nomecorretoras[1618]='POL'
    nomecorretoras[262]='PLK'
    nomecorretoras[40]='GUK'
    nomecorretoras[92]='KUT'
    nomecorretoras[238]='KIR'
    nomecorretoras[23]='KYT'
    nomecorretoras[735]='YRE'
    nomecorretoras[39]='YOT'
    nomecorretoras[1130]='MJF'
    nomecorretoras[58]='DRP'
    nomecorretoras[90]='EYX'
    nomecorretoras[6003]='ZXY'
    nomecorretoras[115]='ZYY'
    nomecorretoras[59]='HHO'
    nomecorretoras[77]='JII'
    nomecorretoras[13]='DOO'
    nomecorretoras[129]='NAA'
    nomecorretoras[131]='BEE'
    if nomecorretoras[id] == nil then 
        return 'X'
    else 
        return nomecorretoras[id]
    end    
end

function espacos(texto, n)
    local t = tostring(texto):len()
    local tam = n - t - 1
    local s = ' '
    for i=1,tam do 
        s = s..' '
    end
    return texto..s
end


function criarSaida(h,q,p,n,idc,idv)
    local t = {}
    local d = estrutura[h]
    if d == nil then 
        d = {}
    end
    t.data=h
    t.qte = q
    t.preco = p 
    t.negocio = n
    t.idc = idc
    t.idv = idv
    d[#d+1]=t
    estrutura[h]=d
end

function gerarSaida()
        s = "01/01/2020  "..imprimetempo(contador, hini, mini).."  5  "..tostring(preco)
        contador = contador + 1
        preco = preco + 0.5
        return s
end

function criarSaidaDemo()
    criarSaida('090002',5,1230.5,1,1982,735)
    criarSaida('090002',5,1230.5,1,1982,735)
    criarSaida('090002',5,1229.0,2,1982,735)
    criarSaida('090002',5,1229.0,2,1982,735)
    criarSaida('090005',5,1228.5,2,1982,735)
    criarSaida('090005',5,1228.5,2,1982,735)
    criarSaida('090005',5,1229.5,1,1982,735)
    criarSaida('090015',5,1229.5,1,1982,735)
    criarSaida('090015',5,1230.0,1,1982,735)
    criarSaida('090015',5,1230.0,1,1982,735)
    criarSaida('090015',5,1230.5,1,1982,735)
    criarSaida('090015',5,1230.5,1,1982,735)
    criarSaida('090025',5,1231.5,1,1982,735)
    criarSaida('090025',5,1231.5,1,1982,735)
end

function imprimetempo(c, h, m)
    -- print(c)
     mini = c % 60
     if (c % 60) then 
         h = h + 1
     end
     return formata(2, h)..':'..formata(2,m)
 end
 
 function formata(n, valor)
     local s = tostring(valor)
     local x = string.match(s, '%d+')
     local t = x:len()
     if t < n then 
         return '0'..x
     else
         return x    
     end
 end
 
 function puxarSaida(texto)
     local lista = estrutura[texto]
     if lista ~= nil then 
         return lista
     end
 end

function iniciar()
    saida={}
    estrutura={}
    iUltimo=0
    iPrimeiro=0
    carregarDolar()
    epo = os.time{year=2020,month=1,day=1,hour=hini,min=mini,sec=sini}
    tela.set(1)
    numeroOperacoes=0
    posicao=0
    posicaotemp=0
    qte_no_preco = {}
    qte_por_agressor = {}
end

function carregarDolar()
--'20191104', '20191126', '20200107', '20200108',
--'20200121', '20200218', '20200311', '20200324',
--'20200414', '20200429', '20200527', '20200615',
--'20200616', '20200617', '20200623', '20200713',
--'20200727', '20200728', '20200729', '20200803',
--'20200805', '20200812', '20200817', '20200819'

    if numarquivo == 1 then 
        load20191104()
    elseif numarquivo == 2 then    
        load20191126()
    elseif numarquivo == 3 then    
        load20200107()
    elseif numarquivo == 4 then    
        load20200108()
    elseif numarquivo == 5 then    
        load20200121()
    elseif numarquivo == 6 then    
        load20200218()
    elseif numarquivo == 7 then    
        load20200311()
    elseif numarquivo == 8 then    
        load20200324()
    elseif numarquivo == 9 then    
        load20200414()
    elseif numarquivo == 10 then    
        load20200429()
    elseif numarquivo == 11 then    
        load20200527()
    elseif numarquivo == 12 then    
        load20200615()
    elseif numarquivo == 13 then    
        load20200616()
    elseif numarquivo == 14 then    
        load20200617()
    elseif numarquivo == 15 then    
        load20200623()
    elseif numarquivo == 16 then    
        load20200713()
    elseif numarquivo == 17 then    
        load20200727()
    elseif numarquivo == 18 then    
        load20200728()
    elseif numarquivo == 19 then    
        load20200729()
    elseif numarquivo == 20 then    
        load20200803()
    elseif numarquivo == 21 then    
        load20200805()
    elseif numarquivo == 22 then    
        load20200812()
    elseif numarquivo == 23 then    
        load20200817()
    elseif numarquivo == 24 then    
        load20200819()
    end    
end

function formataHora(dh)
    return dh:sub(1,2)..':'..dh:sub(3,4)..':'..dh:sub(5,6)
end

--retorna: 
--1. o tamanho do dicionario,
--2. o menor valor da chave (preço minimo)
--3. o maior valor da chave (preço maximo)
function tamanhoDicionario(di)
    local n = 0
    local p = {}
    for k,v in pairs(di) do
       n = n + 1
       p[#p + 1] = k
    end
    table.sort(p)
    return n, p[1], p[#p]
 end

 function getArquivo(num)
    local arquivos={
        '20191104', '20191126', '20200107', '20200108',
        '20200121', '20200218', '20200311', '20200324',
        '20200414', '20200429', '20200527', '20200615',
        '20200616', '20200617', '20200623', '20200713',
        '20200727', '20200728', '20200729', '20200803',
        '20200805', '20200812', '20200817', '20200819'
            }
    return arquivos[num]        
 end
 
--********PROBLEMA ENCONTRADO PARA ANDROID/LOVE**********
--Não consigo colocar em modo retrato
--...
--Ao dar rotate, embora rode o desenho, as coordenadas das figuras permanecem
--Não rodam juntas, logo o botão visivelmente vai para outro canto, mas para
--aciona-lo, ele permanece no mesmo lugar
--...
--Nao consigo ler um arquivo TXT e reproduzir de um love do android
--solucao de contorno : colocar o dia num arquivo lua
--********************************************************
