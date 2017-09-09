/'
	Autor: 	Fábio Moura de Oliveira
	Gerador de dados pra o banco de dados ltk, esquema: lotofacil.
'/

/'
	Cada grupo, terá um id, identificando cada combinação.
	A vantagem disto, é que iremos apontar o id da combinação e não 
	os dados da combinação.
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
	Gera todos os ids referente a grupos.
'/
Sub Gerar_Grupo_id()
	Dim as long coluna_1, coluna_2, coluna_3, coluna_4, coluna_5
	Dim grupo_id as long = 0
	
	Redim grupo2_id(1 to 25, 1 to 25) 
	Redim grupo3_id(1 to 25, 1 to 25, 1 to 25) 
	Redim grupo4_id(1 to 25, 1 to 25, 1 to 25, 1 to 25) 
	Redim grupo5_id(1 to 25, 1 to 25, 1 to 25, 1 to 25, 1 to 25) 
	
	' Cria os strings que serão armazenados no arquivo ao ser criado;
	Dim as string strGrupo2, strGrupo3, strGrupo4, strGrupo5	

	grupo_id = 0
	strGrupo2 = "grp_id;bola1;bola2"
	for coluna_1 = 1 to 25
		for coluna_2 = coluna_1 + 1 to 25
			grupo_id += 1
			grupo2_id(coluna_1, coluna_2) = grupo_id
			
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
				grupo3_id(coluna_1, coluna_2, coluna_3) = grupo_id
				
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
					grupo4_id(coluna_1, coluna_2, coluna_3, coluna_4) = grupo_id
					
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
						grupo5_id(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5) = grupo_id
						
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
	open "./lotofacil_id_grupo_2bolas.csv" for output as #arquivoGrupo2Bolas
	print #arquivoGrupo2Bolas, strGrupo2
	close
	
	arquivoGrupo3Bolas = freefile	
	open "./lotofacil_id_grupo_3bolas.csv" for output as #arquivoGrupo3Bolas
	print #arquivoGrupo3Bolas, strGrupo3
	close

	arquivoGrupo4Bolas = freefile	
	open "./lotofacil_id_grupo_4bolas.csv" for output as #arquivoGrupo4Bolas
	print #arquivoGrupo4Bolas, strGrupo4
	close
	
	arquivoGrupo5Bolas = freefile	
	open "./lotofacil_id_grupo_5bolas.csv" for output as #arquivoGrupo5Bolas
	print #arquivoGrupo5Bolas, strGrupo5
	close
	
	
End sub

Dim shared b1() 			as long
Dim shared b1_b15() 		as long
Dim shared b1_b8_b15() 		as long
Dim shared b1_b4_b8_b12_b15	as long

Sub Gerar_Grupo_Coluna_id()
	' As colunas b1, b4, b8, b12, b15, tem estes limites:
	' b1  - de 1  até 11
	' b4  - de 4  até 14
	' b8  - de 8  até 18
	' b12 - de 12 até 22
	' b15 - de 15 até 25
	redim b1(1 to 11)
	redim b1_b15(1 to 11, 15 to 25)
	redim b1_b8_b15(1 to 11, 8 to 18, 15 to 25)
	redim b1_b4_b8_b12_b15(1 to 11, 4 to 14, 8 to 18, 12 to 22, 15 to 25)
		
	
	Dim as long coluna_1, coluna_2, coluna_3, coluna_4, coluna_5
	
	Dim as long idColuna = 0
	Dim strColuna_B1 as string = "b1_id;b1"	
	for coluna_1 = 1 to 11
		idColuna += 1
		b1(coluna_1) = idColuna		
		strColuna_B1 += chr(10)
		strColuna_B1 += format(idColuna) & ";" & format(coluna_1)
	next
	
	idColuna = 0
	Dim strColuna_B1_B15 as string = "b1_b15_id;b1;b15"
	for coluna_1 = 1 to 11
		
		' Limite inferior b15 = 15
		for coluna_2 = coluna_1 + 14 to 25
			idColuna += 1
			b1_b15(coluna_1, coluna_2) = idColuna
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
				b1_b8_b15(coluna_1, coluna_2, coluna_3) = idColuna
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
						b1_b4_b8_b12_b15(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5) = idColuna
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
	open "lotofacil_id_B1.csv" for output as #arquivo_B1
	
	arquivo_B1_B15 = freefile	
	open "lotofacil_id_B1_B15.csv" for output as #arquivo_B1_B15
	
	arquivo_B1_B8_B15 = freefile
	open "lotofacil_id_B1_B8_B15.csv" for output as #arquivo_B1_B8_B15
	
	arquivo_B1_B4_B8_B12_B15 = freefile
	open "lotofacil_id_B1_B4_B8_B12_B15.csv" for output as #arquivo_B1_B4_B8_B12_B15
	
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


