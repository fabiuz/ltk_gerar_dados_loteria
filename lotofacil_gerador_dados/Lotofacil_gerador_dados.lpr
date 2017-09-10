{ Lotofacil_Gerador_Dados

  Copyright (C) 2017 Fábio Moura de Oliveira <contact>

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
  externo_interno_id:  array[0..16] of array[0..9] of array[0..2] of integer;
  primo_nao_primo_id: array[0..9] of array[0..16] of array[0..2] of integer;

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

 Aqui, a combinação é comum e recíproca, pois, podemos implementar posteriormente,
 no programa que o usuário escolhe uma quantidade de bolas maior e o programa
 seleciona as outras combinações que são comum.

}
procedure Gerar_Par_Impar_Comum_id;
var
  par_1, impar_1, id_par_impar_1, soma_par_impar_1: Integer;
  par_2, impar_2, id_par_impar_2, soma_par_impar_2: Integer;
  lista_par_impar : TStrings;
  str_par_impar : AnsiString;
  comum_localizado: boolean;
  comum_id : Integer;
  strPar_Impar : String;
begin
  lista_par_impar := TStringList.Create;
  comum_id := 0;

  lista_par_impar.Add('comum_id;par_impar_id;par_impar_comum_id');

  for par_1 := 2 to 12 do begin
    for impar_1 := 3 to 13 do
    begin

      soma_par_impar_1 := par_1 + impar_1;

      if soma_par_impar_1 in [15, 16, 17, 18] then
      begin

        id_par_impar_1 := par_impar_id[par_1, impar_1, 0];

        for par_2 := 2 to 12 do
        begin
          for impar_2 := 3 to 13 do
          begin

            soma_par_impar_2 := par_2 + impar_2;
            if soma_par_impar_2 in [15, 16, 17, 18] then
            begin
              id_par_impar_2 := par_impar_id[par_2, impar_2, 0];
              comum_localizado := false;
              // Aqui, devemos pegar todas as combinações comum, conforme
              // a quantidade de bolas
              case soma_par_impar_1 of
                   // ================ 15 BOLAS.
                   15: begin
                     // Verifica se a combinação é a própria combinação.
                     if (par_1 = par_2) and (impar_1 = impar_2) then begin
                       comum_localizado := true;
                     end else

                     // Compara com as combinações de 16 bolas, haverá 1 bolas a
                     // mais, no seguinte esquema:
                     // 0 par x 1 ímpar;
                     // 1 par x 0 ímpar.
                     if (par_1 = par_2) and (impar_1 + 1 = impar_2) then begin
                       comum_localizado := true;
                     end else
                     if (par_1 + 1 = par_2) and (impar_1 = impar_2) then begin
                       comum_localizado := true;
                     end else

                     // Compara com as combinações de 17 bolas, haverá 2 bolas a
                     // mais, no seguinte esquema:
                     // 0 par x 2 ímpar;
                     // 1 par x 1 ímpar;
                     // 2 par x 0 ímpar.
                     if (par_1 = par_2) and (impar_1 + 2 = impar_2) then begin
                       comum_localizado := true;
                     end else
                     if (par_1 + 1 = par_2) and (impar_1 + 1 = impar_2) then begin
                       comum_localizado := true;
                     end else
                     if (par_1 + 2 = par_2) and (impar_1 = impar_2) then begin
                       comum_localizado := true;
                     end else

                     // Comparar com as combinações de 18 bolas, haverá 3 bolas a
                     // mais, no seguinte esquema:
                     // 0 par x 3 ímpar;
                     // 1 par x 2 ímpar;
                     // 2 par x 1 ímpar;
                     // 3 par x 0 ímpar;
                     if (par_1 = par_2) and (impar_1 + 3 = impar_2) then begin
                       comum_localizado := true;
                     end else
                     if (par_1 + 1 = par_2) and (impar_1 + 2 = impar_2) then begin
                       comum_localizado := true;
                     end else
                     if (par_1 + 2 = par_2) and (impar_1 + 1 = impar_2) then begin
                       comum_localizado := true;
                     end else
                     if (par_1 + 3 = par_2) and (impar_1 = impar_2) then begin
                       comum_localizado := true;
                     end end;
                     // ================ FIM: 15 BOLAS;

                     // ================ INÍCIO: 16 BOLAS.
                     16: begin
                       // Compara com as combinações de 15 bolas, haverá 1 bolas a
                       // menos, no seguinte esquema:
                       // 0 par x 1 ímpar;
                       // 1 par x 0 ímpar.
                       if (par_1 = par_2) and (impar_1 - 1 = impar_2) then begin
                         comum_localizado := true;
                       end else
                       if (par_1 - 1 = par_2) and (impar_1 = impar_2) then begin
                         comum_localizado := true;
                       end else

                       // Verifica se a combinação é a própria combinação.
                       if (par_1 = par_2) and (impar_1 = impar_2) then begin
                         comum_localizado := true;
                       end else

                       // Compara com as combinações de 17 bolas, haverá 1 bolas a
                       // mais, no seguinte esquema:
                       // 0 par x 1 ímpar;
                       // 1 par x 0 ímpar;
                       if (par_1 = par_2) and (impar_1 + 1 = impar_2) then begin
                         comum_localizado := true;
                       end else
                       if (par_1 + 1 = par_2) and (impar_1 = impar_2) then begin
                         comum_localizado := true;
                       end else

                       // Comparar com as combinações de 18 bolas, haverá 2 bolas a
                       // mais, no seguinte esquema:
                       // 0 par x 2 ímpar;
                       // 1 par x 1 ímpar;
                       // 2 par x 0 ímpar;
                       if (par_1 = par_2) and (impar_1 + 2 = impar_2) then begin
                         comum_localizado := true;
                       end else
                       if (par_1 + 1 = par_2) and (impar_1 + 1 = impar_2) then begin
                         comum_localizado := true;
                       end else
                       if (par_1 + 2 = par_2) and (impar_1 = impar_2) then begin
                         comum_localizado := true;
                       end end;
                       // ================ FIM: 16 BOLAS;

                       // ================ 17 BOLAS.
                       17:
                       begin
                         // Verifica se a combinação é a própria combinação.
                         if (par_1 = par_2) and (impar_1 = impar_2) then begin
                           comum_localizado := true;
                         end else

                         // Compara com as combinações de 15 bolas, haverá 2 bolas a
                         // menos, no seguinte esquema:
                         // 0 par x 2 ímpar;
                         // 1 par x 1 ímpar.
                         // 2 par x 0 ímpar.
                         if (par_1 = par_2) and (impar_1 - 2 = impar_2) then begin
                           comum_localizado := true;
                         end else
                         if (par_1 - 1 = par_2) and (impar_1 - 1 = impar_2) then begin
                           comum_localizado := true;
                         end else
                         if (par_1 - 2 = par_2) and (impar_1 = impar_2) then begin
                           comum_localizado := true;
                         end else

                         // Compara com as combinações de 16 bolas, haverá 1 bolas a
                         // menos, no seguinte esquema:
                         // 0 par x 1 ímpar;
                         // 1 par x 0 ímpar.
                         if (par_1 = par_2) and (impar_1 - 1 = impar_2) then begin
                           comum_localizado := true;
                         end else
                         if (par_1 - 1 = par_2) and (impar_1 = impar_2) then begin
                           comum_localizado := true;
                         end else

                         // Compara com as combinações de 17 bolas, neste caso,
                         // com a própria combinação, no seguinte esquema:
                         // 0 par x 0 ímpar.
                         if (par_1 = par_2) and (impar_1 = impar_2) then begin
                           comum_localizado := true;
                         end else

                         // Comparar com as combinações de 18 bolas, haverá 1 bolas a
                         // mais, no seguinte esquema:
                         // 0 par x 1 ímpar;
                         // 1 par x 0 ímpar.
                         if (par_1 = par_2) and (impar_1 + 1 = impar_2) then begin
                           comum_localizado := true;
                         end else
                         if (par_1 + 1 = par_2) and (impar_1 = impar_2) then begin
                           comum_localizado := true;
                         end
                       end;
                         // ================ FIM: 15 BOLAS;

                         // ================ 15 BOLAS.
                         18:
                         begin
                           // Compara com as combinações de 15 bolas, haverá 3 bolas a
                           // menos, no seguinte esquema:
                           // 0 par x 3 ímpar;
                           // 1 par x 2 ímpar;
                           // 2 par x 1 ímpar;
                           // 3 par x 0 ímpar;
                           if (par_1 = par_2) and (impar_1 - 3 = impar_2) then begin
                             comum_localizado := true;
                           end else
                           if (par_1 - 1 = par_2) and (impar_1 - 2 = impar_2) then begin
                             comum_localizado := true;
                           end else
                           if (par_1 - 2 = par_2) and (impar_1 - 1 = impar_2) then begin
                             comum_localizado := true;
                           end else
                           if (par_1 - 3 = par_2) and (impar_1 = impar_2) then begin
                             comum_localizado := true;
                           end else

                           // Compara com as combinações de 16 bolas, haverá 2 bolas a menos
                           // no seguinte esquema:
                           // 0 par x 2 ímpar;
                           // 1 par x 1 ímpar.
                           // 2 par x 0 ímpar.
                           if (par_1 = par_2) and (impar_1 - 2 = impar_2) then begin
                             comum_localizado := true;
                           end else
                           if (par_1 - 1 = par_2) and (impar_1 - 1 = impar_2) then begin
                             comum_localizado := true;
                           end else
                           if (par_1 - 2 = par_2) and (impar_1 = impar_2) then begin
                             comum_localizado := true;
                           end else

                           // Compara com as combinações de 17 bolas, haverá 1 bola a menos,
                           // no seguinte esquema:
                           // 0 par x 1 ímpar;
                           // 1 par x 0 ímpar.
                           if (par_1 = par_2) and (impar_1 - 1 = impar_2) then begin
                             comum_localizado := true;
                           end else
                           if (par_1 - 1 = par_2) and (impar_1 = impar_2) then begin
                             comum_localizado := true;
                           end else

                           // Compara com a própria combinação, haverá, 0 bolas a menos,
                           // no seguinte esquema:
                           // 0 par x 0 ímpar.
                           // Verifica se a combinação é a própria combinação.
                           if (par_1 = par_2) and (impar_1 = impar_2) then begin
                             comum_localizado := true;
                           end;
                         end;

              end;
              if comum_localizado = true then
              begin
                Inc(comum_id);
                strPar_Impar := '';
                strPar_Impar := strPar_Impar + IntToStr(comum_id) + ';';
                strPar_Impar := strPar_Impar + IntToStr(id_par_impar_1) + ';';
                strPar_Impar := strPar_Impar + IntToStr(id_par_impar_2);
                lista_par_impar.Add(strPar_Impar);
              end;
            end;
          end;
        end;    // Vi este
      end;      // Vi este
    end;
  end;

  // Salva o arquivo.
  lista_par_impar.SaveToFile('./arquivos_csv/lotofacil_id_par_impar_comum.csv');
