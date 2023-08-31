program solution;
{$mode delphi}

uses SysUtils, Math, fgl;

type
   TPriceList = TFPGList<Integer>;

function SortCompare(a, b: Integer): Integer;
begin
   Result := a - b;
end;

procedure Solve;
var
   a, i, n, k, z: Integer;
   PriceList: TPriceList;
begin
   PriceList := TPriceList.Create;
	readln(n, k, z);
   z := z div 2;
   for i := 1 to n do begin
      Read(a);
      PriceList.Add(a);
   end;
   PriceList.Sort(@SortCompare);
   n := 0;
   for i := 0 to PriceList.Count-1 do begin
      if PriceList[i] > z then
         Break;
      z -= PriceList[i];
      Inc(n);
      if n = k then
         Break;
   end;
   WriteLn(n);
end;

begin
   Solve;
end.
