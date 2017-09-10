/'
	Autor: 		Fábio Moura de Oliveira
	Programa: 	Gerar_Lotofacil.bas
	Função	:	Gerar dados em arquivo csv, pra ser populados nas tabelas
				utilizadas para analisar o jogo da lotofacil.

	Descrição das tabelas:
	*** lotofacil_num ***

'/



#include "string.bi"


Dim shared grupo2_id() as long
Dim shared grupo3_id() as long
Dim shared grupo4_id() as long
Dim shared grupo5_id() as long

Dim as long coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, coluna_6
Dim as long coluna_7, coluna_8, coluna_9, coluna_10, coluna_11, coluna_12
Dim as long coluna_13, coluna_14, coluna_15, coluna_16, coluna_17, coluna_18

/'
	Gera todos os identificadores pra cada possível na lotofacil.
	Gera identificadores para os grupos de 2, 3, 4, 5 bolas.
'/
Sub Gerar_Grupo_id()
	Dim as long coluna_1, coluna_2, coluna_3, coluna_4, coluna_5
	Dim grupo_id as long = 0
	
	'
	' O mesmo grupo pode pertence aos jogos de 15, 16, 17 ou 18 bolas
	' A penúltima dimensão indicará a quantidade de bolas, como um índice e 
	' a última dimensão, indicará:
	' Índice 0, identificador, o mesmo pra as três combinações
	' Índice 1, indica o total de bolas.
	' Este índice 1, será usado quando formos percorrer a tabela lotofacil_num e lotofacil_bolas
	' toda vez que encontrarmos uma combinação, iremos contabilizar, pra depois, realizar o agrupamento.
	' Haverá dois tipos de agrupamos, um com o id e a quantidade total deste id e um outro com o id, 
	' a quantidade de bolas do jogo e outro com a quantidade total deste id.
	'
	
	' Este arranjo, servirá pra dois propósitos, 1 pra recuperar o id, ao percorrer todas as combinações possíveis
	' e outra, ao gerar as tabelas agrupadas teremos a contabilização total.
	
	Redim grupo2_id(1 to 25, 1 to 25, 15 to 18, 0 to 1) 
	Redim grupo3_id(1 to 25, 1 to 25, 1 to 25, 15 to 18, 0 to 1 )  
	Redim grupo4_id(1 to 25, 1 to 25, 1 to 25, 1 to 25, 15 to 18, 0 to 1)  
	Redim grupo5_id(1 to 25, 1 to 25, 1 to 25, 1 to 25, 1 to 25, 15 to 18, 0 to 1)  
	
	' Cria os strings que serão armazenados no arquivo ao ser criado;
	Dim as string strGrupo2, strGrupo3, strGrupo4, strGrupo5	

	grupo_id = 0
	strGrupo2 = "grp_id;bola1;bola2"
	for coluna_1 = 1 to 25
		for coluna_2 = coluna_1 + 1 to 25
			grupo_id += 1
			grupo2_id(coluna_1, coluna_2, 15, 0) = grupo_id
			grupo2_id(coluna_1, coluna_2, 16, 0) = grupo_id
			grupo2_id(coluna_1, coluna_2, 17, 0) = grupo_id
			grupo2_id(coluna_1, coluna_2, 18, 0) = grupo_id
			
			strGrupo2 += iif(strGrupo2 <> "", chr(13) & chr(10), "")
			
			strGrupo2 += format(grupo_id) & ";"
			strGrupo2 += format(coluna_1) & ";"
			strGrupo2 += format(coluna_2)
		next
	next
	
	grupo_id = 0
	strGrupo3 = "grp_id;bola1;bola2;bola3"
	for coluna_1 = 1 to 25
		for coluna_2 = coluna_1 + 1 to 25
			for coluna_3 = coluna_2 + 1 to 25
				grupo_id += 1
				grupo3_id(coluna_1, coluna_2, coluna_3, 15, 0) = grupo_id
				grupo3_id(coluna_1, coluna_2, coluna_3, 16, 0) = grupo_id
				grupo3_id(coluna_1, coluna_2, coluna_3, 17, 0) = grupo_id
				grupo3_id(coluna_1, coluna_2, coluna_3, 18, 0) = grupo_id
				
				
				strGrupo3 += iif(strGrupo3 <> "", chr(13) & chr(10), "")
				strGrupo3 += format(grupo_id) & ";"
				strGrupo3 += format(coluna_1) & ";"
				strGrupo3 += format(coluna_2) & ";"
				strGrupo3 += format(coluna_3) 
								
			next
		next
	next
	
	grupo_id = 0
	strGrupo3 = "grp_id;bola1;bola2;bola3;bola4"
	for coluna_1 = 1 to 25
		for coluna_2 = coluna_1 + 1 to 25
			for coluna_3 = coluna_2 + 1 to 25
				for coluna_4 = coluna_3 + 1 to 25
					grupo_id += 1
					grupo4_id(coluna_1, coluna_2, coluna_3, coluna_4, 15, 0) = grupo_id
					grupo4_id(coluna_1, coluna_2, coluna_3, coluna_4, 16, 0) = grupo_id
					grupo4_id(coluna_1, coluna_2, coluna_3, coluna_4, 17, 0) = grupo_id
					grupo4_id(coluna_1, coluna_2, coluna_3, coluna_4, 18, 0) = grupo_id					
					
					strGrupo4 += iif(strGrupo4 <> "", chr(13) & chr(10), "")
					strGrupo4 += format(grupo_id) & ";"
					strGrupo4 += format(coluna_1) & ";"
					strGrupo4 += format(coluna_2) & ";"
					strGrupo4 += format(coluna_3) & ";"
					strGrupo4 += format(coluna_4)	
					
				next
			next
		next
	next
	
	grupo_id = 0
	strGrupo5 = "grp_id;bola1;bola2;bola3;bola4;bola5"
	for coluna_1 = 1 to 25
		for coluna_2 = coluna_1 + 1 to 25
			for coluna_3 = coluna_2 + 1 to 25
				for coluna_4 = coluna_3 + 1 to 25
					for coluna_5 = coluna_4 + 1 to 25
						grupo_id += 1
						grupo5_id(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 15, 0) = grupo_id
						grupo5_id(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 16, 0) = grupo_id
						grupo5_id(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 17, 0) = grupo_id
						grupo5_id(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 18, 0) = grupo_id
						
						strGrupo5 += iif(strGrupo5 <> "", chr(13) & chr(10), "")
						strGrupo5 += format(grupo_id) & ";"
						strGrupo5 += format(coluna_1) & ";"
						strGrupo5 += format(coluna_2) & ";"
						strGrupo5 += format(coluna_3) & ";"
						strGrupo5 += format(coluna_4) & ";"
						strGrupo5 += format(coluna_5)
					
					next 
				next
			next
		next
	next
	
	Dim arquivoGrupo2Bolas as long
	Dim arquivoGrupo3Bolas as long
	Dim arquivoGrupo4Bolas as long
	Dim arquivoGrupo5Bolas as long
	
	arquivoGrupo2Bolas = freefile	
	open "./arquivos_csv/lotofacil_id_grupo_2bolas.csv" for output as #arquivoGrupo2Bolas
	print #arquivoGrupo2Bolas, strGrupo2
	close
	
	arquivoGrupo3Bolas = freefile	
	open "./arquivos_csv/lotofacil_id_grupo_3bolas.csv" for output as #arquivoGrupo3Bolas
	print #arquivoGrupo3Bolas, strGrupo3
	close

	arquivoGrupo4Bolas = freefile	
	open "./arquivos_csv/lotofacil_id_grupo_4bolas.csv" for output as #arquivoGrupo4Bolas
	print #arquivoGrupo4Bolas, strGrupo4
	close
	
	arquivoGrupo5Bolas = freefile	
	open "./arquivos_csv/lotofacil_id_grupo_5bolas.csv" for output as #arquivoGrupo5Bolas
	print #arquivoGrupo5Bolas, strGrupo5
	close
	
	