end;

{ Externo x Interno }
{
 Gera um identificador pra cada combinação externo x interno válida na lotofacil.
 Após todos os identificadores serem gerados, cada identificador, total de bolas,
 quantidade de números externoes e quantidades de números ímexternoes, é salvo em um arquivo
 de nome 'lotofacil_id_externo_interno.csv', onde a primeira linha tem o cabeçalho
 seexternoados por ';', o cabeçalho é: ext_id;ext_qt;externo;interno.
 As demais linhas tem os valores identificando

 Na lotofacil, há 16 externos e 9 internos.
 Na lotofacil, há 0 interno no mínimo;
 Na lotofacil, há 6 no mínimo
 Na lotofacil, as combinações válidas de externoes e internoes tem que estar entre
 15, 16, 17 ou 18 bolas, pois, na lotofacil pode-se jogar de 15 a 18 bolas.

 Layout do arranjo externo_interno_id:
 A dimensão 0, representa a quantidade de números externoes;
 A dimensão 1, representa a quantidade de números internoes;
 A dimensão 2, índice 0, representa o identificador;
 A dimensão 2, índice 1, representa o total de bolas daquele jogo, 15, 16, 17 ou 18
 A dimensão 2, índice 2, representa o total de jogos já encontrados com aquela combinação.
 A dimensão 2, índice 2, será utilizada posteriormente quando percorrermos todas as
 combinações possíveis da lotofacil.
 }
