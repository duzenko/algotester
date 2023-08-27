program offices;
{$mode objfpc}

uses SysUtils;

var
   Density: array[0..100000] of Double;
   Index: array[0..100000] of Integer;

function Compare(a, b: Double): Single; inline;
begin
   Result := b-a;
end;

Procedure QuickSort(L, R : Longint);
var
  I, J, Qi : Longint;
  P, Q : Double;
begin
 repeat
   I := L;
   J := R;
   P := Density[ (L + R) div 2 ];
   repeat
     while Compare(P, Density[i]) > 0 do
       I := I + 1;
     while Compare(P, Density[J]) < 0 do
       J := J - 1;
     If I <= J then
     begin
       Qi := Index[I];
       Index[I] := Index[J];
       Index[J] := Qi;
       Q := Density[I];
       Density[I] := Density[J];
       Density[J] := Q;
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
   Sizes: array of Integer;
begin
	readln(x);
   SetLength(Sizes, x+1);
   for i := 1 to High(Sizes) do begin
      read(Sizes[i]);
      Index[i] := i;
   end;
   for i := 1 to High(Sizes) do begin
      read(x);
      Density[i] := x / Sizes[i];
   end;
	QuickSort(1, High(Sizes));
   for i := 1 to High(Sizes) do begin
   	Write(Index[i], ' ');
   end;
end;

begin
   Solve;
end.
