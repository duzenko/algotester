program offices;
{$mode objfpc}

uses SysUtils, Math, Classes;

type
  	TCompanyData = record
     	Id: Integer;
      Density: Double;
   end;

var
   Data: array of TCompanyData = nil;
   Index: array of ^TCompanyData;

function Compare(const a, b: TCompanyData): Integer; inline;
begin
   Result := Integer(Single(b.Density-a.Density));
end;

Procedure QuickSort(L, R : Longint);
var
  I, J : Longint;
  P, Q : ^TCompanyData;
begin
 repeat
   I := L;
   J := R;
   P := Index[ (L + R) div 2 ];
   repeat
     while Compare(P^, Index[i]^) > 0 do
       I := I + 1;
     while Compare(P^, Index[J]^) < 0 do
       J := J - 1;
     If I <= J then
     begin
       Q := Index[I];
       Index[I] := Index[J];
       Index[J] := Q;
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

procedure Solve;
var
   i, x: Integer;
begin
	readln(x);
   SetLength(Data, x);
   SetLength(Index, x);
   for i := 0 to High(Data) do begin
      read(Data[i].Density);
      Index[i] := @Data[i];
      Data[i].Id := i+1;
   end;
   for i := 0 to High(Data) do begin
      read(x);
      Data[i].Density := x / Data[i].Density;
   end;
	QuickSort(0, High(Index));
   for i := 0 to High(Index) do begin
      x := TCompanyData(Index[i]^).Id;
   	Write(x, ' ');
   end;
end;

begin
   Solve;
end.