procedure Gerar_externo_interno_id();
var
  externo, interno: integer;
  id_externo_interno: integer;
  soma_externo_interno: integer;
  str_externo_interno : ansiString;
  lista_externo_interno : TStrings;
begin
  id_externo_interno := 0;
  str_externo_interno := 'ext_int_id;ext_int_qt;externo;interno';

  lista_externo_interno := TStringList.Create;
  lista_externo_interno.Clear;
  lista_externo_interno.Add(str_externo_interno);

  for externo := 0 to 16 do begin
    for interno := 0 to 9 do begin

      soma_externo_interno := externo + interno;

      if soma_externo_interno in [15, 16, 17, 18] then begin
        Inc(id_externo_interno);
        externo_interno_id [externo, interno, 0] := id_externo_interno;
        externo_interno_id [externo, interno, 1] := soma_externo_interno;

        str_externo_interno := '';
        str_externo_interno := str_externo_interno + IntToStr(id_externo_interno) + ';';
        str_externo_interno := str_externo_interno + IntToStr(soma_externo_interno) + ';';
        str_externo_interno := str_externo_interno + IntToStr(externo) + ';';
        str_externo_interno := str_externo_interno + IntToStr(interno);
        lista_externo_interno.Add(str_externo_interno);
      end;
    end;
  end;

  // Grava em um arquivo.
  lista_externo_interno.SaveToFile('./arquivos_csv/lotofacil_id_externo_interno.csv');

end;

{
 Gera um arquivo, onde tem os campos seguintes:
 id_comum;ext_int_id;ext_int_comum_id

 Ao considerarmos uma combinação de externo e interno de 15 bolas, com as demais
 combinações de externo e interno das outras quantidades de 16, 17 e 18 bolas, pode
 ocorrer de uma combinação ser comum a outra combinação só diferente de 1, 2
 ou 3 bolas, então segue-se descrição desta situação:

 16 bolas, tem 1 bola a mais, ela pode estar nas seguintes formas:
 0 no externo e 1 no ímexterno;
 1 no externo e 0 no ímexterno;

 17 bolas, tem 2 bolas a mais, ela pode estar nas seguintes formas:
 0 no externo e 2 no ímexterno;
 1 no externo e 1 no ímexterno;
 2 no externo e 0 no ímexterno;

 18 bolas, tem 3 bolas a mais, ela pode estar nas seguintes formas:
 0 no externo e 3 no ímexterno;
 1 no externo e 2 no ímexterno;
 2 no externo e 1 no ímexterno;
 3 no externo e 0 no ímexterno;

 O que o nosso algoritmo fará é comexternoar cada um das combinação com todas as
 outras combinações pra identificar quais combinações são comuns e em seguida,
 iremos associar o identificador da combinação atual que estamos analisando
 com o identificador da outra combinação que é comum.

 Aqui, a combinação é comum e recíproca, pois, podemos implementar posteriormente,
 no programa que o usuário escolhe uma quantidade de bolas maior e o programa
 seleciona as outras combinações que são comum.

}
procedure Gerar_externo_interno_Comum_id;
var
  externo_1, interno_1, id_externo_interno_1, soma_externo_interno_1: Integer;
  externo_2, interno_2, id_externo_interno_2, soma_externo_interno_2: Integer;
  lista_externo_interno : TStrings;
  str_externo_interno : AnsiString;
  comum_localizado: boolean;
  comum_id : Integer;
  strexterno_interno : String;