End sub

Dim shared b1() 				as long
Dim shared b1_b15() 			as long
Dim shared b1_b8_b15() 			as long
Dim shared b1_b4_b8_b12_b15()	as long

Sub Gerar_Grupo_Coluna_id()
	' As colunas b1, b4, b8, b12, b15, tem estes limites:
	' b1  - de 1  até 11
	' b4  - de 4  até 14
	' b8  - de 8  até 18
	' b12 - de 12 até 22
	' b15 - de 15 até 25
	
	' 0, indica o identificador daquela combinação
	' 1, indica qual o total de bolas daquela combinação, se é 15, 16, 17 ou 18 bolas.
	' 2, indica o total daquela combinação que saiu até agora.
	' 3, indica o total daquela combinação que saiu até agora, em jogos de 15 bolas;
	' 4, indica o total daquela combinação que saiu até agora, em jogos de 16 bolas;
	' 5, indica o total daquela combinação que saiu até agora, em jogos de 17 bolas;
	' 6, indica o total daquela combinação que saiu até agora, em jogos de 18 bolas;
	' Os índices de 2 a 6, será usada quando percorrermos cada registro da tabela lotofacil_num.
	
	' Como haverá um único identificador para todas as combinações de 15 a 18 bolas
	' Teremos que identificar a quantidade de combinações de colunas para cada quantidade de bolas.	
	redim b1(1 to 11, 15 to 18, 0 to 1) as long
	redim b1_b15(1 to 11, 15 to 25, 15 to 18, 0 to 1) as long
	redim b1_b8_b15(1 to 11, 8 to 18, 15 to 25, 15 to 18, 0 to 1) as long
	redim b1_b4_b8_b12_b15(1 to 11, 4 to 14, 8 to 18, 12 to 22, 15 to 25, 15 to 18, 0 to 1) as long
		
	
	Dim as long coluna_1, coluna_2, coluna_3, coluna_4, coluna_5
	
	Dim as long idColuna = 0
	Dim strColuna_B1 as string = "b1_id;b1"	
	for coluna_1 = 1 to 11
		idColuna += 1
		b1(coluna_1, 15, 0) = idColuna
		b1(coluna_1, 16, 0) = idColuna
		b1(coluna_1, 17, 0) = idColuna
		b1(coluna_1, 18, 0) = idColuna
		
		strColuna_B1 += chr(10)
		strColuna_B1 += format(idColuna) & ";" & format(coluna_1)
	next
	
	idColuna = 0
	Dim strColuna_B1_B15 as string = "b1_b15_id;b1;b15"
	for coluna_1 = 1 to 11
		
		' Limite inferior b15 = 15
		for coluna_2 = coluna_1 + 14 to 25
			idColuna += 1
			b1_b15(coluna_1, coluna_2, 15, 0) = idColuna
			b1_b15(coluna_1, coluna_2, 16, 0) = idColuna
			b1_b15(coluna_1, coluna_2, 17, 0) = idColuna
			b1_b15(coluna_1, coluna_2, 18, 0) = idColuna
			
			strColuna_B1_B15 += chr(10)
			strColuna_B1_B15 += format(idColuna) & ";" 
			strColuna_B1_B15 += format(coluna_1) & ";"			 
			strColuna_B1_B15 += format(coluna_2)
		next
	next
	
	idColuna = 0
	Dim strColuna_B1_B8_B15 as string = "b1_b8_b15_id;b1;b8;b15"
	for coluna_1 = 1 to 11

		' Limite inferior: coluna b8 = 8
		' Limite superior: coluna b8 = 18
		for coluna_2 = coluna_1 + 7 to 18

			' Limite inferior: coluna b15 = 15
			' Limite superior: coluna b15 = 25
			for coluna_3 = coluna_2 + 7 to 25
				idColuna += 1
				b1_b8_b15(coluna_1, coluna_2, coluna_3, 15, 0) = idColuna
				b1_b8_b15(coluna_1, coluna_2, coluna_3, 16, 0) = idColuna
				b1_b8_b15(coluna_1, coluna_2, coluna_3, 17, 0) = idColuna
				b1_b8_b15(coluna_1, coluna_2, coluna_3, 18, 0) = idColuna
				
				strColuna_B1_B8_B15 += chr(10)
				strColuna_B1_B8_B15 += format(idColuna) & ";" 
				strColuna_B1_B8_B15 += format(coluna_1) & ";"			 
				strColuna_B1_B8_B15 += format(coluna_2) & ";"
				strColuna_B1_B8_B15 += format(coluna_3) 
			next
		next
	next	
	
	idColuna = 0
	Dim strColuna_B1_B4_B8_B12_B15 as string = "b1_b4_b8_b12_b15_id;b1;b4;b8;b12;b15"
	
	' Limite inferior: coluna b1 = 1
	for coluna_1 = 1 to 11
	
		' Limite inferior: coluna b4 = 4
		for coluna_2 = coluna_1 + 3 to 14
		
			' Limite inferior: coluna b8 = 8
			' Limite superior: coluna b8 = 18
			for coluna_3 = coluna_2 + 4 to 18
			
				' Limite inferior: coluna b12 = 12
				' Limite superior: coluna b12 = 22
				for coluna_4 = coluna_3 + 4 to 22
					
					' Limite inferior: coluna b15 = 15
					' Limite superior: coluna b15 = 25
					for coluna_5 = coluna_4 + 3 to 25
			
						idColuna += 1
						b1_b4_b8_b12_b15(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 15, 0) = idColuna
						b1_b4_b8_b12_b15(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 16, 0) = idColuna
						b1_b4_b8_b12_b15(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 17, 0) = idColuna
						b1_b4_b8_b12_b15(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 18, 0) = idColuna
						
						strColuna_B1_B4_B8_B12_B15 += chr(10)
						strColuna_B1_B4_B8_B12_B15 += format(idColuna) & ";" 
						strColuna_B1_B4_B8_B12_B15 += format(coluna_1) & ";"			 
						strColuna_B1_B4_B8_B12_B15 += format(coluna_2) & ";"
						strColuna_B1_B4_B8_B12_B15 += format(coluna_3) & ";"
						strColuna_B1_B4_B8_B12_B15 += format(coluna_4) & ";"
						strColuna_B1_B4_B8_B12_B15 += format(coluna_5) 
					next
				next			
			next
		next
	next
	
	Dim arquivo_B1 as long
	Dim arquivo_B1_B15 AS LONG
	Dim arquivo_B1_B8_B15 AS LONG
	Dim arquivo_B1_B4_B8_B12_B15 AS LONG	
	
	arquivo_B1 = freefile
	open "./arquivos_csv/lotofacil_id_B1.csv" for output as #arquivo_B1
	
	arquivo_B1_B15 = freefile	
	open "./arquivos_csv/lotofacil_id_B1_B15.csv" for output as #arquivo_B1_B15
	
	arquivo_B1_B8_B15 = freefile
	open "./arquivos_csv/lotofacil_id_B1_B8_B15.csv" for output as #arquivo_B1_B8_B15
	
	arquivo_B1_B4_B8_B12_B15 = freefile
	open "./arquivos_csv/lotofacil_id_B1_B4_B8_B12_B15.csv" for output as #arquivo_B1_B4_B8_B12_B15
	
	print #arquivo_B1, strColuna_B1
	print #arquivo_B1_B15, strColuna_B1_B15
	print #arquivo_B1_B8_B15, strColuna_B1_B8_B15
	print #arquivo_B1_B4_B8_B12_B15, strColuna_B1_B4_B8_B12_B15
	
	close	

