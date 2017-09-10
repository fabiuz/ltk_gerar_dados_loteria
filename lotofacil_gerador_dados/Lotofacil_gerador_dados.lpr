{ <description>

  Copyright (C) <year> <name of author> <contact>

  This source is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 2 of the License, or (at your option)
  any later version.

  This code is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  A copy of the GNU General Public License is available on the World Wide Web
  at <http://www.gnu.org/copyleft/gpl.html>. You can also obtain it by writing
  to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  MA 02111-1307, USA.
}

{
 Programa:      Lotofacil_gerador_dados
 Autor:         Fábio Moura de Oliveira
 Objetivos:     Gerar arquivos csv, que serão utilizados pra popular
                as tabelas do banco de dados ltk, referente ao jogo da lotofacil.

 Maiores
 informações:

}
program Lotofacil_gerador_dados;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,
  sysUtils
  { you can add units after this };

var
  // As dimensões do arranjo são explicados dentro das funções que
  // gerão os ids.
  par_impar_id : array[2..12] of array[3..13] of array[0..2] of integer;
  externo_interno_id:  array[0..16] of array[0..9] of integer;
  primo_id: array[0..9] of array[0..16] of array[0..2] of integer;

{
 Gera um identificador pra cada combinação par x impar válida na lotofacil.
 Após todos os identificadores serem gerados, cada identificador, total de bolas,
 quantidade de números pares e quantidades de números ímpares, é salvo em um arquivo
 de nome 'lotofacil_id_par_impar.csv', onde a primeira linha tem o cabeçalho
 separados por ';', o cabeçalho é: par_impar_id;par_impar_qt;par;impar.
 As demais linhas tem os valores identificando

 Na lotofacil, há 12 pares e 13 ímpares.
 Na lotofacil, há 2 pares no mínimo;
 Na lotofacil, há 3 ímpares no mínimo
 Na lotofacil, as combinações válidas de pares e impares tem que estar entre
 15, 16, 17 ou 18 bolas, pois, na lotofacil pode-se jogar de 15 a 18 bolas.

 Layout do arranjo par_impar_id:
 A dimensão 0, representa a quantidade de números pares;
 A dimensão 1, representa a quantidade de números impares;
 A dimensão 2, índice 0, representa o identificador;
 A dimensão 2, índice 1, representa o total de bolas daquele jogo, 15, 16, 17 ou 18
 A dimensão 2, índice 2, representa o total de jogos já encontrados com aquela combinação.
 A dimensão 2, índice 2, será utilizada posteriormente quando percorrermos todas as
 combinações possíveis da lotofacil.
 }
procedure Gerar_Par_Impar_id();
var
  par, impar: integer;
  id_par_impar: integer;
  soma_par_impar: integer;
  str_par_impar : ansiString;
  lista_par_impar : TStrings;
begin
  id_par_impar := 0;
  str_par_impar := 'par_impar_id;par_impar_qt;par;impar';

  lista_par_impar := TStringList.Create;
  lista_par_impar.Clear;
  lista_par_impar.Add(str_par_impar);

  for par := 2 to 12 do begin
    for impar := 3 to 13 do begin

      soma_par_impar := par + impar;

      if soma_par_impar in [15, 16, 17, 18] then begin
        Inc(id_par_impar);
        par_impar_id [par, impar, 0] := id_par_impar;
        par_impar_id [par, impar, 1] := soma_par_impar;

        str_par_impar := '';
        str_par_impar := str_par_impar + IntToStr(id_par_impar) + ';';
        str_par_impar := str_par_impar + IntToStr(soma_par_impar) + ';';
        str_par_impar := str_par_impar + IntToStr(par) + ';';
        str_par_impar := str_par_impar + IntToStr(impar);
        lista_par_impar.Add(str_par_impar);
      end;
    end;
  end;

  // Grava em um arquivo.
  lista_par_impar.SaveToFile('./arquivos_csv/lotofacil_id_par_impar.csv');

end;

{
 Gera um arquivo, onde tem os campos seguintes:
 id_comum;par_impar_id;par_impar_comum_id

 Ao considerarmos uma combinação de par e impar de 15 bolas, com as demais
 combinações de par e impar das outras quantidades de 16, 17 e 18 bolas, pode
 ocorrer de uma combinação ser comum a outra combinação só diferente de 1, 2
 ou 3 bolas, então segue-se descrição desta situação:

 16 bolas, tem 1 bola a mais, ela pode estar nas seguintes formas:
 0 no par e 1 no ímpar;
 1 no par e 0 no ímpar;

 17 bolas, tem 2 bolas a mais, ela pode estar nas seguintes formas:
 0 no par e 2 no ímpar;
 1 no par e 1 no ímpar;
 2 no par e 0 no ímpar;

 18 bolas, tem 3 bolas a mais, ela pode estar nas seguintes formas:
 0 no par e 3 no ímpar;
 1 no par e 2 no ímpar;
 2 no par e 1 no ímpar;
 3 no par e 0 no ímpar;

 O que o nosso algoritmo fará é comparar cada um das combinação com todas as
 outras combinações pra identificar quais combinações são comuns e em seguida,
 iremos associar o identificador da combinação atual que estamos analisando
 com o identificador da outra combinação que é comum.

}
procedure Gerar_Par_Impar_Comum_id;
var
  par_1, impar_1, id_par_impar_1, soma_par_impar_1: Integer;
  par_2, impar_2, id_par_impar_2, soma_par_impar_2: Integer;
  lista_par_impar : TStrings;
  comum_localizado: boolean;
begin
  lista_par_impar := TStringList.Create;

  for par_1 := 2 to 12 do begin
    for impar_1 := 3 to 13 do begin

      soma_par_impar_1 := par_1 + impar_1;

      if soma_par_impar in [15, 16, 17, 18] then begin

        id_par_impar_1 := par_impar_id[par_1, impar_1, 0];

        for par_2 := 2 to 12 do begin
          for impar_2 := 3 to 13 do begin

            soma_par_impar_2 := par_2 + impar_2;
            if soma_par_impar_2 in [15, 16, 17, 18] then begin

              // Aqui, devemos pegar todas as combinações comum, conforme
              // a quantidade de bolas
              case soma_par_impar_1 of
                   15: begin
                     // Compara com 16 bolas, pode ter 1 bola a mais.
                     if par_1 = par_2 and impar_2 = impar_1 + 1 then begin
                       comum_localizado := true;
                     end else if par_2 = par_1 + 1 and impar_1 = impar_2 then begin
                       comum_localizado := true;
                     end else if par_1 = par_2 and impar_1 = impar_2 then begin
                       comum_localizado := true;
                     end;
                     // Compara com 17 bolas, pode ter 2 bolas a mais.
                     if par_1 = par_2 and impar_2 = impar_1 + 2 then begin
                       comum_localizado := true;
                     end;




                   end;
              end;


            end;
          end;
        end;
      end;

    end;
  end;

end;

{
 Início do programa:
 Aqui, o programa vai verificar se a pasta existe, se não existe tentaremos
 criá-la, se o procedimento for realizado com sucesso iremos chamar todos
 os métodos que criamos pra gerar todos os arquivos csv que são necessários
 pra popular todas as tabelas que necessitaremos pra analisar o jogo da lotofacil
 }
begin
     // Cria a pasta, se não existir.
  if DirectoryExists('./arquivos_csv/') = false then begin
    if CreateDir('./arquivos_csv/') = false then begin
      Writeln('Não foi possível criar o diretório: ./arquivos_csv');
    end;
  end;


  Gerar_Par_Impar_id();
end.