begin
  lista_externo_interno := TStringList.Create;
  comum_id := 0;

  lista_externo_interno.Add('comum_id;ext_int_id;ext_int_comum_id');

  for externo_1 := 0 to 16 do begin
    for interno_1 := 0 to 9 do
    begin

      soma_externo_interno_1 := externo_1 + interno_1;

      if soma_externo_interno_1 in [15, 16, 17, 18] then
      begin

        id_externo_interno_1 := externo_interno_id[externo_1, interno_1, 0];

        for externo_2 := 0 to 16 do
        begin
          for interno_2 := 0 to 9 do
          begin

            soma_externo_interno_2 := externo_2 + interno_2;
            if soma_externo_interno_2 in [15, 16, 17, 18] then
            begin
              id_externo_interno_2 := externo_interno_id[externo_2, interno_2, 0];
              comum_localizado := false;
              // Aqui, devemos pegar todas as combinações comum, conforme
              // a quantidade de bolas
              case soma_externo_interno_1 of
                   // ================ 15 BOLAS.
                   15: begin
                     // Verifica se a combinação é a própria combinação.
                     if (externo_1 = externo_2) and (interno_1 = interno_2) then begin
                       comum_localizado := true;
                     end else

                     // Comexternoa com as combinações de 16 bolas, haverá 1 bolas a
                     // mais, no seguinte esquema:
                     // 0 externo x 1 ímexterno;
                     // 1 externo x 0 ímexterno.
                     if (externo_1 = externo_2) and (interno_1 + 1 = interno_2) then begin
                       comum_localizado := true;
                     end else
                     if (externo_1 + 1 = externo_2) and (interno_1 = interno_2) then begin
                       comum_localizado := true;
                     end else

                     // Comexternoa com as combinações de 17 bolas, haverá 2 bolas a
                     // mais, no seguinte esquema:
                     // 0 externo x 2 ímexterno;
                     // 1 externo x 1 ímexterno;
                     // 2 externo x 0 ímexterno.
                     if (externo_1 = externo_2) and (interno_1 + 2 = interno_2) then begin
                       comum_localizado := true;
                     end else
                     if (externo_1 + 1 = externo_2) and (interno_1 + 1 = interno_2) then begin
                       comum_localizado := true;
                     end else
                     if (externo_1 + 2 = externo_2) and (interno_1 = interno_2) then begin
                       comum_localizado := true;
                     end else

                     // Comexternoar com as combinações de 18 bolas, haverá 3 bolas a
                     // mais, no seguinte esquema:
                     // 0 externo x 3 ímexterno;
                     // 1 externo x 2 ímexterno;
                     // 2 externo x 1 ímexterno;
                     // 3 externo x 0 ímexterno;
                     if (externo_1 = externo_2) and (interno_1 + 3 = interno_2) then begin
                       comum_localizado := true;
                     end else
                     if (externo_1 + 1 = externo_2) and (interno_1 + 2 = interno_2) then begin
                       comum_localizado := true;
                     end else
                     if (externo_1 + 2 = externo_2) and (interno_1 + 1 = interno_2) then begin
                       comum_localizado := true;
                     end else
                     if (externo_1 + 3 = externo_2) and (interno_1 = interno_2) then begin
                       comum_localizado := true;
                     end end;
                     // ================ FIM: 15 BOLAS;

                     // ================ INÍCIO: 16 BOLAS.
                     16: begin
                       // Comexternoa com as combinações de 15 bolas, haverá 1 bolas a
                       // menos, no seguinte esquema:
                       // 0 externo x 1 ímexterno;
                       // 1 externo x 0 ímexterno.
                       if (externo_1 = externo_2) and (interno_1 - 1 = interno_2) then begin
                         comum_localizado := true;
                       end else
                       if (externo_1 - 1 = externo_2) and (interno_1 = interno_2) then begin
                         comum_localizado := true;
                       end else

                       // Verifica se a combinação é a própria combinação.
                       if (externo_1 = externo_2) and (interno_1 = interno_2) then begin
                         comum_localizado := true;
                       end else

                       // Comexternoa com as combinações de 17 bolas, haverá 1 bolas a
                       // mais, no seguinte esquema:
                       // 0 externo x 1 ímexterno;
                       // 1 externo x 0 ímexterno;
                       if (externo_1 = externo_2) and (interno_1 + 1 = interno_2) then begin
                         comum_localizado := true;
                       end else
                       if (externo_1 + 1 = externo_2) and (interno_1 = interno_2) then begin
                         comum_localizado := true;
                       end else

                       // Comexternoar com as combinações de 18 bolas, haverá 2 bolas a
                       // mais, no seguinte esquema:
                       // 0 externo x 2 ímexterno;
                       // 1 externo x 1 ímexterno;
                       // 2 externo x 0 ímexterno;
                       if (externo_1 = externo_2) and (interno_1 + 2 = interno_2) then begin
                         comum_localizado := true;
                       end else
                       if (externo_1 + 1 = externo_2) and (interno_1 + 1 = interno_2) then begin
                         comum_localizado := true;
                       end else
                       if (externo_1 + 2 = externo_2) and (interno_1 = interno_2) then begin
                         comum_localizado := true;
                       end end;
                       // ================ FIM: 16 BOLAS;

                       // ================ 17 BOLAS.
                       17:
                       begin
                         // Verifica se a combinação é a própria combinação.
                         if (externo_1 = externo_2) and (interno_1 = interno_2) then begin
                           comum_localizado := true;
                         end else

                         // Comexternoa com as combinações de 15 bolas, haverá 2 bolas a
                         // menos, no seguinte esquema:
                         // 0 externo x 2 ímexterno;
                         // 1 externo x 1 ímexterno.
                         // 2 externo x 0 ímexterno.
                         if (externo_1 = externo_2) and (interno_1 - 2 = interno_2) then begin
                           comum_localizado := true;
                         end else
                         if (externo_1 - 1 = externo_2) and (interno_1 - 1 = interno_2) then begin
                           comum_localizado := true;
                         end else
                         if (externo_1 - 2 = externo_2) and (interno_1 = interno_2) then begin
                           comum_localizado := true;
                         end else

                         // Comexternoa com as combinações de 16 bolas, haverá 1 bolas a
                         // menos, no seguinte esquema:
                         // 0 externo x 1 ímexterno;
                         // 1 externo x 0 ímexterno.
                         if (externo_1 = externo_2) and (interno_1 - 1 = interno_2) then begin
                           comum_localizado := true;
                         end else
                         if (externo_1 - 1 = externo_2) and (interno_1 = interno_2) then begin
                           comum_localizado := true;
                         end else

                         // Comexternoa com as combinações de 17 bolas, neste caso,
                         // com a própria combinação, no seguinte esquema:
                         // 0 externo x 0 ímexterno.
                         if (externo_1 = externo_2) and (interno_1 = interno_2) then begin
                           comum_localizado := true;
                         end else

                         // Comexternoar com as combinações de 18 bolas, haverá 1 bolas a
                         // mais, no seguinte esquema:
                         // 0 externo x 1 ímexterno;
                         // 1 externo x 0 ímexterno.
                         if (externo_1 = externo_2) and (interno_1 + 1 = interno_2) then begin
                           comum_localizado := true;
                         end else
                         if (externo_1 + 1 = externo_2) and (interno_1 = interno_2) then begin
                           comum_localizado := true;
                         end
                       end;
                         // ================ FIM: 15 BOLAS;

                         // ================ 15 BOLAS.
                         18:
                         begin
                           // Comexternoa com as combinações de 15 bolas, haverá 3 bolas a
                           // menos, no seguinte esquema:
                           // 0 externo x 3 ímexterno;
                           // 1 externo x 2 ímexterno;
                           // 2 externo x 1 ímexterno;
                           // 3 externo x 0 ímexterno;
                           if (externo_1 = externo_2) and (interno_1 - 3 = interno_2) then begin
                             comum_localizado := true;
                           end else
                           if (externo_1 - 1 = externo_2) and (interno_1 - 2 = interno_2) then begin
                             comum_localizado := true;
                           end else
                           if (externo_1 - 2 = externo_2) and (interno_1 - 1 = interno_2) then begin
                             comum_localizado := true;
                           end else
                           if (externo_1 - 3 = externo_2) and (interno_1 = interno_2) then begin
                             comum_localizado := true;
                           end else

                           // Comexternoa com as combinações de 16 bolas, haverá 2 bolas a menos
                           // no seguinte esquema:
                           // 0 externo x 2 ímexterno;
                           // 1 externo x 1 ímexterno.
                           // 2 externo x 0 ímexterno.
                           if (externo_1 = externo_2) and (interno_1 - 2 = interno_2) then begin
                             comum_localizado := true;
                           end else
                           if (externo_1 - 1 = externo_2) and (interno_1 - 1 = interno_2) then begin
                             comum_localizado := true;
                           end else
                           if (externo_1 - 2 = externo_2) and (interno_1 = interno_2) then begin
                             comum_localizado := true;
                           end else

                           // Comexternoa com as combinações de 17 bolas, haverá 1 bola a menos,
                           // no seguinte esquema:
                           // 0 externo x 1 ímexterno;
                           // 1 externo x 0 ímexterno.
                           if (externo_1 = externo_2) and (interno_1 - 1 = interno_2) then begin
                             comum_localizado := true;
                           end else
                           if (externo_1 - 1 = externo_2) and (interno_1 = interno_2) then begin
                             comum_localizado := true;
                           end else

                           // Comexternoa com a própria combinação, haverá, 0 bolas a menos,
                           // no seguinte esquema:
                           // 0 externo x 0 ímexterno.
                           // Verifica se a combinação é a própria combinação.
                           if (externo_1 = externo_2) and (interno_1 = interno_2) then begin
                             comum_localizado := true;
                           end;
                         end;

              end;
              if comum_localizado = true then
              begin
                Inc(comum_id);
                strexterno_interno := '';
                strexterno_interno := strexterno_interno + IntToStr(comum_id) + ';';
                strexterno_interno := strexterno_interno + IntToStr(id_externo_interno_1) + ';';
                strexterno_interno := strexterno_interno + IntToStr(id_externo_interno_2);
                lista_externo_interno.Add(strexterno_interno);
              end;
            end;
          end;
        end;    // Vi este
      end;      // Vi este
    end;
  end;

  // Salva o arquivo.
  lista_externo_interno.SaveToFile('./arquivos_csv/lotofacil_id_externo_interno_comum.csv');
