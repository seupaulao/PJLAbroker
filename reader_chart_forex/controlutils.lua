function drawBt()
    for i,t in ipairs(botoes) do 
        love.graphics.setColor(t.br,t.bg,t.bb)
        love.graphics.rectangle(t.tipo,t.x,t.y,t.w,t.h)
        love.graphics.setColor(t.tr,t.tg,t.tb)
        love.graphics.print(t.texto,t.x+25,t.y+7)
    end
end

function criarBotao(tipo,texto,x,y,w,h,br,bg,bb,tr,tg,tb)
    local t = {}
    t.id="id_"..tostring(#botoes+1)
    t.tipo=tipo
    t.texto=texto
    t.x=x
    t.y=y
    t.w=w
    t.h=h
    t.br=br
    t.bg=bg
    t.bb=bb
    t.tr=tr
    t.tg=tg
    t.tb=tb
    botoes[#botoes + 1] = t
end