End Sub


' Esta variável é usada pra armazenar o identificador das combinações
' horizontal, vertical, diagonal e cruzeta.
' Diz que é uma combinação de 5 bolas, pois, cada campo de uma combinação
' pode armazenar até 5 bolas.
Dim shared combinacao_5Bolas() as long

Dim shared horizontal_id() as long
Dim shared vertical_id() as long
Dim shared diagonal_id() as long
Dim shared cruzeta_id() as long


Sub Gerar_Combinacao_5Bolas()
	'
	' As tabelas horizontal, vertical, diagonal e cruzeta, 	
	'
	'
	redim horizontal_id(0 to 5, 0 to 5, 0 to 5, 0 to 5, 0 to 5, 0 to 2)
	redim vertical_id(0 to 5, 0 to 5, 0 to 5, 0 to 5, 0 to 5, 0 to 2)
	redim diagonal_id(0 to 5, 0 to 5, 0 to 5, 0 to 5, 0 to 5, 0 to 2)
	redim cruzeta_id(0 to 5, 0 to 5, 0 to 5, 0 to 5, 0 to 5, 0 to 2)	
	
	Dim as long coluna_1, coluna_2, coluna_3, coluna_4, coluna_5
	Dim identificador as long = 0
	Dim somaColunas as long = 0
	Dim strCombinacao as string = ""
	
	on error goto manipulador_erro
	 
	for coluna_1 = 0 to 5
		for coluna_2 = 0 to 5
			for coluna_3 = 0 to 5
				for coluna_4 = 0 to 5
					for coluna_5 = 0 to 5
						somaColunas = coluna_1 + coluna_2 + coluna_3 + coluna_4 + coluna_5
						if somaColunas >= 15 and somaColunas <= 18 then
							identificador += 1							
							horizontal_id(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 0) = identificador
							horizontal_id(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 1) = somaColunas
							
							vertical_id(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 0) = identificador
							vertical_id(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 1) = somaColunas
							
							diagonal_id(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 0) = identificador
							diagonal_id(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 1) = somaColunas
							
							cruzeta_id(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 0) = identificador
							cruzeta_id(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 1) = somaColunas
						
							strCombinacao &= iif(strCombinacao <> "", chr(10), "")
							strCombinacao &= identificador & ";"
							strCombinacao &= somaColunas & ";"
							strCombinacao &= coluna_1 & ";"
							strCombinacao &= coluna_2 & ";"
							strCombinacao &= coluna_3 & ";"
							strCombinacao &= coluna_4 & ";"
							strCombinacao &= coluna_5
								
						end if
					next
				next
			next
		next
	next
	
	
	Dim arquivo as long
	arquivo = Freefile
	open "lotofacil_id_horizontal.csv" for output as #arquivo
	' Imprime o cabeçalho.
	print #arquivo, "hrz_id;hrz_qt;hrz_1;hrz_2;hrz_3;hrz_4;hrz_5"
	print #arquivo, strCombinacao
	close
	
	arquivo = Freefile
	open "lotofacil_id_vertical.csv" for output as #arquivo
	' Imprime o cabeçalho.
	print #arquivo, "vrt_id;vrt_qt;vrt_1;vrt_2;vrt_3;vrt_4;vrt_5"
	print #arquivo, strCombinacao
	close
	
	arquivo = Freefile
	open "lotofacil_id_diagonal.csv" for output as #arquivo
	' Imprime o cabeçalho.
	print #arquivo, "dg_id;dg_qt;dg_1;dg_2;dg_3;dg_4;dg_5"
	print #arquivo, strCombinacao
	close
	
	arquivo = Freefile
	open "lotofacil_id_cruzeta.csv" for output as #arquivo
	' Imprime o cabeçalho.
	print #arquivo, "crz_id;crz_qt;crz_1;crz_2;crz_3;crz_4;crz_5"
	print #arquivo, strCombinacao
	close
	
	return
	
	manipulador_erro:
	print "Um erro ocorreu"
	close
	end
	
end sub