end;
{Externo x Interno: Fim}


{ Primo x Nao-Primo }
{
 Gera um identificador pra cada combinação primo x nao_primo válida na lotofacil.
 Após todos os identificadores serem gerados, cada identificador, total de bolas,
 quantidade de números primoes e quantidades de números ímexternoes, é salvo em um arquivo
 de nome 'lotofacil_id_primo_nao_primo.csv', onde a primeira linha tem o cabeçalho
 seexternoados por ';', o cabeçalho é: ext_id;ext_qt;primo;nao_primo.
 As demais linhas tem os valores identificando

 Na lotofacil, há 16 primos e 9 nao_primos.
 Na lotofacil, há 0 nao_primo no mínimo;
 Na lotofacil, há 6 no mínimo
 Na lotofacil, as combinações válidas de primoes e nao_primoes tem que estar entre
 15, 16, 17 ou 18 bolas, pois, na lotofacil pode-se jogar de 15 a 18 bolas.

 Layout do arranjo primo_nao_primo_id:
 A dimensão 0, representa a quantidade de números primoes;
 A dimensão 1, representa a quantidade de números nao_primoes;
 A dimensão 2, índice 0, representa o identificador;
 A dimensão 2, índice 1, representa o total de bolas daquele jogo, 15, 16, 17 ou 18
 A dimensão 2, índice 2, representa o total de jogos já encontrados com aquela combinação.
 A dimensão 2, índice 2, será utilizada posteriormente quando percorrermos todas as
 combinações possíveis da lotofacil.
 }
