
function telaInicial()
    love.graphics.setFont(fonte22)
    love.graphics.setColor(1,0,1) 
    love.graphics.rectangle("line",180,110,350,200)
    love.graphics.print("Simulador",300,150)
    love.graphics.print("Times & Trades",280,170)
    love.graphics.print("Dolar Futuro",290,190)
    love.graphics.setFont(fonte16)

end

function telaInstrucoes01()
    love.graphics.setFont(fonte16)
    love.graphics.setColor(1,0,1) 
    love.graphics.print("Simulador Dolar Futuro - Times & Trades",100,130)
    love.graphics.setColor(1,1,1) 
    love.graphics.print("Segue o simulador de Dolar Futuro com o livro Times&Trades",100,160)
    love.graphics.setColor(0,1,0) 
    love.graphics.print("Compras são verdes",100,190)
    love.graphics.setColor(1,0,0) 
    love.graphics.print("Vendas são vermelho",100,220)
    love.graphics.setColor(1,1,1) 
    love.graphics.print("No times&trades so ha agressoes - so ha negocio fechado",100,250)
    love.graphics.print("So eh possivel comprar ou vender a mercado",100,280)
end
function telaInstrucoes02()
    love.graphics.setFont(fonte16)
    love.graphics.setColor(1,1,1) 
    local y = 130
    love.graphics.print("Regras",100,y)
    love.graphics.print("Procure identificar os movimentos de subida e descida do preço",100,y+30*1)
    love.graphics.print("Mesmo sendo atores ficticios, procure identificar quem compra e quem vende",100,y+30*2)
    love.graphics.print("Procure identificar quanto em quantidade esta sendo vendida ou comprada",100,y+30*3)
    love.graphics.print("Procure identificar qual o preco esta sendo vendido ou comprado",100,y+30*4)
    love.graphics.print("Visualize qual player esta piorando a oferta ",100,y+30*5)
    love.graphics.print("Comprando mais caro, vendendo mais barato",100,y+30*6)
    love.graphics.print("Procure identificar os movimentos de mercado : subida e descida",100,y+30*7)
    love.graphics.print("Procure identificar o momentum: ou seja o intervalo que havera queda ou subida de preco",100,y+30*8)
    love.graphics.print("Avalie quanto em media sobe ou desce o preco em pontos",100,y+30*9)
end

function telaInstrucoes03()
    love.graphics.setFont(fonte16)
    love.graphics.setColor(1,1,1) 
    local y = 130
    love.graphics.print("Ativos - Contratos",100,y)
    love.graphics.print("WDO - mini contrato  - 0.5 ponto a 1 contrato de WDO = R$ 5,00",100,y+30*2)
    love.graphics.print("DOL - contrato cheio - 0.5 ponto a 5 contrato de DOL = R$ 125,00",100,y+30*3)
end

function telaInstrucoes04()
    love.graphics.setFont(fonte16)
    love.graphics.setColor(1,1,1) 
    local y = 130
    love.graphics.print("Termos",100,y)
    love.graphics.print("TICK é a unidade de medida e vale 0.5 ponto",100,y+30*1)
    love.graphics.print("Quem BATE = agrediu a venda = vendeu = bate no preço do comprador",100,y+30*2)
    love.graphics.print("Quem TOMA = agrediu a compra = comprou = toma no preço do vendedor",100,y+30*3)
    love.graphics.print("POSICAO eh como esta o player : VENDIDO ou COMPRADO ou ZERADO",100,y+30*4)
    love.graphics.print("NUMERO OPERACAO - inicia numa compra e termina numa venda, ",100,y+30*5)
    love.graphics.print("isso eh 1 operacao. E vice-versa. ",100,y+30*6)
    love.graphics.print("Estime uma META de negócio = quantos pontos vc fara no dia = Ex: 25 pontos. ",100,y+30*7)
    love.graphics.print("RESULTADO = valor financeiro das operacao, pode ser lucro ou prejuizo. ",100,y+30*8)
end

function telaInstrucoes05()
    love.graphics.setFont(fonte16)
    love.graphics.setColor(1,1,1) 
    local y = 130
    love.graphics.print("Grafico de Candles",100,y)
    love.graphics.print("Observe os candles ou padroes graficos",100,y+30*1)
    love.graphics.print("Sao formados por alta,baixa,abertura e fechamento",100,y+30*2)
    love.graphics.print("Se a abertura eh menor que o fechamento o candle eh de alta",100,y+30*3)
    love.graphics.print("Se a abertura eh maior que o fechamento o candle eh de baixa",100,y+30*4)
    love.graphics.print("Observe as tendencias de mercado: ",100,y+30*5)
    love.graphics.print(" * mercado subindo = de ALTA ",100,y+30*6)
    love.graphics.print(" * mercado descendo = de BAIXA  ",100,y+30*7)
    love.graphics.print(" * mercado de lado = CONSOLIDADO ",100,y+30*8)
    love.graphics.print(" Observe os padrões de candle ",100,y+30*9)
    love.graphics.print(" confirmam descida, confirmam subida, indicam reversao de tendencia ",100,y+30*10)
end