Dim shared par_impar_id() as long
Sub Gerar_Par_Impar_Id()
	' Na lotofacil, há 12 pares e 13 ímpares.
	' A menor quantidade de bolas possíveis de ser formada é 15 bolas então,
	' em uma combinação, pode haver no mínimo 2 pares ou 3 ímpares.
	' Dimensão 0, armazena par;
	' Dimensão 1, armazena ímpar;
	' Dimensão 3, índice 0, armazena o ídentificador da combinação;
	' Dimensão 3, índice 1, armazena a quantidade de bolas daquela combinação, se 15, 16, 17 e 18.
	' Dimensáo 3, índice 2, armazena o total de bolas encontrada até agora daquela combinação.

	Redim par_impar_id(1 to 12, 1 to 13, 0 to 2)
	Dim as long par, impar
	Dim as long soma_par_impar
	Dim as long idPar_Impar = 0
	Dim as string strPar_Impar = "par_impar_id;par_impar_qt;par;impar"
	
	for par = 1 to 12
		for impar = 1 to 13
			soma_par_impar = par + impar
			if soma_par_impar >= 15 and soma_par_impar <= 18 then
				idPar_Impar += 1
				par_impar_id(par, impar, 0) = idPar_Impar
				par_impar_id(par, impar, 1) = soma_par_impar
				
				strPar_Impar &= chr(10)
				strPar_Impar &= idPar_Impar & ";"
				strPar_Impar &= soma_par_impar & ";"
				strPar_Impar &= par & ";"
				strPar_Impar &= impar
			end if
		next
	next
	
	Dim as long arquivo = freefile
	open "./lotofacil_id_par_impar.csv" for output as #arquivo
	print #arquivo, strPar_Impar
	close
	
	'
	' Vamos gerar os dados para a tabela lotofacil_id_par_impar_comum;
	' Esta tabela terá dois identificadores, 1 deles, é o identificador
	' de cada registro da tabela lotofacil_id_par_impar
	' e haverá um segundo identificador, este identificador também é cada
	' identificador da tabela lotofacil_id_par_impar
	' Então, como funciona o algoritmo segue.
	' Haverá 2 loops, o primeiro vai pegar cada registro da tabela lotofacil_id_par_impar
	' e comparar com todos os registros da mesma tabela.
	' Então, o identificador do registro que está no segundo loop será inserido
	' na tabela lotofacil_id_par_impar_comum, se, qualquer uma das condições abaixo
	' for atendida:
	' se o campo 'par' e 'impar' do registro no segundo loop for igual aos
	' campos 'par' e 'impar' do registro no primeiro loop;
	' se o campo 'par' do registro do segundo loop for igual ao campo 'par' do 
	' registro no primeiro loop mas o campo impar for diferente.
	' se o campo 'impar' do registro do segundo loop for igual ao campo 'impar' do 
	' registro no primeiro loop mas o campo impar for diferente.

	Dim as long id_1 = 0
	Dim as long par_1 = 0
	Dim as long impar_1 = 0
	Dim as long soma_1 = 0
	
	Dim as long id_2 = 0
	Dim as long par_2 = 0	
	Dim as long impar_2 = 0
	Dim as long soma_2 = 0
	
	Dim as long id_comum = 0
	
	Dim as string strPar_Impar_Comum = "comum_id;par_impar_id;par_impar_comum_id"
	
	' No loop for, somente podemos comparar combinações válidas, ou seja,
	' combinações que tem 15, 16, 17 e 18 bolas.
	for par_1 = 1 to 12	
		for impar_1 = 1 to 13
			soma_1 = par_1 + impar_1	
				
			' Só iremos comparar combinações válidas.	
			if soma_1 >= 15 and soma_1 <= 18 then
				' Pega o id do primeiro loop.
				' O id da combinação está na terceira dimensão índice 0.
				id_1 = par_impar_id(par_1, impar_1, 0)
			
				for par_2 = 1 to 12				
					for impar_2 =  1 to 13						
						
						soma_2 = par_2 + impar_2
						
						' Só iremos comparar combinações válidas.						
						if soma_2 >= 15 and soma_2 <= 18 then
							' Pega o id
							id_2 = par_impar_id(par_2, impar_2, 0)
						
							' Agora, iremos verificar se há pelos a mesma quantidade par ou impar ou ambas
							' da combinação do loop 1 com a combinação do loop 2.
							Dim bLocalizado as boolean
							if par_1 = par_2 and impar_1 = impar_2 then
								bLocalizado = true
							elseif par_1 = par_2 and impar_1 <> impar_2 then
								bLocalizado = true
							elseif par_1 <> par_2 and impar_1 = impar_2 then
								bLocalizado = true
							End if
							
							if bLocalizado = true then
								bLocalizado = false
								id_comum += 1
								strPar_Impar_Comum &= chr(10)
								strPar_Impar_Comum &= id_comum & ";"
								strPar_Impar_Comum &= id_1 & ";"
								strPar_Impar_Comum &= id_2 
							end if
						end if
					next
				next
			end if
		next
	next
	
	' Gravar o arquivo
	arquivo = FreeFile
	Open "lotofacil_id_par_impar_comum.csv" for output as #arquivo
	print #arquivo, strPar_Impar_Comum
	close

End Sub
			
Dim shared externo_interno_id() as long

