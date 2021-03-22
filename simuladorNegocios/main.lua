require "funcoes"
require "telas"

function love.load()
    socket = require("socket")
    suit = require 'suit'
    carregarRecursos()
end

--A FAZER
    --8. carregar mais historicos de negocio de outros dias

function love.update(dt)
    if tela.get()==0 then
        rodarInicio()
    elseif tela.get()==1 or tela.get()==4 then
        rodarJogo()
    elseif tela.get()==2 then
        rodarConfiguracao()    
    elseif tela.get()==3 then
        rodarResultado()    
    end
end

function rodarInicio()
    if suit.Button("JOGAR", 250,220, 200,30,{id=1}).hit then
        tela.set(2)
    end
end

function rodarResultado()
    if suit.Button("Ir para Inicio",250,120, 200,30,{id=1}).hit then
        tela.set(0)
    end
end

local slider2 = {value = 1, min = 1, max = 24, step = 1}
local slider3 = {value = 9, min = 9, max = 18, step = 1}
local slider4 = {value = 0, min = 0, max = 59, step = 1}
function rodarConfiguracao()
    if suit.Button("ZERAR PLACAR", 450,70, 200,30,{id=1}).hit then
        zerarPlacar()
    end
    if suit.Button("INICIAR TREINO", 450,120, 200,30,{id=1}).hit then
        iniciar()
    end
    if suit.Button("+", 140,80, 30,30,{id=2}).hit then
        numcontratos = numcontratos + 1
    end
    if suit.Button("-", 100,80, 30,30,{id=3}).hit then
        numcontratos = numcontratos - 1
        if numcontratos < 1 then numcontratos = 1 end
    end
    --if suit.Button("<", 100,140, 30,30,{id=4}).hit then
    --    numarquivo = numarquivo - 1
    --    if numarquivo < 1 then numarquivo = 1 end
    --end
    --if suit.Button(">", 140,140, 30,30,{id=5}).hit then
    --    numarquivo = numarquivo + 1
    --    if numarquivo > #arquivos then numarquivo = #arquivos end
    --end
    suit.Slider(slider2, 100,140, 200,20)
    numarquivo = math.floor(slider2.value)
    suit.Slider(slider3, 100,200, 200,20)
    hini = math.floor(slider3.value)
    suit.Slider(slider4, 100,260, 200,20)
    mini = math.floor(slider4.value)

end


