--
-- ALTERACOES
--   *  apagar MAX-NUMEROITENSEXIBIR dos negocios e 
--             garantir que continuara aparecendo os itens
--   *  atualizar o book de negocios de baixo pra cima
--   *  atualizar o book de ofertas de cima pra baixo
--   *  pintar os valores acima de 25 no book de ofertas
--      25 - 50
--      50 - 100
--     100 - 300
--     300 - 500
--     500 - 1K
--     acima de 1K
--   *  fazer o book de ofertas funcionar com o negocios e domvap
--   *  mapear os botoes da boleta turbo
--   *  mapear os botoes do domvap para operacoes
--          compra e venda
--          stop
--          quantidade de contratos por ordem
--          realizar parcial
--   *  lancar as ordens de acordo com a execucao na boleta e domvap
--   *  calcular as posicoes de acordo com o fluxo e as ordens
--   *  pintar indicadores no domvap : fechamento, ajuste, 
--             vwap diario, vwap semanal e vwap mensal
--   *  mostrar posicao bigplayer estrangeiros, petro, 
--              demais correlacoes + ajuste [0%,1%,2%,3%,-1%,-2%,-3%]
--              em outro quadro
function love.load()
    require "funcoes"
    negocios = {}
    ofertas={}
    --ofertasAPrecos={QteCompra PrecoCompra PrecoVenda QteVenda}
    domvap={}
    ordens={}
    tfonte = 14
    fonte = love.graphics.newFont("courier.ttf",tfonte)
    love.graphics.setFont(fonte)

    novaOrdem("compra",5,5290.00)
    novaOrdem("venda",5,5293.50)
    novaOrdem("venda",5,5295.50)
    novaOrdem("compra",5,5294.50)

    novaOferta("Ideal",5,5289.5,5390.0,20,"XP")
    novaOferta("Ideal",15,5289.5,5390.0,5,"XP")
    novaOferta("Ideal",5,5289.5,5390.0,5,"BTG")
    novaOferta("Ideal",5,5289.5,5390.0,5,"ITAU")
    novaOferta("Ideal",5,5289.5,5390.0,200,"JPMorgan")
    novaOferta("Ideal",5,5289.5,5390.0,20,"XP")
    novaOferta("Ideal",15,5289.5,5390.0,5,"XP")
    novaOferta("Ideal",5,5289.5,5390.0,5,"BTG")
    novaOferta("Ideal",5,5289.5,5390.0,5,"ITAU")
    novaOferta("Ideal",5,5289.5,5390.0,200,"JPMorgan")
    novaOferta("Ideal",5,5289.5,5390.0,5,"ITAU")
    novaOferta("Ideal",5,5289.5,5390.0,200,"JPMorgan")
    
    start = 1;
    indiceOrdemExecutada = 1
    maximoOrdemVisualizar = 5
    horainicio = 9
    contadortempo = 55
    ajuste = 5286.0
    fechamento = 5285.5
    maxima = 5320.0 
    minima = 5280.0 
    love.graphics.setColor(1,1,1)
    numeroMaximoNegocios=100
    hAtual = "09:00:55"
    hAnterior = "09:00:55"

   for valor=ajuste-300, ajuste+600, 0.5 do
      novoVap(valor,0,0,0,0)
   end

end

--posx, posy, ajuste, fechant, max, min, numerolinhas
function imprimirDomVap(posx, posy, precoMovel, numeroLinhas)
   local x = posx
   local y = posy
   for i,vap in ipairs(domvap) do
       if (vap.preco >= precoMovel - numeroLinhas/2) and  (vap.preco <= precoMovel + numeroLinhas/2 - 1) then
         love.graphics.setColor(0,1,0)
         love.graphics.rectangle("line",x,y,20,20)
         love.graphics.rectangle("line",x+20,y,20,20)
         love.graphics.setColor(1,1,1)
         love.graphics.print(tostring(vap.preco),x+50,y+5)
         love.graphics.setColor(1,0,0)
         love.graphics.rectangle("line",x+110,y,20,20)
         love.graphics.rectangle("line",x+130,y,20,20)
         love.graphics.setColor(0,1,0)
         love.graphics.print(qte2String(vap.agrqtecompra),x+160,y+5)
         love.graphics.setColor(1,0,0)
         love.graphics.print(qte2String(vap.agrqtevenda),x+220,y+5)
         y = y + 20    
       end
   end
end

function imprimirGraficoVap()
      --local dc = math.random(100)
      --local dv = 100 - dc 
      --love.graphics.rectangle("fill",x+200,y,dc,20)
      --love.graphics.setColor(1,0,0)
      --love.graphics.rectangle("fill",x+200+dc,y,dv,20)
end


function love.update(dt)
       --love.timer.sleep(1) 
       contadortempo = contadortempo + dt
       hAtual = calcularHora(contadortempo, horainicio)
       if hAtual ~= hAnterior then
          criarNegocio()
          if #negocios >= numeroMaximoNegocios then
             negocios = {}
             start = 1
          end
          hAnterior=hAtual
       end
end

function love.keypressed(key)
   if key=="escape" then
      love.event.quit()
   end
end



