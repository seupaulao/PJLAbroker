--local variavel = {}

--function variavel.fn(vp) 
local function fn(vp) 
    valor = vp
    local function get() 
         return valor
    end
    local function set(v1)
         valor = v1
    end 
    return {get=get, set=set}
end

local function filaS()
    valor = {}
    local function add(_v)
        valor[#valor + 1] = _v
    end
    local function zera()
        valor = {}  
    end
    local function getAll()
        return valor
    end
    local function setAll(_tabela)
        valor = _tabela
    end
    local function remove()
        table.remove(valor,1)
    end
    local function set(_index, _vl)
        valor[_index] = _vl
    end    
    local function get(_index)
        return valor[_index]
    end
    local function soma()
        local s = 0
        for i,v in ipairs(valor)
            s = s + v.valor
        end
        return s
    end         
    return {add=add, zera=zera, getAll=getAll, setAll=setAll, remove=remove, set=set, get=get, soma=soma}    
end

local function filaC()
    fila = {}
    local function add(_v, _o, _a, _pt)
        local temp = {}
        temp.preco_operacao = _v
        temp.operacao = _o
        temp.aberta = _a   
        temp.pontos = 0
        temp.posicaotemp = _pt
        valor[#valor + 1] = fila
    end
    local function zera()
        fila = {}  
    end
    local function getAll()
        return fila
    end
    local function setAll(_tabela)
        fila = _tabela
    end
    local function remove()
        table.remove(fila,1)
    end
    local function getPontos(_index)
        return fila[_index].pontos
    end
    local function setPontos(_index, _vl)
        fila[_index].pontos = _vl
    end    
    local function getPrecoOperacao(_index)
        return fila[_index].preco_operacao
    end
    local function setPrecoOperacao(_index, _vl)
        fila[_index].preco_operacao = _vl
    end    
    local function setPosicaoTemp(_index, _vl)
        fila[_index].posicaotemp = _vl
    end    
    local function isAberta(_index)
        local _temp = fila[_index]
        return _temp.aberta
    end    
    local function isVenda(_index)
        local _temp = fila[_index]
        return _temp.operacao == 2
    end    
    local function isCompra(_index)
        local _temp = fila[_index]
        return _temp.operacao == 1
    end   
    local function getPosicaoTemp(_index)
        local _temp = fila[_index]
        return _temp.posicaotemp == 1
    end
    return {add=add, zera=zera, getAll=getAll, setAll=setAll, remove=remove, isAberta=isAberta, isVenda=isVenda, isCompra=isCompra, getPosicaoTemp=getPosicaoTemp, setPosicaoTemp=setPosicaoTemp, getPontos=getPontos, setPontos=setPontos, getPrecoOperacao=getPrecoOperacao, setPrecoOperacao=setPrecoOperacao}    
end



--return variavel
return {fn=fn, filaS=filaS, filaC=filaC}