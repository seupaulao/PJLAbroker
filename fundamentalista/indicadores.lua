function balancoPatrimonial()
	ativo = 50000
	disponibilidade = 50000
	ativo_circulante = 100000
	divida_bruta = 20000
	divida_liquida = 30000
	patrimonio_liquido = 50000 
end

function dre()
	receita_liquida = 30000
	ebit = 10000
	lucro_liquido = 20000
	--lucro_operacional = receita - despesas_operacionais
	lucro_operacional = lucro_liquido + juros + impostos
end

function mercado()
	cotacao = 20.0
        acoes=10000
	valor_mercado = 200000
	valor_firma = 150000
end

function indicadores()
	LPA = lucro_liquido / acoes
	VPA = patrimonio_liquido / acoes
	P_L = cotacao / LPA
	P_VP = cotacao / VPA
	P_EBIT = valor_mercado / ebit
	PSR = valor_mercado / receita_liquida
	MARGEM_EBIT = ebit / receita_liquida
	MARGEM_LIQUIDA = lucro_liquido / receita_liquida
	ROE = lucro_liquido / patrimonio_liquido
	ROA = lucro_liquido / ativo
	LIQUIDEZ_CORRENTE = ativo_circulante / passivo_circulante
	if LIQUIDEZ_CORRENTE > 1.5 then
		print('comprar')
	end
	LIQUIDEZ_SECA = (ativo_circulante - estoque) / passivo_circulante
	if LIQUIDEZ_SECA > 1.0 then
		print('comprar')
	end
	CAPITAL_GIRO = ativo_circulante - passivo_circulante
	if CAPITAL_GIRO >= 0.1 then
		print('comprar')
	end
	CAPITALIZACAO_MERCADO = acoes * cotacao + dividas
	EV_SE = ((acoes * cotacao) + dividas - caixa) / patrimonio_liquido
	if EV_SE > (2 * patrimonio_liquido) then
		print('descartar empresa')
	end
	PMR = (contas_receber / vendas_periodo) * 100
	GIRO_ESTOQUE = custo_mercadorias_vendidas / estoque
	D_B = divida_bruta / patrimonio_liquido
	DIVIDEND_YIELD = (dividendo / cotacao) * 100
	EV_EBIT = valor_firma / ebit
	CRESC_RECEITA_5A = 999
	PAYOUT = ((lucro_liquido - divida_liquida) / lucro_liquido) * 100
	DL_PL = divida_liquida / patrimonio_liquido
	DL_LO = divida_liquida / lucro_operacional
	NOPAT = ebit * (1 - Impostos)
	GIRO_INVESTIMENTO = receita_liquida / (divida_onerosa + patrimonio_liquido)
	MARGEM_OPERACIONAL_LIQUIDA_IR = NOPAT / receita_liquida
	ROIC = NOPAT / (divida_onerosa + patrimonio_liquido)
end