function criarNegocio()
   local h = hAtual
   local corretoras = {"XP","BTG","UCS","JP MORGAN","ITAU","Santander","Clear","Rico"}
   local quantidades = {5,100,500,1000,3000}
   local precos= {}
   for valor=ajuste-5,ajuste+5,0.5 do
      table.insert(precos, valor)
   end
   local tipoagressor = {"C","V"}
   local numeronegocios = math.random(5)
   local q = math.random(#quantidades)
   local p = math.random(#precos)
   local c = math.random(#corretoras)
   local v = math.random(#corretoras)
   local t = math.random(#tipoagressor)
   for i=1,numeronegocios do
      atualizarVap(precos[p], quantidades[q], tipoagressor[t])
      novoNegocio(h, quantidades[q], precos[p], corretoras[c], corretoras[v], tipoagressor[t])
   end   
end

function atualizarVap(preco, quantidade, agressor)
   for j, vap in ipairs(domvap) do
      if preco == vap.preco then
         if agressor == "C" then
               vap.agrqtecompra = vap.agrqtecompra + quantidade
         else
               vap.agrqtevenda = vap.agrqtevenda + quantidade
         end
         break
      end
   end
end

function imprimirRelogio()
    love.graphics.print(" tempo = "..calcularHora(contadortempo, horainicio), love.graphics.getWidth()/2, 580)
end

function imprimirPosicao(textoposicao, posx, posy, qte, saldo)
   love.graphics.setColor(1,1,1)
   love.graphics.rectangle("line",posx-2, posy-4, 330 , 20)
   local ssaldo = tostring(saldo)
   if qte <= 0 then
      sentenca=espacos("Pos:",5)..espacos(textoposicao, 10)..espacos("Saldo:",7)..espacos(ssaldo,ssaldo:len())
   else
      sentenca=espacos("Pos:",5)..espacos(textoposicao, 10)..espacos("Cont:",6)..espacos(tostring(qte), 6)..espacos("Saldo:",7)..espacos(ssaldo,ssaldo:len())
   end
   love.graphics.print(sentenca,posx,posy) 
end

function imprimirHistorico(posicaox, posicaoy, tam)
   love.graphics.setColor(1,1,1)
   local y = posicaoy
   for i=indiceOrdemExecutada,indiceOrdemExecutada+tam-1 do
       if ordens[i] ~= nil then 
            local ordem = ordens[i]
            local texto1 = espacos("Tipo:",7)..espacos(ordem.tipo,8)
            local texto2 = espacos("Qte:",6)..espacos(tostring(ordem.quantidade),4)
            local texto3 = espacos("Preco:",8)..espacos(tostring(ordem.preco),10)
            local texto = texto1..texto2..texto3
            love.graphics.print(texto,posicaox, y)
            y = y + 10
       end  
   end
end

function imprimirNegocios(px,py,tam)
   local y = py
   local c = 0
   for i=#negocios,start,-1 do
       if negocios[i].agressor == "C" then
         love.graphics.setColor(0,1,0)
       else  
         love.graphics.setColor(1,0,0)
       end  
       local sentenca = espacos(negocios[i].hora, 12)
             sentenca = sentenca..espacos(qte2String(negocios[i].quantidade), 6)
             sentenca = sentenca..espacos(tostring(negocios[i].preco), 10)
             sentenca = sentenca..espacos(negocios[i].comprador, 10)
             sentenca = sentenca..espacos(negocios[i].vendedor, 10)
       love.graphics.print(sentenca,x,y)
       y = y + 10
       c = c + 1
       if c > tam then 
          y = py 
          c = 0
          start = start + 1
         end
   end
end

function destacarQuantidade(_qte)
   if _qte >= 50 then
      love.graphics.setBackgroundColor(0,1,1)
  else    
      love.graphics.setBackgroundColor(0,0,0)
  end
end

function imprimirOfertas(posx, posy, numeroLinhas)
   local y = posy
   love.graphics.setColor(1,1,1)
   for i=1,numeroLinhas do
       local v = ofertas[i]
       local sentenca = ""
       if v ~= nil then
       sentenca = sentenca..espacos(v.comprador, 10)
       sentenca = sentenca..espacos(qte2String(v.qtecomprador), 5)
       sentenca = sentenca..espacos(qte2String(v.precocomprador), 10)
       sentenca = sentenca..espacos(tostring(v.precovendedor), 10)
       sentenca = sentenca..espacos(tostring(v.qtevendedor), 5)
       sentenca = sentenca..espacos(v.vendedor, 10) 
       end
       love.graphics.print(sentenca, posx,y)
       y = y + 10 
   end   
end



function imprimirBoletaTurbo(posx, posy,ativo,qte)
   local x = posx
   local y = posy
   love.graphics.setColor(1,1,1)
   love.graphics.rectangle("line",x-10,y-4,298,136)
   love.graphics.print("Ativo: "..ativo..espacos("    Qte: ",10)..zeros(qte,2),x,y)
   love.graphics.rectangle("line",x-4,y+30-4,136,24)
   love.graphics.print("Compra a Mercado",x,y+30)
   love.graphics.rectangle("line",x+150-4,y+30-4,136,24)
   love.graphics.print("Venda a Mercado",x+150,y+30)
   love.graphics.rectangle("line",x-4,y+60-4,136,24)
   love.graphics.print("Compra no Bid",x,y+60)
   love.graphics.rectangle("line",x+150-4,y+60-4,136,24)
   love.graphics.print("Venda no Ask",x+150,y+60)
   love.graphics.rectangle("line",x-4,y+90-4,136,24)
   love.graphics.print("Compra no Ask",x,y+90)
   love.graphics.rectangle("line",x+150-4,y+90-4,136,24)
   love.graphics.print("Venda no Bid",x+150,y+90)
end

function love.draw()
   hAtual = calcularHora(contadortempo,horainicio)
   love.graphics.setColor(1,1,1)
   imprimirRelogio() 
   imprimirPosicao("ZERADO", 10, 460, 20, 500)
   imprimirHistorico(10, 500, maximoOrdemVisualizar)
   imprimirDomVap(460,10,ajuste,10)
   imprimirNegocios(10,10,25)
   imprimirOfertas(10, 300, 10)
   imprimirBoletaTurbo(460,430,"WIN",1)
end