function telaPlacar()
    local x = 100
    local y = 225
    if #placar > 0 then 
        love.graphics.print("Resultados: ",100,200)
        if #placar <= 10 then 
             local c = 0
             for i=#placar,1,-1 do 
                 if tonumber(placar[i].posicao) < 0 then 
                     love.graphics.setColor(1,0,0)
                 else
                     love.graphics.setColor(0,1,0)
                 end
                 love.graphics.print(espacos(placar[i].dia, 10)..espacos(tostring(placar[i].operacoes), 5)..espacos(tostring(placar[i].posicao),10),x,y+(25*c))
                 c = c + 1
             end
         else 
             local c = 0
             for i=#placar,#placar-10,-1 do 
                 if tonumber(placar[i].posicao) < 0 then 
                     love.graphics.setColor(1,0,0)
                 else
                     love.graphics.setColor(0,1,0)
                 end
                 love.graphics.print(espacos(placar[i].dia, 10)..espacos(tostring(placar[i].operacoes), 5)..espacos(tostring(placar[i].posicao),10),x,y+(25*c))
                 c = c + 1
             end
         end
    end
end

function telaConfiguracao()
   love.graphics.setColor(1,0,1) 
   love.graphics.print("Configuracao",300,30)
   love.graphics.print("Contratos     : "..tostring(numcontratos),100,60)
   love.graphics.print("Cenario       : "..tostring(arquivos[numarquivo]),100,120)
   love.graphics.print("Hora    Inicio: "..tostring(hini),100,180)
   love.graphics.print("Minuto  Inicio: "..tostring(mini),100,240)
end
-- TODO alteracoes:

function telaDOM()
    -- 3. criar estrutura que mostre as quantidades acumuladas em cada nivel de preco
    -- barra de precos
    -- preco atual ao background laranja
    -- quantidades de compra acumulados por preco do lado esquerdo    
    -- quantidades de vendas acumulados por preco do lado direito    

    --colocar controles de compra e venda a mercado
    --colocar controles de compra e venda a melhor preço (bid e ask)
    --colocar controles de zerar e inverter
    --colocar controles de lotes
    --colocar controle de alternar entre WDO e DOL

end

function telaIndicadores()
    -- maximo
    -- minimo
    -- abertura
    -- fechamento
    -- vwap
    -- preco medio
end

function telaCandles()
    -- 4. criar tela que exiba o grafico candles simplificado : *, v, c - conforme outro servico do broker (imprimirAltaBaixa.lua)
    
end

function telaPosicaoAtual()
    -- separar a tela de resultado / posicao da configuracao
    --       1.  em pontos
    --       2.  quantide de operacoes
    --       3.  em valor
end

function telaPrincipaisAgressores()
    -- 2. criar estrutura que mostre os 10 maiores vendedores e compradores e sua quantidade de lotes
    --    Se estiver comprando fica com valores positivos e verdes
    --    Se estiver vendendo  fica com valores negativos e vermelhos   
    --    Logo um lado estara verde e o outro vermelho
    
end

function telaNegociosOrdemOriginal()
    -- 1. criar estrutura que mostre a quantidade agrupada por:tempo, agressor, valor : essa  eh a ordem original
    
end

function telaNegocios()
    --tela de cenario atual (apenas os negocios sem filtro)
    local x = 490
    local y = 425
    local c = 1
    love.graphics.translate(width/2, height/2)
	love.graphics.rotate(angulo)
    love.graphics.translate(-width/2, -height/2)

    love.graphics.setColor(1,1,1) 
    love.graphics.print(tempotextob, x, 40)

    love.graphics.setColor(1,0,1) 
    local s = espacos("HORA",12)..espacos("QTE",6)..espacos("PRECO",10)..espacos("COMPRA",7)..espacos("VENDA",7)
    love.graphics.print(s, 80, 40)


    love.graphics.setColor(1,1,1)  
    love.graphics.print("Dia  : "..tostring(arquivos[numarquivo]), x, 160)
    love.graphics.print("Contrato  : "..tostring(tipocontrato), x, 180)
    if posicao > 0 then 
        love.graphics.setColor(0,1,0)
    elseif posicao < 0 then     
        love.graphics.setColor(1,0,0)
    elseif posicao == 0 then
        love.graphics.setColor(1,1,1)        
    end
    love.graphics.print("Lucro/Prejuizo  : "..tostring(posicao), x, 200)
    if posicaotemp > 0 then 
        love.graphics.setColor(0,1,0)
    elseif posicaotemp < 0 then     
        love.graphics.setColor(1,0,0)
    elseif posicaotemp == 0 then
        love.graphics.setColor(1,1,1)        
    end
    love.graphics.print("Osc prec : "..tostring(posicaotemp), x, 260)
    love.graphics.setColor(1,1,1)
    love.graphics.print("Pontos   : "..tostring(pontos), x, 280)
    love.graphics.print("Ult Preco: "..tostring(preco_operacao), x, 220)
    love.graphics.print("Operacoes: "..tostring(numeroOperacoes),x, 300)
    if tonumber(operacao) == 1 then
        love.graphics.setColor(0,1,0)
        love.graphics.print("Posicao : COMPRA", x, 240)
    elseif tonumber(operacao) == 2 then
        love.graphics.setColor(1,0,0)
        love.graphics.print("Posicao : VENDA", x, 240)
    end 
    if iUltimo > 0 then 
        for i=iUltimo,iPrimeiro,-1 do
            if saida[i] ~= nil then
                local op = tonumber(saida[i]:sub(#saida[i]))
                if op == 4 then 
                    love.graphics.setColor(1,0,1)
                elseif op == 1 then 
                    love.graphics.setColor(0,1,0)     
                elseif op == 2 then 
                    love.graphics.setColor(1,0,0)
                else 
                    love.graphics.setColor(1,1,1) 
                end    
                love.graphics.print(saida[i]:sub(1,#saida[i]-2), 80, y-15*(c)) 
            end 
            c = c + 1
        end        
    end
end