procedure Gerar_primo_nao_primo_id();
var
  primo, nao_primo: integer;
  id_primo_nao_primo: integer;
  soma_primo_nao_primo: integer;
  str_primo_nao_primo : ansiString;
  lista_primo_nao_primo : TStrings;
begin
  id_primo_nao_primo := 0;
  str_primo_nao_primo := 'prm_id;prm_qt;primo;nao_primo';

  lista_primo_nao_primo := TStringList.Create;
  lista_primo_nao_primo.Clear;
  lista_primo_nao_primo.Add(str_primo_nao_primo);

  for primo := 0 to 9 do begin
    for nao_primo := 0 to 16 do begin

      soma_primo_nao_primo := primo + nao_primo;

      if soma_primo_nao_primo in [15, 16, 17, 18] then begin
        Inc(id_primo_nao_primo);
        primo_nao_primo_id [primo, nao_primo, 0] := id_primo_nao_primo;
        primo_nao_primo_id [primo, nao_primo, 1] := soma_primo_nao_primo;

        str_primo_nao_primo := '';
        str_primo_nao_primo := str_primo_nao_primo + IntToStr(id_primo_nao_primo) + ';';
        str_primo_nao_primo := str_primo_nao_primo + IntToStr(soma_primo_nao_primo) + ';';
        str_primo_nao_primo := str_primo_nao_primo + IntToStr(primo) + ';';
        str_primo_nao_primo := str_primo_nao_primo + IntToStr(nao_primo);
        lista_primo_nao_primo.Add(str_primo_nao_primo);
      end;
    end;
  end;

  // Grava em um arquivo.
  lista_primo_nao_primo.SaveToFile('./arquivos_csv/lotofacil_id_primo_nao_primo.csv');

end;

{
 Gera um arquivo, onde tem os campos seguintes:
 id_comum;prm_id;prm_comum_id

 Ao considerarmos uma combinação de primo e nao_primo de 15 bolas, com as demais
 combinações de primo e nao_primo das outras quantidades de 16, 17 e 18 bolas, pode
 ocorrer de uma combinação ser comum a outra combinação só diferente de 1, 2
 ou 3 bolas, então segue-se descrição desta situação:

 16 bolas, tem 1 bola a mais, ela pode estar nas seguintes formas:
 0 no primo e 1 no ímprimo;
 1 no primo e 0 no ímprimo;

 17 bolas, tem 2 bolas a mais, ela pode estar nas seguintes formas:
 0 no primo e 2 no ímprimo;
 1 no primo e 1 no ímprimo;
 2 no primo e 0 no ímprimo;

 18 bolas, tem 3 bolas a mais, ela pode estar nas seguintes formas:
 0 no primo e 3 no ímprimo;
 1 no primo e 2 no ímprimo;
 2 no primo e 1 no ímprimo;
 3 no primo e 0 no ímprimo;

 O que o nosso algoritmo fará é comprimoar cada um das combinação com todas as
 outras combinações pra identificar quais combinações são comuns e em seguida,
 iremos associar o identificador da combinação atual que estamos analisando
 com o identificador da outra combinação que é comum.

 Aqui, a combinação é comum e recíproca, pois, podemos implementar posteriormente,
 no programa que o usuário escolhe uma quantidade de bolas maior e o programa
 seleciona as outras combinações que são comum.

}
procedure Gerar_primo_nao_primo_Comum_id;
var
  primo_1, nao_primo_1, id_primo_nao_primo_1, soma_primo_nao_primo_1: Integer;
  primo_2, nao_primo_2, id_primo_nao_primo_2, soma_primo_nao_primo_2: Integer;
  lista_primo_nao_primo : TStrings;
  comum_localizado: boolean;
  comum_id : Integer;
  strprimo_nao_primo : String;