'
'	Na lotofácil, há 25 bolas, 16 são externas e 9 internas
' 
'	Esta função gera um identificador pra cada combinação de externo e interno
' válida para cada combinação válida de 15, 16, 17 e 18 números
'
Sub Gerar_Externo_Interno_id()
	' A dimensão 0, representa as bolas externas, há 16
	' e a dimensão 1, representa as bolas internas.
	' A dimensão 2, índice 0, representa o identificador
	' A dimensão 2, índice 1, representa a quantidade de bolas combinadas, se é 15, 16, 17 ou 18 bolas.
	' A dimensão 3, índice 2, representa a quantidade de jogos já encontrados com aquela combinação
	' está dimensão 3, índice 2, não será utilizada aqui, será utilizada quando percorrermos todas as combinações.
	Redim externo_interno_id(0 to 16, 0 to 9, 0 to 2)
	
	Dim as long soma_externo_interno = 0
	Dim as long externo, interno 
	Dim as string strExterno_Interno = "ext_id;ext_qt;externo;interno"
	Dim as long idExterno_Interno = 0
	
	for externo = 0 to 16
		for interno = 0 to 9
			soma_externo_interno = externo + interno
			if soma_externo_interno >= 15 and soma_externo_interno <= 18 then
				idExterno_Interno += 1
				externo_interno_id(externo, interno, 0) = idExterno_Interno
				externo_interno_id(externo, interno, 1) = soma_externo_interno
				strExterno_Interno &= chr(10)
				strExterno_Interno &= idExterno_Interno & ";"
				strExterno_Interno &= soma_externo_interno & ";"
				strExterno_Interno &= externo & ";"
				strExterno_Interno &= interno & ";"
			end if
		Next
	Next
	
	Dim as long arquivo = freefile
	Open "lotofacil_id_externo_interno.csv" for output as #arquivo
	print #arquivo, strExterno_Interno
	close
	
	' Agora, iremos gerar os dados para a tabela lotofacil_id_externo_interno_comum
	Dim as long id_1
	Dim as long externo_1
	Dim as long interno_1
	Dim as long soma_1
	
	Dim as long id_2
	Dim as long externo_2
	Dim as long interno_2
	Dim as long soma_2
	
	Dim as long id_comum = 0
	Dim as string strExterno_Interno_Comum = "comum_id;par_impar_id;par_impar_comum_id"
	
	for externo_1 = 0 to 16 
		for interno_1 = 0 to 9
			soma_1 = externo_1 + interno_1
			
			' Só podemos pegar combinações válidas.
			if soma_1 >= 15 and soma_1 <= 18 then
				' Pega o id atual da combinação.
				id_1 = externo_interno_id(externo, interno, 0)
				
				' Agora, iremos percorrer todas as combinações
				' e verificar se encontramos um par ou impar, ou ambos, par e impar
				' coincidente com a combinação atual do primeiro for.
				for externo_2 = 0 to 16
					for interno_2 = 0 to 9
						soma_2 = externo_2 + interno_2
						
						if soma_2 >= 15 and soma_2 <= 18 then
							' Pega o id atual.
							id_2 = externo_interno_id(externo, interno, 0)
							
							Dim bLocalizado as boolean
							if externo_1 = externo_2 and interno_1 = interno_2 then
								bLocalizado = true
							elseif externo_1 = externo_2 and interno_1 <> interno_2 then
								bLocalizado = true
							elseif externo_1 <> externo_2 and interno_1 = interno_2 then
								bLocalizado = true
							end if
							
							if bLocalizado = true then
								bLocalizado = false
								id_comum += 1
								strExterno_Interno_Comum &= chr(10)
								strExterno_Interno_Comum &= id_comum & ";"
								strExterno_Interno_Comum &= id_1 & ";"
								strExterno_Interno_Comum &= id_2
							end if
						end if
					next
				next
			end if
		next
	next
	
	arquivo = FreeFile
	open "./lotofacil_id_externo_interno_comum.csv" for output as #arquivo
	print #arquivo, strExterno_Interno_Comum
	close
	
End sub

Dim shared primo_nao_primo_id() as long
Sub Gerar_primo_nao_primo_id()
	' Na lotofacil, há 9 primos e 16 nao_primos, totalizando 25 bolas.
	' Então
	Redim primo_nao_primo_id(0 to 9, 0 to 16, 0 to 1)
	
	Dim as long soma_primo_nao_primo = 0
	Dim as long primo, nao_primo 
	Dim as string strprimo_nao_primo = "prm_id;prm_qt;primo;nao_primo"
	Dim as long idprimo_nao_primo = 0
	
	for primo = 0 to 9
		for nao_primo = 0 to 16
			soma_primo_nao_primo = primo + nao_primo
			if soma_primo_nao_primo >= 15 and soma_primo_nao_primo <= 18 then
				idprimo_nao_primo += 1
				primo_nao_primo_id(primo, nao_primo, 0) = idprimo_nao_primo
				primo_nao_primo_id(primo, nao_primo, 1) = soma_primo_nao_primo
				strprimo_nao_primo &= chr(10)
				strprimo_nao_primo &= idprimo_nao_primo & ";"
				strprimo_nao_primo &= soma_primo_nao_primo & ";"
				strprimo_nao_primo &= primo & ";"
				strprimo_nao_primo &= nao_primo & ";"
			end if
		Next
	Next
	
	Dim as long arquivo = freefile
	Open "./arquivos_csv/lotofacil_id_primo_nao_primo.csv" for output as #arquivo
	print #arquivo, strprimo_nao_primo
	close
	
	' Agora, iremos gerar os dados para a tabela lotofacil_id_primo_nao_primo_comum
	Dim as long id_1
	Dim as long primo_1
	Dim as long nao_primo_1
	Dim as long soma_1
	
	Dim as long id_2
	Dim as long primo_2
	Dim as long nao_primo_2
	Dim as long soma_2
	
	Dim as long id_comum = 0
	Dim as string strprimo_nao_primo_Comum = "comum_id;par_impar_id;par_impar_comum_id"
	
	for primo_1 = 0 to 9 
		for nao_primo_1 = 0 to 16
			soma_1 = primo_1 + nao_primo_1
			
			' Só podemos pegar combinações válidas.
			if soma_1 >= 15 and soma_1 <= 18 then
				' Pega o id atual da combinação.
				id_1 = primo_nao_primo_id(primo, nao_primo, 0)
				
				' Agora, iremos percorrer todas as combinações
				' e verificar se encontramos um par ou impar, ou ambos, par e impar
				' coincidente com a combinação atual do primeiro for.
				for primo_2 = 0 to 16
					for nao_primo_2 = 0 to 9
						soma_2 = primo_2 + nao_primo_2
						
						if soma_2 >= 15 and soma_2 <= 18 then
							' Pega o id atual.
							id_2 = primo_nao_primo_id(primo, nao_primo, 0)
							
							dim bLocalizado as boolean = false
							if primo_1 = primo_2 and nao_primo_1 = nao_primo_2 then
								bLocalizado = true
							elseif primo_1 = primo_2 and nao_primo_1 <> nao_primo_2 then
								bLocalizado = true
							elseif primo_1 <> primo_2 and nao_primo_1 = nao_primo_2 then
								bLocalizado = true
							end if
							
							if bLocalizado = true then
								id_comum += 1
								strprimo_nao_primo_Comum &= chr(10)
								strprimo_nao_primo_Comum &= id_comum & ";"
								strprimo_nao_primo_Comum &= id_1 & ";"
								strprimo_nao_primo_Comum &= id_2
							end if
						end if
					next
				next
			end if
		next
	next
	
	arquivo = FreeFile
	open "./lotofacil_id_primo_nao_primo_comum.csv" for output as #arquivo
	print #arquivo, strprimo_nao_primo_Comum
	close
	
End sub
	
	
' 
'	O trio é composto de 7 grupos de 3 bolas e um grupo de 4 bolas.
' 	Os grupos são:
' 	Grupo 1:	1, 2, 6
' 	Grupo 2: 	3, 7, 8
' 	Grupo 3: 	4, 5, 9
' 	Grupo 4: 	10, 14, 15
' 	Grupo 5: 	19, 20, 25
' 	Grupo 6: 	18, 23, 24
' 	Grupo 7: 	12, 13, 17
' 	Grupo 8: 	11, 16, 21, 22
'
'	

