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

--return variavel
return {fn=fn}