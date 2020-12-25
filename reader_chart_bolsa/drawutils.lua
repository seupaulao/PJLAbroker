

function drawPosicaoInicio(x,y)
    love.graphics.setColor(1,1,1)
    love.graphics.print(tostring(pinicio).." - "..tostring(pinicio+wcandles),x,y)
    if hora1 ~= nil and hora2 ~= nil then 
        love.graphics.print(hora1.." - "..hora2,x,y+25)
    end
    love.graphics.print(tCopiaArquivo[pinicio].data,x,y+50)
end


function atualizarDados()
    carregarExibicao(pinicio)
    --min, max, centro = calcularMin(texibir)
    min = calcularMin(texibir)
    max = (20+min)
    centro = (min+max)/2  
    min = min + (texibir[#texibir].baixa - centro)
    max = max + (texibir[#texibir].alta - centro)
    --min = min
    --max = max
    hpx = calcularAlturaTick(min,max)
  --  print(min,max,texibir[#texibir].alta, texibir[#texibir].baixa)
end

-- function subtrairPorTT()
--     if getTT() <= 1 then 
--         return 100
--     else    
--         return getTT() * 10
--     end
-- end

function plotarPrecoCandles()
    printPreco(min, max, hpx)
    for i=#texibir,1,-1 do
        if i==#texibir then ultimo = texibir[i] end
        drawCandle(i,texibir[i],min,max,hpx)
    end
end

function printPreco(min,max,h)
    local c = 1
    love.graphics.setColor(1,1,1)
    for i=max,min,-0.5 do 
        love.graphics.print(tostring(i),580,10 + h * (c - 1))
        c = c + 1
    end
end   

function calcularAlturaTick(min,max)
    local t = love.graphics.getHeight()-40 / (max-min)
    return math.floor(t/45)
end

function calcularMin(_tabela)
    local mn = _tabela[1].baixa
    for i=2,#_tabela do 
        if _tabela[i].baixa < mn then
            mn = _tabela[i].baixa
        end
    end
    return mn 
end

-- function getTT()
--     local tt=1
--     if tmul > 1 then 
--         for i=1,tmul do tt=tt*10 end
--     end
--     return tt
-- end

function drawCandle(i,dado,min,max,htick)
        if (dado.fechamento > dado.abertura) then 
            love.graphics.setColor(0,1,0)
        else
            love.graphics.setColor(1,0,0)
        end
    
        local lw = 9
        local py = 10
        local px = 10
        local lc = 4
        --barra
        local x = px + (i-1)*lw+1
        local y = 0
         if dado.abertura > dado.fechamento then 
             y = py * 2.7 * (max - dado.abertura)
         else 
             y = py * 2.7 * (max - dado.fechamento)
         end
         local w = lw-1
        local h = math.abs(dado.abertura - dado.fechamento)
        love.graphics.rectangle("fill",x,y,w,h*htick+1)
        --linha
        love.graphics.line(x+lc,(max - dado.alta)*2.7*py , x+lc, py * (max - dado.baixa)*2.7)

end

function plotarLinhas()
    --plotar do usuário
    --linhas angulares
    ----plotar as linhas de tendencia: LTAs e LTBs
    --linhas horizontais
    ----plotar as linhas de suporte e resistencia
    --plotar as linhas verticais
end