Dim shared trio_id() as long
Sub Gerar_Trio_id()
	' Aqui, temos um leve problema, arranjo em freebasic, te um limite de 8 dimensões
	' Então, há duas técnicas, criar um único arranjo bidimensional, onde a primeira dimensão é todas as combinações 
	' possíveis, e na segunda dimensão, terá um índice de 0 a 1.
	' Ou criar um segundo arranjo, com o mesmo total de dimensões, pra identificar a quantidade.
	Redim trio_id(0 to 3, 0 to 3, 0 to 3, 0 to 3, 0 to 3, 0 to 3, 0 to 3, 0 to 4) as long
	Redim trio_qt(0 to 3, 0 to 3, 0 to 3, 0 to 3, 0 to 3, 0 to 3, 0 to 3, 0 to 4) as long
	Redim trio_total(0 to 3, 0 to 3, 0 to 3, 0 to 3, 0 to 3, 0 to 3, 0 to 3, 0 to 4) as long
	
	
	Dim as long soma_trio = 0
	Dim as long coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, coluna_6, coluna_7, coluna_8
	Dim as long id_trio = 0
	Dim as string strTrio = "trio_id;trio_qt;tr_1;tr_2;tr_3;tr_4;tr_5;tr_6;tr_7;tr_8"
	
	for coluna_1 = 0 to 3
	for coluna_2 = 0 to 3
	for coluna_3 = 0 to 3
	for coluna_4 = 0 to 3
	for coluna_5 = 0 to 3
	for coluna_6 = 0 to 3
	for coluna_7 = 0 to 3
	for coluna_8 = 0 to 4
		soma_trio = coluna_1 + coluna_2 + coluna_3 + coluna_4 + coluna_5 + coluna_6 + coluna_7 + coluna_8
		
		if soma_trio >= 15 and soma_trio <= 18 then
			id_trio += 1
			trio_id(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, coluna_6, coluna_7, coluna_8) = id_trio
			trio_qt(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, coluna_6, coluna_7, coluna_8) = soma_trio
			
			strTrio &= chr(10)
			strTrio &= id_trio & ";"
			strTrio &= soma_trio & ";"
			strTrio &= coluna_1 & ";"
			strTrio &= coluna_2 & ";"
			strTrio &= coluna_3 & ";"
			strTrio &= coluna_4 & ";"
			strTrio &= coluna_5 & ";"
			strTrio &= coluna_6 & ";"
			strTrio &= coluna_7 & ";"
			strTrio &= coluna_8 & ";"			
		end if
	next
	next
	next
	next
	next
	next
	next
	next
	
	Dim as long arquivo = freefile
	Open "./arquivos_csv/lotofacil_id_trio.csv" for output as #arquivo
	print #arquivo, strTrio
	close
End Sub
	
Dim lotofacil_num() as long
Dim lotofacil_bolas() as long
/'
	Gera as 
	
