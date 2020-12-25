function espacos(texto, espacos)
    local tt = texto:len()
    local dif = espacos - tt
    local ss = ""
    for i=1,dif do
       ss = ss.." "
    end
    return texto..ss
 end
 
 function zeros(valor, digitos)
    local svalor = tostring(valor)
    local tam = svalor:len()
    local t = digitos - tam
    local z = ""
    for i=1,t do
       z = z.."0"
    end
    return z..svalor
 end

 function qte2String(_numero)
   local op = ""  
   local qu = -1
   if _numero >= 1000000000 then 
      op = "B"
      qu = _numero / 1000000000
   elseif _numero >= 1000000 and _numero < 1000000000 then 
      op = "M"
      qu = _numero / 1000000
   elseif _numero >= 1000 and _numero < 1000000 then
      op = "K"
      qu = _numero / 1000
   else 
      qu = _numero   
   end
   if qu == 0 then
      return "0"
   end   
   local ss = tostring(qu)
   return ss:sub(1,4)..op
 end

 function novoVap(_p, _qc, _qv, _aqc, _aqv)
   local v = {}
   v.preco = _p
   v.qtecompra = _qc
   v.qtevenda = _qv
   v.agrqtecompra = _aqc
   v.agrqtevenda = _aqv
   table.insert(domvap, v) 
end

function novoNegocio(_hora, _quantidade, _preco, _comprador, _vendedor, _agressor)
   local negocio = {}
   negocio.hora = _hora
   negocio.quantidade = _quantidade
   negocio.preco = _preco
   negocio.comprador = _comprador
   negocio.vendedor = _vendedor
   negocio.agressor = _agressor
   table.insert(negocios,negocio)

   -- agrupar por preco as quantidades para obter Volume At Price
   -- agrupar por agressor as quantidades no preco para obter o negócio ordem original
end

function novaOferta(_comprador, _qtecomprador, _precocomprador, _precovendedor, _qtevendedor, _vendedor)
   ofe = {}
   ofe.comprador = _comprador
   ofe.qtecomprador = _qtecomprador
   ofe.precocomprador = _precocomprador
   ofe.precovendedor =  _precovendedor
   ofe.qtevendedor = _qtevendedor
   ofe.vendedor = _vendedor
   table.insert(ofertas,ofe)
   -- agrupar por preco para ofertasAPreco
   -- criar DOM atraves das ofertas agrupadas por preco
end

function novaOrdem(_tipo,_qte,_preco)
    local ordem = {}
    ordem.tipo =  _tipo
    ordem.quantidade = _qte
    ordem.preco = _preco
    table.insert(ordens, ordem)
end


function calcularHora(_contador, _hinicio)
   local segundo = math.ceil(_contador) % 60
   local minuto = math.floor(math.ceil(_contador) / 60)
   local hora = math.floor(minuto / 60) + _hinicio
   return zeros(hora,2)..":"..zeros(minuto,2)..":"..zeros(segundo,2)
end
