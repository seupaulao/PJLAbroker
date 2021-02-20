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

local function fila()
    valor = {}
    local function add(valor)
        table.insert(valor)
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
            s = s + v
        end
        return s
    end         
    return {add=add, zera=zera, getAll=getAll, setAll=setAll, remove=remove, set=set, get=get, soma=soma}    
end

--return variavel
return {fn=fn, fila=fila}