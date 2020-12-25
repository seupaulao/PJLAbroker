function love.load()
    --copia todos os dados do arquivo para a tabela tCopiaArquivo
    tCopiaArquivo={}
    --numero de candles possiveis de exibicao na tela
    wcandles=50 
    --tabela temporaria que armazena ateh o maximo de wcandles
    texibir={}
    botoes={}
   
    rindex = 1
    tmul=1
    pinicio = 3319
    camera ={
        x = 10,
        y = 10
    }
    min, max, centro = 0
    hpx=11
    xBOperacao=650
    yBOperacao=400
    ultimo = {}

    require "fileutils"
    require "controlutils"
    require "drawutils"
    require "candles"
    loadCandles()

    atualizarDados()

    --criarBotao("line","Candlestick",xBOperacao,yBOperacao-300,100,25,1,0,0,1,0,0)
    --criarBotao("line","Henki-Ashi",xBOperacao,yBOperacao-250,100,25,1,0,0,1,0,0)
    --criarBotao("line","Linhas",xBOperacao,yBOperacao-200,100,25,1,0,0,1,0,0)
    criarBotao("fill","COMPRAR",xBOperacao,yBOperacao,100,25,0,1,0,0,0,0)
    criarBotao("fill","VENDER",xBOperacao,yBOperacao+50,100,25,1,0,0,0,0,0)
    hora1 = nil
    hora2 = nil


end

function love.keypressed(key)
   
    if key=='escape' then
        love.event.quit()
    end	
    if key=='space' then
	rindex = rindex + 1
	if rindex > #arquivos then 
		rindex = 1 
	end
	carregarDoArquivo()
	atualizarDados()
    end
end

function love.update(dt)
    local tmin = min
    local tmax = max
    if love.keyboard.isDown("up") then 
        max = max + 10
        min = min + 10 
        hpx = calcularAlturaTick(min,max)
    end
    if love.keyboard.isDown("down") then 
        max = max - 10
        min = min - 10 
        hpx = calcularAlturaTick(min,max)
    end
    if love.keyboard.isDown("left") then
        pinicio = pinicio - 1 
        if pinicio < 1 then pinicio = 1 end
        atualizarDados()
        hora1 = tCopiaArquivo[pinicio].hora
        hora2 = tCopiaArquivo[pinicio+wcandles].hora
    end
    if love.keyboard.isDown("right") then
        pinicio = pinicio + 1 
        if pinicio > #tCopiaArquivo then pinicio = #tCopiaArquivo - wcandles end
        atualizarDados()
        hora1 = tCopiaArquivo[pinicio].hora
        hora2 = tCopiaArquivo[pinicio+wcandles].hora
    end
end


function love.draw()
    drawBt()
    plotarPrecoCandles()
    plotarLinhas()
    drawPosicaoInicio(xBOperacao,yBOperacao+100)
end

--[[
  1. criar funções para desenhar linhas de tendencia, suporte e resistencia no gráfico
  2. criar mecanismo de simulação: comprar e vender estilo FOREX, calcular pips e dar o retorno em conta simulada
  3. criar função para alterar entre os gráficos: de velas, linha e henki-ashi
  4. alterar papéis na base de dados para cada win/loss
  5. criar ajuda para traçar as linhas de suporte, resistencia e tendencia
     criar ajuda para determinar os padrões de vela mais comuns
]]