'/
Sub Gerar_Lotofacil_Num()
	' Indica as colunas.
	Dim as long b_1, b_2, b_3, b_4, b_5, b_6, b_7, b_8, b_9, b_10, b_11, b_12, b_13, b_14, b_15, b_16, b_17, b_18
	
	Dim as long qt_par, qt_impar
	Dim as long qt_externo, qt_interno
	Dim as long qt_primo, qt_nao_primo
		
	Dim as long qt_hrz_1, qt_hrz_2, qt_hrz_3, qt_hrz_4, qt_hrz_5 										' Horizontal
	Dim as long qt_vrt_1, qt_vrt_2, qt_vrt_3, qt_vrt_4, qt_vrt_5										' Vertical
	Dim as long qt_dg_1, qt_dg_2, qt_dg_3, qt_dg_4, qt_dg_5												' Diagonal
	Dim as long qt_crz_1, qt_crz_2, qt_crz_3, qt_crz_4, qt_crz_5										' Cruzeta
	Dim as long qt_qrt_1, qt_qrt_2, qt_qrt_3, qt_qrt_4, qt_qrt_5, qt_qrt_6								' Quarteto
	Dim as long qt_trio_1, qt_trio_2, qt_trio_3, qt_trio_4, qt_trio_5, qt_trio_6, qt_trio_7, qt_trio_8 
	
	Dim as long id_par, id_externo, id_primo, id_trio
	Dim as long id_hrz, id_vrt, id_dg, id_crz, id_qrt												
	
	Dim as long id_b1, id_b1_b15, id_b1_b8_b15, id_b1_b4_b8_b12_b15
	Dim as long id_grupo2, id_grupo3, id_grupo4, id_grupo5	
	
	
	Dim as long lotofacil_id
	Dim as long lotofacil_qt
	
	Redim lotofacil_num(1 to 25) as long
	Redim lotofacil_bolas(1 to 18) as long
	
	' Cabeçalho dos arquivos csv, um arquivo csv, geralmente, é separado por vírgula ou ponto e vírgula
	Dim as string strPar_Impar = "ltf_id;ltf_qt;par_impar_id"
	Dim as string strExterno_Interno = "ltf_id;ltf_qt;ext_id"
	Dim as string strPrimo = "ltf_id;ltf_qt;prm_id"
	Dim as string strTrio = "ltf_id;ltf_qt;tr_id"
	Dim as string strHorizontal = "ltf_id;ltf_qt;hrz_id"
	Dim as string strVertical = "ltf_id;ltf_qt;vrt_id"
	Dim as string strDiagonal = "ltf_id;ltf_qt;dg_id"
	Dim as string strCruzeta = "ltf_id;ltf_qt;crz_id"
	Dim as string strQuarteto = "ltf_id;ltf_qt;qrt_id"
	
	
	Dim as string strLotofacil_id 
	strLotofacil_id  = "ltf_id;ltf_qt;par_impar_id;ext_id;prm_id;hrz_id;vrt_id;dg_id;crz_id;qrt_id;trio_id"
	strLotofacil_id &= "b1_id;b1_b15_id;b1_b8_b15_id;b1_b4_b8_b12_b15_id"
	
	
	lotofacil_id = 0
	

	' Sempre as bolas estão em ordem crescente, por este motivo cada loop 
	' for mais interno é maior que 1 unidade do loop for externo mais próximo.
	for b_1 = 1 to 25
	for b_2 = b_1 + 1 to 25
	for b_3 = b_2 + 1 to 25
	for b_4 = b_3 + 1 to 25
	for b_5 = b_4 + 1 to 25
	for b_6 = b_5 + 1 to 25
	for b_7 = b_6 + 1 to 25
	for b_8 = b_7 + 1 to 25
	for b_9 = b_8 + 1 to 25
	for b_10 = b_9 + 1 to 25
	for b_11 = b_10 + 1 to 25
	for b_12 = b_11 + 1 to 25
	for b_13 = b_12 + 1 to 25
	for b_14 = b_13 + 1 to 25
	for b_15 = b_14 + 1 to 25
		print lotofacil_id
		lotofacil_bolas(1) = b_1
		lotofacil_bolas(2) = b_2
		lotofacil_bolas(3) = b_3
		lotofacil_bolas(4) = b_4
		lotofacil_bolas(5) = b_5
		lotofacil_bolas(6) = b_6
		lotofacil_bolas(7) = b_7
		lotofacil_bolas(8) = b_8
		lotofacil_bolas(9) = b_9
		lotofacil_bolas(10) = b_10
		lotofacil_bolas(11) = b_11
		lotofacil_bolas(12) = b_12
		lotofacil_bolas(13) = b_13
		lotofacil_bolas(14) = b_14
		lotofacil_bolas(15) = b_15
		
		' Reseta todas os campos de lotofacil_num
		lotofacil_num(1) = 0
		lotofacil_num(2) = 0
		lotofacil_num(3) = 0
		lotofacil_num(4) = 0
		lotofacil_num(5) = 0
		lotofacil_num(6) = 0
		lotofacil_num(7) = 0
		lotofacil_num(8) = 0
		lotofacil_num(9) = 0
		lotofacil_num(10) = 0
		lotofacil_num(11) = 0
		lotofacil_num(12) = 0
		lotofacil_num(13) = 0
		lotofacil_num(14) = 0
		lotofacil_num(15) = 0		
		lotofacil_num(16) = 0
		lotofacil_num(17) = 0
		lotofacil_num(18) = 0
		lotofacil_num(19) = 0
		lotofacil_num(20) = 0
		lotofacil_num(21) = 0
		lotofacil_num(22) = 0
		lotofacil_num(23) = 0
		lotofacil_num(24) = 0
		lotofacil_num(25) = 0
		
		' Atribui os novos valores.
		lotofacil_num(b_1) = 1
		lotofacil_num(b_2) = 1
		lotofacil_num(b_3) = 1
		lotofacil_num(b_4) = 1
		lotofacil_num(b_5) = 1
		lotofacil_num(b_6) = 1
		lotofacil_num(b_7) = 1
		lotofacil_num(b_8) = 1
		lotofacil_num(b_9) = 1
		lotofacil_num(b_10) = 1
		lotofacil_num(b_11) = 1
		lotofacil_num(b_12) = 1
		lotofacil_num(b_13) = 1
		lotofacil_num(b_14) = 1
		lotofacil_num(b_15) = 1
		
		' Contabiliza números par e ímpar.
		qt_par = lotofacil_num(2) + lotofacil_num(4) + lotofacil_num(6) + lotofacil_num(8) + lotofacil_num(10)
		qt_par += lotofacil_num(12) + lotofacil_num(14) + lotofacil_num(16) + lotofacil_num(18) + lotofacil_num(20)
		qt_par += lotofacil_num(22) + lotofacil_num(24)
		
		qt_impar = lotofacil_num(1) + lotofacil_num(3) + lotofacil_num(5) + lotofacil_num(7) + lotofacil_num(9)
		qt_impar += lotofacil_num(11) + lotofacil_num(13) + lotofacil_num(15) + lotofacil_num(17) + lotofacil_num(19)
		qt_impar += lotofacil_num(21) + lotofacil_num(23) + lotofacil_num(25)
		
		
		' Contabiliza externo e interno
		qt_externo = lotofacil_num(1) + lotofacil_num(2) + lotofacil_num(3) + lotofacil_num(4) + lotofacil_num(5)
		qt_externo += lotofacil_num(6) + lotofacil_num(10)
		qt_externo += lotofacil_num(11) + lotofacil_num(15)
		qt_externo += lotofacil_num(16) + lotofacil_num(20)
		qt_externo += lotofacil_num(21) + lotofacil_num(22) + lotofacil_num(23) + lotofacil_num(24) + lotofacil_num(25)
		
		qt_interno = lotofacil_num(7) + lotofacil_num(8) + lotofacil_num(9)
		qt_interno += lotofacil_num(12) + lotofacil_num(13) + lotofacil_num(14)
		qt_interno += lotofacil_num(17) + lotofacil_num(18) + lotofacil_num(19)
		
		
		' Contabiliza números primos e não primos.
		qt_primo 	= lotofacil_num(2) + lotofacil_num(3) + lotofacil_num(5) + lotofacil_num(7) + lotofacil_num(11)
		qt_primo   	+= lotofacil_num(13) + lotofacil_num(17) + lotofacil_num(19) + lotofacil_num(23) 
		
		qt_nao_primo = lotofacil_num(1) + lotofacil_num(4) + lotofacil_num(6) + lotofacil_num(8) + lotofacil_num(9)
		qt_nao_primo += lotofacil_num(10) + lotofacil_num(12) + lotofacil_num(14) + lotofacil_num(15) + lotofacil_num(16)
		qt_nao_primo += lotofacil_num(18) + lotofacil_num(20) + lotofacil_num(21) + lotofacil_num(22) + lotofacil_num(24)
		qt_nao_primo += lotofacil_num(25)
				
		qt_trio_1 = lotofacil_num(1) + lotofacil_num(2) + lotofacil_num(6)
		qt_trio_2 = lotofacil_num(3) + lotofacil_num(7) + lotofacil_num(8) 
		qt_trio_3 = lotofacil_num(4) + lotofacil_num(5) + lotofacil_num(9)
		qt_trio_4 = lotofacil_num(10) + lotofacil_num(14) + lotofacil_num(15)
		qt_trio_5 = lotofacil_num(19) + lotofacil_num(20) + lotofacil_num(25)
		qt_trio_6 = lotofacil_num(18) + lotofacil_num(23) + lotofacil_num(24)
		qt_trio_7 = lotofacil_num(12) + lotofacil_num(13) + lotofacil_num(17)
		qt_trio_8 = lotofacil_num(11) + lotofacil_num(16) + lotofacil_num(21) + lotofacil_num(22)		
				
		qt_hrz_1 = lotofacil_num(1) + lotofacil_num(2) + lotofacil_num(3) + lotofacil_num(4) + lotofacil_num(5)
		qt_hrz_2 = lotofacil_num(6) + lotofacil_num(7) + lotofacil_num(8) + lotofacil_num(9) + lotofacil_num(10)
		qt_hrz_3 = lotofacil_num(11) + lotofacil_num(12) + lotofacil_num(13) + lotofacil_num(14) + lotofacil_num(15)
		qt_hrz_4 = lotofacil_num(16) + lotofacil_num(17) + lotofacil_num(18) + lotofacil_num(19) + lotofacil_num(20)
		qt_hrz_5 = lotofacil_num(21) + lotofacil_num(22) + lotofacil_num(23) + lotofacil_num(24) + lotofacil_num(25)
		
		qt_vrt_1 = lotofacil_num(1) + lotofacil_num(6) + lotofacil_num(11) + lotofacil_num(16) + lotofacil_num(21)
		qt_vrt_2 = lotofacil_num(2) + lotofacil_num(7) + lotofacil_num(12) + lotofacil_num(17) + lotofacil_num(22)
		qt_vrt_3 = lotofacil_num(3) + lotofacil_num(8) + lotofacil_num(13) + lotofacil_num(18) + lotofacil_num(23)
		qt_vrt_4 = lotofacil_num(4) + lotofacil_num(9) + lotofacil_num(14) + lotofacil_num(19) + lotofacil_num(24)
		qt_vrt_5 = lotofacil_num(5) + lotofacil_num(10) + lotofacil_num(15) + lotofacil_num(20) + lotofacil_num(25)
		
		qt_dg_1 = lotofacil_num(1) + lotofacil_num(7) + lotofacil_num(13) + lotofacil_num(19) + lotofacil_num(25)
		qt_dg_2 = lotofacil_num(2) + lotofacil_num(8) + lotofacil_num(14) + lotofacil_num(20) + lotofacil_num(21)
		qt_dg_3 = lotofacil_num(3) + lotofacil_num(9) + lotofacil_num(15) + lotofacil_num(16) + lotofacil_num(22)
		qt_dg_4 = lotofacil_num(4) + lotofacil_num(10) + lotofacil_num(11) + lotofacil_num(17) + lotofacil_num(23)
		qt_dg_5 = lotofacil_num(5) + lotofacil_num(6) + lotofacil_num(12) + lotofacil_num(18) + lotofacil_num(24)		
		
		qt_crz_1 = lotofacil_num(1) + lotofacil_num(2) + lotofacil_num(6) + lotofacil_num(7) + lotofacil_num(11)
		qt_crz_2 = lotofacil_num(4) + lotofacil_num(5) + lotofacil_num(9) + lotofacil_num(10) + lotofacil_num(15)
		qt_crz_3 = lotofacil_num(3) + lotofacil_num(8) + lotofacil_num(13) + lotofacil_num(18) + lotofacil_num(23)
		qt_crz_4 = lotofacil_num(12) + lotofacil_num(16) + lotofacil_num(17) + lotofacil_num(21) + lotofacil_num(22)
		qt_crz_5 = lotofacil_num(14) + lotofacil_num(19) + lotofacil_num(20) + lotofacil_num(24) + lotofacil_num(25)		
		
		qt_qrt_1 = lotofacil_num(1) + lotofacil_num(2) + lotofacil_num(13) + lotofacil_num(14)
		qt_qrt_2 = lotofacil_num(3) + lotofacil_num(4) + lotofacil_num(15) + lotofacil_num(16)
		qt_qrt_3 = lotofacil_num(5) + lotofacil_num(6) + lotofacil_num(17) + lotofacil_num(18)
		qt_qrt_4 = lotofacil_num(7) + lotofacil_num(8) + lotofacil_num(19) + lotofacil_num(20)
		qt_qrt_5 = lotofacil_num(9) + lotofacil_num(10) + lotofacil_num(21) + lotofacil_num(22)
		qt_qrt_6 = lotofacil_num(11) + lotofacil_num(12) + lotofacil_num(23) + lotofacil_num(24) + lotofacil_num(25)
		
		id_par = par_impar_id(qt_par, qt_impar, 0)
		id_externo = externo_interno_id(qt_externo, qt_interno, 0)
		id_primo = primo_nao_primo_id(qt_primo, qt_nao_primo, 0)
		id_hrz = horizontal_id(qt_hrz_1, qt_hrz_2, qt_hrz_3, qt_hrz_4, qt_hrz_5, 0)
		id_vrt = horizontal_id(qt_vrt_1, qt_vrt_2, qt_vrt_3, qt_vrt_4, qt_vrt_5, 0)
		id_dg = horizontal_id(qt_dg_1, qt_dg_2, qt_dg_3, qt_dg_4, qt_dg_5, 0)
		id_crz = horizontal_id(qt_crz_1, qt_crz_2, qt_crz_3, qt_crz_4, qt_crz_5, 0)
		id_trio = trio_id(qt_trio_1, qt_trio_2, qt_trio_3, qt_trio_4, qt_trio_5, qt_trio_6, qt_trio_7, qt_trio_8)
		
		' Os ids das colunas, são os mesmo pra as colunas 
		'id_b1 				= b1				(b_1, 15, 0)
		'id_b1_b15 			= b1_b15			(b_1, b_15, 15, 0)
		'id_b1_b8_b15 		= b1_b8_b15			(b_1, b_8, b_15, 15, 0)
		'id_b1_b4_b8_b12_b15	= b1_b4_b8_b12_b15	(b_1, b_4, b_8, b_12, b_15, 15, 0)
		
		' Gera id lotofacil
		lotofacil_id += 1
		
		' Estava pensando em gerar uma tabela separada, para cada assunto, por exemplo
		' lotofacil_horizontal, lotofacil_vertical
		' Entretanto, eu percebi, que é melhor haver somente uma tabela, com todos os id
		' ou seja, a tabela, é uma referẽncia pra todas as tabelas do sistema.
		



		
		if lotofacil_id = 500 then
			goto sair
		end if

					
	next: next: next: next: next
	next: next: next: next: next
	next: next: next: next: next
	
	sair:
	
	
	' Grava os arquivos
	Dim arquivo as long
	arquivo = freefile
	open "./arquivos_csv/lotofacil_par_impar.csv" for output as #arquivo
	print #arquivo, strPar_Impar
	close
		
	arquivo = freefile
	open "./arquivos_csv/lotofacil_externo_interno.csv" for output as #arquivo
	print #arquivo, strExterno_Interno
	close
End Sub	


'
' **** Início ****'
'
' Os arquivos csv gerados, serão armazenados na pasta arquivos_csv
if dir("./arquivos_csv/") = "" then
	mkdir("./arquivos_csv/")
end if

Gerar_Grupo_id
Gerar_Grupo_Coluna_id()
Gerar_Combinacao_5Bolas()
Gerar_Par_Impar_Id()
Gerar_Externo_Interno_id()
Gerar_primo_nao_primo_id()
Gerar_Lotofacil_Num()










