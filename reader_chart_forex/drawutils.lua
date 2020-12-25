

function drawPosicaoInicio(x,y)
    love.graphics.setColor(1,1,1)
    love.graphics.print(tostring(pinicio).." - "..tostring(pinicio+wcandles),x,y)
end


function atualizarDados()
    carregarExibicao(pinicio)
    --min, max, centro = calcularMin(texibir)
    min = calcularMin(texibir)
    max = (420+min)
    centro = (min+max)/2 - 150 * getTT()
    print(tostring(min).." , "..tostring(max).." , "..tostring(centro).." , "..tostring(texibir[#texibir].abertura).." , "..tostring(texibir[#texibir].fechamento).." , "..tostring(tmul).." , "..tostring(getTT()))
    min = min + (texibir[#texibir].fechamento - centro)
    max = max + (texibir[#texibir].fechamento - centro)
    min = min/getTT()
    max = max/getTT()
    hpx = calcularAlturaTick(min,max)
end

function subtrairPorTT()
    if getTT() <= 1 then 
        return 100
    else    
        return getTT() * 10
    end
end

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
    for i=max,min,-10 do 
        love.graphics.print(tostring(i),580,10 + h * (c - 1))
        c = c + 1
    end
end   

function calcularAlturaTick(min,max)
    local t = love.graphics.getHeight()-20 / (max-min)
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

function getTT()
    local tt=1
    if tmul > 1 then 
        for i=1,tmul do tt=tt*10 end
    end
    return tt
end

function drawCandle(i,dado,min,max,htick)
        if (dado.fechamento/getTT() > dado.abertura/getTT()) then 
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
        if dado.abertura/getTT() > dado.fechamento/getTT() then 
            y = py + max - dado.abertura/getTT()
        else 
            y = py + max - dado.fechamento/getTT()
        end
        local w = lw-1
        local h = math.abs(dado.abertura/getTT() - dado.fechamento/getTT()) + 2
        love.graphics.rectangle("fill",x,y,w,h)
        --linha
        love.graphics.line(x+lc,py+(max - dado.alta/getTT()),x+lc,py+(max - dado.baixa/getTT()))

end

function plotarLinhas()
    --plotar do usuário
    --linhas angulares
    ----plotar as linhas de tendencia: LTAs e LTBs
    --linhas horizontais
    ----plotar as linhas de suporte e resistencia
    --plotar as linhas verticais
end