function rodarJogo()
    local b = tostring(socket.gettime())
    local ss, ml = string.match(b,'(%d+).(%d%d)')
    local milisegundos = formata(2,tostring(tonumber(ml) * 0.6):sub(1,2))
    local lista
    local teste = os.date("%H%M%S",epo)
    tempotextob = os.date("%H:%M:%S",epo)
    if milisegundos == '00' then 
        epo = epo + 1 
        lista = puxarSaida(teste)
    end
    

    if lista ~= nil then
            for i,v in ipairs(lista) do                 
                iUltimo = iUltimo + 1
                
                if tonumber(v.negocio)==1 then
                    saida[iUltimo]= espacos(formataHora(v.data),12)..espacos(v.qte,6)..espacos(v.preco,10)..espacos(getNomeCorretora(v.idc),7)..espacos("-",7)..v.negocio
                elseif tonumber(v.negocio)==2 then 
                    saida[iUltimo]= espacos(formataHora(v.data),12)..espacos(v.qte,6)..espacos(v.preco,10)..espacos("-",7)..espacos(getNomeCorretora(v.idv),7)..v.negocio
                else
                    saida[iUltimo]= espacos(formataHora(v.data),12)..espacos(v.qte,6)..espacos(v.preco,10)..espacos(getNomeCorretora(v.idc),7)..espacos(getNomeCorretora(v.idv),7)..v.negocio
                end
                
                precocorrente[iUltimo]=tonumber(v.preco)
                preco_corrente_negociado=precocorrente[iUltimo]

                if iUltimo - iPrimeiro > linhas then 
                    iPrimeiro = iPrimeiro + 1
                    saida[iPrimeiro] = nil
                    precocorrente[iPrimeiro]=nil
                end

                addQuantidadeNoPreco(v.preco, v.qte, v.negocio)
               -- addQuantidadePorAgressor(v.idc, v.qte, v.negocio)
                addAgrupar(v.data, v.idc, v.preco, v.qte, v.negocio)
            end
            lista = nil
    end


    local x = 490
   

    if suit.Button("Sair", x,70, 200,30,{id=1}).hit then
      if placartemp[#placartemp] ~= nil then 
        addPlacar(placar, placartemp[#placartemp].dia, placartemp[#placartemp].operacoes, placartemp[#placartemp].posicao)
        salvarPlacar()
      end
      placartemp={}
      estrutura={}
      saida={}
      tela.set(3)
   end
   if suit.Button("Alternar Contrato", x,120, 200,30,{id=2}).hit then
        if tipocontrato=='WDO' then 
            tipocontrato='DOL'
        else         
            tipocontrato='WDO'
        end   
   end
   -- TODO Alterar o comportamento dos botoes
   --      fazer fila para multiplas entradas
   --      criar saida baseada no preço médio das multiplas entradas
   --      fechar as posições começando da primeira aberta
   if suit.Button("COMPRAR", x,370, 100,30,{id=3}).hit then
        --TODO
        --1. buscar venda
        local index = buscarVenda()
        --2. se nao encontrar venda entao adiciona compra
        if index < 0 then 
            compravenda.add(precocorrente[iUltimo], 1, true, posicaotemp, inicieiOperacao())
        else    
            --3. se encontrar venda entao processa a primeira venda encontrada
            processarCompraVenda()
        end
   end
   if suit.Button("VENDER", x+110,370, 100,30,{id=4}).hit then
        local index = buscarCompra()
        if index < 0 then 
            compravenda.add(precocorrente[iUltimo], 2, true, posicaotemp, inicieiOperacao())
        else    
            processarCompraVenda()
        end
   end

   atualizarCompraVenda()

end

function atualizarCompraVenda()
    for i,v in ipairs(compravenda.getAll()) do
        if compravenda.isAberta(i) and compravenda.isCompra(i) then 
            compravenda.setPontos(i, precocorrente[iUltimo] - compravenda.getPrecoOperacao(i))
        end    
        if compravenda.isAberta(i) and compravenda.isVenda(i) then 
            compravenda.setPontos(i, compravenda.getPrecoOperacao(i) - precocorrente[iUltimo])
        end    
        compravenda.setPosicaoTemp(i, calcularPosicaoTemp(compravenda.getPontos(i)))            
    end
end

function processarCompraVenda()
    posicao = posicao + compravenda.getPosicaoTemp(1)
    numeroOperacoes = numeroOperacoes + 1
    compravenda.remove()
    addPlacar(placartemp, getArquivo(numarquivo), numeroOperacoes, posicao)
end

function buscarCompra()
    for i,v in ipairs(compravenda.getAll()) do
        if compravenda.isAberta(i) and compravenda.isCompra(i) then
            return i
        end    
    end
    return -1
end

function buscarVenda()
    for i,v in ipairs(compravenda.getAll()) do
        if compravenda.isAberta(i) and compravenda.isVenda(i) then
            return i
        end    
    end
    return -1
end

function calcularPosicaoTemp(_pontos)
    if tipocontrato == 'DOL' then 
        return _pontos * numcontratos * 250
    else
        return  _pontos * numcontratos * 10
    end
end

function inicieiOperacao()
    if tipocontrato == 'DOL' then 
        return 0.5 * numcontratos * 250 * -1
    else
        return 0.5 * numcontratos * 10 * -1
    end
end


function love.keypressed(key)
    if key=='escape' then
        love.event.quit()
    elseif key=='z' then 
        zerarPlacar()
    elseif key=='d' then 
        tela.set(4)
    elseif key=='t' then 
        tela.set(1)
    elseif key=='r' then 
        if angulo < 0 then 
            angulo = 0
        else         
            angulo = -math.pi/2
        end    
    end
end


function love.draw()
    if mostrarMsg then 
        love.graphics.print("NAO CONSEGUI CARREGAR",20,20)
    end
    if tela.get()==1 then 
        telaNegocios()
    elseif tela.get()==2 then 
        telaConfiguracao()
    elseif tela.get()==3 then 
        telaPlacar()
    elseif tela.get()==4 then 
        telaDOM()
    elseif tela.get()==0 then
        telaInicial()        
    end
    suit.draw()
end