Sub Gerar_Combinacao_5Bolas()
	' Na última dimensão, o índice 0, é o identificador da combinação
	' o índice 1 é a quantidade de bolas.
	redim combinacao_5Bolas(0 to 5, 0 to 5, 0 to 5, 0 to 5, 0 to 5, 0 to 1)
	
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
							combinacao_5Bolas(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 0) = identificador
							combinacao_5Bolas(coluna_1, coluna_2, coluna_3, coluna_4, coluna_5, 1) = somaColunas
						
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
	' Dimensão 3, índice 1, armazena a quantidade de bolas daquela combinação.

	Redim par_impar_id(1 to 12, 1 to 13, 0 to 1)
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
							if par_1 = par_2 and impar_1 = impar_2 then
								id_comum += 1
								strPar_Impar_Comum &= chr(10)
								strPar_Impar_Comum &= id_comum & ";"
								strPar_Impar_Comum &= id_1 & ";"
								strPar_Impar_Comum &= id_2 
							elseif par_1 = par_2 and impar_1 <> impar_2 then
								id_comum += 1
								strPar_Impar_Comum &= chr(10)
								strPar_Impar_Comum &= id_comum & ";"
								strPar_Impar_Comum &= id_1 & ";"
								strPar_Impar_Comum &= id_2 
							elseif par_1 <> par_2 and impar_1 = impar_2 then
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
Sub Gerar_Externo_Interno_id()
	' Na lotofacil, há 16 externos e 9 internos, totalizando 25 bolas.
	' Então
	Redim externo_interno_id(0 to 16, 0 to 9, 0 to 1)
	
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
							
							if externo_1 = externo_2 and interno_1 = interno_2 then
								id_comum += 1
								strExterno_Interno_Comum &= chr(10)
								strExterno_Interno_Comum &= id_comum & ";"
								strExterno_Interno_Comum &= id_1 & ";"
								strExterno_Interno_Comum &= id_2
							elseif externo_1 = externo_2 and interno_1 <> interno_2 then
								id_comum += 1
								strExterno_Interno_Comum &= chr(10)
								strExterno_Interno_Comum &= id_comum & ";"
								strExterno_Interno_Comum &= id_1 & ";"
								strExterno_Interno_Comum &= id_2
							elseif externo_1 <> externo_2 and interno_1 = interno_2 then
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
	Open "lotofacil_id_primo_nao_primo.csv" for output as #arquivo
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
							
							if primo_1 = primo_2 and nao_primo_1 = nao_primo_2 then
								id_comum += 1
								strprimo_nao_primo_Comum &= chr(10)
								strprimo_nao_primo_Comum &= id_comum & ";"
								strprimo_nao_primo_Comum &= id_1 & ";"
								strprimo_nao_primo_Comum &= id_2
							elseif primo_1 = primo_2 and nao_primo_1 <> nao_primo_2 then
								id_comum += 1
								strprimo_nao_primo_Comum &= chr(10)
								strprimo_nao_primo_Comum &= id_comum & ";"
								strprimo_nao_primo_Comum &= id_1 & ";"
								strprimo_nao_primo_Comum &= id_2
							elseif primo_1 <> primo_2 and nao_primo_1 = nao_primo_2 then
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
	
	


' Início.
Gerar_Grupo_id
Gerar_Grupo_Coluna_id()
Gerar_Combinacao_5Bolas()
Gerar_Par_Impar_Id()
Gerar_Externo_Interno_id()