begin
  lista_primo_nao_primo := TStringList.Create;
  lista_primo_nao_primo.Clear;
  comum_id := 0;

  lista_primo_nao_primo.Add('comum_id;prm_id;prm_comum_id');

  for primo_1 := 0 to 9 do begin
    for nao_primo_1 := 0 to 16 do
    begin

      soma_primo_nao_primo_1 := primo_1 + nao_primo_1;

      if soma_primo_nao_primo_1 in [15, 16, 17, 18] then
      begin

        id_primo_nao_primo_1 := primo_nao_primo_id[primo_1, nao_primo_1, 0];

        for primo_2 := 0 to 9 do
        begin
          for nao_primo_2 := 0 to 16 do
          begin

            soma_primo_nao_primo_2 := primo_2 + nao_primo_2;
            if soma_primo_nao_primo_2 in [15, 16, 17, 18] then
            begin
              id_primo_nao_primo_2 := primo_nao_primo_id[primo_2, nao_primo_2, 0];
              comum_localizado := false;
              // Aqui, devemos pegar todas as combinações comum, conforme
              // a quantidade de bolas
              case soma_primo_nao_primo_1 of
                   // ================ 15 BOLAS.
                   15: begin
                     // Verifica se a combinação é a própria combinação.
                     if (primo_1 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                       comum_localizado := true;
                     end else

                     // Comprimoa com as combinações de 16 bolas, haverá 1 bolas a
                     // mais, no seguinte esquema:
                     // 0 primo x 1 ímprimo;
                     // 1 primo x 0 ímprimo.
                     if (primo_1 = primo_2) and (nao_primo_1 + 1 = nao_primo_2) then begin
                       comum_localizado := true;
                     end else
                     if (primo_1 + 1 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                       comum_localizado := true;
                     end else

                     // Comprimoa com as combinações de 17 bolas, haverá 2 bolas a
                     // mais, no seguinte esquema:
                     // 0 primo x 2 ímprimo;
                     // 1 primo x 1 ímprimo;
                     // 2 primo x 0 ímprimo.
                     if (primo_1 = primo_2) and (nao_primo_1 + 2 = nao_primo_2) then begin
                       comum_localizado := true;
                     end else
                     if (primo_1 + 1 = primo_2) and (nao_primo_1 + 1 = nao_primo_2) then begin
                       comum_localizado := true;
                     end else
                     if (primo_1 + 2 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                       comum_localizado := true;
                     end else

                     // Comprimoar com as combinações de 18 bolas, haverá 3 bolas a
                     // mais, no seguinte esquema:
                     // 0 primo x 3 ímprimo;
                     // 1 primo x 2 ímprimo;
                     // 2 primo x 1 ímprimo;
                     // 3 primo x 0 ímprimo;
                     if (primo_1 = primo_2) and (nao_primo_1 + 3 = nao_primo_2) then begin
                       comum_localizado := true;
                     end else
                     if (primo_1 + 1 = primo_2) and (nao_primo_1 + 2 = nao_primo_2) then begin
                       comum_localizado := true;
                     end else
                     if (primo_1 + 2 = primo_2) and (nao_primo_1 + 1 = nao_primo_2) then begin
                       comum_localizado := true;
                     end else
                     if (primo_1 + 3 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                       comum_localizado := true;
                     end end;
                     // ================ FIM: 15 BOLAS;

                     // ================ INÍCIO: 16 BOLAS.
                     16: begin
                       // Comprimoa com as combinações de 15 bolas, haverá 1 bolas a
                       // menos, no seguinte esquema:
                       // 0 primo x 1 ímprimo;
                       // 1 primo x 0 ímprimo.
                       if (primo_1 = primo_2) and (nao_primo_1 - 1 = nao_primo_2) then begin
                         comum_localizado := true;
                       end else
                       if (primo_1 - 1 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                         comum_localizado := true;
                       end else

                       // Verifica se a combinação é a própria combinação.
                       if (primo_1 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                         comum_localizado := true;
                       end else

                       // Comprimoa com as combinações de 17 bolas, haverá 1 bolas a
                       // mais, no seguinte esquema:
                       // 0 primo x 1 ímprimo;
                       // 1 primo x 0 ímprimo;
                       if (primo_1 = primo_2) and (nao_primo_1 + 1 = nao_primo_2) then begin
                         comum_localizado := true;
                       end else
                       if (primo_1 + 1 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                         comum_localizado := true;
                       end else

                       // Comprimoar com as combinações de 18 bolas, haverá 2 bolas a
                       // mais, no seguinte esquema:
                       // 0 primo x 2 ímprimo;
                       // 1 primo x 1 ímprimo;
                       // 2 primo x 0 ímprimo;
                       if (primo_1 = primo_2) and (nao_primo_1 + 2 = nao_primo_2) then begin
                         comum_localizado := true;
                       end else
                       if (primo_1 + 1 = primo_2) and (nao_primo_1 + 1 = nao_primo_2) then begin
                         comum_localizado := true;
                       end else
                       if (primo_1 + 2 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                         comum_localizado := true;
                       end end;
                       // ================ FIM: 16 BOLAS;

                       // ================ 17 BOLAS.
                       17:
                       begin
                         // Verifica se a combinação é a própria combinação.
                         if (primo_1 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                           comum_localizado := true;
                         end else

                         // Comprimoa com as combinações de 15 bolas, haverá 2 bolas a
                         // menos, no seguinte esquema:
                         // 0 primo x 2 ímprimo;
                         // 1 primo x 1 ímprimo.
                         // 2 primo x 0 ímprimo.
                         if (primo_1 = primo_2) and (nao_primo_1 - 2 = nao_primo_2) then begin
                           comum_localizado := true;
                         end else
                         if (primo_1 - 1 = primo_2) and (nao_primo_1 - 1 = nao_primo_2) then begin
                           comum_localizado := true;
                         end else
                         if (primo_1 - 2 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                           comum_localizado := true;
                         end else

                         // Comprimoa com as combinações de 16 bolas, haverá 1 bolas a
                         // menos, no seguinte esquema:
                         // 0 primo x 1 ímprimo;
                         // 1 primo x 0 ímprimo.
                         if (primo_1 = primo_2) and (nao_primo_1 - 1 = nao_primo_2) then begin
                           comum_localizado := true;
                         end else
                         if (primo_1 - 1 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                           comum_localizado := true;
                         end else

                         // Comprimoa com as combinações de 17 bolas, neste caso,
                         // com a própria combinação, no seguinte esquema:
                         // 0 primo x 0 ímprimo.
                         if (primo_1 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                           comum_localizado := true;
                         end else

                         // Comprimoar com as combinações de 18 bolas, haverá 1 bolas a
                         // mais, no seguinte esquema:
                         // 0 primo x 1 ímprimo;
                         // 1 primo x 0 ímprimo.
                         if (primo_1 = primo_2) and (nao_primo_1 + 1 = nao_primo_2) then begin
                           comum_localizado := true;
                         end else
                         if (primo_1 + 1 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                           comum_localizado := true;
                         end
                       end;
                         // ================ FIM: 15 BOLAS;

                         // ================ 15 BOLAS.
                         18:
                         begin
                           // Comprimoa com as combinações de 15 bolas, haverá 3 bolas a
                           // menos, no seguinte esquema:
                           // 0 primo x 3 ímprimo;
                           // 1 primo x 2 ímprimo;
                           // 2 primo x 1 ímprimo;
                           // 3 primo x 0 ímprimo;
                           if (primo_1 = primo_2) and (nao_primo_1 - 3 = nao_primo_2) then begin
                             comum_localizado := true;
                           end else
                           if (primo_1 - 1 = primo_2) and (nao_primo_1 - 2 = nao_primo_2) then begin
                             comum_localizado := true;
                           end else
                           if (primo_1 - 2 = primo_2) and (nao_primo_1 - 1 = nao_primo_2) then begin
                             comum_localizado := true;
                           end else
                           if (primo_1 - 3 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                             comum_localizado := true;
                           end else

                           // Comprimoa com as combinações de 16 bolas, haverá 2 bolas a menos
                           // no seguinte esquema:
                           // 0 primo x 2 ímprimo;
                           // 1 primo x 1 ímprimo.
                           // 2 primo x 0 ímprimo.
                           if (primo_1 = primo_2) and (nao_primo_1 - 2 = nao_primo_2) then begin
                             comum_localizado := true;
                           end else
                           if (primo_1 - 1 = primo_2) and (nao_primo_1 - 1 = nao_primo_2) then begin
                             comum_localizado := true;
                           end else
                           if (primo_1 - 2 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                             comum_localizado := true;
                           end else

                           // Comprimoa com as combinações de 17 bolas, haverá 1 bola a menos,
                           // no seguinte esquema:
                           // 0 primo x 1 ímprimo;
                           // 1 primo x 0 ímprimo.
                           if (primo_1 = primo_2) and (nao_primo_1 - 1 = nao_primo_2) then begin
                             comum_localizado := true;
                           end else
                           if (primo_1 - 1 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                             comum_localizado := true;
                           end else

                           // Comprimoa com a própria combinação, haverá, 0 bolas a menos,
                           // no seguinte esquema:
                           // 0 primo x 0 ímprimo.
                           // Verifica se a combinação é a própria combinação.
                           if (primo_1 = primo_2) and (nao_primo_1 = nao_primo_2) then begin
                             comum_localizado := true;
                           end;
                         end;

              end;
              if comum_localizado = true then
              begin
                Inc(comum_id);
                strprimo_nao_primo := '';
                strprimo_nao_primo := strprimo_nao_primo + IntToStr(comum_id) + ';';
                strprimo_nao_primo := strprimo_nao_primo + IntToStr(id_primo_nao_primo_1) + ';';
                strprimo_nao_primo := strprimo_nao_primo + IntToStr(id_primo_nao_primo_2);
                lista_primo_nao_primo.Add(strprimo_nao_primo);
              end;
            end;
          end;
        end;    // Vi este
      end;      // Vi este
    end;
  end;

  // Salva o arquivo.
  lista_primo_nao_primo.SaveToFile('./arquivos_csv/lotofacil_id_primo_nao_primo_comum.csv');
end;
{ Primo x Nao-Primo}





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


  Gerar_Par_Impar_id;
  Gerar_Par_Impar_Comum_id;
  Gerar_externo_interno_id;
  Gerar_externo_interno_Comum_id;
  Gerar_primo_nao_primo_id;
  Gerar_primo_nao_primo_Comum_id;
end.

