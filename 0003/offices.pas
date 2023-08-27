program offices;
{$mode objfpc}

uses SysUtils;

function Compare(Item1, Item2: Integer): Integer; inline;
begin
  	Result := Item1 - Item2;
end;

var
   CompanySizes: array[0..100000] of Integer;
   CompanyIndex: array[0..100000] of Integer;

Procedure QuickSort(L, R : Longint);
var
  I, J, Qi : Longint;
  P, Q : Integer;
begin
 repeat
   I := L;
   J := R;
   P := CompanySizes[ (L + R) div 2 ];
   repeat
     while Compare(P, CompanySizes[i]) > 0 do
       I := I + 1;
     while Compare(P, CompanySizes[J]) < 0 do
       J := J - 1;
     If I <= J then
     begin
       Q := CompanySizes[I];
       CompanySizes[I] := CompanySizes[J];
       CompanySizes[J] := Q;
       Qi := CompanyIndex[I];
       CompanyIndex[I] := CompanyIndex[J];
       CompanyIndex[J] := Qi;
       I := I + 1;
       J := J - 1;
     end;
   until I > J;
   if J - L < R - I then
   begin
     if L < J then
       QuickSort(L, J);
     L := I;
   end
   else
   begin
     if I < R then
       QuickSort(I, R);
     R := J;
   end;
 until L >= R;
end;

var
   i, n: LongWord;
begin
	readln(n);
   for i := 0 to n-1 do begin
      CompanyIndex[i] := i;
      read(CompanySizes[i]);
   end;
   QuickSort(0, n-1);
   for i := 0 to n-1 do
   	Write(CompanyIndex[i] + 1, ' ');
end.

